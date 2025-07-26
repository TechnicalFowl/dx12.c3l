module d3d12;

import std::os::win32;
import dxgi;

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

struct ID3D12DeviceChildVtbl @private
{
    // ID3D12Object methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    SetName set_name;

    // ID3D12DeviceChild methods
    GetDevice get_device;
}

interface ID3D12DeviceChild : ID3D12Object
{
    fn ID3D12Device? get_device();
}

fn ID3D12Device? get_device_helper(void* this, GetDevice func)
{
    void* device;
    DeviceVersion version = g_supported_version_tracker.device_version;
    if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) DeviceVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = DeviceVersion.from_ordinal(i).riid;
            hr = func(this, riid, &device);
            if (hr == S_OK)
            {
                version = DeviceVersion.from_ordinal(i);
                g_supported_version_tracker.device_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            g_supported_version_tracker.device_version = NOT_SUPPORTED;
            return NOINTERFACE?;
        }
    }
    else
    {
        Win32_HRESULT hr = func(this, version.riid, &device);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(device != null, "Failed to create device, no supported version found");
    ID3D12DeviceImpl* impl = mem::new(ID3D12DeviceImpl);
    impl.vtbl = *(ID3D12DeviceVtbl**) device;
    impl.raw = (ID3D12DeviceRaw*) device;
    impl.version = version;
    return impl;
}

struct ID3D12DeviceVtbl @private
{
    // ID3D12Object methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    SetName set_name;

    // ID3D12Device methods
    GetNodeCount get_node_count;
    CreateCommandQueue create_command_queue;
    CreateCommandAllocator create_command_allocator;
    CreateGraphicsPipelineState create_graphics_pipeline_state;
    CreateComputePipelineState create_compute_pipeline_state;
    CreateCommandList create_command_list;
    CheckFeatureSupport check_feature_support;
    CreateDescriptorHeap create_descriptor_heap;
    GetDescriptorHandleIncrementSize get_descriptor_handle_increment_size;
    CreateRootSignature create_root_signature;
    CreateConstantBufferView create_constant_buffer_view;
    CreateShaderResourceView create_shader_resource_view;
    CreateUnorderedAccessView create_unordered_access_view;
    CreateRenderTargetView create_render_target_view;
    CreateDepthStencilView create_depth_stencil_view;
    CreateSampler create_sampler;
    CopyDescriptors copy_descriptors;
    CopyDescriptorsSimple copy_descriptors_simple;
    GetResourceAllocationInfo get_resource_allocation_info;
    GetCustomHeapProperties get_custom_heap_properties;
    CreateCommittedResource create_committed_resource;
    CreateHeap create_heap;
    CreatePlacedResource create_placed_resource;
    CreateReservedResource create_reserved_resource;
    CreateSharedHandle create_shared_handle;
    OpenSharedHandle open_shared_handle;
    OpenSharedHandleByName open_shared_handle_by_name;
    MakeResident make_resident;
    Evict evict;
    CreateFence create_fence;
    GetDeviceRemovedReason get_device_removed_reason;
    GetCopyableFootprints get_copyable_footprints;
    CreateQueryHeap create_query_heap;
    SetStablePowerState set_stable_power_state;
    CreateCommandSignature create_command_signature;
    GetResourceTiling get_resource_tiling;
    GetAdapterLuid get_adapter_luid;

    // ID3D12Device1 methods
    CreatePipelineLibrary create_pipeline_library;
    SetEventOnMultipleFenceCompletion set_event_on_multiple_fence_completion;
    SetResidencyPriority set_residency_priority;

    // ID3D12Device2 methods
    CreatePipelineState create_pipeline_state;

    // ID3D12Device3 methods
    OpenExistingHeapFromAddress open_existing_heap_from_address;
    OpenExistingHeapFromFileMapping open_existing_heap_from_file_mapping;
    EnqueueMakeResident enqueue_make_resident;

    // ID3D12Device4 methods
    CreateCommandList1 create_command_list1;
    CreateProtectedResourceSession create_protected_resource_session;
    CreateCommittedResource1 create_committed_resource1;
    CreateHeap1 create_heap1;
    CreateReservedResource1 create_reserved_resource1;
    GetResourceAllocationInfo1 get_resource_allocation_info1;

    // ID3D12Device5 methods
    CreateLifetimeTracker create_lifetime_tracker;
    RemoveDevice remove_device;
    EnumerateMetaCommands enumerate_meta_commands;
    EnumerateMetaCommandParameters enumerate_meta_command_parameters;
    CreateMetaCommand create_meta_command;
    CreateStateObject create_state_object;
    GetRaytracingAccelerationStructurePrebuildInfo get_raytracing_acceleration_structure_prebuild_info;
    CheckDriverMatchingIdentifier check_driver_matching_identifier;

    // ID3D12Device6 methods
    SetBackgroundProcessingMode set_background_processing_mode;

    // ID3D12Device7 methods
    AddToStateObject add_to_state_object;
    CreateProtectedResourceSession1 create_protected_resource_session1;

    // ID3D12Device8 methods
    GetResourceAllocationInfo2 get_resource_allocation_info2;
    CreateCommittedResource2 create_committed_resource2;
    CreatePlacedResource1 create_placed_resource1;
    CreateSamplerFeedbackUnorderedAccessView create_sampler_feedback_unordered_access_view;
    GetCopyableFootprints1 get_copyable_footprints1;

    // ID3D12Device9 methods
    CreateShaderCacheSession create_shader_cache_session;
    ShaderCacheControl shader_cache_control;
    CreateCommandQueue1 create_command_queue1;

    // ID3D12Device10 methods
    CreateCommittedResource3 create_committed_resource3;
    CreatePlacedResource2 create_placed_resource2;
    CreateReservedResource2 create_reserved_resource2;

    // ID3D12Device11 methods
    CreateSampler2 create_sampler2;

    // ID3D12Device12 methods
    GetResourceAllocationInfo3 get_resource_allocation_info3;

    // ID3D12Device13 methods
    OpenExistingHeapFromAddress1 open_existing_heap_from_address1;

    // ID3D12Device14 methods
    CreateRootSignatureFromSubobjectInLibrary create_root_signature_from_subobject_in_library;
}

interface ID3D12Device : ID3D12Object
{
    fn DeviceVersion get_device_version();

    fn Win32_ULONG get_node_count();
    
    <*
     Creates a command queue.
    *>
    fn ID3D12CommandQueue? create_command_queue(Dx_D3D12_COMMAND_QUEUE_DESC* desc);

    <*
     Creates a command allocator object.
    *>
    fn ID3D12CommandAllocator? create_command_allocator(Dx_D3D12_COMMAND_LIST_TYPE type);
    fn ID3D12PipelineState? create_graphics_pipeline_state(Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC* desc);
    fn ID3D12PipelineState? create_compute_pipeline_state(Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC* desc);
    
    <*
     Creates a command list.
    *>
    fn ID3D12GraphicsCommandList? create_command_list(Win32_UINT node_mask, Dx_D3D12_COMMAND_LIST_TYPE type, ID3D12CommandAllocator command_allocator, ID3D12PipelineState initial_state);

    <*
     Gets information about the features that are supported by the current graphics driver.
    *>
    fn void? check_feature_support(Dx_D3D12_FEATURE feature, void* feature_data, Win32_UINT feature_data_size);
    fn ID3D12DescriptorHeap? create_descriptor_heap(Dx_D3D12_DESCRIPTOR_HEAP_DESC* desc);
    fn Win32_UINT get_descriptor_handle_increment_size(Dx_D3D12_DESCRIPTOR_HEAP_TYPE heap_type);
    fn ID3D12RootSignature? create_root_signature(Win32_UINT node_mask, char[] blob_with_root_signature);
    fn void create_constant_buffer_view(Dx_D3D12_CONSTANT_BUFFER_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);
    fn void create_shader_resource_view(ID3D12Resource resource, Dx_D3D12_SHADER_RESOURCE_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);
    fn void create_unordered_access_view(ID3D12Resource resource, ID3D12Resource counter_resource, Dx_D3D12_UNORDERED_ACCESS_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);
    fn void create_render_target_view(ID3D12Resource resource, Dx_D3D12_RENDER_TARGET_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);
    fn void create_depth_stencil_view(ID3D12Resource resource, Dx_D3D12_DEPTH_STENCIL_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);
    fn void create_sampler(Dx_D3D12_SAMPLER_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);

    <*
     Copies descriptors from a source to a destination.
    *>
    fn void copy_descriptors(Win32_UINT numDestDescriptorRanges, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* destDescriptorRangeStarts, Win32_UINT* destDescriptorRangeSizes, Win32_UINT numSrcDescriptorRanges, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* srcDescriptorRangeStarts, Win32_UINT* srcDescriptorRangeSizes, Dx_D3D12_DESCRIPTOR_HEAP_TYPE descriptorHeapType);

    <*
     Copies descriptors from a source to a destination.
    *>
    fn void copy_descriptors_simple(Win32_UINT count, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor, Dx_D3D12_CPU_DESCRIPTOR_HANDLE src_descriptor, Dx_D3D12_DESCRIPTOR_HEAP_TYPE heap_type);
    fn Dx_D3D12_RESOURCE_ALLOCATION_INFO get_resource_allocation_info(Win32_UINT visible_mask, Win32_UINT resource_count, Dx_D3D12_RESOURCE_DESC* resources);
    fn Dx_D3D12_HEAP_PROPERTIES get_custom_heap_properties(Win32_UINT node_mask, Dx_D3D12_HEAP_TYPE heap_type);
    fn ID3D12Resource? create_committed_resource(Dx_D3D12_HEAP_PROPERTIES* heap_properties, Dx_D3D12_HEAP_FLAGS heap_flags, Dx_D3D12_RESOURCE_DESC* resource_desc, Dx_D3D12_RESOURCE_STATES initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value);
    fn ID3D12Heap? create_heap(Dx_D3D12_HEAP_DESC* desc);
    fn ID3D12Resource? create_placed_resource(ID3D12Heap heap, Win32_SIZE_T heap_offset, Dx_D3D12_RESOURCE_DESC* resource_desc, Dx_D3D12_RESOURCE_STATES initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value);
    fn ID3D12Resource? create_reserved_resource(Dx_D3D12_RESOURCE_DESC* resource_desc, Dx_D3D12_RESOURCE_STATES initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value);
    fn Win32_HANDLE? create_shared_handle(ID3D12DeviceChild resource, Win32_SECURITY_ATTRIBUTES* attributes, Win32_DWORD access, WString name);
    fn IUnknown? open_shared_handle(Win32_HANDLE handle, Win32_REFIID riid);
    fn Win32_HANDLE? open_shared_handle_by_name(WString name, Win32_DWORD access);
    fn void? make_resident(ID3D12Pageable[] objects);
    fn void? evict(ID3D12Pageable[] objects);
    fn ID3D12Fence? create_fence(Win32_UINT64 initial_value, Dx_D3D12_FENCE_FLAGS flags);
    fn Win32_HRESULT get_device_removed_reason();
    fn void get_copyable_footprints(Dx_D3D12_RESOURCE_DESC* resource_desc, Win32_UINT first_subresource, Win32_UINT num_subresources, Win32_SIZE_T base_offset, Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT* layouts, Win32_UINT* num_rows, Win32_UINT64* row_size_in_bytes, Win32_SIZE_T* total_bytes);
    fn ID3D12QueryHeap? create_query_heap(Dx_D3D12_QUERY_HEAP_DESC* desc);
    fn void? set_stable_power_state(Win32_BOOL enable);
    
    <*
     This method creates a command signature.
    *>
    fn ID3D12CommandSignature? create_command_signature(Dx_D3D12_COMMAND_SIGNATURE_DESC* desc, ID3D12RootSignature root_signature);
    fn void get_resource_tiling(ID3D12Resource resource, Win32_UINT* num_tiles_for_all_subresources, Dx_D3D12_PACKED_MIP_INFO* macked_mip_desc, Dx_D3D12_TILE_SHAPE* standard_tile_shape_for_non_packed_mips, Win32_UINT* num_subresource_tilings_to_get, Win32_UINT first_subresource_tiling_to_get, Dx_D3D12_SUBRESOURCE_TILING* subresource_tilings);
    fn Win32_LUID get_adapter_luid();

    // ID3D12Device1 methods
    fn ID3D12PipelineLibrary? create_pipeline_library(void* libraryBlob, Win32_SIZE_T libraryBlobSize);
    fn void? set_event_on_multiple_fence_completion(ID3D12Fence[] fences, Win32_UINT64[] fenceValues, Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS flags, Win32_HANDLE eventHandle);
    fn void? set_residency_priority(ID3D12Pageable[] objects, Dx_D3D12_RESIDENCY_PRIORITY* priority);

    // ID3D12Device2 methods
    fn ID3D12PipelineState? create_pipeline_state(Dx_D3D12_PIPELINE_STATE_STREAM_DESC* desc);

    // ID3D12Device3 methods
    fn ID3D12Heap? open_existing_heap_from_address(void* address);
    fn ID3D12Heap? open_existing_heap_from_file_mapping(Win32_HANDLE fileMapping);
    fn void? enqueue_make_resident(Dx_D3D12_RESIDENCY_FLAGS flags, ID3D12Pageable[] objects, ID3D12Fence fence, Win32_UINT64 fenceValue);

    // ID3D12Device4 methods
    fn ID3D12CommandList? create_command_list1(Win32_UINT nodeMask, Dx_D3D12_COMMAND_LIST_TYPE type, Dx_D3D12_COMMAND_LIST_FLAGS flags);
    fn ID3D12ProtectedResourceSession? create_protected_resource_session(Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC* desc);
    fn ID3D12Resource? create_committed_resource1(Dx_D3D12_HEAP_PROPERTIES* heap_properties, Dx_D3D12_HEAP_FLAGS heap_flags, Dx_D3D12_RESOURCE_DESC* resource_desc, Dx_D3D12_RESOURCE_STATES initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, ID3D12ProtectedResourceSession protected_resource_session);
    fn ID3D12Heap? create_heap1(Dx_D3D12_HEAP_DESC* desc, ID3D12ProtectedResourceSession protected_resource_session);
    fn ID3D12Resource? create_reserved_resource1(Dx_D3D12_RESOURCE_DESC* resource_desc, Dx_D3D12_RESOURCE_STATES initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, ID3D12ProtectedResourceSession protected_resource_session);
    fn Dx_D3D12_RESOURCE_ALLOCATION_INFO? get_resource_allocation_info1(Win32_UINT visibleMask, Win32_UINT resourceCount, Dx_D3D12_RESOURCE_DESC* resources, Dx_D3D12_RESOURCE_ALLOCATION_INFO1* info1);
    
    // ID3D12Device5 methods
    fn ID3D12LifetimeTracker? create_lifetime_tracker(ID3D12LifetimeOwner owner);
    fn void? remove_device();
    fn Dx_D3D12_META_COMMAND_DESC[]? enumerate_meta_commands();
    fn Dx_D3D12_META_COMMAND_PARAMETER_DESC[]? enumerate_meta_command_parameters(Win32_REFGUID metaCommandId, Dx_D3D12_META_COMMAND_PARAMETER_STAGE stage, Win32_UINT* totalStructureSizeInBytes);
    fn ID3D12MetaCommand? create_meta_command(Win32_REFGUID metaCommandId, Win32_UINT node_mask, Win32_SIZE_T metaCommandCreationDataSizeInBytes, void* metaCommandCreationData);
    fn ID3D12StateObject? create_state_object(Dx_D3D12_STATE_OBJECT_DESC* desc);
    fn Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO? get_raytracing_acceleration_structure_prebuild_info(Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS* desc);
    fn Dx_D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS? check_driver_matching_identifier(Dx_D3D12_SERIALIZED_DATA_TYPE serializedDataType, Dx_D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER* identifierToCheck);

    // ID3D12Device6 methods
    fn bool? set_background_processing_mode(Dx_D3D12_BACKGROUND_PROCESSING_MODE mode, Dx_D3D12_MEASUREMENTS_ACTION action, Win32_HANDLE completionEvent);

    // ID3D12Device7 methods
    fn ID3D12StateObject? add_to_state_object(Dx_D3D12_STATE_OBJECT_DESC* addition, ID3D12StateObject stateObject);
    fn ID3D12ProtectedResourceSession? create_protected_resource_session1(Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1* desc);

    // ID3D12Device8 methods
    fn Dx_D3D12_RESOURCE_ALLOCATION_INFO? get_resource_allocation_info2(Win32_UINT visibleMask, Win32_UINT resourceCount, Dx_D3D12_RESOURCE_DESC1* resources, Dx_D3D12_RESOURCE_ALLOCATION_INFO1* resourceAllocationInfo1);
    fn ID3D12Resource? create_committed_resource2(Dx_D3D12_HEAP_PROPERTIES* heapProperties, Dx_D3D12_HEAP_FLAGS heapFlags, Dx_D3D12_RESOURCE_DESC1* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue, ID3D12ProtectedResourceSession protectedResourceSession);
    fn ID3D12Resource? create_placed_resource1(ID3D12Heap heap, Win32_UINT64 heapOffset, Dx_D3D12_RESOURCE_DESC1* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue);
    fn void? create_sampler_feedback_unordered_access_view(ID3D12Resource target_resource, ID3D12Resource feedback_resource, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);
    fn void? get_copyable_footprints1(Dx_D3D12_RESOURCE_DESC1* resource_desc, Win32_UINT first_subresource, Win32_UINT num_subresources, Win32_UINT64 base_offset, Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT* footprints, Win32_UINT* num_footprints, Win32_UINT64* row_size_in_bytes, Win32_UINT64* total_bytes);

    // ID3D12Device9 methods
    fn ID3D12ShaderCacheSession? create_shader_cache_session(Dx_D3D12_SHADER_CACHE_SESSION_DESC* desc);
    fn void? shader_cache_control(Dx_D3D12_SHADER_CACHE_KIND_FLAGS kind, Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS flags);
    fn ID3D12CommandQueue? create_command_queue1(Dx_D3D12_COMMAND_QUEUE_DESC* desc, Win32_REFIID creatorId);

    // ID3D12Device10 methods
    fn ID3D12Resource? create_committed_resource3(Dx_D3D12_HEAP_PROPERTIES* heap_properties, Dx_D3D12_HEAP_FLAGS heap_flags, Dx_D3D12_RESOURCE_DESC1* resource_desc, Dx_D3D12_BARRIER_LAYOUT initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, ID3D12ProtectedResourceSession protected_resource_session, Dx_DXGI_FORMAT[] castable_formats);
    fn ID3D12Resource? create_placed_resource2(ID3D12Heap heap, Win32_UINT64 heap_offset, Dx_D3D12_RESOURCE_DESC1* resource_desc, Dx_D3D12_BARRIER_LAYOUT initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, Dx_DXGI_FORMAT[] castable_formats);
    fn ID3D12Resource? create_reserved_resource2(Dx_D3D12_RESOURCE_DESC1* resource_desc, Dx_D3D12_BARRIER_LAYOUT initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, ID3D12ProtectedResourceSession protected_resource_session, Dx_DXGI_FORMAT[] castable_formats);

    // ID3D12Device11 methods
    fn void? create_sampler2(Dx_D3D12_SAMPLER_DESC2* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor);

    // ID3D12Device12 methods
    fn Dx_D3D12_RESOURCE_ALLOCATION_INFO? get_resource_allocation_info3(Win32_UINT visible_mask, Win32_UINT resource_count, Dx_D3D12_RESOURCE_DESC1* resources, Win32_UINT32* num_castable_formats, Dx_DXGI_FORMAT** castable_formats, Dx_D3D12_RESOURCE_ALLOCATION_INFO1* resource_allocation_info1);

    // ID3D12Device13 methods
    fn ID3D12Heap? open_existing_heap_from_address1(void* address, Win32_SIZE_T size);

    // ID3D12Device14 methods
    fn ID3D12RootSignature? create_root_signature_from_subobject_in_library(Win32_UINT node_mask, void* library_blob, Win32_SIZE_T, Win32_LPCWSTR subobject_name);
}

struct ID3D12DeviceImpl (ID3D12Device)
{
    ID3D12DeviceVtbl* vtbl;
    ID3D12DeviceRaw* raw;
    DeviceVersion version;
}

fn DeviceVersion ID3D12DeviceImpl.get_device_version(&self) @dynamic => self.version;

fn void* ID3D12DeviceImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12DeviceImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12DeviceImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12DeviceImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12DeviceImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12DeviceImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12DeviceImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12DeviceImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);

fn Win32_UINT ID3D12DeviceImpl.get_node_count(&self) @dynamic
{
    return self.vtbl.get_node_count(self.raw);
}

fn ID3D12CommandQueue? ID3D12DeviceImpl.create_command_queue(&self, Dx_D3D12_COMMAND_QUEUE_DESC* desc) @dynamic
{
    void* commandQueue;
    Win32_HRESULT hr = self.vtbl.create_command_queue(self.raw, desc, &IID_ID3D12COMMANDQUEUE, &commandQueue);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12CommandQueueImpl* impl = mem::new(ID3D12CommandQueueImpl);
    impl.vtbl = *(ID3D12CommandQueueVtbl**) commandQueue;
    impl.raw = (ID3D12CommandQueueRaw*) commandQueue;
    return impl;
}

fn ID3D12CommandAllocator? ID3D12DeviceImpl.create_command_allocator(&self, Dx_D3D12_COMMAND_LIST_TYPE type) @dynamic
{
    void* commandAllocator;
    Win32_HRESULT hr = self.vtbl.create_command_allocator(self.raw, type, &IID_ID3D12COMMANDALLOCATOR, &commandAllocator);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12CommandAllocatorImpl* impl = mem::new(ID3D12CommandAllocatorImpl);
    impl.vtbl = *(ID3D12CommandAllocatorVtbl**) commandAllocator;
    impl.raw = (ID3D12CommandAllocatorRaw*) commandAllocator;
    return impl;
}

fn ID3D12PipelineState? ID3D12DeviceImpl.create_graphics_pipeline_state(&self, Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC* desc) @dynamic
{
    void* pipelineState;
    Win32_HRESULT hr = self.vtbl.create_graphics_pipeline_state(self.raw, desc, &IID_ID3D12PIPELINESTATE, &pipelineState);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12PipelineStateImpl* impl = mem::new(ID3D12PipelineStateImpl);
    impl.vtbl = *(ID3D12PipelineStateVtbl**) pipelineState;
    impl.raw = (ID3D12PipelineStateRaw*) pipelineState;
    return impl;
}

fn ID3D12PipelineState? ID3D12DeviceImpl.create_compute_pipeline_state(&self, Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC* desc) @dynamic
{
    void* pipelineState;
    Win32_HRESULT hr = self.vtbl.create_compute_pipeline_state(self.raw, desc, &IID_ID3D12PIPELINESTATE, &pipelineState);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12PipelineStateImpl* impl = mem::new(ID3D12PipelineStateImpl);
    impl.vtbl = *(ID3D12PipelineStateVtbl**) pipelineState;
    impl.raw = (ID3D12PipelineStateRaw*) pipelineState;
    return impl;
}

fn ID3D12GraphicsCommandList? ID3D12DeviceImpl.create_command_list(&self, Win32_UINT nodeMask, Dx_D3D12_COMMAND_LIST_TYPE type, ID3D12CommandAllocator commandAllocator, ID3D12PipelineState initialState) @dynamic
{
    void* command_list;
    GraphicsCommandListVersion version = g_supported_version_tracker.graphics_command_list_version;
    if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) GraphicsCommandListVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = GraphicsCommandListVersion.from_ordinal(i).riid;
            hr = self.vtbl.create_command_list(self.raw, nodeMask, type, commandAllocator.get_com_ptr(), initialState ? initialState.get_com_ptr() : null, riid, &command_list);
            if (hr == S_OK)
            {
                version = GraphicsCommandListVersion.from_ordinal(i);
                g_supported_version_tracker.graphics_command_list_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            g_supported_version_tracker.graphics_command_list_version = NOT_SUPPORTED;
            return NOINTERFACE?;
        }
    }
    else
    {
        Win32_REFIID riid = version.riid;
        Win32_HRESULT hr = self.vtbl.create_command_list(self.raw, nodeMask, type, commandAllocator.get_com_ptr(), initialState.get_com_ptr(), riid, &command_list);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(command_list != null, "Failed to create graphics command list, no supported version found");
    ID3D12GraphicsCommandListImpl* impl = mem::new(ID3D12GraphicsCommandListImpl);
    impl.vtbl = *(ID3D12GraphicsCommandListVtbl**) command_list;
    impl.raw = (ID3D12GraphicsCommandListRaw*) command_list;
    impl.version = version;
    return impl;
}

fn void? ID3D12DeviceImpl.check_feature_support(&self, Dx_D3D12_FEATURE feature, void* featureSupportData, Win32_UINT featureSupportDataSize) @dynamic
{
    Win32_HRESULT hr = self.vtbl.check_feature_support(self.raw, feature, featureSupportData, featureSupportDataSize);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12DescriptorHeap? ID3D12DeviceImpl.create_descriptor_heap(&self, Dx_D3D12_DESCRIPTOR_HEAP_DESC* desc) @dynamic
{
    void* descriptorHeap;
    Win32_HRESULT hr = self.vtbl.create_descriptor_heap(self.raw, desc, &IID_ID3D12DESCRIPTORHEAP, &descriptorHeap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12DescriptorHeapImpl* impl = mem::new(ID3D12DescriptorHeapImpl);
    impl.vtbl = *(ID3D12DescriptorHeapVtbl**) descriptorHeap;
    impl.raw = (ID3D12DescriptorHeapRaw*) descriptorHeap;
    log_trace("Created descriptor heap with type: { .num_descriptors=%d .type=%s .flags=%d .node_mask=%d }", desc.num_descriptors, Dx_D3D12_DESCRIPTOR_HEAP_TYPE.names[desc.type], (uint)desc.flags, desc.node_mask);
    return impl;
}

fn Win32_UINT ID3D12DeviceImpl.get_descriptor_handle_increment_size(&self, Dx_D3D12_DESCRIPTOR_HEAP_TYPE descriptorHeapType) @dynamic
{
    Win32_UINT size = self.vtbl.get_descriptor_handle_increment_size(self.raw, descriptorHeapType);
    log_trace("Getting descriptor handle increment size for heap type: %s = %d", Dx_D3D12_DESCRIPTOR_HEAP_TYPE.names[descriptorHeapType], size);
    return size;
}

fn ID3D12RootSignature? ID3D12DeviceImpl.create_root_signature(&self, Win32_UINT nodeMask, char[] blobWithRootSignature) @dynamic
{
    void* rootSignature;
    Win32_HRESULT hr = self.vtbl.create_root_signature(self.raw, nodeMask, blobWithRootSignature.ptr, blobWithRootSignature.len, &IID_ID3D12ROOTSIGNATURE, &rootSignature);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12RootSignatureImpl* impl = mem::new(ID3D12RootSignatureImpl);
    impl.vtbl = *(ID3D12RootSignatureVtbl**) rootSignature;
    impl.raw = (ID3D12RootSignatureRaw*) rootSignature;
    return impl;
}

fn void ID3D12DeviceImpl.create_constant_buffer_view(&self, Dx_D3D12_CONSTANT_BUFFER_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    self.vtbl.create_constant_buffer_view(self.raw, desc, destDescriptor);
}

fn void ID3D12DeviceImpl.create_shader_resource_view(&self, ID3D12Resource resource, Dx_D3D12_SHADER_RESOURCE_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    self.vtbl.create_shader_resource_view(self.raw, resource.get_com_ptr(), desc, destDescriptor);
}

fn void ID3D12DeviceImpl.create_unordered_access_view(&self, ID3D12Resource resource, ID3D12Resource counterResource, Dx_D3D12_UNORDERED_ACCESS_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    self.vtbl.create_unordered_access_view(self.raw, resource.get_com_ptr(), counterResource.get_com_ptr(), desc, destDescriptor);
}

fn void ID3D12DeviceImpl.create_render_target_view(&self, ID3D12Resource resource, Dx_D3D12_RENDER_TARGET_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    self.vtbl.create_render_target_view(self.raw, resource.get_com_ptr(), desc, destDescriptor);
}

fn void ID3D12DeviceImpl.create_depth_stencil_view(&self, ID3D12Resource resource, Dx_D3D12_DEPTH_STENCIL_VIEW_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    self.vtbl.create_depth_stencil_view(self.raw, resource.get_com_ptr(), desc, destDescriptor);
}

fn void ID3D12DeviceImpl.create_sampler(&self, Dx_D3D12_SAMPLER_DESC* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    self.vtbl.create_sampler(self.raw, desc, destDescriptor);
}

fn void ID3D12DeviceImpl.copy_descriptors(&self, Win32_UINT numDestDescriptorRanges, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* destDescriptorRangeStarts, Win32_UINT* destDescriptorRangeSizes, Win32_UINT numSrcDescriptorRanges, Dx_D3D12_CPU_DESCRIPTOR_HANDLE* srcDescriptorRangeStarts, Win32_UINT* srcDescriptorRangeSizes, Dx_D3D12_DESCRIPTOR_HEAP_TYPE descriptorHeapType) @dynamic
{
    self.vtbl.copy_descriptors(self.raw, numDestDescriptorRanges, destDescriptorRangeStarts, destDescriptorRangeSizes, numSrcDescriptorRanges, srcDescriptorRangeStarts, srcDescriptorRangeSizes, descriptorHeapType);
}

fn void ID3D12DeviceImpl.copy_descriptors_simple(&self, Win32_UINT numDescriptors, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptorRangeStart, Dx_D3D12_CPU_DESCRIPTOR_HANDLE srcDescriptorRangeStart, Dx_D3D12_DESCRIPTOR_HEAP_TYPE descriptorHeapType) @dynamic
{
    self.vtbl.copy_descriptors_simple(self.raw, numDescriptors, destDescriptorRangeStart, srcDescriptorRangeStart, descriptorHeapType);
}

fn Dx_D3D12_RESOURCE_ALLOCATION_INFO ID3D12DeviceImpl.get_resource_allocation_info(&self, Win32_UINT visibleMask, Win32_UINT numResourceDescs, Dx_D3D12_RESOURCE_DESC* resourceDescs) @dynamic
{
    Dx_D3D12_RESOURCE_ALLOCATION_INFO info;
    self.vtbl.get_resource_allocation_info(self.raw, &info, visibleMask, numResourceDescs, resourceDescs);
    return info;
}

fn Dx_D3D12_HEAP_PROPERTIES ID3D12DeviceImpl.get_custom_heap_properties(&self, Win32_UINT nodeMask, Dx_D3D12_HEAP_TYPE heapType) @dynamic
{
    Dx_D3D12_HEAP_PROPERTIES properties;
    self.vtbl.get_custom_heap_properties(self.raw, &properties, nodeMask, heapType);
    return properties;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_committed_resource(&self, Dx_D3D12_HEAP_PROPERTIES* heapProperties, Dx_D3D12_HEAP_FLAGS heapFlags, Dx_D3D12_RESOURCE_DESC* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue) @dynamic
{
    void* resource;
    // @Todo: Allow creating resources with other riids than IID_ID3D12RESOURCE
    Win32_HRESULT hr = self.vtbl.create_committed_resource(self.raw, heapProperties, heapFlags, resourceDesc, initialResourceState, optimizedClearValue, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn ID3D12Heap? ID3D12DeviceImpl.create_heap(&self, Dx_D3D12_HEAP_DESC* desc) @dynamic
{
    void* heap;
    Win32_HRESULT hr = self.vtbl.create_heap(self.raw, desc, &IID_ID3D12HEAP, &heap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12HeapImpl* impl = mem::new(ID3D12HeapImpl);
    impl.vtbl = *(ID3D12HeapVtbl**) heap;
    impl.raw = (ID3D12HeapRaw*) heap;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_placed_resource(&self, ID3D12Heap heap, Win32_UINT64 heapOffset, Dx_D3D12_RESOURCE_DESC* resourceDesc, Dx_D3D12_RESOURCE_STATES initialState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue) @dynamic
{
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_placed_resource(self.raw, heap.get_com_ptr(), heapOffset, resourceDesc, initialState, optimizedClearValue, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_reserved_resource(&self, Dx_D3D12_RESOURCE_DESC* resourceDesc, Dx_D3D12_RESOURCE_STATES initialState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue) @dynamic
{
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_reserved_resource(self.raw, resourceDesc, initialState, optimizedClearValue, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn Win32_HANDLE? ID3D12DeviceImpl.create_shared_handle(&self, ID3D12DeviceChild object, Win32_SECURITY_ATTRIBUTES* attributes, Win32_DWORD access, WString name) @dynamic
{
    Win32_HANDLE handle;
    Win32_HRESULT hr = self.vtbl.create_shared_handle(self.raw, object.get_com_ptr(), attributes, access, name, &handle);
    if (hr != S_OK) check_hresult(hr)!;
    return handle;
}

fn IUnknown? ID3D12DeviceImpl.open_shared_handle(&self, Win32_HANDLE handle, Win32_REFIID riid) @dynamic
{
    void* resource; // @Todo: Heap, Resource, or Fence
    Win32_HRESULT hr = self.vtbl.open_shared_handle(self.raw, handle, riid, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    switch (*riid)
    {
    case IID_ID3D12RESOURCE:
        ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
        impl.vtbl = *(ID3D12ResourceVtbl**) resource;
        impl.raw = (ID3D12ResourceRaw*) resource;
        return impl;
    case IID_ID3D12HEAP:
        ID3D12HeapImpl* heapImpl = mem::new(ID3D12HeapImpl);
        heapImpl.vtbl = *(ID3D12HeapVtbl**) resource;
        heapImpl.raw = (ID3D12HeapRaw*) resource;
        return heapImpl;
    case IID_ID3D12FENCE:
        ID3D12FenceImpl* fenceImpl = mem::new(ID3D12FenceImpl);
        fenceImpl.vtbl = *(ID3D12FenceVtbl**) resource;
        fenceImpl.raw = (ID3D12FenceRaw*) resource;
        return fenceImpl;
    default:
        abort("Unsupported interface for open_shared_handle: %s", *riid);
    }
}

fn Win32_HANDLE? ID3D12DeviceImpl.open_shared_handle_by_name(&self, WString name, Win32_DWORD desiredAccess) @dynamic
{
    Win32_HANDLE resource;
    Win32_HRESULT hr = self.vtbl.open_shared_handle_by_name(self.raw, name, desiredAccess, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    return resource;
}

fn void? ID3D12DeviceImpl.make_resident(&self, ID3D12Pageable[] objects) @dynamic
{
    void** objectarray = mem::temp_array(void*, objects.len);
    for (int i = 0; i < objects.len; ++i)
    {
        objectarray[i] = objects[i].get_com_ptr();
    }
    Win32_HRESULT hr = self.vtbl.make_resident(self.raw, objects.len, objectarray);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12DeviceImpl.evict(&self, ID3D12Pageable[] objects) @dynamic
{
    void** objectarray = mem::temp_array(void*, objects.len);
    for (int i = 0; i < objects.len; ++i)
    {
        objectarray[i] = objects[i].get_com_ptr();
    }
    Win32_HRESULT hr = self.vtbl.evict(self.raw, objects.len, objectarray);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12Fence? ID3D12DeviceImpl.create_fence(&self, Win32_UINT64 initialValue, Dx_D3D12_FENCE_FLAGS flags) @dynamic
{
    void* fence;
    FenceVersion version = g_supported_version_tracker.fence_version;
    if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) FenceVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = FenceVersion.from_ordinal(i).riid;
            hr = self.vtbl.create_fence(self.raw, initialValue, flags, riid, &fence);
            if (hr == S_OK)
            {
                version = FenceVersion.from_ordinal(i);
                g_supported_version_tracker.fence_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            g_supported_version_tracker.fence_version = NOT_SUPPORTED;
            return NOINTERFACE?;
        }
    }
    else
    {
        Win32_REFIID riid = version.riid;
        Win32_HRESULT hr = self.vtbl.create_fence(self.raw, initialValue, flags, riid, &fence);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(fence != null, "Failed to create fence, no supported version found");
    ID3D12FenceImpl* impl = mem::new(ID3D12FenceImpl);
    impl.vtbl = *(ID3D12FenceVtbl**) fence;
    impl.raw = (ID3D12FenceRaw*) fence;
    impl.version = version;
    return impl;
}

fn Win32_HRESULT ID3D12DeviceImpl.get_device_removed_reason(&self) @dynamic
{
    return self.vtbl.get_device_removed_reason(self.raw);
}

fn void ID3D12DeviceImpl.get_copyable_footprints(&self, Dx_D3D12_RESOURCE_DESC* resourceDesc, Win32_UINT firstSubresource, Win32_UINT numSubresources, Win32_UINT64 baseOffset, Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT* layouts, Win32_UINT* numRows, Win32_UINT64* rowSizeInBytes, Win32_UINT64* totalBytes) @dynamic
{
    self.vtbl.get_copyable_footprints(self.raw, resourceDesc, firstSubresource, numSubresources, baseOffset, layouts, numRows, rowSizeInBytes, totalBytes);
}

fn ID3D12QueryHeap? ID3D12DeviceImpl.create_query_heap(&self, Dx_D3D12_QUERY_HEAP_DESC* desc) @dynamic
{
    void* queryHeap;
    Win32_HRESULT hr = self.vtbl.create_query_heap(self.raw, desc, &IID_ID3D12QUERYHEAP, &queryHeap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12QueryHeapImpl* impl = mem::new(ID3D12QueryHeapImpl);
    impl.vtbl = *(ID3D12QueryHeapVtbl**) queryHeap;
    impl.raw = (ID3D12QueryHeapRaw*) queryHeap;
    return impl;
}

fn void? ID3D12DeviceImpl.set_stable_power_state(&self, Win32_BOOL enable) @dynamic
{
    Win32_HRESULT hr = self.vtbl.set_stable_power_state(self.raw, enable);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12CommandSignature? ID3D12DeviceImpl.create_command_signature(&self, Dx_D3D12_COMMAND_SIGNATURE_DESC* desc, ID3D12RootSignature rootSignature) @dynamic
{
    void* commandSignature;
    Win32_HRESULT hr = self.vtbl.create_command_signature(self.raw, desc, rootSignature.get_com_ptr(), &IID_ID3D12COMMANDSIGNATURE, &commandSignature);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12CommandSignatureImpl* impl = mem::new(ID3D12CommandSignatureImpl);
    impl.vtbl = *(ID3D12CommandSignatureVtbl**) commandSignature;
    impl.raw = (ID3D12CommandSignatureRaw*) commandSignature;
    return impl;
}

fn void ID3D12DeviceImpl.get_resource_tiling(&self, ID3D12Resource resource, Win32_UINT* numTilesForEntireResource, Dx_D3D12_PACKED_MIP_INFO* packedMipInfo, Dx_D3D12_TILE_SHAPE* tileShapeForNonPackedMips, Win32_UINT* numSubresourceTilings, Win32_UINT first_subresource_tiling_to_get, Dx_D3D12_SUBRESOURCE_TILING* subresource_tilings_for_non_packed_mips) @dynamic
{
    self.vtbl.get_resource_tiling(self.raw, resource.get_com_ptr(), numTilesForEntireResource, packedMipInfo, tileShapeForNonPackedMips, numSubresourceTilings, first_subresource_tiling_to_get, subresource_tilings_for_non_packed_mips);
}

fn Win32_LUID ID3D12DeviceImpl.get_adapter_luid(&self) @dynamic
{
    Win32_LUID luid;
    self.vtbl.get_adapter_luid(self.raw, &luid);
    return luid;
}

fn ID3D12PipelineLibrary? ID3D12DeviceImpl.create_pipeline_library(&self, void* libraryBlob, Win32_SIZE_T libraryBlobSize) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE1)!;
    void* pipelineLibrary;
    PipelineLibraryVersion version = g_supported_version_tracker.pipeline_library_version;
    if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) PipelineLibraryVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = PipelineLibraryVersion.from_ordinal(i).riid;
            hr = self.vtbl.create_pipeline_library(self.raw, libraryBlob, libraryBlobSize, riid, &pipelineLibrary);
            if (hr == S_OK)
            {
                version = PipelineLibraryVersion.from_ordinal(i);
                g_supported_version_tracker.pipeline_library_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            g_supported_version_tracker.pipeline_library_version = NOT_SUPPORTED;
            return NOINTERFACE?;
        }
    }
    else
    {
        Win32_REFIID riid = version.riid;
        Win32_HRESULT hr = self.vtbl.create_pipeline_library(self.raw, libraryBlob, libraryBlobSize, riid, &pipelineLibrary);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(pipelineLibrary != null, "Failed to create pipeline library, no supported version found");
    ID3D12PipelineLibraryImpl* impl = mem::new(ID3D12PipelineLibraryImpl);
    impl.vtbl = *(ID3D12PipelineLibraryVtbl**) pipelineLibrary;
    impl.raw = (ID3D12PipelineLibraryRaw*) pipelineLibrary;
    impl.version = version;
    return impl;
}

fn void? ID3D12DeviceImpl.set_event_on_multiple_fence_completion(&self, ID3D12Fence[] fences, Win32_UINT64[] fenceValues, Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS flags, Win32_HANDLE eventHandle) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE1)!;
    assert(fences.len == fenceValues.len);
    ID3D12FenceRaw** rawFences = mem::temp_array(ID3D12FenceRaw*, fences.len);
    for (int i = 0; i < fences.len; ++i)
    {
        rawFences[i] = (ID3D12FenceRaw*) fences[i].get_com_ptr();
    }
    Win32_HRESULT hr = self.vtbl.set_event_on_multiple_fence_completion(self.raw, rawFences, fenceValues.ptr, fences.len, flags, eventHandle);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12DeviceImpl.set_residency_priority(&self, ID3D12Pageable[] objects, Dx_D3D12_RESIDENCY_PRIORITY* priority) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE1)!;
    ID3D12PageableRaw** rawObjects = mem::temp_array(ID3D12PageableRaw*, objects.len);
    for (int i = 0; i < objects.len; ++i)
    {
        rawObjects[i] = (ID3D12PageableRaw*) objects[i].get_com_ptr();
    }
    Win32_HRESULT hr = self.vtbl.set_residency_priority(self.raw, objects.len, rawObjects, priority);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12PipelineState? ID3D12DeviceImpl.create_pipeline_state(&self, Dx_D3D12_PIPELINE_STATE_STREAM_DESC* desc) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE2)!;
    void* pipelineState;
    Win32_HRESULT hr = self.vtbl.create_pipeline_state(self.raw, desc, &IID_ID3D12PIPELINESTATE, &pipelineState);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12PipelineStateImpl* impl = mem::new(ID3D12PipelineStateImpl);
    impl.vtbl = *(ID3D12PipelineStateVtbl**) pipelineState;
    impl.raw = (ID3D12PipelineStateRaw*) pipelineState;
    return impl;
}

fn ID3D12Heap? ID3D12DeviceImpl.open_existing_heap_from_address(&self, void* address) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE3)!;
    void* heap;
    Win32_HRESULT hr = self.vtbl.open_existing_heap_from_address(self.raw, address, &IID_ID3D12HEAP, &heap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12HeapImpl* impl = mem::new(ID3D12HeapImpl);
    impl.vtbl = *(ID3D12HeapVtbl**) heap;
    impl.raw = (ID3D12HeapRaw*) heap;
    return impl;
}

fn ID3D12Heap? ID3D12DeviceImpl.open_existing_heap_from_file_mapping(&self, Win32_HANDLE fileMapping) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE3)!;
    void* heap;
    Win32_HRESULT hr = self.vtbl.open_existing_heap_from_file_mapping(self.raw, fileMapping, &IID_ID3D12HEAP, &heap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12HeapImpl* impl = mem::new(ID3D12HeapImpl);
    impl.vtbl = *(ID3D12HeapVtbl**) heap;
    impl.raw = (ID3D12HeapRaw*) heap;
    return impl;
}

fn void? ID3D12DeviceImpl.enqueue_make_resident(&self, Dx_D3D12_RESIDENCY_FLAGS flags, ID3D12Pageable[] objects, ID3D12Fence fence, Win32_UINT64 fenceValue) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE3)!;
    ID3D12PageableRaw** rawObjects = mem::temp_array(ID3D12PageableRaw*, objects.len);
    for (int i = 0; i < objects.len; ++i)
    {
        rawObjects[i] = (ID3D12PageableRaw*) objects[i].get_com_ptr();
    }
    Win32_HRESULT hr = self.vtbl.enqueue_make_resident(self.raw, flags, objects.len, rawObjects, fence.get_com_ptr(), fenceValue);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12CommandList? ID3D12DeviceImpl.create_command_list1(&self, Win32_UINT nodeMask, Dx_D3D12_COMMAND_LIST_TYPE type, Dx_D3D12_COMMAND_LIST_FLAGS flags) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE4)!;
    void* commandList;
    Win32_HRESULT hr = self.vtbl.create_command_list1(self.raw, nodeMask, type, flags, &IID_ID3D12GRAPHICSCOMMANDLIST, &commandList);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12GraphicsCommandListImpl* impl = mem::new(ID3D12GraphicsCommandListImpl);
    impl.vtbl = *(ID3D12GraphicsCommandListVtbl**) commandList;
    impl.raw = (ID3D12GraphicsCommandListRaw*) commandList;
    return impl;
}

fn ID3D12ProtectedResourceSession? ID3D12DeviceImpl.create_protected_resource_session(&self, Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC* desc) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE4)!;
    assert(g_supported_version_tracker.protected_resource_session_version != PROTECTED_RESOURCE_SESSION1, "Cannot use both versions of protected resource session at the same time");
    void* protectedResourceSession;
    Win32_HRESULT hr = self.vtbl.create_protected_resource_session(self.raw, desc, &IID_ID3D12PROTECTEDRESOURCESESSION, &protectedResourceSession);
    if (hr != S_OK) check_hresult(hr)!;
    g_supported_version_tracker.protected_resource_session_version = PROTECTED_RESOURCE_SESSION;
    ID3D12ProtectedResourceSessionImpl* impl = mem::new(ID3D12ProtectedResourceSessionImpl);
    impl.vtbl = *(ID3D12ProtectedResourceSessionVtbl**) protectedResourceSession;
    impl.raw = (ID3D12ProtectedResourceSessionRaw*) protectedResourceSession;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_committed_resource1(&self, Dx_D3D12_HEAP_PROPERTIES* heapProperties, Dx_D3D12_HEAP_FLAGS heapFlags, Dx_D3D12_RESOURCE_DESC* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue, ID3D12ProtectedResourceSession protectedResourceSession) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE4)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_committed_resource1(self.raw, heapProperties, heapFlags, resourceDesc, initialResourceState, optimizedClearValue, protectedResourceSession.get_com_ptr(), &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn ID3D12Heap? ID3D12DeviceImpl.create_heap1(&self, Dx_D3D12_HEAP_DESC* desc, ID3D12ProtectedResourceSession protectedResourceSession) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE4)!;
    void* heap;
    Win32_HRESULT hr = self.vtbl.create_heap1(self.raw, desc, protectedResourceSession.get_com_ptr(), &IID_ID3D12HEAP, &heap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12HeapImpl* impl = mem::new(ID3D12HeapImpl);
    impl.vtbl = *(ID3D12HeapVtbl**) heap;
    impl.raw = (ID3D12HeapRaw*) heap;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_reserved_resource1(&self, Dx_D3D12_RESOURCE_DESC* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue, ID3D12ProtectedResourceSession protectedResourceSession) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE4)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_reserved_resource1(self.raw, resourceDesc, initialResourceState, optimizedClearValue, protectedResourceSession.get_com_ptr(), &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn Dx_D3D12_RESOURCE_ALLOCATION_INFO? ID3D12DeviceImpl.get_resource_allocation_info1(&self, Win32_UINT visibleMask, Win32_UINT resourceCount, Dx_D3D12_RESOURCE_DESC* resources, Dx_D3D12_RESOURCE_ALLOCATION_INFO1* allocation_info1) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE4)!;
    Dx_D3D12_RESOURCE_ALLOCATION_INFO info;
    self.vtbl.get_resource_allocation_info1(self.raw, &info, visibleMask, resourceCount, resources, allocation_info1);
    return info;
}

fn ID3D12LifetimeTracker? ID3D12DeviceImpl.create_lifetime_tracker(&self, ID3D12LifetimeOwner owner) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    void* lifetimeTracker;
    Win32_HRESULT hr = self.vtbl.create_lifetime_tracker(self.raw, owner.get_com_ptr(), &IID_ID3D12LIFETIMETRACKER, &lifetimeTracker);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12LifetimeTrackerImpl* impl = mem::new(ID3D12LifetimeTrackerImpl);
    impl.vtbl = *(ID3D12LifetimeTrackerVtbl**) lifetimeTracker;
    impl.raw = (ID3D12LifetimeTrackerRaw*) lifetimeTracker;
    return impl;
}

fn void? ID3D12DeviceImpl.remove_device(&self) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    Win32_HRESULT hr = self.vtbl.remove_device(self.raw);
    if (hr != S_OK) check_hresult(hr)!;
}

fn Dx_D3D12_META_COMMAND_DESC[]? ID3D12DeviceImpl.enumerate_meta_commands(&self) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    Win32_UINT num_meta_commands;
    Win32_HRESULT hr = self.vtbl.enumerate_meta_commands(self.raw, &num_meta_commands, null);
    if (hr != S_OK) check_hresult(hr)!;
    Dx_D3D12_META_COMMAND_DESC[] metaCommands = mem::new_array(Dx_D3D12_META_COMMAND_DESC, num_meta_commands);
    hr = self.vtbl.enumerate_meta_commands(self.raw, &num_meta_commands, metaCommands.ptr);
    if (hr != S_OK) check_hresult(hr)!;
    return metaCommands;
}

fn Dx_D3D12_META_COMMAND_PARAMETER_DESC[]? ID3D12DeviceImpl.enumerate_meta_command_parameters(&self, Win32_REFGUID metaCommandId, Dx_D3D12_META_COMMAND_PARAMETER_STAGE stage, Win32_UINT* totalStructureSizeInBytes) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    Win32_UINT num_parameters;
    Win32_HRESULT hr = self.vtbl.enumerate_meta_command_parameters(self.raw, metaCommandId, stage, totalStructureSizeInBytes, &num_parameters, null);
    if (hr != S_OK) check_hresult(hr)!;
    Dx_D3D12_META_COMMAND_PARAMETER_DESC[] parameters = mem::new_array(Dx_D3D12_META_COMMAND_PARAMETER_DESC, num_parameters);
    hr = self.vtbl.enumerate_meta_command_parameters(self.raw, metaCommandId, stage, null, &num_parameters, &parameters[0]);
    if (hr != S_OK) check_hresult(hr)!;
    return parameters;
}

fn ID3D12MetaCommand? ID3D12DeviceImpl.create_meta_command(&self, Win32_REFGUID metaCommandId, Win32_UINT node_mask, Win32_SIZE_T metaCommandCreationDataSizeInBytes, void* metaCommandCreationData) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    void* metaCommand;
    Win32_HRESULT hr = self.vtbl.create_meta_command(self.raw, metaCommandId, node_mask, metaCommandCreationData, metaCommandCreationDataSizeInBytes, &IID_ID3D12METACOMMAND, &metaCommand);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12MetaCommandImpl* impl = mem::new(ID3D12MetaCommandImpl);
    impl.vtbl = *(ID3D12MetaCommandVtbl**) metaCommand;
    impl.raw = (ID3D12MetaCommandRaw*) metaCommand;
    return impl;
}

fn ID3D12StateObject? ID3D12DeviceImpl.create_state_object(&self, Dx_D3D12_STATE_OBJECT_DESC* desc) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    void* stateObject;
    Win32_HRESULT hr = self.vtbl.create_state_object(self.raw, desc, &IID_ID3D12STATEOBJECT, &stateObject);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12StateObjectImpl* impl = mem::new(ID3D12StateObjectImpl);
    impl.vtbl = *(ID3D12StateObjectVtbl**) stateObject;
    impl.raw = (ID3D12StateObjectRaw*) stateObject;
    return impl;
}

fn Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO? ID3D12DeviceImpl.get_raytracing_acceleration_structure_prebuild_info(&self, Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS* desc) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO prebuildInfo;
    Win32_HRESULT hr = self.vtbl.get_raytracing_acceleration_structure_prebuild_info(self.raw, desc, &prebuildInfo);
    if (hr != S_OK) check_hresult(hr)!;
    return prebuildInfo;
}

fn Dx_D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS? ID3D12DeviceImpl.check_driver_matching_identifier(&self, Dx_D3D12_SERIALIZED_DATA_TYPE serializedDataType, Dx_D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER* identifierToCheck) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE5)!;
    Dx_D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS status = self.vtbl.check_driver_matching_identifier(self.raw, serializedDataType, identifierToCheck);
    return status;
}

fn bool? ID3D12DeviceImpl.set_background_processing_mode(&self, Dx_D3D12_BACKGROUND_PROCESSING_MODE mode, Dx_D3D12_MEASUREMENTS_ACTION action, Win32_HANDLE completionEvent) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE6)!;
    Win32_BOOL more;
    Win32_HRESULT hr = self.vtbl.set_background_processing_mode(self.raw, mode, action, completionEvent, &more);
    if (hr != S_OK) check_hresult(hr)!;
    return more != 0;
}

fn ID3D12StateObject? ID3D12DeviceImpl.add_to_state_object(&self, Dx_D3D12_STATE_OBJECT_DESC* addition, ID3D12StateObject stateObject) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE7)!;
    void* stateObjectOut;
    Win32_HRESULT hr = self.vtbl.add_to_state_object(self.raw, addition, stateObject.get_com_ptr(), &IID_ID3D12STATEOBJECT, &stateObjectOut);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12StateObjectImpl* impl = mem::new(ID3D12StateObjectImpl);
    impl.vtbl = *(ID3D12StateObjectVtbl**) stateObjectOut;
    impl.raw = (ID3D12StateObjectRaw*) stateObjectOut;
    return impl;
}

fn ID3D12ProtectedResourceSession? ID3D12DeviceImpl.create_protected_resource_session1(&self, Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1* desc) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE7)!;
    assert(g_supported_version_tracker.protected_resource_session_version != PROTECTED_RESOURCE_SESSION, "Cannot use both versions of protected resource session at the same time");
    void* protectedResourceSession;
    Win32_HRESULT hr = self.vtbl.create_protected_resource_session1(self.raw, desc, &IID_ID3D12PROTECTEDRESOURCESESSION1, &protectedResourceSession);
    if (hr != S_OK) check_hresult(hr)!;
    g_supported_version_tracker.protected_resource_session_version = ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1;
    ID3D12ProtectedResourceSessionImpl* impl = mem::new(ID3D12ProtectedResourceSessionImpl);
    impl.vtbl = *(ID3D12ProtectedResourceSessionVtbl**) protectedResourceSession;
    impl.raw = (ID3D12ProtectedResourceSessionRaw*) protectedResourceSession;
    impl.version = ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1;
    return impl;
}

fn Dx_D3D12_RESOURCE_ALLOCATION_INFO? ID3D12DeviceImpl.get_resource_allocation_info2(&self, Win32_UINT visibleMask, Win32_UINT resourceCount, Dx_D3D12_RESOURCE_DESC1* resources, Dx_D3D12_RESOURCE_ALLOCATION_INFO1* resourceAllocationInfo1) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE8)!;
    Dx_D3D12_RESOURCE_ALLOCATION_INFO info;
    self.vtbl.get_resource_allocation_info2(self.raw, &info, visibleMask, resourceCount, resources, resourceAllocationInfo1);
    return info;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_committed_resource2(&self, Dx_D3D12_HEAP_PROPERTIES* heapProperties, Dx_D3D12_HEAP_FLAGS heapFlags, Dx_D3D12_RESOURCE_DESC1* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue, ID3D12ProtectedResourceSession protectedResourceSession) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE8)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_committed_resource2(self.raw, heapProperties, heapFlags, resourceDesc, initialResourceState, optimizedClearValue, protectedResourceSession.get_com_ptr(), &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_placed_resource1(&self, ID3D12Heap heap, Win32_UINT64 heapOffset, Dx_D3D12_RESOURCE_DESC1* resourceDesc, Dx_D3D12_RESOURCE_STATES initialResourceState, Dx_D3D12_CLEAR_VALUE* optimizedClearValue) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE8)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_placed_resource1(self.raw, heap.get_com_ptr(), heapOffset, resourceDesc, initialResourceState, optimizedClearValue, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn void? ID3D12DeviceImpl.create_sampler_feedback_unordered_access_view(&self, ID3D12Resource target_resource, ID3D12Resource feedback_resource, Dx_D3D12_CPU_DESCRIPTOR_HANDLE dest_descriptor) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE8)!;
    self.vtbl.create_sampler_feedback_unordered_access_view(self.raw, target_resource.get_com_ptr(), feedback_resource.get_com_ptr(), dest_descriptor);
}

fn void? ID3D12DeviceImpl.get_copyable_footprints1(&self, Dx_D3D12_RESOURCE_DESC1* resource_desc, Win32_UINT first_subresource, Win32_UINT num_subresources, Win32_UINT64 base_offset, Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT* footprints, Win32_UINT* num_footprints, Win32_UINT64* row_size_in_bytes, Win32_UINT64* total_bytes) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE8)!;
    self.vtbl.get_copyable_footprints1(self.raw, resource_desc, first_subresource, num_subresources, base_offset, footprints, num_footprints, row_size_in_bytes, total_bytes);
}

fn ID3D12ShaderCacheSession? ID3D12DeviceImpl.create_shader_cache_session(&self, Dx_D3D12_SHADER_CACHE_SESSION_DESC* desc) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE9)!;
    void* shaderCacheSession;
    Win32_HRESULT hr = self.vtbl.create_shader_cache_session(self.raw, desc, &IID_ID3D12SHADERCACHESESSION, &shaderCacheSession);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ShaderCacheSessionImpl* impl = mem::new(ID3D12ShaderCacheSessionImpl);
    impl.vtbl = *(ID3D12ShaderCacheSessionVtbl**) shaderCacheSession;
    impl.raw = (ID3D12ShaderCacheSessionRaw*) shaderCacheSession;
    return impl;
}

fn void? ID3D12DeviceImpl.shader_cache_control(&self, Dx_D3D12_SHADER_CACHE_KIND_FLAGS kind, Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS flags) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE9)!;
    Win32_HRESULT hr = self.vtbl.shader_cache_control(self.raw, kind, flags);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12CommandQueue? ID3D12DeviceImpl.create_command_queue1(&self, Dx_D3D12_COMMAND_QUEUE_DESC* desc, Win32_REFIID creator_id) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE9)!;
    void* commandQueue;
    Win32_HRESULT hr = self.vtbl.create_command_queue1(self.raw, desc, creator_id, &IID_ID3D12COMMANDQUEUE, &commandQueue);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12CommandQueueImpl* impl = mem::new(ID3D12CommandQueueImpl);
    impl.vtbl = *(ID3D12CommandQueueVtbl**) commandQueue;
    impl.raw = (ID3D12CommandQueueRaw*) commandQueue;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_committed_resource3(&self, Dx_D3D12_HEAP_PROPERTIES* heap_properties, Dx_D3D12_HEAP_FLAGS heap_flags, Dx_D3D12_RESOURCE_DESC1* resource_desc, Dx_D3D12_BARRIER_LAYOUT initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, ID3D12ProtectedResourceSession protected_resource_session, Dx_DXGI_FORMAT[] castable_formats) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE10)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_committed_resource3(self.raw, heap_properties, heap_flags, resource_desc, initial_resource_state, optimized_clear_value, protected_resource_session.get_com_ptr(), castable_formats.len, castable_formats.ptr, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_placed_resource2(&self, ID3D12Heap heap, Win32_UINT64 heap_offset, Dx_D3D12_RESOURCE_DESC1* resource_desc, Dx_D3D12_BARRIER_LAYOUT initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, Dx_DXGI_FORMAT[] castable_formats) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE10)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_placed_resource2(self.raw, heap.get_com_ptr(), heap_offset, resource_desc, initial_resource_state, optimized_clear_value, castable_formats.len, castable_formats.ptr, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn ID3D12Resource? ID3D12DeviceImpl.create_reserved_resource2(&self, Dx_D3D12_RESOURCE_DESC1* resource_desc, Dx_D3D12_BARRIER_LAYOUT initial_resource_state, Dx_D3D12_CLEAR_VALUE* optimized_clear_value, ID3D12ProtectedResourceSession protected_resource_session, Dx_DXGI_FORMAT[] castable_formats) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE10)!;
    void* resource;
    Win32_HRESULT hr = self.vtbl.create_reserved_resource2(self.raw, resource_desc, initial_resource_state, optimized_clear_value, protected_resource_session.get_com_ptr(), castable_formats.len, castable_formats.ptr, &IID_ID3D12RESOURCE, &resource);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    return impl;
}

fn void? ID3D12DeviceImpl.create_sampler2(&self, Dx_D3D12_SAMPLER_DESC2* desc, Dx_D3D12_CPU_DESCRIPTOR_HANDLE destDescriptor) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE11)!;
    self.vtbl.create_sampler2(self.raw, desc, destDescriptor);
}

fn Dx_D3D12_RESOURCE_ALLOCATION_INFO? ID3D12DeviceImpl.get_resource_allocation_info3(&self, Win32_UINT visibleMask, Win32_UINT resourceCount, Dx_D3D12_RESOURCE_DESC1* resources, Win32_UINT32* num_castable_formats, Dx_DXGI_FORMAT** castable_formats, Dx_D3D12_RESOURCE_ALLOCATION_INFO1* resourceAllocationInfo1) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE12)!;
    Dx_D3D12_RESOURCE_ALLOCATION_INFO info;
    self.vtbl.get_resource_allocation_info3(self.raw, &info, visibleMask, resourceCount, resources, num_castable_formats, castable_formats, resourceAllocationInfo1);
    return info;
}

fn ID3D12Heap? ID3D12DeviceImpl.open_existing_heap_from_address1(&self, void* address, Win32_SIZE_T size) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE13)!;
    void* heap;
    Win32_HRESULT hr = self.vtbl.open_existing_heap_from_address1(self.raw, address, size, &IID_ID3D12HEAP, &heap);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12HeapImpl* impl = mem::new(ID3D12HeapImpl);
    impl.vtbl = *(ID3D12HeapVtbl**) heap;
    impl.raw = (ID3D12HeapRaw*) heap;
    return impl;
}

fn ID3D12RootSignature? ID3D12DeviceImpl.create_root_signature_from_subobject_in_library(&self, Win32_UINT node_mask, void* library_blob, Win32_SIZE_T library_blob_size, Win32_LPCWSTR subobject_name) @dynamic
{
    validate_version(self.version, DeviceVersion.DEVICE14)!;
    void* rootSignature;
    Win32_HRESULT hr = self.vtbl.create_root_signature_from_subobject_in_library(self.raw, node_mask, library_blob, library_blob_size, subobject_name, &IID_ID3D12ROOTSIGNATURE, &rootSignature);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12RootSignatureImpl* impl = mem::new(ID3D12RootSignatureImpl);
    impl.vtbl = *(ID3D12RootSignatureVtbl**) rootSignature;
    impl.raw = (ID3D12RootSignatureRaw*) rootSignature;
    return impl;
}

struct ID3D12DeviceRemovedExtendedDataSettingsVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DeviceRemovedExtendedDataSettings
    SetAutoBreadcrumbsEnablement set_auto_breadcrumbs_enablement;
    SetPageFaultEnablement set_page_fault_enablement;
    SetWatsonDumpEnablement set_watson_dump_enablement;

    // ID3D12DeviceRemovedExtendedDataSettings1
    SetBreadcrumbContextEnablement set_breadcrumb_context_enablement;

     // ID3D12DeviceRemovedExtendedDataSettings2
    UseMarkersOnlyAutoBreadcrumbs use_markers_only_auto_breadcrumbs;
}

interface ID3D12DeviceRemovedExtendedDataSettings : IUnknown
{
    fn DeviceRemovedExtendedDataSettingsVersion get_version();

    fn void set_auto_breadcrumbs_enablement(Dx_D3D12_DRED_ENABLEMENT enable);
    fn void set_page_fault_enablement(Dx_D3D12_DRED_ENABLEMENT enable);
    fn void set_watson_dump_enablement(Dx_D3D12_DRED_ENABLEMENT enable);

    // ID3D12DeviceRemovedExtendedDataSettings1
    fn void? set_breadcrumb_context_enablement(Dx_D3D12_DRED_ENABLEMENT enable);

    // ID3D12DeviceRemovedExtendedDataSettings2
    fn void? use_markers_only_auto_breadcrumbs(Dx_D3D12_DRED_ENABLEMENT enable);
}

struct ID3D12DeviceRemovedExtendedDataSettingsImpl (ID3D12DeviceRemovedExtendedDataSettings)
{
    ID3D12DeviceRemovedExtendedDataSettingsVtbl* vtbl;
    ID3D12DeviceRemovedExtendedDataSettingsRaw* raw;
    DeviceRemovedExtendedDataSettingsVersion version; 
}

fn DeviceRemovedExtendedDataSettingsVersion ID3D12DeviceRemovedExtendedDataSettingsImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12DeviceRemovedExtendedDataSettingsImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12DeviceRemovedExtendedDataSettingsImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12DeviceRemovedExtendedDataSettingsImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12DeviceRemovedExtendedDataSettingsImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

fn void ID3D12DeviceRemovedExtendedDataSettingsImpl.set_auto_breadcrumbs_enablement(&self, Dx_D3D12_DRED_ENABLEMENT enable) @dynamic
{
    self.vtbl.set_auto_breadcrumbs_enablement(self.raw, enable);
}

fn void ID3D12DeviceRemovedExtendedDataSettingsImpl.set_page_fault_enablement(&self, Dx_D3D12_DRED_ENABLEMENT enable) @dynamic
{
    self.vtbl.set_page_fault_enablement(self.raw, enable);
}

fn void ID3D12DeviceRemovedExtendedDataSettingsImpl.set_watson_dump_enablement(&self, Dx_D3D12_DRED_ENABLEMENT enable) @dynamic
{
    self.vtbl.set_watson_dump_enablement(self.raw, enable);
}

fn void? ID3D12DeviceRemovedExtendedDataSettingsImpl.set_breadcrumb_context_enablement(&self, Dx_D3D12_DRED_ENABLEMENT enable) @dynamic
{
    validate_version(self.version, DeviceRemovedExtendedDataSettingsVersion.DRED_SETTINGS1)!;
    self.vtbl.set_breadcrumb_context_enablement(self.raw, enable);
}

fn void? ID3D12DeviceRemovedExtendedDataSettingsImpl.use_markers_only_auto_breadcrumbs(&self, Dx_D3D12_DRED_ENABLEMENT enable) @dynamic
{
    validate_version(self.version, DeviceRemovedExtendedDataSettingsVersion.DRED_SETTINGS2)!;
    self.vtbl.use_markers_only_auto_breadcrumbs(self.raw, enable);
}

struct ID3D12DeviceRemovedExtendedDataVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DeviceRemovedExtendedData
    GetAutoBreadcrumbsOutput get_auto_breadcrumbs_output;
    GetPageFaultAllocationOutput get_page_fault_allocation_output;

    // ID3D12DeviceRemovedExtendedData1
    GetAutoBreadcrumbsOutput1 get_auto_breadcrumbs_output1;
    GetPageFaultAllocationOutput1 get_page_fault_allocation_output1;

    // ID3D12DeviceRemovedExtendedData2
    GetPageFaultAllocationOutput2 get_page_fault_allocation_output2;
    GetDeviceState get_device_state;
}

struct ID3D12DeviceConfigurationVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DeviceConfiguration methods
    GetDeviceConfigurationDesc get_desc;
    GetEnabledExperimentalFeatures get_enabled_experimental_features;
    SerializeVersionedRootSignature serialize_versioned_root_signature;
    CreateVersionedRootSignatureDeserializer create_versioned_root_signature_deserializer;
    CreateVersionedRootSignatureDeserializerFromSubobjectInLibrary create_versioned_root_signature_deserializer_from_subobject_in_library;
}

interface ID3D12DeviceConfiguration : IUnknown
{
    fn Dx_D3D12_DEVICE_CONFIGURATION_DESC get_desc();
    fn Win32_GUID[]? get_enabled_experimental_features();
    fn ID3DBlob*? serialize_versioned_root_signature(Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* versionedRootSignature);
    fn ID3D12VersionedRootSignatureDeserializer? create_versioned_root_signature_deserializer(void* data, Win32_SIZE_T size);
    fn ID3D12VersionedRootSignatureDeserializer? create_versioned_root_signature_deserializer_from_subobject_in_library(void* libraryBlob, Win32_SIZE_T libraryBlobSize, Win32_LPCWSTR subobjectName);
}

struct ID3D12DeviceFactoryVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DeviceFactory methods
    InitializeFromGlobalState initialize_from_global_state;
    ApplyToGlobalState apply_to_global_state;
    SetFlags set_flags;
    GetFlags get_flags;
    GetConfigurationInterface get_configuration_interface;
    EnableExperimentalFeatures enable_experimental_features;
    CreateDevice create_device;
}

interface ID3D12DeviceFactory : IUnknown
{
    fn void? initialize_from_global_state();
    fn void? apply_to_global_state();
    fn void? set_flags(Dx_D3D12_DEVICE_FACTORY_FLAGS flags);
    fn Dx_D3D12_DEVICE_FACTORY_FLAGS get_flags();
    fn ID3D12DeviceConfiguration? get_configuration_interface(Win32_CLSID riid);
    fn void? enable_experimental_features(Win32_UINT numFeatures, Win32_REFGUID* featureIds, void* configuration_structs, Win32_SIZE_T* configuration_structs_sizes);
    fn ID3D12Device? create_device(IUnknown adapter, Dx_D3D_FEATURE_LEVEL minimumFeatureLevel);
}

struct ID3D12DSRDeviceFactoryVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DSRDeviceFactory methods
    CreateDSRDevice create_dsr_device;
}

interface ID3D12DSRDeviceFactory : IUnknown
{
    //fn ID3D12DSRDevice? create_dsr_device(ID3D12Device device, Win32_UINT node_mask);
}

////////////////////////////////////////////////////////////////////////////////
// Loose Functions
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// D3D12CreateDevice
// ------------------
//
// pAdapter
//      If NULL, D3D12CreateDevice will choose the primary adapter.
//      If non-NULL, D3D12CreateDevice will use the provided adapter.
// MinimumFeatureLevel
//      The minimum feature level required for successful device creation.
// riid
//      The interface IID of the device to be returned. Expected: ID3D12Device.
// ppDevice
//      Pointer to returned interface. May be NULL.
//
// Return Values
//  Any of those documented for 
//          CreateDXGIFactory1
//          IDXGIFactory::EnumAdapters
//          D3D12CreateDevice
//
////////////////////////////////////////////////////////////////////////////////
extern fn Win32_HRESULT d3d12CreateDevice(IUnknownRaw* adapter, Dx_D3D_FEATURE_LEVEL minimum_Feature_Level, Win32_REFIID riid, void** device) @extern("D3D12CreateDevice");

fn ID3D12Device? create_device(IUnknown adapter, Dx_D3D_FEATURE_LEVEL minimum_Feature_Level)
{
    IUnknownRaw* raw_adapter = adapter ? adapter.get_com_ptr() : null;
    void* device;
    DeviceVersion version = g_supported_version_tracker.device_version;
    if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) DeviceVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = DeviceVersion.from_ordinal(i).riid;
            hr = d3d12CreateDevice(raw_adapter, minimum_Feature_Level, riid, &device);
            if (hr == S_OK)
            {
                version = DeviceVersion.from_ordinal(i);
                g_supported_version_tracker.device_version = version;
                break;
            }
            else
            {
                //log_warn("Failed to create device with version %s, HRESULT: %X", DeviceVersion.from_ordinal(i), (uint)hr);
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            g_supported_version_tracker.device_version = NOT_SUPPORTED;
            return NOINTERFACE?;
        }
    }
    else
    {
        Win32_REFIID riid = version.riid;
        Win32_HRESULT hr = d3d12CreateDevice(raw_adapter, minimum_Feature_Level, riid, &device);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(device != null, "Failed to create device, no supported version found");
    ID3D12DeviceImpl* impl = mem::new(ID3D12DeviceImpl);
    impl.vtbl = *(ID3D12DeviceVtbl**) device;
    impl.raw = (ID3D12DeviceRaw*) device;
    impl.version = version;
    return impl;

}
