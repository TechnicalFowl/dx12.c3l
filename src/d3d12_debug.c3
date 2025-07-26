module d3d12;

import std::os::win32;

struct ID3D12ToolsVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12Tools methods
    EnableShaderInstrumentation enable_shader_instrumentation;
    ShaderInstrumentationEnabled shader_instrumentation_enabled;

    // ID3D12Tools1 methods
    ReserveGPUVARangesAtCreate reserve_gpu_va_ranges_at_create;
    ClearReservedGPUVARangesList clear_reserved_gpu_va_ranges_list;

    // ID3D12Tools2 methods
    SetApplicationSpecificDriverState set_application_specific_driver_state;
}

interface ID3D12Tools : IUnknown
{
    fn void enable_shader_instrumentation(bool state);
    fn bool shader_instrumentation_enabled();

    fn void? reserve_gpu_va_ranges_at_create(Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE[] ranges);
    fn void? clear_reserved_gpu_va_ranges_list();

    fn void? set_application_specific_driver_state(IUnknown adapter, ID3DBlob* blob);
}

struct ID3D12PageableToolsVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12PageableTools methods
    GetAllocation get_allocation;
}

interface ID3D12PageableTools : IUnknown
{
    fn Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE? get_allocation();
}

struct ID3D12DeviceToolsVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DeviceTools methods
    SetNextAllocationAddress set_next_allocation_address;

    // ID3D12DeviceTools1 methods
    GetApplicationSpecificDriverState get_application_specific_driver_state;
    GetApplicationSpecificDriverBlobStatus get_application_specific_driver_blob_status;
}

interface ID3D12DeviceTools : IUnknown
{
    fn void set_next_allocation_address(Dx_D3D12_GPU_VIRTUAL_ADDRESS address);

    fn ID3DBlob*? get_application_specific_driver_state();
    fn Dx_D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_STATUS? get_application_specific_driver_blob_status();
}

struct ID3D12GBVDiagnosticsVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12GBVDiagnostics methods
    GetGBVEntireSubresourceStatesData get_gbv_entire_subresource_states_data;
    GetGBVSubresourceState get_gbv_subresource_state;
    GetGBVResourceUniformState get_gbv_resource_uniform_state;
    GetGBVResourceInfo get_gbv_resource_info;
    GBVReserved0 gbv_reserved_0;
    GBVReserved1 gbv_reserved_1;
}

interface ID3D12GBVDiagnostics : IUnknown
{

}

struct ID3D12DebugVtbl @private
{
    // IUnknown methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12Debug methods
    EnableDebugLayer enable_debug_layer;

    // ID3D12Debug1 methods
    SetEnableGPUBasedValidation set_enable_gpu_based_validation;
    SetEnableSynchronizedCommandQueueValidation set_enable_synchronized_command_queue_validation;

    // ID3D12Debug3 methods
    SetGPUBasedValidationFlags set_gpu_based_validation_flags;

    // ID3D12Debug4 methods
    DisableDebugLayer disable_debug_layer;

    // ID3D12Debug5 methods
    SetEnableAutoName set_enable_auto_name;

    // ID3D12Debug6 methods
    SetForceLegacyBarrierValidation set_force_legacy_barrier_validation;
}

interface ID3D12Debug : IUnknown
{
    fn void enable_debug_layer();

    // ID3D12Debug1 methods
    fn void? set_enable_gpu_based_validation(bool enable);
    fn void? set_enable_synchronized_command_queue_validation(bool enable);

    // ID3D12Debug3 methods
    fn void? set_gpu_based_validation_flags(Dx_D3D12_GPU_BASED_VALIDATION_FLAGS flags);

    // ID3D12Debug4 methods
    fn void? disable_debug_layer();

    // ID3D12Debug5 methods
    fn void? set_enable_auto_name(bool enable);

    // ID3D12Debug6 methods
    fn void? set_force_legacy_barrier_validation(bool enable);
}

struct ID3D12DebugImpl (ID3D12Debug)
{
    ID3D12DebugVtbl* vtbl;
    ID3D12DebugRaw* raw;
    DebugVersion version;
}

fn DebugVersion ID3D12DebugImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12DebugImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12DebugImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12DebugImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12DebugImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

fn void ID3D12DebugImpl.enable_debug_layer(&self) @dynamic
{
    self.vtbl.enable_debug_layer(self.raw);
}

fn void? ID3D12DebugImpl.set_enable_gpu_based_validation(&self, bool enable) @dynamic
{
    validate_version(self.version, DebugVersion.DEBUG1)!;
    self.vtbl.set_enable_gpu_based_validation(self.raw, enable ? 1 : 0);
}

fn void? ID3D12DebugImpl.set_enable_synchronized_command_queue_validation(&self, bool enable) @dynamic
{
    validate_version(self.version, DebugVersion.DEBUG1)!;
    self.vtbl.set_enable_synchronized_command_queue_validation(self.raw, enable ? 1 : 0);
}

fn void? ID3D12DebugImpl.set_gpu_based_validation_flags(&self, Dx_D3D12_GPU_BASED_VALIDATION_FLAGS flags) @dynamic
{
    validate_version(self.version, DebugVersion.DEBUG3)!;
    return self.vtbl.set_gpu_based_validation_flags(self.raw, flags);
}

fn void? ID3D12DebugImpl.disable_debug_layer(&self) @dynamic
{
    validate_version(self.version, DebugVersion.DEBUG4)!;
    self.vtbl.disable_debug_layer(self.raw);
}

fn void? ID3D12DebugImpl.set_enable_auto_name(&self, bool enable) @dynamic
{
    validate_version(self.version, DebugVersion.DEBUG5)!;
    self.vtbl.set_enable_auto_name(self.raw, enable ? 1 : 0);
}

fn void? ID3D12DebugImpl.set_force_legacy_barrier_validation(&self, bool enable) @dynamic
{
    validate_version(self.version, DebugVersion.DEBUG6)!;
    self.vtbl.set_force_legacy_barrier_validation(self.raw, enable ? 1 : 0);
}

struct ID3D12DebugDeviceVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12DebugDevice methods
    void* set_feature_mask;
    void* get_feature_mask;
    ReportLiveDeviceObjects report_live_device_objects;
}

interface ID3D12DebugDevice : IUnknown
{
    fn void? report_live_device_objects(Dx_D3D12_RLDO_FLAGS flags);
}

struct ID3D12DebugDeviceImpl (ID3D12DebugDevice)
{
    ID3D12DebugDeviceVtbl* vtbl;
    ID3D12DebugDeviceRaw* raw;
}

fn void* ID3D12DebugDeviceImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12DebugDeviceImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12DebugDeviceImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12DebugDeviceImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

fn void? ID3D12DebugDeviceImpl.report_live_device_objects(&self, Dx_D3D12_RLDO_FLAGS flags) @dynamic
{
    Win32_HRESULT hr = self.vtbl.report_live_device_objects(self.raw, flags);
    if (hr != S_OK) check_hresult(hr)!;
}

fn ID3D12DebugDevice? get_debug_device(ID3D12Device device)
{
	void* dbg;
    ID3D12DeviceImpl* idevice = (ID3D12DeviceImpl*)device;
    Win32_HRESULT hr = idevice.vtbl.query_interface(idevice.raw, &IID_ID3D12DEBUGDEVICE, &dbg);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12DebugDeviceImpl* impl = mem::new(ID3D12DebugDeviceImpl);
    impl.vtbl = *(ID3D12DebugDeviceVtbl**)dbg;
    impl.raw = (ID3D12DebugDeviceRaw*)dbg;
    return impl;
}

struct ID3D12InfoQueueVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12InfoQueue methods
    void* set_message_count_limit;
    ClearStoredMessages clear_stored_messages;
    GetMessage get_message;
    void* get_num_messages_allowed_by_storage_filter;
    void* get_num_messages_denied_by_storage_filter;
    void* get_num_stored_messages;
    GetNumStoredMessagesAllowedByRetrievalFilter get_num_stored_messages_allowed_by_retrieval_filter;
    void* get_num_messages_discarded_by_message_count_limit;
    void* get_message_count_limit;
    void* add_storage_filter_entries;
    void* get_storage_filter;
    void* clear_storage_filter;
    void* push_empty_storage_filter;
    void* push_copy_of_storage_filter;
    void* push_storage_filter;
    void* pop_storage_filter;
    void* get_storage_filter_stack_size;
    void* add_retrieval_filter_entries;
    void* get_retrieval_filter;
    void* clear_retrieval_filter;
    void* push_empty_retrieval_filter;
    void* push_copy_of_retrieval_filter;
    void* push_retrieval_filter;
    void* pop_retrieval_filter;
    void* get_retrieval_filter_stack_size;
    void* add_message;
    void* add_application_message;
    void* set_break_on_category;
    void* set_break_on_severity;
    void* set_break_on_id;
    void* set_mute_debug_output;
    void* get_mute_debug_output;

    // ID3D12InfoQueue1 methods
    RegisterMessageCallback register_message_callback;
    void* unregister_message_callback;
}

interface ID3D12InfoQueue : IUnknown
{
    fn void clear_stored_messages();

    fn void? get_message(Win32_UINT64 index, Dx_D3D12_MESSAGE* message, Win32_SIZE_T* message_size);

    fn Win32_UINT64 get_num_stored_messages_allowed_by_retrieval_filter();

    fn Win32_DWORD? register_message_callback(D3D12MessageFunc cb, Dx_D3D12_MESSAGE_CALLBACK_FLAGS flags);

    fn void? poll_for_debug_messages();
}

struct ID3D12InfoQueueImpl (ID3D12InfoQueue)
{
    ID3D12InfoQueueVtbl* vtbl;
    ID3D12InfoQueueRaw* raw;
}

fn void* ID3D12InfoQueueImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12InfoQueueImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12InfoQueueImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12InfoQueueImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

fn void ID3D12InfoQueueImpl.clear_stored_messages(&self) @dynamic
{
    self.vtbl.clear_stored_messages(self.raw);
}

fn void? ID3D12InfoQueueImpl.get_message(&self, Win32_UINT64 index, Dx_D3D12_MESSAGE* message, Win32_SIZE_T* message_size) @dynamic
{
    Win32_HRESULT hr = self.vtbl.get_message(self.raw, index, message, message_size);
    if (hr != S_OK) check_hresult(hr)!;
}

fn Win32_UINT64 ID3D12InfoQueueImpl.get_num_stored_messages_allowed_by_retrieval_filter(&self) @dynamic
{
    Win32_UINT64 count = self.vtbl.get_num_stored_messages_allowed_by_retrieval_filter(self.raw);
    return count;
}

fn Win32_DWORD? ID3D12InfoQueueImpl.register_message_callback(&self, D3D12MessageFunc cb, Dx_D3D12_MESSAGE_CALLBACK_FLAGS flags) @dynamic
{
    Win32_DWORD id;
    Win32_HRESULT hr = self.vtbl.register_message_callback(self.raw, cb, flags, null, &id);
    if (hr != S_OK) check_hresult(hr)!;
    return id;
}

fn void? ID3D12InfoQueueImpl.poll_for_debug_messages(&self) @dynamic
{
    @stack_mem(512; Allocator allocator)
    {
        Win32_UINT64 count = self.get_num_stored_messages_allowed_by_retrieval_filter();
        Win32_UINT64 i;
        defer catch
        {
            log_error("Failed to poll for debug messages, %d messages discarded", count - i);
            self.clear_stored_messages();
        }
        Dx_D3D12_MESSAGE* message = allocator.acquire(512, ZERO)!!;
        for (; i < count; ++i)
        {
            Win32_SIZE_T message_size = 512;
            self.get_message(i, message, &message_size)!;
            
            log_trace("[%s] %s: %s : %s", Dx_D3D12_MESSAGE_CATEGORY.names[message.category], 
                    Dx_D3D12_MESSAGE_SEVERITY.names[message.severity],
                    message.id.get_name(),
                    message.description);
        }
        self.clear_stored_messages();
    };
}

fn ID3D12InfoQueue? get_info_queue(ID3D12Device device)
{
    void* info_queue = device.query_interface(&IID_ID3D12INFOQUEUE)!;
    ID3D12InfoQueueImpl* impl = mem::new(ID3D12InfoQueueImpl);
    impl.vtbl = *(ID3D12InfoQueueVtbl**)info_queue;
    impl.raw = (ID3D12InfoQueueRaw*) info_queue;
    return impl;
}