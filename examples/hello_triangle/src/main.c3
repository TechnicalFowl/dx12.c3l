module hello_world;

import std::io;
import std::os::win32;
import d3d12;
import dxgi;
import d3dcompile;

const FRAME_COUNT = 2;

Win32_HWND g_hwnd;

ID3D12Device g_device;
IDXGISwapChain g_swap_chain;
ID3D12Resource[FRAME_COUNT] g_render_targets;
ID3D12CommandAllocator g_command_allocator;
ID3D12CommandQueue g_command_queue;
ID3D12DescriptorHeap g_rtv_heap;
ID3D12PipelineState g_pipeline_state;
ID3D12GraphicsCommandList g_command_list;
ID3D12RootSignature g_root_signature;
ID3D12Resource g_vertex_buffer;
Dx_D3D12_VERTEX_BUFFER_VIEW g_vertex_buffer_view;
uint g_rtv_descriptor_size;

Win32_UINT g_frame_index;
Win32_HANDLE g_fence_event;
ID3D12Fence g_fence;
Win32_UINT64 g_fence_value;

Dx_D3D12_VIEWPORT g_viewport;
Dx_D3D12_RECT g_scissor_rect;

struct Vertex
{
	float[3] position;
	float[4] color;
}

fn void on_init()
{
	g_viewport = { 0, 0, 1600, 900, d3d12::D3D12_MIN_DEPTH, d3d12::D3D12_MAX_DEPTH };
	g_scissor_rect = { 0, 0, 1600, 900 };

	load_pipeline();
	load_assets();
}

fn void load_pipeline()
{
	uint dxgi_factory_flags = 4;
	ID3D12Debug? debug_controller = d3d12::get_debug_interface();
	if (try debug_controller)
	{
		debug_controller.enable_debug_layer();
		dxgi_factory_flags |= dxgi::DXGI_CREATE_FACTORY_DEBUG;
		d3d12::@safe_release(debug_controller);
	}
	else
	{
		d3d12::log_warn("Failed to get D3D12 debug interface, running without debug layer");
	}

	IDXGIFactory factory = dxgi::create_dxgi_factory(dxgi_factory_flags)!!;
	IDXGIAdapter adapter = dxgi::get_hardware_adapter(factory, true)!!;
	g_device = d3d12::create_device((IUnknown) adapter, D3D_FEATURE_LEVEL_12_1)!!;

	Dx_D3D12_COMMAND_QUEUE_DESC queue_desc = {
		.type = DIRECT,
	};
	g_command_queue = g_device.create_command_queue(&queue_desc)!!;

	Dx_DXGI_SWAP_CHAIN_DESC1 swap_chain_desc = {
		.buffer_count = FRAME_COUNT,
		.width = 1600,
		.height = 900,
		.format = R8G8B8A8_UNORM,
		.buffer_usage = RENDER_TARGET_OUTPUT,
		.swap_effect = FLIP_DISCARD,
		.sample_desc = { .count = 1, },
	};

	g_swap_chain = factory.create_swap_chain_for_hwnd(
		g_command_queue,
		g_hwnd,
		&swap_chain_desc,
		null,
		null
	)!!;

	factory.make_window_association(g_hwnd, dxgi::DXGI_MWA_NO_ALT_ENTER)!!;

	g_frame_index = g_swap_chain.get_current_back_buffer_index()!!;

	// Create descriptor heaps.
    {
        // Describe and create a render target view (RTV) descriptor heap.
        Dx_D3D12_DESCRIPTOR_HEAP_DESC rtvHeapDesc = {
			.num_descriptors = FRAME_COUNT,
			.type = RTV,
			.flags = {},
		};
		g_rtv_heap = g_device.create_descriptor_heap(&rtvHeapDesc)!!;
        g_rtv_descriptor_size = g_device.get_descriptor_handle_increment_size(RTV);
    }

    // Create frame resources.
    {
        Dx_D3D12_CPU_DESCRIPTOR_HANDLE rtv_handle = g_rtv_heap.get_cpu_descriptor_handle_for_heap_start();

        // Create a RTV for each frame.
        for (int n = 0; n < FRAME_COUNT; n++)
        {
			g_render_targets[n] = g_swap_chain.get_buffer(n)!!;
            g_device.create_render_target_view(g_render_targets[n], null, rtv_handle);
            rtv_handle.ptr += g_rtv_descriptor_size;
        }
    }

	g_command_allocator = g_device.create_command_allocator(DIRECT)!!;
	g_command_allocator.set_name(@wstring("Main Command Allocator"))!!;

}

fn void load_assets()
{
	g_viewport = { 0, 0, 1600, 900, d3d12::D3D12_MIN_DEPTH, d3d12::D3D12_MAX_DEPTH };
	g_scissor_rect = { 0, 0, 1600, 900 };

	{
		Dx_D3D12_ROOT_SIGNATURE_DESC root_signature_desc = {
			.num_parameters = 0,
			.flags = { .allow_input_assembler_input_layout = true },
		};

		char[] blob = d3d12::serialize_root_signature(&root_signature_desc, VERSION_1)!!;
		g_root_signature = g_device.create_root_signature(0, blob)!!;
	}

	{
		D3DCompileFlags flags = { .debug, .skip_optimization };
		char[] vertex_shader = d3dcompile::compile_from_file(@wstring("resources/shader.hlsl"), "VSMain", "vs_5_0", flags)!!;
		char[] pixel_shader = d3dcompile::compile_from_file(@wstring("resources/shader.hlsl"), "PSMain", "ps_5_0", flags)!!;

		Dx_D3D12_INPUT_ELEMENT_DESC[] input_element_descs = {
			{ "POSITION", 0, R32G32B32_FLOAT, 0, 0, PER_VERTEX_DATA, 0 },
			{ "COLOR", 0, R32G32B32A32_FLOAT, 0, 12, PER_VERTEX_DATA, 0 },
		};

		Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC pso_desc =
		{
			.root_signature = g_root_signature.get_com_ptr(),
			.input_layout = { input_element_descs.ptr, input_element_descs.len },
			.vs = { vertex_shader.ptr, vertex_shader.len },
			.ps = { pixel_shader.ptr, pixel_shader.len },
			.rasterizer_state = {
				.fill_mode = SOLID,
				.cull_mode = BACK,
				.front_counter_clockwise = (Win32_BOOL) false,
				.depth_bias = d3d12::D3D12_DEFAULT_DEPTH_BIAS,
				.depth_bias_clamp = d3d12::D3D12_DEFAULT_DEPTH_BIAS_CLAMP,
				.slope_scaled_depth_bias = d3d12::D3D12_DEFAULT_SLOPE_SCALED_DEPTH_BIAS,
				.depth_clip_enable = (Win32_BOOL) true,
				.multisample_enable = (Win32_BOOL) false,
				.antialiased_line_enable = (Win32_BOOL) false,
				.forced_sample_count = (Win32_BOOL) false,
				.conservative_raster = OFF,
			},
			.blend_state = {
				.alpha_to_coverage_enable = 0,
				.independent_blend_enable = 0,
				.render_target = {
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
					{ 0, 0, ONE, ZERO, ADD, ONE, ZERO, ADD, NOOP, 0xF },
				}
			},
			.depth_stencil_state = {
				.depth_enable = (Win32_BOOL) false,
				.stencil_enable = (Win32_BOOL) false,
			},
			.sample_mask = 0xFFFFFFFF,
			.primitive_topology_type = TRIANGLE,
			.num_render_targets = 1,
			.rtv_formats = { [0] = R8G8B8A8_UNORM },
			.sample_desc = { .count = 1, }
		};

		g_pipeline_state = g_device.create_graphics_pipeline_state(&pso_desc)!!;
	}
	
	g_command_list = g_device.create_command_list(0, DIRECT, g_command_allocator, g_pipeline_state)!!;
	g_command_list.close()!!;

	{
		float aspect_ratio = 1600.0 / 900.0;
		Vertex[] triangle_vertices = {
			{ { 0.0, 0.25 * aspect_ratio, 0.0}, { 1.0, 0.0, 0.0, 1.0 } },
			{ { 0.25, -0.25 * aspect_ratio, 0.0}, { 0.0, 1.0, 0.0, 1.0 } },
			{ { -0.25, -0.25 * aspect_ratio, 0.0}, { 0.0, 0.0, 1.0, 1.0 } },
		};
		usz vertex_buffer_size = Vertex.sizeof * triangle_vertices.len;
		Dx_D3D12_HEAP_PROPERTIES heap_props = {
			.creation_node_mask = 1,
			.visible_node_mask = 1,
			.cpu_page_property = UNKNOWN,
			.memory_pool = UNKNOWN,
			.type = UPLOAD,
		};

		Dx_D3D12_RESOURCE_DESC resource_desc = {
			.dimension = BUFFER,
			.alignment = 0,
			.width = vertex_buffer_size,
			.height = 1,
			.depth_or_array_size = 1,
			.mip_levels = 1,
			.format = UNKNOWN,
			.sample_desc = { .count = 1, .quality = 0 },
			.layout = ROW_MAJOR,
			.flags = {},
		};

		g_vertex_buffer = g_device.create_committed_resource(
			&heap_props,
			{},
			&resource_desc,
			d3d12::D3D12_RESOURCE_STATE_GENERIC_READ,
			null
		)!!;

		char* vertex_data_begin;
		Dx_D3D12_RANGE read_range;
		vertex_data_begin = g_vertex_buffer.map(0, &read_range)!!;
		mem::copy(vertex_data_begin, &triangle_vertices[0], vertex_buffer_size);
		g_vertex_buffer.unmap(0, null)!!;

		g_vertex_buffer_view = {
			.buffer_location = g_vertex_buffer.get_gpu_virtual_address(),
			.size_in_bytes = (uint) vertex_buffer_size,
			.stride_in_bytes = Vertex.sizeof,
		};
	}
	
	g_fence = g_device.create_fence(0, d3d12::D3D12_FENCE_FLAG_NONE)!!;
	g_fence_value = 1;
	g_fence_event = win32::createEventExA(null, "Frame Completion", 0, 0x1F0003);
	if (g_fence_event == null) win32::get_last_error()!!;

	wait_for_previous_frame();
}

fn void on_render()
{
	populate_command_list();

	g_command_queue.execute_command_lists({g_command_list});

	g_swap_chain.present(1, dxgi::DXGI_PRESENT_NONE)!!;

	wait_for_previous_frame();
}

fn void populate_command_list()
{
	g_command_allocator.reset()!!;
	g_command_list.reset(g_command_allocator, g_pipeline_state)!!;

	g_command_list.set_graphics_root_signature(g_root_signature);
	g_command_list.rs_set_viewports(1, &g_viewport);
	g_command_list.rs_set_scissor_rects(1, &g_scissor_rect);

	{
		Dx_D3D12_RESOURCE_BARRIER barrier;
		barrier.type = TRANSITION;
		barrier.transition.resource = g_render_targets[g_frame_index].get_com_ptr();
		barrier.transition.state_before = d3d12::D3D12_RESOURCE_STATE_PRESENT;
		barrier.transition.state_after = d3d12::D3D12_RESOURCE_STATE_RENDER_TARGET;
		barrier.transition.subresource = d3d12::D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES;
		g_command_list.resource_barrier({barrier});
	}

	Dx_D3D12_CPU_DESCRIPTOR_HANDLE rtv_handle = g_rtv_heap.get_cpu_descriptor_handle_for_heap_start();
	rtv_handle.ptr += (Win32_SIZE_T) g_frame_index * g_rtv_descriptor_size;

	g_command_list.om_set_render_targets(1, &rtv_handle, false, null);

	float[4] clear_color = { 0.0, 0.2, 0.4, 1.0 };
	g_command_list.clear_render_target_view(rtv_handle, clear_color, 0, null);
	g_command_list.ia_set_primitive_topology(TRIANGLELIST);
	g_command_list.ia_set_vertex_buffers(0, 1, &g_vertex_buffer_view);
	g_command_list.draw_instanced(3, 1, 0, 0);

	{
		Dx_D3D12_RESOURCE_BARRIER barrier;
		barrier.type = TRANSITION;
		barrier.transition.resource = g_render_targets[g_frame_index].get_com_ptr();
		barrier.transition.state_before = d3d12::D3D12_RESOURCE_STATE_RENDER_TARGET;
		barrier.transition.state_after = d3d12::D3D12_RESOURCE_STATE_PRESENT;
		barrier.transition.subresource = d3d12::D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES;
		g_command_list.resource_barrier({barrier});
	}

	g_command_list.close()!!;
}

fn void wait_for_previous_frame()
{
	Win32_UINT64 fence = g_fence_value;
	win32::resetEvent(g_fence_event);
	g_command_queue.signal(g_fence, fence)!!;
	g_fence_value++;

	if (g_fence.get_completed_value() < fence)
	{
		g_fence.set_event_on_completion(fence, g_fence_event)!!;
		win32::waitForSingleObject(g_fence_event, win32::INFINITE);
	}

	g_frame_index = g_swap_chain.get_current_back_buffer_index()!!;
}

fn void on_destroy()
{
	wait_for_previous_frame();
	win32::closeHandle(g_fence_event);
}

fn int main(String[] args)
{
    Win32_HINSTANCE hinstance = win32::get_module_handle_w(null)!!;

    Win32_WNDCLASSEXW wc = {
        .cbSize = Win32_WNDCLASSEXW.sizeof,
        .style = win32::CS_HREDRAW | win32::CS_VREDRAW,
        .lpfnWndProc = &window_proc,
        .hInstance = hinstance,
        .lpszClassName = @wstring("DX12RenderClass"),
    };
    win32::register_class_ex_w(&wc)!!;

    Win32_RECT windowRect = {0, 0, 1600, 900 };
    win32::adjust_window_rect(&windowRect, win32::WS_OVERLAPPEDWINDOW, 0)!!;
	
    g_hwnd = win32::create_window_ex_w(
        0, // Extended window style
        wc.lpszClassName,
        @wstring("DX12 Render Window"),
        win32::WS_OVERLAPPEDWINDOW,
        win32::CW_USEDEFAULT,
        win32::CW_USEDEFAULT,
        windowRect.right - windowRect.left,
        windowRect.bottom - windowRect.top,
        null, // Parent window
        null, // Menu
        hinstance, // Instance handle
        null
    )!!;

	on_init();

    win32::showWindow(g_hwnd, win32::SW_NORMAL);

    Win32_MSG msg;
    while (msg.message != WindowMessage.WM_QUIT)
    {
        if (win32::peekMessageW(&msg, null, 0, 0, win32::PM_REMOVE))
        {
            win32::translateMessage(&msg);
            win32::dispatchMessage(&msg);
        }
		else
		{
			on_render();
		}
    }

	on_destroy();

    return (int) msg.wParam;
}

fn Win32_LRESULT window_proc(Win32_HWND hwnd, Win32_UINT pmsg, Win32_WPARAM wparam, Win32_LPARAM lparam)
{
    WindowMessage msg = (WindowMessage) pmsg;
    switch (msg)
    {
    case WM_PAINT:
		Win32_PAINTSTRUCT ps;
		win32::beginPaint(hwnd, &ps);
		win32::endPaint(hwnd, &ps);
    case WM_DESTROY:
        win32::postQuitMessage(0);
        return 0;
    default:
        break;
    }
    return win32::defWindowProcW(hwnd, pmsg, wparam, lparam);
}