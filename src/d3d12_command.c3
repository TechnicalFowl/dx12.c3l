module d3d12;

import std::os::win32;
import dxgi;

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

struct ID3D12CommandAllocatorVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12CommandAllocator methods
    Reset reset;
}

interface ID3D12CommandAllocator : ID3D12DeviceChild
{
    fn void? reset();
}

struct ID3D12CommandAllocatorImpl (ID3D12CommandAllocator)
{
    ID3D12CommandAllocatorVtbl* vtbl;
    ID3D12CommandAllocatorRaw* raw;
}

fn void* ID3D12CommandAllocatorImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12CommandAllocatorImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12CommandAllocatorImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12CommandAllocatorImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12CommandAllocatorImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12CommandAllocatorImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12CommandAllocatorImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12CommandAllocatorImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12CommandAllocatorImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn void? ID3D12CommandAllocatorImpl.reset(&self) @dynamic
{
    Win32_HRESULT hr = self.vtbl.reset(self.raw);
    if (hr != S_OK) check_hresult(hr)!;
}

struct ID3D12CommandSignatureVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;
}

interface ID3D12CommandSignature : ID3D12Pageable
{

}

struct ID3D12CommandSignatureImpl (ID3D12CommandSignature)
{
    ID3D12CommandSignatureVtbl* vtbl;
    ID3D12CommandSignatureRaw* raw;
}

fn void* ID3D12CommandSignatureImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12CommandSignatureImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12CommandSignatureImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12CommandSignatureImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12CommandSignatureImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12CommandSignatureImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12CommandSignatureImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12CommandSignatureImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12CommandSignatureImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

struct ID3D12CommandListVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12CommandList methods
    GetCommandListType get_type;
}

interface ID3D12CommandList : ID3D12DeviceChild
{
    fn Dx_D3D12_COMMAND_LIST_TYPE get_type();
}

struct ID3D12GraphicsCommandListVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12CommandList methods
    GetCommandListType get_type;

    // ID3D12GraphicsCommandList methods
    Close close;
    ResetCommandList reset;
    ClearState clear_state;
    DrawInstanced draw_instanced;
    DrawIndexedInstanced draw_indexed_instanced;
    Dispatch dispatch;
    CopyBufferRegion copy_buffer_region;
    CopyTextureRegion copy_texture_region;
    CopyResource copy_resource;
    CopyTiles copy_tiles;
    ResolveSubresource resolve_subresource;
    IASetPrimitiveTopology ia_set_primitive_topology;
    RSSetViewports rs_set_viewports;
    RSSetScissorRects rs_set_scissor_rects;
    OMSetBlendFactor om_set_blend_factor;
    OMSetStencilRef om_set_stencil_ref;
    SetPipelineState set_pipeline_state;
    ResourceBarrier resource_barrier;
    ExecuteBundle execute_bundle;
    SetDescriptorHeaps set_descriptor_heaps;
    SetComputeRootSignature set_compute_root_signature;
    SetGraphicsRootSignature set_graphics_root_signature;
    SetComputeRootDescriptorTable set_compute_root_descriptor_table;
    SetGraphicsRootDescriptorTable set_graphics_root_descriptor_table;
    SetComputeRoot32BitConstant set_compute_root_32_bit_constant;
    SetGraphicsRoot32BitConstant set_graphics_root_32_bit_constant;
    SetComputeRoot32BitConstants set_compute_root_32_bit_constants;
    SetGraphicsRoot32BitConstants set_graphics_root_32_bit_constants;
    SetComputeRootConstantBufferView set_compute_root_constant_buffer_view;
    SetGraphicsRootConstantBufferView set_graphics_root_constant_buffer_view;
    SetComputeRootShaderResourceView set_compute_root_shader_resource_view;
    SetGraphicsRootShaderResourceView set_graphics_root_shader_resource_view;
    SetComputeRootUnorderedAccessView set_compute_root_unordered_access_view;
    SetGraphicsRootUnorderedAccessView set_graphics_root_unordered_access_view;
    IASetIndexBuffer ia_set_index_buffer;
    IASetVertexBuffers ia_set_vertex_buffers;
    SOSetTargets so_set_targets;
    OMSetRenderTargets om_set_render_targets;
    ClearDepthStencilView clear_depth_stencil_view;
    ClearRenderTargetView clear_render_target_view;
    ClearUnorderedAccessViewUint clear_unordered_access_view_uint;
    ClearUnorderedAccessViewFloat clear_unordered_access_view_float;
    DiscardResource discard_resource;
    BeginQuery begin_query;
    EndQuery end_query;
    ResolveQueryData resolve_query_data;
    SetPredication set_predication;
    SetMarker set_marker;
    BeginEvent begin_event;
    EndEvent end_event;
    ExecuteIndirect execute_indirect;

    // ID3D12GraphicsCommandList1 methods
    AtomicCopyBufferUINT atomic_copy_buffer_uint;
    AtomicCopyBufferUINT64 atomic_copy_buffer_uint64;
    OMSetDepthBounds om_set_depth_bounds;
    SetSamplePositions set_sample_positions;
    ResolveSubresourceRegion resolve_subresource_region;
    SetViewInstanceMask set_view_instance_mask;

    // ID3D12GraphicsCommandList2 methods
    WriteBufferImmediate write_buffer_immediate;

    // ID3D12GraphicsCommandList3 methods
    SetProtectedResourceSession set_protected_resource_session;

    // ID3D12GraphicsCommandList4 methods
    BeginRenderPass begin_render_pass;
    EndRenderPass end_render_pass;
    InitializeMetaCommand initialize_meta_command;
    ExecuteMetaCommand execute_meta_command;
    BuildRaytracingAccelerationStructure build_raytracing_acceleration_structure;
    EmitRaytracingAccelerationStructurePostbuildInfo emit_raytracing_acceleration_structure_postbuild_info;
    CopyRaytracingAccelerationStructure copy_raytracing_acceleration_structure;
    SetPipelineState1 set_pipeline_state1;
    DispatchRays dispatch_rays;

    // ID3D12GraphicsCommandList5 methods
    RSSetShadingRate rs_set_shading_rate;
    RSSetShadingRateImage rs_set_shading_rate_image;

    // ID3D12GraphicsCommandList6 methods
    DispatchMesh dispatch_mesh;

    // ID3D12GraphicsCommandList7 methods
    Barrier barrier;

    // ID3D12GraphicsCommandList8 methods
    OMSetFrontAndBackStencilRef om_set_front_and_back_stencil_ref;

    // ID3D12GraphicsCommandList9 methods
    RSSetDepthBias rs_set_depth_bias;
    IASetIndexBufferStripCutValue ia_set_index_buffer_strip_cut_value;

    // ID3D12GraphicsCommandList10 methods
    SetProgram set_program;
    DispatchGraph dispatch_graph;
}

interface ID3D12GraphicsCommandList : ID3D12CommandList
{
    fn GraphicsCommandListVersion get_version();

    <*
     Indicates that recording to the command list has finished.
    *>
    fn void? close();
    
    <*
     Resets a command list back to its initial state as if a new command list was just created.
     The command list must be in the closed state before it can be reset.
    *>
    fn void? reset(ID3D12CommandAllocator commandAllocator, ID3D12PipelineState initialPipelineState);
    
    fn void clear_state(ID3D12PipelineState pipelineState);

    <*
     Draws a number of instances of a non-indexed triangle list.
    *>
    fn void draw_instanced(Win32_UINT vertexCountPerInstance, Win32_UINT instanceCount, Win32_UINT startVertexLocation, Win32_UINT startInstanceLocation);
    
    <*
     Draws a number of instances of an indexed triangle list.
    *>
    fn void draw_indexed_instanced(Win32_UINT indexCountPerInstance, Win32_UINT instanceCount, Win32_UINT startIndexLocation, Win32_INT baseVertexLocation, Win32_UINT startInstanceLocation);

    <*
     Dispatches a number of threads in a compute shader.

     @require threadGroupCountX <= D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION
     @require threadGroupCountY <= D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION
     @require threadGroupCountZ <= D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION
    *>
    fn void dispatch(Win32_UINT threadGroupCountX, Win32_UINT threadGroupCountY, Win32_UINT threadGroupCountZ);
    
    <*
     Copies a region of a buffer resource to another buffer resource.
    *>
    fn void copy_buffer_region(ID3D12Resource dstBuffer, Win32_UINT64 dstOffset, ID3D12Resource srcBuffer, Win32_UINT64 srcOffset, Win32_UINT64 numBytes);
    
    <*
     Copies a region of a texture resource to another texture resource. If the resources are buffers then
     all units are in bytes. If they are textures then all units are in texels. The two resources cannot
     be the same resource. If you try and copy outside the destination resource or specify a source box
     that is larger than the source resource the behaviour is undefined.
    
     To copy the entire resource it is recommended to use copy_resource instead.
    *>
    fn void copy_texture_region(Dx_D3D12_TEXTURE_COPY_LOCATION* dstTexture, Win32_UINT dstX, Win32_UINT dstY, Win32_UINT dstZ, Dx_D3D12_TEXTURE_COPY_LOCATION* srcTexture, Dx_D3D12_BOX* srcBox);

    <*
     Copies a resource to another resource.
    *>
    fn void copy_resource(ID3D12Resource dstResource, ID3D12Resource srcResource);

    <*
     Copies a set of tiles from one resource to another.
    *>
    fn void copy_tiles(ID3D12Resource tiledResource, Dx_D3D12_TILED_RESOURCE_COORDINATE* regionStartCoordinate, Dx_D3D12_TILE_REGION_SIZE* regionSizeInTiles, ID3D12Resource buffer, Win32_UINT64 bufferStartOffsetInBytes, Dx_D3D12_TILE_COPY_FLAGS flags);

    <*
     Copy a multi-sampled resource into a non-multi-sampled resource.
    *>
    fn void resolve_subresource(ID3D12Resource dstResource, Win32_UINT dstSubresource, ID3D12Resource srcResource, Win32_UINT srcSubresource, Dx_DXGI_FORMAT format);

    <*
     Sets the primitive topology for the command list.
    *>
    fn void ia_set_primitive_topology(Dx_D3D12_PRIMITIVE_TOPOLOGY primitiveTopology);

    <*
     Bind an array of viewports to the rasterizer stage of the pipeline.
    
     @require numViewports <= D3D12_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE
    *>
    fn void rs_set_viewports(Win32_UINT numViewports, Dx_D3D12_VIEWPORT* viewports);

    <*
     Bind an array of scissor rectangles to the rasterizer stage of the pipeline. All scissor rectangles must be set atomically as one operation.
     Any scissor rectangles not defined by the call are disabled.
    *>
    fn void rs_set_scissor_rects(Win32_UINT numRects, Dx_D3D12_RECT* rects);

    <*
     Sets the blend factor that modulate values for a pixel shader, render target, or both.
    *>
    fn void om_set_blend_factor(float[4] blendFactor);

    <*
     Sets the stencil reference value for the depth-stencil state.
    *>
    fn void om_set_stencil_ref(Win32_UINT stencilRef);

    <*
     Sets the pipeline state object for the command list.
    *>
    fn void set_pipeline_state(ID3D12PipelineState pipelineState);

    <*
     Notifies the driver that it needs to synchronize multiple accesses to resources.
    *>
    fn void resource_barrier(Dx_D3D12_RESOURCE_BARRIER[] barriers);

    <*
     Executes a command list that has been previously recorded.
    *>
    fn void execute_bundle(ID3D12GraphicsCommandList commandList);

    <*
     Sets the descriptor heaps that the command list will use.
    
     @require descriptorHeaps.len <= 2
    *>
    fn void set_descriptor_heaps(ID3D12DescriptorHeap[] descriptorHeaps);

    <*
     Sets the compute root signature for the command list.
    *>
    fn void set_compute_root_signature(ID3D12RootSignature rootSignature);

    <*
     Sets the graphics root signature for the command list.
    *>
    fn void set_graphics_root_signature(ID3D12RootSignature rootSignature);

    <*
     Sets a descriptor table into the compute root signature.
    *>
    fn void set_compute_root_descriptor_table(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_DESCRIPTOR_HANDLE baseDescriptor);

    <*
     Sets a descriptor table into the graphics root signature.
    *>
    fn void set_graphics_root_descriptor_table(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_DESCRIPTOR_HANDLE baseDescriptor);

    <*
     Sets a 32-bit constant in the compute root signature.
    *>
    fn void set_compute_root_32_bit_constant(Win32_UINT rootParameterIndex, Win32_UINT value, Win32_UINT destOffsetIn32BitValues);

    <*
     Sets a 32-bit constant in the compute root signature.
    *>
    fn void set_graphics_root_32_bit_constant(Win32_UINT rootParameterIndex, Win32_UINT value, Win32_UINT destOffsetIn32BitValues);

    <*
     Sets a 32-bit constant for the command list.
    *>
    fn void set_compute_root_32_bit_constants(Win32_UINT rootParameterIndex, Win32_UINT num32BitValuesToSet, Win32_UINT* pSrcData, Win32_UINT destOffsetIn32BitValues);

    <*
     Sets a graphics root 32-bit constant for the command list.
    *>
    fn void set_graphics_root_32_bit_constants(Win32_UINT rootParameterIndex, Win32_UINT num32BitValuesToSet, Win32_UINT* pSrcData, Win32_UINT destOffsetIn32BitValues);

    <*
     Sets a constant buffer view in the compute root signature.
    *>
    fn void set_compute_root_constant_buffer_view(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation);

    <*
     Sets a constant buffer view in the graphics root signature.
    *>
    fn void set_graphics_root_constant_buffer_view(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation);

    <*
     Sets a shader resource view in the compute root signature.
    *>
    fn void set_compute_root_shader_resource_view(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation);

    <*
     Sets a shader resource view in the graphics root signature.
    *>
    fn void set_graphics_root_shader_resource_view(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation);

    <*
     Sets an unordered access view in the compute root signature.
    *>
    fn void set_compute_root_unordered_access_view(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation);

    <*
     Sets an unordered access view in the graphics root signature.
    *>
    fn void set_graphics_root_unordered_access_view(Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation);

    <*
     Sets the view for the index buffer.
    *>
    fn void ia_set_index_buffer(Dx_D3D12_INDEX_BUFFER_VIEW* indexBufferView);

    <*
     Sets a CPU descriptor handle for the vertex buffers.
    *>
    fn void ia_set_vertex_buffers(Win32_UINT startSlot, Win32_UINT numBuffers, Dx_D3D12_VERTEX_BUFFER_VIEW* vertexBufferViews);

    <*
     Sets the stream output buffer views.
    *>
    fn void so_set_targets(Win32_UINT startSlot, Win32_UINT numBuffers, Dx_D3D12_STREAM_OUTPUT_BUFFER_VIEW* bufferViews);

    <*
     Sets CPU descriptor handles for the render targets and depth stencil.
    *>
    fn void om_set_render_targets(Win32_UINT numRenderTargetDescriptors, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* renderTargetDescriptors, bool rtsSingleHandleToDescriptorRange, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* depthStencilDescriptor);

    <*
     Clears the depth-stencil resource.
    *>
    fn void clear_depth_stencil_view(Dx_D3D12_CPU_DESCRIPTOR_HANDLE depthStencilView, Dx_D3D12_CLEAR_FLAGS clearFlags, float depth, Win32_UINT8 stencil, Win32_UINT numRects, Dx_D3D12_RECT* rects);

    <*
     Clears the render target view.
    *>
    fn void clear_render_target_view(Dx_D3D12_CPU_DESCRIPTOR_HANDLE renderTargetView, float[4] colorRGBA, Win32_UINT numRects, Dx_D3D12_RECT* rects);

    <*
     Clears an unordered access view to a specific value.
    
     Note: This behaves like a compute operation in that it isn't ordered with respect to surrounding work such as Dispatch calls.
    *>
    fn void clear_unordered_access_view_uint(Dx_D3D12_GPU_DESCRIPTOR_HANDLE viewGPUHandleInCurrentHeap, Dx_D3D12_CPU_DESCRIPTOR_HANDLE viewCPUHandle, ID3D12Resource resource, Win32_UINT[4] values, Win32_UINT numRects, Dx_D3D12_RECT* rects);

    <*
     Clears an unordered access view to a specific value.
    
     Note: This behaves like a compute operation in that it isn't ordered with respect to surrounding work such as Dispatch calls.
    *>
    fn void clear_unordered_access_view_float(Dx_D3D12_GPU_DESCRIPTOR_HANDLE viewGPUHandleInCurrentHeap, Dx_D3D12_CPU_DESCRIPTOR_HANDLE viewCPUHandle, ID3D12Resource resource, float[4] values, Win32_UINT numRects, Dx_D3D12_RECT* rects);

    <*
     Discards the contents of a resource.
    *>
    fn void discard_resource(ID3D12Resource resource, Dx_D3D12_DISCARD_REGION* region);

    <*
     Starts a query running.
    *>
    fn void begin_query(ID3D12QueryHeap queryHeap, Dx_D3D12_QUERY_TYPE type, Win32_UINT index);

    <*
     Ends a query that was started with begin_query.
    *>
    fn void end_query(ID3D12QueryHeap queryHeap, Dx_D3D12_QUERY_TYPE type, Win32_UINT index);

    <*
     Resolves the results of a query to a buffer.
    *>
    fn void resolve_query_data(ID3D12QueryHeap queryHeap, Dx_D3D12_QUERY_TYPE type, Win32_UINT index, Win32_UINT numQueries, ID3D12Resource dstBuffer, Win32_UINT64 dstOffsetInBytes);

    <*
     Sets a rendering predicate.
    *>
    fn void set_predication(ID3D12Resource predicate, Win32_UINT64 alignedBufferOffset, Dx_D3D12_PREDICATION_OP operation);

    fn void set_marker(Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes);

    fn void begin_event(Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes);

    fn void end_event();

    <*
     Performs indirect draws or dispatches.
    *>
    fn void execute_indirect(ID3D12CommandSignature commandSignature, Win32_UINT maxCommandCount, ID3D12Resource argumentBuffer, Win32_UINT64 argumentBufferOffset, ID3D12Resource countBuffer, Win32_UINT64 countBufferOffset);

    // ID3D12GraphicsCommandList1 methods
    <*
     Atomically copies a primary data element of type UINT from one resource to another, along with optional dependent resources.
    *>
    fn void? atomic_copy_buffer_uint(ID3D12Resource dstResource, Win32_UINT64 dstOffsetInBytes, ID3D12Resource srcResource, Win32_UINT64 srcOffsetInBytes, Win32_UINT dependencies, ID3D12Resource* dependentResources, Dx_D3D12_SUBRESOURCE_RANGE_UINT64* dependentSubresourceRanges);

    <*
     Atomically copies a primary data element of type UINT64 from one resource to another, along with optional dependent resources.
    *>
    fn void? atomic_copy_buffer_uint64(ID3D12Resource dstResource, Win32_UINT64 dstOffsetInBytes, ID3D12Resource srcResource, Win32_UINT64 srcOffsetInBytes, Win32_UINT dependencies, ID3D12Resource* dependentResources, Dx_D3D12_SUBRESOURCE_RANGE_UINT64* dependentSubresourceRanges);

    <*
     This method enables you to change the depth bounds dynamically.
    *>
    fn void? om_set_depth_bounds(float minDepth, float maxDepth);

    <*
     This method configures the sample positions used by subsequent draw, copy, resolve, and similar operations.
    *>
    fn void? set_sample_positions(Win32_UINT numSamplesPerPixel, Win32_UINT numPixels, Dx_D3D12_SAMPLE_POSITION* samplePositions);

    <*
     Copy a region of a multisampled or compressed resource into a non-multisampled or non-compressed resource.
    *>
    fn void? resolve_subresource_region(ID3D12Resource dstResource, Win32_UINT dstSubresource, Win32_UINT dstX, Win32_UINT dstY, ID3D12Resource srcResource, Win32_UINT srcSubresource, Dx_D3D12_RECT* srcRect, Dx_DXGI_FORMAT format, Dx_D3D12_RESOLVE_MODE resolveMode);

    <*
     Set a mask that controls which view instances are enabled for subsequent draws.
    *>
    fn void? set_view_instance_mask(Win32_UINT viewInstanceMask);

    // ID3D12GraphicsCommandList2 methods

    <*
     Writes a number of 32-bit immediate values to the specified buffer locations directly from the command stream.
    *>
    fn void? write_buffer_immediate(Win32_UINT count, Dx_D3D12_WRITEBUFFERIMMEDIATE_PARAMETER* params, Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE* modes);

    // ID3D12GraphicsCommandList3 methods

    fn void? set_protected_resource_session(ID3D12ProtectedResourceSession protectedResourceSession);

    // ID3D12GraphicsCommandList4 methods

    fn void? begin_render_pass(Dx_D3D12_RENDER_PASS_RENDER_TARGET_DESC[] renderTargets, Dx_D3D12_RENDER_PASS_DEPTH_STENCIL_DESC* depthStencil, Dx_D3D12_RENDER_PASS_FLAGS flags);

    fn void? end_render_pass();

    fn void? initialize_meta_command(ID3D12MetaCommand metaCommand, void* initializationParametersData, Win32_UINT initializationParametersDataSizeInBytes);

    fn void? execute_meta_command(ID3D12MetaCommand metaCommand, void* executionParametersData, Win32_UINT executionParametersDataSizeInBytes);

    fn void? build_raytracing_acceleration_structure(Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC* desc, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC[] postbuildInfoDescs);

    fn void? emit_raytracing_acceleration_structure_postbuild_info(Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC* postbuildInfoDesc, Dx_D3D12_GPU_VIRTUAL_ADDRESS[] source_acceleration_structures);

    fn void? copy_raytracing_acceleration_structure(Dx_D3D12_GPU_VIRTUAL_ADDRESS dstAccelerationStructure, Dx_D3D12_GPU_VIRTUAL_ADDRESS srcAccelerationStructure, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE mode);

    fn void? set_pipeline_state1(ID3D12StateObject pipelineState);

    fn void? dispatch_rays(Dx_D3D12_DISPATCH_RAYS_DESC* desc);

    // ID3D12GraphicsCommandList5 methods
    fn void? rs_set_shading_rate(Dx_D3D12_SHADING_RATE shadingRate, Dx_D3D12_SHADING_RATE_COMBINER[D3D12_RS_SET_SHADING_RATE_COMBINER_COUNT] combiner);

    fn void? rs_set_shading_rate_image(ID3D12Resource shadingRateImage);

    // ID3D12GraphicsCommandList6 methods
    fn void? dispatch_mesh(Win32_UINT threadGroupCountX, Win32_UINT threadGroupCountY, Win32_UINT threadGroupCountZ);

    // ID3D12GraphicsCommandList7 methods
    fn void? barrier(Dx_D3D12_BARRIER_GROUP[] barriers);

    // ID3D12GraphicsCommandList8 methods
    fn void? om_set_front_and_back_stencil_ref(Win32_UINT frontStencilRef, Win32_UINT backStencilRef);
    
    // ID3D12GraphicsCommandList9 methods
    fn void? rs_set_depth_bias(Win32_INT depthBias, float depthBiasClamp, Win32_UINT slopeScaledDepthBias);
    fn void? ia_set_index_buffer_strip_cut_value(Dx_D3D12_INDEX_BUFFER_STRIP_CUT_VALUE stripCutValue);

    // ID3D12GraphicsCommandList10 methods
    fn void? set_program(Dx_D3D12_SET_PROGRAM_DESC* program);
    fn void? dispatch_graph(Dx_D3D12_DISPATCH_GRAPH_DESC* desc);
}

struct ID3D12GraphicsCommandListImpl (ID3D12GraphicsCommandList)
{
    ID3D12GraphicsCommandListVtbl* vtbl;
    ID3D12GraphicsCommandListRaw* raw;
    GraphicsCommandListVersion version;
}

fn GraphicsCommandListVersion ID3D12GraphicsCommandListImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12GraphicsCommandListImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12GraphicsCommandListImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12GraphicsCommandListImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12GraphicsCommandListImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12GraphicsCommandListImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12GraphicsCommandListImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12GraphicsCommandListImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12GraphicsCommandListImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12GraphicsCommandListImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn Dx_D3D12_COMMAND_LIST_TYPE ID3D12GraphicsCommandListImpl.get_type(&self) @dynamic
{
    return self.vtbl.get_type(self.raw);
}

fn void? ID3D12GraphicsCommandListImpl.close(&self) @dynamic
{
    Win32_HRESULT hr = self.vtbl.close(self.raw);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12GraphicsCommandListImpl.reset(&self, ID3D12CommandAllocator commandAllocator, ID3D12PipelineState initialPipelineState) @dynamic
{
    Win32_HRESULT hr = self.vtbl.reset(self.raw, commandAllocator.get_com_ptr(), initialPipelineState ? initialPipelineState.get_com_ptr() : null);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void ID3D12GraphicsCommandListImpl.clear_state(&self, ID3D12PipelineState pipelineState) @dynamic
{
    self.vtbl.clear_state(self.raw, pipelineState.get_com_ptr());
}

fn void ID3D12GraphicsCommandListImpl.draw_instanced(&self, Win32_UINT vertexCountPerInstance, Win32_UINT instanceCount, Win32_UINT startVertexLocation, Win32_UINT startInstanceLocation) @dynamic
{
    self.vtbl.draw_instanced(self.raw, vertexCountPerInstance, instanceCount, startVertexLocation, startInstanceLocation);
}

fn void ID3D12GraphicsCommandListImpl.draw_indexed_instanced(&self, Win32_UINT indexCountPerInstance, Win32_UINT instanceCount, Win32_UINT startIndexLocation, Win32_INT baseVertexLocation, Win32_UINT startInstanceLocation) @dynamic
{
    self.vtbl.draw_indexed_instanced(self.raw, indexCountPerInstance, instanceCount, startIndexLocation, baseVertexLocation, startInstanceLocation);
}

fn void ID3D12GraphicsCommandListImpl.dispatch(&self, Win32_UINT threadGroupCountX, Win32_UINT threadGroupCountY, Win32_UINT threadGroupCountZ) @dynamic
{
    self.vtbl.dispatch(self.raw, threadGroupCountX, threadGroupCountY, threadGroupCountZ);
}

fn void ID3D12GraphicsCommandListImpl.copy_buffer_region(&self, ID3D12Resource dstBuffer, Win32_UINT64 dstOffset, ID3D12Resource srcBuffer, Win32_UINT64 srcOffset, Win32_UINT64 numBytes) @dynamic
{
    self.vtbl.copy_buffer_region(self.raw, dstBuffer.get_com_ptr(), dstOffset, srcBuffer.get_com_ptr(), srcOffset, numBytes);
}

fn void ID3D12GraphicsCommandListImpl.copy_texture_region(&self, Dx_D3D12_TEXTURE_COPY_LOCATION* dstTexture, Win32_UINT dstX, Win32_UINT dstY, Win32_UINT dstZ, Dx_D3D12_TEXTURE_COPY_LOCATION* srcTexture, Dx_D3D12_BOX* srcBox) @dynamic
{
    self.vtbl.copy_texture_region(self.raw, dstTexture, dstX, dstY, dstZ, srcTexture, srcBox);
}

fn void ID3D12GraphicsCommandListImpl.copy_resource(&self, ID3D12Resource dstResource, ID3D12Resource srcResource) @dynamic
{
    self.vtbl.copy_resource(self.raw, dstResource.get_com_ptr(), srcResource.get_com_ptr());
}

fn void ID3D12GraphicsCommandListImpl.copy_tiles(&self, ID3D12Resource tiledResource, Dx_D3D12_TILED_RESOURCE_COORDINATE* regionStartCoordinate, Dx_D3D12_TILE_REGION_SIZE* regionSizeInTiles, ID3D12Resource buffer, Win32_UINT64 bufferStartOffsetInBytes, Dx_D3D12_TILE_COPY_FLAGS flags) @dynamic
{
    self.vtbl.copy_tiles(self.raw, tiledResource.get_com_ptr(), regionStartCoordinate, regionSizeInTiles, buffer.get_com_ptr(), bufferStartOffsetInBytes, flags);
}

fn void ID3D12GraphicsCommandListImpl.resolve_subresource(&self, ID3D12Resource dstResource, Win32_UINT dstSubresource, ID3D12Resource srcResource, Win32_UINT srcSubresource, Dx_DXGI_FORMAT format) @dynamic
{
    self.vtbl.resolve_subresource(self.raw, dstResource.get_com_ptr(), dstSubresource, srcResource.get_com_ptr(), srcSubresource, format);
}

fn void ID3D12GraphicsCommandListImpl.ia_set_primitive_topology(&self, Dx_D3D12_PRIMITIVE_TOPOLOGY primitiveTopology) @dynamic
{
    self.vtbl.ia_set_primitive_topology(self.raw, primitiveTopology);
}

fn void ID3D12GraphicsCommandListImpl.rs_set_viewports(&self, Win32_UINT numViewports, Dx_D3D12_VIEWPORT* viewports) @dynamic
{
    self.vtbl.rs_set_viewports(self.raw, numViewports, viewports);
}

fn void ID3D12GraphicsCommandListImpl.rs_set_scissor_rects(&self, Win32_UINT numRects, Dx_D3D12_RECT* rects) @dynamic
{
    self.vtbl.rs_set_scissor_rects(self.raw, numRects, rects);
}

fn void ID3D12GraphicsCommandListImpl.om_set_blend_factor(&self, float[4] blendFactor) @dynamic
{
    self.vtbl.om_set_blend_factor(self.raw, blendFactor);
}

fn void ID3D12GraphicsCommandListImpl.om_set_stencil_ref(&self, Win32_UINT stencilRef) @dynamic
{
    self.vtbl.om_set_stencil_ref(self.raw, stencilRef);
}

fn void ID3D12GraphicsCommandListImpl.set_pipeline_state(&self, ID3D12PipelineState pipelineState) @dynamic
{
    self.vtbl.set_pipeline_state(self.raw, pipelineState.get_com_ptr());
}

fn void ID3D12GraphicsCommandListImpl.resource_barrier(&self, Dx_D3D12_RESOURCE_BARRIER[] barriers) @dynamic
{
    self.vtbl.resource_barrier(self.raw, barriers.len, barriers.ptr);
}

fn void ID3D12GraphicsCommandListImpl.execute_bundle(&self, ID3D12GraphicsCommandList commandList) @dynamic
{
    self.vtbl.execute_bundle(self.raw, commandList.get_com_ptr());
}

fn void ID3D12GraphicsCommandListImpl.set_descriptor_heaps(&self, ID3D12DescriptorHeap[] descriptorHeaps) @dynamic
{
    void** heaps = mem::temp_array(void*, descriptorHeaps.len);
    for (int i = 0; i < descriptorHeaps.len; i++)
    {
        heaps[i] = descriptorHeaps[i].get_com_ptr();
    }
    self.vtbl.set_descriptor_heaps(self.raw, descriptorHeaps.len, heaps);
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_signature(&self, ID3D12RootSignature rootSignature) @dynamic
{
    self.vtbl.set_compute_root_signature(self.raw, rootSignature.get_com_ptr());
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_signature(&self, ID3D12RootSignature rootSignature) @dynamic
{
    self.vtbl.set_graphics_root_signature(self.raw, rootSignature.get_com_ptr());
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_descriptor_table(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_DESCRIPTOR_HANDLE baseDescriptor) @dynamic
{
    self.vtbl.set_compute_root_descriptor_table(self.raw, rootParameterIndex, baseDescriptor);
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_descriptor_table(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_DESCRIPTOR_HANDLE baseDescriptor) @dynamic
{
    self.vtbl.set_graphics_root_descriptor_table(self.raw, rootParameterIndex, baseDescriptor);
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_32_bit_constant(&self, Win32_UINT rootParameterIndex, Win32_UINT value, Win32_UINT destOffsetIn32BitValues) @dynamic
{
    self.vtbl.set_compute_root_32_bit_constant(self.raw, rootParameterIndex, value, destOffsetIn32BitValues);
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_32_bit_constant(&self, Win32_UINT rootParameterIndex, Win32_UINT value, Win32_UINT destOffsetIn32BitValues) @dynamic
{
    self.vtbl.set_graphics_root_32_bit_constant(self.raw, rootParameterIndex, value, destOffsetIn32BitValues);
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_32_bit_constants(&self, Win32_UINT rootParameterIndex, Win32_UINT num32BitValuesToSet, Win32_UINT* pSrcData, Win32_UINT destOffsetIn32BitValues) @dynamic
{
    self.vtbl.set_compute_root_32_bit_constants(self.raw, rootParameterIndex, num32BitValuesToSet, pSrcData, destOffsetIn32BitValues);
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_32_bit_constants(&self, Win32_UINT rootParameterIndex, Win32_UINT num32BitValuesToSet, Win32_UINT* pSrcData, Win32_UINT destOffsetIn32BitValues) @dynamic
{
    self.vtbl.set_graphics_root_32_bit_constants(self.raw, rootParameterIndex, num32BitValuesToSet, pSrcData, destOffsetIn32BitValues);
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_constant_buffer_view(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation) @dynamic
{
    self.vtbl.set_compute_root_constant_buffer_view(self.raw, rootParameterIndex, bufferLocation);
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_constant_buffer_view(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation) @dynamic
{
    self.vtbl.set_graphics_root_constant_buffer_view(self.raw, rootParameterIndex, bufferLocation);
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_shader_resource_view(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation) @dynamic
{
    self.vtbl.set_compute_root_shader_resource_view(self.raw, rootParameterIndex, bufferLocation);
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_shader_resource_view(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation) @dynamic
{
    self.vtbl.set_graphics_root_shader_resource_view(self.raw, rootParameterIndex, bufferLocation);
}

fn void ID3D12GraphicsCommandListImpl.set_compute_root_unordered_access_view(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation) @dynamic
{
    self.vtbl.set_compute_root_unordered_access_view(self.raw, rootParameterIndex, bufferLocation);
}

fn void ID3D12GraphicsCommandListImpl.set_graphics_root_unordered_access_view(&self, Win32_UINT rootParameterIndex, Dx_D3D12_GPU_VIRTUAL_ADDRESS bufferLocation) @dynamic
{
    self.vtbl.set_graphics_root_unordered_access_view(self.raw, rootParameterIndex, bufferLocation);
}

fn void ID3D12GraphicsCommandListImpl.ia_set_index_buffer(&self, Dx_D3D12_INDEX_BUFFER_VIEW* indexBufferView) @dynamic
{
    self.vtbl.ia_set_index_buffer(self.raw, indexBufferView);
}

fn void ID3D12GraphicsCommandListImpl.ia_set_vertex_buffers(&self, Win32_UINT startSlot, Win32_UINT numBuffers, Dx_D3D12_VERTEX_BUFFER_VIEW* vertexBufferViews) @dynamic
{
    self.vtbl.ia_set_vertex_buffers(self.raw, startSlot, numBuffers, vertexBufferViews);
}

fn void ID3D12GraphicsCommandListImpl.so_set_targets(&self, Win32_UINT startSlot, Win32_UINT numBuffers, Dx_D3D12_STREAM_OUTPUT_BUFFER_VIEW* bufferViews) @dynamic
{
    self.vtbl.so_set_targets(self.raw, startSlot, numBuffers, bufferViews);
}

fn void ID3D12GraphicsCommandListImpl.om_set_render_targets(&self, Win32_UINT numRenderTargetDescriptors, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* renderTargetDescriptors, bool rtsSingleHandleToDescriptorRange, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* depthStencilDescriptor) @dynamic
{
    self.vtbl.om_set_render_targets(self.raw, numRenderTargetDescriptors, renderTargetDescriptors, rtsSingleHandleToDescriptorRange, depthStencilDescriptor);
}

fn void ID3D12GraphicsCommandListImpl.clear_depth_stencil_view(&self, Dx_D3D12_CPU_DESCRIPTOR_HANDLE depthStencilView, Dx_D3D12_CLEAR_FLAGS clearFlags, float depth, Win32_UINT8 stencil, Win32_UINT numRects, Dx_D3D12_RECT* rects) @dynamic
{
    self.vtbl.clear_depth_stencil_view(self.raw, depthStencilView, clearFlags, depth, stencil, numRects, rects);
}

fn void ID3D12GraphicsCommandListImpl.clear_render_target_view(&self, Dx_D3D12_CPU_DESCRIPTOR_HANDLE renderTargetView, float[4] colorRGBA, Win32_UINT numRects, Dx_D3D12_RECT* rects) @dynamic
{
    self.vtbl.clear_render_target_view(self.raw, renderTargetView, colorRGBA, numRects, rects);
}

fn void ID3D12GraphicsCommandListImpl.clear_unordered_access_view_uint(&self, Dx_D3D12_GPU_DESCRIPTOR_HANDLE viewGPUHandleInCurrentHeap, Dx_D3D12_CPU_DESCRIPTOR_HANDLE viewCPUHandle, ID3D12Resource resource, Win32_UINT[4] values, Win32_UINT numRects, Dx_D3D12_RECT* rects) @dynamic
{
    self.vtbl.clear_unordered_access_view_uint(self.raw, viewGPUHandleInCurrentHeap, viewCPUHandle, resource.get_com_ptr(), values, numRects, rects);
}

fn void ID3D12GraphicsCommandListImpl.clear_unordered_access_view_float(&self, Dx_D3D12_GPU_DESCRIPTOR_HANDLE viewGPUHandleInCurrentHeap, Dx_D3D12_CPU_DESCRIPTOR_HANDLE viewCPUHandle, ID3D12Resource resource, float[4] values, Win32_UINT numRects, Dx_D3D12_RECT* rects) @dynamic
{
    self.vtbl.clear_unordered_access_view_float(self.raw, viewGPUHandleInCurrentHeap, viewCPUHandle, resource.get_com_ptr(), values, numRects, rects);
}

fn void ID3D12GraphicsCommandListImpl.discard_resource(&self, ID3D12Resource resource, Dx_D3D12_DISCARD_REGION* region) @dynamic
{
    self.vtbl.discard_resource(self.raw, resource.get_com_ptr(), region);
}

fn void ID3D12GraphicsCommandListImpl.begin_query(&self, ID3D12QueryHeap queryHeap, Dx_D3D12_QUERY_TYPE type, Win32_UINT index) @dynamic
{
    self.vtbl.begin_query(self.raw, queryHeap.get_com_ptr(), type, index);
}

fn void ID3D12GraphicsCommandListImpl.end_query(&self, ID3D12QueryHeap queryHeap, Dx_D3D12_QUERY_TYPE type, Win32_UINT index) @dynamic
{
    self.vtbl.end_query(self.raw, queryHeap.get_com_ptr(), type, index);
}

fn void ID3D12GraphicsCommandListImpl.resolve_query_data(&self, ID3D12QueryHeap queryHeap, Dx_D3D12_QUERY_TYPE type, Win32_UINT index, Win32_UINT numQueries, ID3D12Resource dstBuffer, Win32_UINT64 dstOffsetInBytes) @dynamic
{
    self.vtbl.resolve_query_data(self.raw, queryHeap.get_com_ptr(), type, index, numQueries, dstBuffer.get_com_ptr(), dstOffsetInBytes);
}

fn void ID3D12GraphicsCommandListImpl.set_predication(&self, ID3D12Resource predicate, Win32_UINT64 alignedBufferOffset, Dx_D3D12_PREDICATION_OP operation) @dynamic
{
    self.vtbl.set_predication(self.raw, predicate.get_com_ptr(), alignedBufferOffset, operation);
}

fn void ID3D12GraphicsCommandListImpl.set_marker(&self, Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes) @dynamic
{
    self.vtbl.set_marker(self.raw, metadata, data, dataSizeInBytes);
}

fn void ID3D12GraphicsCommandListImpl.begin_event(&self, Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes) @dynamic
{
    self.vtbl.begin_event(self.raw, metadata, data, dataSizeInBytes);
}

fn void ID3D12GraphicsCommandListImpl.end_event(&self) @dynamic
{
    self.vtbl.end_event(self.raw);
}

fn void ID3D12GraphicsCommandListImpl.execute_indirect(&self, ID3D12CommandSignature commandSignature, Win32_UINT maxCommandCount, ID3D12Resource argumentBuffer, Win32_UINT64 argumentBufferOffset, ID3D12Resource countBuffer, Win32_UINT64 countBufferOffset) @dynamic
{
    self.vtbl.execute_indirect(self.raw, commandSignature.get_com_ptr(), maxCommandCount, argumentBuffer.get_com_ptr(), argumentBufferOffset, countBuffer.get_com_ptr(), countBufferOffset);
}

fn void? ID3D12GraphicsCommandListImpl.atomic_copy_buffer_uint(&self, ID3D12Resource dstResource, Win32_UINT64 dstOffsetInBytes, ID3D12Resource srcResource, Win32_UINT64 srcOffsetInBytes, Win32_UINT dependencies, ID3D12Resource* dependentResources, Dx_D3D12_SUBRESOURCE_RANGE_UINT64* dependentSubresourceRanges) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST1)!;
    void** dependents = mem::temp_array(void*, dependencies);
    for (int i = 0; i < dependencies; i++)
    {
        dependents[i] = dependentResources[i].get_com_ptr();
    }
    self.vtbl.atomic_copy_buffer_uint(self.raw, dstResource.get_com_ptr(), dstOffsetInBytes, srcResource.get_com_ptr(), srcOffsetInBytes, dependencies, dependents, dependentSubresourceRanges);
}

fn void? ID3D12GraphicsCommandListImpl.atomic_copy_buffer_uint64(&self, ID3D12Resource dstResource, Win32_UINT64 dstOffsetInBytes, ID3D12Resource srcResource, Win32_UINT64 srcOffsetInBytes, Win32_UINT dependencies, ID3D12Resource* dependentResources, Dx_D3D12_SUBRESOURCE_RANGE_UINT64* dependentSubresourceRanges) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST1)!;
    void** dependents = mem::temp_array(void*, dependencies);
    for (int i = 0; i < dependencies; i++)
    {
        dependents[i] = dependentResources[i].get_com_ptr();
    }
    self.vtbl.atomic_copy_buffer_uint64(self.raw, dstResource.get_com_ptr(), dstOffsetInBytes, srcResource.get_com_ptr(), srcOffsetInBytes, dependencies, dependents, dependentSubresourceRanges);
}

fn void? ID3D12GraphicsCommandListImpl.om_set_depth_bounds(&self, float minDepth, float maxDepth) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST1)!;
    self.vtbl.om_set_depth_bounds(self.raw, minDepth, maxDepth);
}

fn void? ID3D12GraphicsCommandListImpl.set_sample_positions(&self, Win32_UINT numSamplesPerPixel, Win32_UINT numPixels, Dx_D3D12_SAMPLE_POSITION* samplePositions) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST1)!;
    self.vtbl.set_sample_positions(self.raw, numSamplesPerPixel, numPixels, samplePositions);
}

fn void? ID3D12GraphicsCommandListImpl.resolve_subresource_region(&self, ID3D12Resource dstResource, Win32_UINT dstSubresource, Win32_UINT dstX, Win32_UINT dstY, ID3D12Resource srcResource, Win32_UINT srcSubresource, Dx_D3D12_RECT* srcRect, Dx_DXGI_FORMAT format, Dx_D3D12_RESOLVE_MODE resolveMode) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST1)!;
    self.vtbl.resolve_subresource_region(self.raw, dstResource.get_com_ptr(), dstSubresource, dstX, dstY, srcResource.get_com_ptr(), srcSubresource, srcRect, format, resolveMode);
}

fn void? ID3D12GraphicsCommandListImpl.set_view_instance_mask(&self, Win32_UINT viewInstanceMask) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST1)!;
    self.vtbl.set_view_instance_mask(self.raw, viewInstanceMask);
}

fn void? ID3D12GraphicsCommandListImpl.write_buffer_immediate(&self, Win32_UINT count, Dx_D3D12_WRITEBUFFERIMMEDIATE_PARAMETER* params, Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE* modes) @dynamic 
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST2)!;
    self.vtbl.write_buffer_immediate(self.raw, count, params, modes);
}

fn void? ID3D12GraphicsCommandListImpl.set_protected_resource_session(&self, ID3D12ProtectedResourceSession protectedResourceSession) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST3)!;
    self.vtbl.set_protected_resource_session(self.raw, protectedResourceSession.get_com_ptr());
}

fn void? ID3D12GraphicsCommandListImpl.begin_render_pass(&self, Dx_D3D12_RENDER_PASS_RENDER_TARGET_DESC[] renderTargets, Dx_D3D12_RENDER_PASS_DEPTH_STENCIL_DESC* depthStencil, Dx_D3D12_RENDER_PASS_FLAGS flags) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.begin_render_pass(self.raw, renderTargets.len, renderTargets.ptr, depthStencil, flags);
}

fn void? ID3D12GraphicsCommandListImpl.end_render_pass(&self) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.end_render_pass(self.raw);
}

fn void? ID3D12GraphicsCommandListImpl.initialize_meta_command(&self, ID3D12MetaCommand metaCommand, void* initializationParametersData, Win32_UINT initializationParametersDataSizeInBytes) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.initialize_meta_command(self.raw, metaCommand.get_com_ptr(), initializationParametersData, initializationParametersDataSizeInBytes);
}

fn void? ID3D12GraphicsCommandListImpl.execute_meta_command(&self, ID3D12MetaCommand metaCommand, void* executionParametersData, Win32_UINT executionParametersDataSizeInBytes) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.execute_meta_command(self.raw, metaCommand.get_com_ptr(), executionParametersData, executionParametersDataSizeInBytes);
}

fn void? ID3D12GraphicsCommandListImpl.build_raytracing_acceleration_structure(&self, Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC* desc, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC[] postbuildInfoDescs) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.build_raytracing_acceleration_structure(self.raw, desc, postbuildInfoDescs.len, postbuildInfoDescs.ptr);
}

fn void? ID3D12GraphicsCommandListImpl.emit_raytracing_acceleration_structure_postbuild_info(&self, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC* postbuildInfoDesc, Dx_D3D12_GPU_VIRTUAL_ADDRESS[] source_acceleration_structures) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.emit_raytracing_acceleration_structure_postbuild_info(self.raw, postbuildInfoDesc, source_acceleration_structures.len, source_acceleration_structures.ptr);
}

fn void? ID3D12GraphicsCommandListImpl.copy_raytracing_acceleration_structure(&self, Dx_D3D12_GPU_VIRTUAL_ADDRESS dstAccelerationStructure, Dx_D3D12_GPU_VIRTUAL_ADDRESS srcAccelerationStructure, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE mode) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.copy_raytracing_acceleration_structure(self.raw, dstAccelerationStructure, srcAccelerationStructure, mode);
}

fn void? ID3D12GraphicsCommandListImpl.set_pipeline_state1(&self, ID3D12StateObject pipelineState) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.set_pipeline_state1(self.raw, pipelineState.get_com_ptr());
}

fn void? ID3D12GraphicsCommandListImpl.dispatch_rays(&self, Dx_D3D12_DISPATCH_RAYS_DESC* desc) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST4)!;
    self.vtbl.dispatch_rays(self.raw, desc);
}

fn void? ID3D12GraphicsCommandListImpl.rs_set_shading_rate(&self, Dx_D3D12_SHADING_RATE shadingRate, Dx_D3D12_SHADING_RATE_COMBINER[D3D12_RS_SET_SHADING_RATE_COMBINER_COUNT] combiner) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST5)!;
    self.vtbl.rs_set_shading_rate(self.raw, shadingRate, &combiner[0]);
}

fn void? ID3D12GraphicsCommandListImpl.rs_set_shading_rate_image(&self, ID3D12Resource shadingRateImage) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST5)!;
    self.vtbl.rs_set_shading_rate_image(self.raw, shadingRateImage.get_com_ptr());
}

fn void? ID3D12GraphicsCommandListImpl.dispatch_mesh(&self, Win32_UINT threadGroupCountX, Win32_UINT threadGroupCountY, Win32_UINT threadGroupCountZ) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST6)!;
    self.vtbl.dispatch_mesh(self.raw, threadGroupCountX, threadGroupCountY, threadGroupCountZ);
}

fn void? ID3D12GraphicsCommandListImpl.barrier(&self, Dx_D3D12_BARRIER_GROUP[] barriers) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST7)!;
    self.vtbl.barrier(self.raw, barriers.len, barriers.ptr);
}

fn void? ID3D12GraphicsCommandListImpl.om_set_front_and_back_stencil_ref(&self, Win32_UINT frontStencilRef, Win32_UINT backStencilRef) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST8)!;
    self.vtbl.om_set_front_and_back_stencil_ref(self.raw, frontStencilRef, backStencilRef);
}

fn void? ID3D12GraphicsCommandListImpl.rs_set_depth_bias(&self, Win32_INT depthBias, float depthBiasClamp, Win32_UINT slopeScaledDepthBias) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST9)!;
    self.vtbl.rs_set_depth_bias(self.raw, depthBias, depthBiasClamp, slopeScaledDepthBias);
}

fn void? ID3D12GraphicsCommandListImpl.ia_set_index_buffer_strip_cut_value(&self, Dx_D3D12_INDEX_BUFFER_STRIP_CUT_VALUE stripCutValue) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST9)!;
    self.vtbl.ia_set_index_buffer_strip_cut_value(self.raw, stripCutValue);
}

fn void? ID3D12GraphicsCommandListImpl.set_program(&self, Dx_D3D12_SET_PROGRAM_DESC* program) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST10)!;
    self.vtbl.set_program(self.raw, program);
}

fn void? ID3D12GraphicsCommandListImpl.dispatch_graph(&self, Dx_D3D12_DISPATCH_GRAPH_DESC* desc) @dynamic
{
    validate_version(self.version, GraphicsCommandListVersion.COMMAND_LIST10)!;
    self.vtbl.dispatch_graph(self.raw, desc);
}

struct ID3D12CommandQueueVtbl
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;
    
    // ID3D12CommandQueue methods
    UpdateTileMappings update_tile_mappings;
    CopyTileMappings copy_tile_mappings;
    ExecuteCommandLists execute_command_lists;
    SetMarker set_marker;
    BeginEvent begin_event;
    EndEvent end_event;
    SignalFence signal;
    Wait wait;
    GetTimestampFrequency get_timestamp_frequency;
    GetClockCalibration get_clock_calibration;
    GetCommandQueueDesc get_desc;
}

interface ID3D12CommandQueue : ID3D12Pageable
{

    <*
     Updates mappings of tile locations in reserved resources to memory locations in a resource heap.
    
     @param [&in] resource
     @param [&in] resourceRegionStartCoordinates
     @param [&in] resourceRegionSizes
    *>
    fn void update_tile_mappings(ID3D12Resource resource, Win32_UINT numResourceRegions, Dx_D3D12_TILED_RESOURCE_COORDINATE* resourceRegionStartCoordinates, Dx_D3D12_TILE_REGION_SIZE* resourceRegionSizes, ID3D12Heap heap, Win32_UINT numRanges, Dx_D3D12_TILE_RANGE_FLAGS* rangeFlags, Win32_UINT* heapRangeStartOffsets, Win32_UINT* rangeTileCounts, Dx_D3D12_TILE_MAPPING_FLAGS flags);

    <*
     Copies mappings from a source reserved resource to a destination reserved resource.
    
     @param [&in] dstResource
     @param [&in] dstRegionStartCoordinate
     @param [&in] srcResource
     @param [&in] srcRegionStartCoordinate
     @param [&in] regionSize
    *>
    fn void copy_tile_mappings(ID3D12Resource dstResource, Dx_D3D12_TILED_RESOURCE_COORDINATE* dstRegionStartCoordinate, ID3D12Resource srcResource, Dx_D3D12_TILED_RESOURCE_COORDINATE* srcRegionStartCoordinate, Dx_D3D12_TILE_REGION_SIZE* regionSize, Dx_D3D12_TILE_MAPPING_FLAGS flags);

    <*
     Executes a list of command lists.
    *>
    fn void execute_command_lists(ID3D12CommandList[] commandLists);

    fn void set_marker(Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes);

    fn void begin_event(Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes);

    fn void end_event();

    <*
     Signals a fence to indicate that the command queue has completed all commands up to the specified fence value.
    
     @param [&in] fence
    *>
    fn void? signal(ID3D12Fence fence, Win32_UINT64 value);

    <*
     Queues a GPU-side wait, and returns immediately. A GPU-side wait is where the GPU waits until the specified fence reaches or exceeds the specified value.
    
     @param [&in] fence
    *>
    fn void? wait(ID3D12Fence fence, Win32_UINT64 value);

    <*
     Gets the frequency of the GPU's timestamp counter.
    *>
    fn Win32_UINT64? get_timestamp_frequency();

    <*
     This method samples the CPU and GPU timestamp counters at the same moment in time.
    
     @param [out] gpuTimestamp
     @param [out] cpuTimestamp
    *>
    fn void? get_clock_calibration(Win32_UINT64* gpuTimestamp, Win32_UINT64* cpuTimestamp);

    <*
     Gets the description of the command queue.
    *>
    fn Dx_D3D12_COMMAND_QUEUE_DESC get_desc();

}

struct ID3D12CommandQueueImpl (ID3D12CommandQueue)
{
    ID3D12CommandQueueVtbl* vtbl;
    ID3D12CommandQueueRaw* raw;
}

fn void* ID3D12CommandQueueImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12CommandQueueImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12CommandQueueImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12CommandQueueImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12CommandQueueImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12CommandQueueImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12CommandQueueImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12CommandQueueImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12CommandQueueImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn void ID3D12CommandQueueImpl.update_tile_mappings(&self, ID3D12Resource resource, Win32_UINT numResourceRegions, Dx_D3D12_TILED_RESOURCE_COORDINATE* resourceRegionStartCoordinates, Dx_D3D12_TILE_REGION_SIZE* resourceRegionSizes, ID3D12Heap heap, Win32_UINT numRanges, Dx_D3D12_TILE_RANGE_FLAGS* rangeFlags, Win32_UINT* heapRangeStartOffsets, Win32_UINT* rangeTileCounts, Dx_D3D12_TILE_MAPPING_FLAGS flags) @dynamic
{
    self.vtbl.update_tile_mappings(self.raw, resource.get_com_ptr(), numResourceRegions, resourceRegionStartCoordinates, resourceRegionSizes, heap.get_com_ptr(), numRanges, rangeFlags, heapRangeStartOffsets, rangeTileCounts, flags);
}

fn void ID3D12CommandQueueImpl.copy_tile_mappings(&self, ID3D12Resource dstResource, Dx_D3D12_TILED_RESOURCE_COORDINATE* dstRegionStartCoordinate, ID3D12Resource srcResource, Dx_D3D12_TILED_RESOURCE_COORDINATE* srcRegionStartCoordinate, Dx_D3D12_TILE_REGION_SIZE* regionSize, Dx_D3D12_TILE_MAPPING_FLAGS flags) @dynamic
{
    self.vtbl.copy_tile_mappings(self.raw, dstResource.get_com_ptr(), dstRegionStartCoordinate, srcResource.get_com_ptr(), srcRegionStartCoordinate, regionSize, flags);
}

fn void ID3D12CommandQueueImpl.execute_command_lists(&self, ID3D12CommandList[] commandLists) @dynamic
{
    void** lists = mem::temp_array(void*, commandLists.len);
    for (int i = 0; i < commandLists.len; i++)
    {
        lists[i] = commandLists[i].get_com_ptr();
    }
    self.vtbl.execute_command_lists(self.raw, commandLists.len, lists);
}

fn void ID3D12CommandQueueImpl.set_marker(&self, Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes) @dynamic
{
    self.vtbl.set_marker(self.raw, metadata, data, dataSizeInBytes);
}

fn void ID3D12CommandQueueImpl.begin_event(&self, Win32_UINT metadata, void* data, Win32_UINT dataSizeInBytes) @dynamic
{
    self.vtbl.begin_event(self.raw, metadata, data, dataSizeInBytes);
}

fn void ID3D12CommandQueueImpl.end_event(&self) @dynamic
{
    self.vtbl.end_event(self.raw);
}

fn void? ID3D12CommandQueueImpl.signal(&self, ID3D12Fence fence, Win32_UINT64 value) @dynamic
{
    Win32_HRESULT hr = self.vtbl.signal(self.raw, fence.get_com_ptr(), value);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12CommandQueueImpl.wait(&self, ID3D12Fence fence, Win32_UINT64 value) @dynamic
{
    Win32_HRESULT hr = self.vtbl.wait(self.raw, fence.get_com_ptr(), value);
    if (hr != S_OK) check_hresult(hr)!;
}

fn Win32_UINT64? ID3D12CommandQueueImpl.get_timestamp_frequency(&self) @dynamic
{
    Win32_UINT64 frequency;
    Win32_HRESULT hr = self.vtbl.get_timestamp_frequency(self.raw, &frequency);
    if (hr != S_OK) check_hresult(hr)!;
    return frequency;
}

fn void? ID3D12CommandQueueImpl.get_clock_calibration(&self, Win32_UINT64* gpuTimestamp, Win32_UINT64* cpuTimestamp) @dynamic
{
    Win32_HRESULT hr = self.vtbl.get_clock_calibration(self.raw, gpuTimestamp, cpuTimestamp);
    if (hr != S_OK) check_hresult(hr)!;
}

fn Dx_D3D12_COMMAND_QUEUE_DESC ID3D12CommandQueueImpl.get_desc(&self) @dynamic
{
    Dx_D3D12_COMMAND_QUEUE_DESC desc;
    self.vtbl.get_desc(self.raw, &desc);
    return desc;
}

struct ID3D12MetaCommandVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12MetaCommand methods
    GetRequiredParameterResourceSize get_required_parameter_resource_size;
}

interface ID3D12MetaCommand : ID3D12Pageable
{
    fn Win32_UINT64 get_required_parameter_resource_size(Dx_D3D12_META_COMMAND_PARAMETER_STAGE stage, Win32_UINT parameterIndex);
}

struct ID3D12MetaCommandImpl (ID3D12MetaCommand)
{
    ID3D12MetaCommandVtbl* vtbl;
    ID3D12MetaCommandRaw* raw;
}

fn void* ID3D12MetaCommandImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12MetaCommandImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12MetaCommandImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12MetaCommandImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12MetaCommandImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12MetaCommandImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12MetaCommandImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12MetaCommandImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12MetaCommandImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn Win32_UINT64 ID3D12MetaCommandImpl.get_required_parameter_resource_size(&self, Dx_D3D12_META_COMMAND_PARAMETER_STAGE stage, Win32_UINT parameterIndex) @dynamic
{
    Win32_UINT64 size = self.vtbl.get_required_parameter_resource_size(self.raw, stage, parameterIndex);
    return size;
}