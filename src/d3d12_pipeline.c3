module d3d12;

import std::os::win32;

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

struct ID3D12PipelineStateVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12PipelineState methods
    GetCachedBlob get_cached_blob;
}

interface ID3D12PipelineState : ID3D12DeviceChild
{
    fn char[]? get_cached_blob();
}

struct ID3D12PipelineStateImpl (ID3D12PipelineState)
{
    ID3D12PipelineStateVtbl* vtbl;
    ID3D12PipelineStateRaw* raw;
}

fn void* ID3D12PipelineStateImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12PipelineStateImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12PipelineStateImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12PipelineStateImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12PipelineStateImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12PipelineStateImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12PipelineStateImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12PipelineStateImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12PipelineStateImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn char[]? ID3D12PipelineStateImpl.get_cached_blob(&self) @dynamic
{
    ID3DBlob* blob;
    Win32_HRESULT hr = self.vtbl.get_cached_blob(self.raw, &blob);
    if (hr != S_OK) check_hresult(hr)!;
    char[] data = blob.get_buffer();
    @safe_release(blob);
    return data;
}

struct ID3D12PipelineLibraryVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    SetName set_name;

    // ID3D12PipelineLibrary methods
    StorePipeline store_pipeline;
    LoadGraphicsPipeline load_graphics_pipeline;
    LoadComputePipeline load_compute_pipeline;
    GetSerializedSize get_serialized_size;
    Serialize serialize;

    // ID3D12PipelineLibrary1 methods
    LoadPipeline load_pipeline;
}

interface ID3D12PipelineLibrary : ID3D12Object
{
    fn PipelineLibraryVersion get_version();

    fn void? store_pipeline(WString name, ID3D12PipelineState pipelineState);

    fn ID3D12PipelineState? load_graphics_pipeline(WString name, Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC* desc);

    fn ID3D12PipelineState? load_compute_pipeline(WString name, Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC* desc);

    fn Win32_SIZE_T get_serialized_size();

    fn void? serialize(void* data, Win32_SIZE_T size);
    
    fn ID3D12PipelineState? load_pipeline(WString name, Dx_D3D12_PIPELINE_STATE_STREAM_DESC* desc);
}

struct ID3D12PipelineLibraryImpl (ID3D12PipelineLibrary)
{
    ID3D12PipelineLibraryVtbl* vtbl;
    ID3D12PipelineLibraryRaw* raw;
    PipelineLibraryVersion version;
}

fn PipelineLibraryVersion ID3D12PipelineLibraryImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12PipelineLibraryImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12PipelineLibraryImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12PipelineLibraryImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12PipelineLibraryImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12PipelineLibraryImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12PipelineLibraryImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12PipelineLibraryImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12PipelineLibraryImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);

fn void? ID3D12PipelineLibraryImpl.store_pipeline(&self, WString name, ID3D12PipelineState pipelineState) @dynamic
{
    Win32_HRESULT hr = self.vtbl.store_pipeline(self.raw, name, pipelineState.get_com_ptr());
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12PipelineState? ID3D12PipelineLibraryImpl.load_graphics_pipeline(&self, WString name, Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC* desc) @dynamic
{
    void* pipelineState;
    Win32_HRESULT hr = self.vtbl.load_graphics_pipeline(self.raw, name, desc, &IID_ID3D12PIPELINESTATE, &pipelineState);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12PipelineStateImpl* impl = mem::new(ID3D12PipelineStateImpl);
    impl.vtbl = *(ID3D12PipelineStateVtbl**) pipelineState;
    impl.raw = (ID3D12PipelineStateRaw*) pipelineState;
    return impl;
}

fn ID3D12PipelineState? ID3D12PipelineLibraryImpl.load_compute_pipeline(&self, WString name, Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC* desc) @dynamic
{
    void* pipelineState;
    Win32_HRESULT hr = self.vtbl.load_compute_pipeline(self.raw, name, desc, &IID_ID3D12PIPELINESTATE, &pipelineState);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12PipelineStateImpl* impl = mem::new(ID3D12PipelineStateImpl);
    impl.vtbl = *(ID3D12PipelineStateVtbl**) pipelineState;
    impl.raw = (ID3D12PipelineStateRaw*) pipelineState;
    return impl;
}

fn Win32_SIZE_T ID3D12PipelineLibraryImpl.get_serialized_size(&self) @dynamic
{
    return self.vtbl.get_serialized_size(self.raw);
}

fn void? ID3D12PipelineLibraryImpl.serialize(&self, void* data, Win32_SIZE_T size) @dynamic
{
    Win32_HRESULT hr = self.vtbl.serialize(self.raw, data, size);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12PipelineState? ID3D12PipelineLibraryImpl.load_pipeline(&self, WString name, Dx_D3D12_PIPELINE_STATE_STREAM_DESC* desc) @dynamic
{
    validate_version(self.version, PipelineLibraryVersion.PIPELINE_LIBRARY1)!;
    void* pipelineState;
    Win32_HRESULT hr = self.vtbl.load_pipeline(self.raw, name, desc, &IID_ID3D12PIPELINESTATE, &pipelineState);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12PipelineStateImpl* impl = mem::new(ID3D12PipelineStateImpl);
    impl.vtbl = *(ID3D12PipelineStateVtbl**) pipelineState;
    impl.raw = (ID3D12PipelineStateRaw*) pipelineState;
    return impl;
}

struct ID3D12SwapChainAssistantVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12SwapChainAssistant methods
    GetLUID get_luid;
    GetSwapChainObject get_swap_chain_object;
    GetCurrentResourceAndCommandQueue get_current_resource_and_command_queue;
    InsertImplicitSync insert_implicit_sync;
}

interface ID3D12SwapChainAssistant : IUnknown
{
    fn Win32_LUID get_luid();

    fn Win32_HRESULT get_swap_chain_object(Win32_REFIID riid, void** swapChainObject);

    fn Win32_HRESULT get_current_resource_and_command_queue(Win32_REFIID riidResource, void** resource, Win32_REFIID riidQueue, void** commandQueue);

    fn Win32_HRESULT insert_implicit_sync();
}

struct ID3D12WorkGraphPropertiesVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12WorkGraphProperties methods
    GetNumWorkGraphs get_num_work_graphs;
    GetProgramName get_program_name;
    GetNumNodes get_num_nodes;
    GetNodeID get_node_id;
    GetNodeIndex get_node_index;
    GetNodeLocalRootArgumentsTableIndex get_node_local_root_arguments_table_index;
    GetNumEntrypoints get_num_entrypoints;
    GetEntrypointID get_entrypoint_id;
    GetEntrypointIndex get_entrypoint_index;
    GetEntrypointRecordSizeInBytes get_entrypoint_record_size_in_bytes;
    GetWorkGraphMemoryRequirements get_work_graph_memory_requirements;
    GetEntrypointRecordAlignmentInBytes get_entrypoint_record_alignment_in_bytes;
}

interface ID3D12WorkGraphProperties : IUnknown
{
    fn Win32_UINT get_num_work_graphs();

    fn WString get_program_name(Win32_UINT work_graph_index);

    fn Win32_UINT get_num_nodes(Win32_UINT work_graph_index);

    fn Dx_D3D12_NODE_ID get_node_id(Win32_UINT work_graph_index, Win32_UINT node_index);

    fn Win32_UINT get_node_index(Win32_UINT work_graph_index, Dx_D3D12_NODE_ID node_id);

    fn Win32_UINT get_node_local_root_arguments_table_index(Win32_UINT work_graph_index, Dx_D3D12_NODE_ID node_id);

    fn Win32_UINT get_num_entrypoints(Win32_UINT work_graph_index);

    fn Dx_D3D12_NODE_ID get_entrypoint_id(Win32_UINT work_graph_index, Win32_UINT entrypoint_index);

    fn Win32_UINT get_entrypoint_index(Win32_UINT work_graph_index, Dx_D3D12_NODE_ID node_id);

    fn Win32_UINT get_entrypoint_record_size_in_bytes(Win32_UINT work_graph_index, Dx_D3D12_NODE_ID node_id);

    fn Dx_D3D12_WORK_GRAPH_MEMORY_REQUIREMENTS get_work_graph_memory_requirements(Win32_UINT work_graph_index);

    fn Win32_UINT get_entrypoint_record_alignment_in_bytes(Win32_UINT work_graph_index, Dx_D3D12_NODE_ID entrypoint_id);
}
