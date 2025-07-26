module d3d12;

import std::collections::tuple;
import std::os::win32;

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

struct ID3D12PageableVtbl @private
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

interface ID3D12Pageable : ID3D12DeviceChild
{

}

struct ID3D12HeapVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12Heap methods
    GetHeapDesc get_desc;

    // ID3D12Heap1 methods
    GetProtectedResourceSession get_protected_resource_session;
}

interface ID3D12Heap : ID3D12Pageable
{
    fn Dx_D3D12_HEAP_DESC get_desc();
}

struct ID3D12HeapImpl (ID3D12Heap)
{
    ID3D12HeapVtbl* vtbl;
    ID3D12HeapRaw* raw;
    HeapVersion version;
}

fn HeapVersion ID3D12HeapImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12HeapImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12HeapImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12HeapImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12HeapImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12HeapImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12HeapImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12HeapImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12HeapImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12HeapImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn Dx_D3D12_HEAP_DESC ID3D12HeapImpl.get_desc(&self) @dynamic
{
    Dx_D3D12_HEAP_DESC desc;
    self.vtbl.get_desc(self.raw, &desc);
    return desc;
}

fn ID3D12ProtectedResourceSession? ID3D12HeapImpl.get_protected_resource_session(&self) @dynamic
{
    validate_version(self.version, HeapVersion.HEAP1)!;
    ProtectedResourceSessionVersion version = g_supported_version_tracker.protected_resource_session_version;
    ID3D12ProtectedResourceSessionRaw* session;
    if (version == NOT_CHECKED_YET)
    {
        version = NOT_SUPPORTED;
        Win32_HRESULT hr = self.vtbl.get_protected_resource_session(self.raw, ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1.riid, &session);
        if (hr != S_OK)
        {
            hr = self.vtbl.get_protected_resource_session(self.raw, ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION.riid, &session);
            if (hr != S_OK) check_hresult(hr)!;
            version = ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION;
        }
        else
        {
            version = ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1;
        }
        g_supported_version_tracker.protected_resource_session_version = version;
    }
    if (session == null) return NOINTERFACE?;
    ID3D12ProtectedResourceSessionImpl* impl = mem::new(ID3D12ProtectedResourceSessionImpl);
    impl.vtbl = *(ID3D12ProtectedResourceSessionVtbl**) session;
    impl.raw = (ID3D12ProtectedResourceSessionRaw*) session;
    impl.version = version;
    return impl;
}

struct ID3D12ResourceVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12Resource methods
    Map map;
    Unmap unmap;
    GetResourceDesc get_desc;
    GetGPUVirtualAddress get_gpu_virtual_address;
    WriteToSubresource write_to_subresource;
    ReadFromSubresource read_from_subresource;
    GetHeapProperties get_heap_properties;

    // ID3D12Resource1 methods
    GetProtectedResourceSession get_protected_resource_session;

    // ID3D12Resource2 methods
    GetResourceDesc1 get_desc1;
}

interface ID3D12Resource : ID3D12Pageable
{
    fn Dx_D3D12_RESOURCE_DESC get_desc();

    fn Dx_D3D12_GPU_VIRTUAL_ADDRESS get_gpu_virtual_address();

    <*
     Gets a CPU pointer to the specified subresource in the resource, but may not disclose the pointer value to applications.
     Map also invalidates the CPU cache, when necessary, so that CPU reads to this address reflect any modifications made by the GPU.
    *>
    fn void*? map(Win32_UINT subresource, Dx_D3D12_RANGE* readRange);
    
    <*
     Invalidates the CPU pointer to the specified subresource in the resource. This indicates that the CPU might have
     been modified.
    *>
    fn void? unmap(Win32_UINT subresource, Dx_D3D12_RANGE* writtenRange);
    
    <*
     Uses the CPU to copy data into a subresource, enabling the CPU to modify the contents of most textures with undefined layouts.
     The resource should first be mapped with ID3D12Resource.map before calling this function.
    *>
    fn void? write_to_subresource(Win32_UINT dstSubresource, Dx_D3D12_BOX* dstBox, void* srcData, Win32_UINT srcRowPitch, Win32_UINT srcDepthPitch);

    <*
     Uses the CPU to copy data from a subresource.
    *>
    fn void? read_from_subresource(void* dstData, Win32_UINT dstRowPitch, Win32_UINT dstDepthPitch, Win32_UINT srcSubresource, Dx_D3D12_BOX* srcBox);

    fn Tuple{Dx_D3D12_HEAP_PROPERTIES,Dx_D3D12_HEAP_FLAGS}? get_heap_properties();

    // ID3D12Resource1 methods
    fn ID3D12ProtectedResourceSession? get_protected_resource_session();

    // ID3D12Resource2 methods
    fn Dx_D3D12_RESOURCE_DESC1? get_desc1();
}

struct ID3D12ResourceImpl (ID3D12Resource)
{
    ID3D12ResourceVtbl* vtbl;
    ID3D12ResourceRaw* raw;
    ResourceVersion version;
}

fn ResourceVersion ID3D12ResourceImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12ResourceImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12ResourceImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12ResourceImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12ResourceImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12ResourceImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12ResourceImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12ResourceImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12ResourceImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12ResourceImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn Dx_D3D12_RESOURCE_DESC ID3D12ResourceImpl.get_desc(&self) @dynamic
{
    Dx_D3D12_RESOURCE_DESC desc;
    self.vtbl.get_desc(self.raw, &desc);
    return desc;
}

fn Dx_D3D12_GPU_VIRTUAL_ADDRESS ID3D12ResourceImpl.get_gpu_virtual_address(&self) @dynamic
{
    return self.vtbl.get_gpu_virtual_address(self.raw);
}

fn void*? ID3D12ResourceImpl.map(&self, Win32_UINT subresource, Dx_D3D12_RANGE* readRange) @dynamic
{
    void* data;
    Win32_HRESULT hr = self.vtbl.map(self.raw, subresource, readRange, &data);
    if (hr != S_OK) check_hresult(hr)!;
    return data;
}

fn void? ID3D12ResourceImpl.unmap(&self, Win32_UINT subresource, Dx_D3D12_RANGE* writtenRange) @dynamic
{
    Win32_HRESULT hr = self.vtbl.unmap(self.raw, subresource, writtenRange);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12ResourceImpl.write_to_subresource(&self, Win32_UINT dstSubresource, Dx_D3D12_BOX* dstBox, void* srcData, Win32_UINT srcRowPitch, Win32_UINT srcDepthPitch) @dynamic
{
    Win32_HRESULT hr = self.vtbl.write_to_subresource(self.raw, dstSubresource, dstBox, srcData, srcRowPitch, srcDepthPitch);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12ResourceImpl.read_from_subresource(&self, void* dstData, Win32_UINT dstRowPitch, Win32_UINT dstDepthPitch, Win32_UINT srcSubresource, Dx_D3D12_BOX* srcBox) @dynamic
{
    Win32_HRESULT hr = self.vtbl.read_from_subresource(self.raw, dstData, dstRowPitch, dstDepthPitch, srcSubresource, srcBox);
    if (hr != S_OK) check_hresult(hr)!;
}

fn Tuple{Dx_D3D12_HEAP_PROPERTIES, Dx_D3D12_HEAP_FLAGS}? ID3D12ResourceImpl.get_heap_properties(&self) @dynamic
{
    Dx_D3D12_HEAP_PROPERTIES properties;
    Dx_D3D12_HEAP_FLAGS flags;
    Win32_HRESULT hr = self.vtbl.get_heap_properties(self.raw, &properties, &flags);
    if (hr != S_OK) check_hresult(hr)!;
    return { properties, flags };
}

fn ID3D12ProtectedResourceSession? ID3D12ResourceImpl.get_protected_resource_session(&self) @dynamic
{
    validate_version(self.version, ResourceVersion.RESOURCE1)!;
    ProtectedResourceSessionVersion version = g_supported_version_tracker.protected_resource_session_version;
    ID3D12ProtectedResourceSessionRaw* session;
    if (version == NOT_CHECKED_YET)
    {
        Win32_HRESULT hr = self.vtbl.get_protected_resource_session(self.raw, ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1.riid, &session);
        version = ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1;
        if (hr != S_OK)
        {
            hr = self.vtbl.get_protected_resource_session(self.raw, ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION.riid, &session);
            if (hr != S_OK) check_hresult(hr)!;
            version = ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION;
        }
    }
    if (session == null) return NOINTERFACE?;
    ID3D12ProtectedResourceSessionImpl* impl = mem::new(ID3D12ProtectedResourceSessionImpl);
    impl.vtbl = *(ID3D12ProtectedResourceSessionVtbl**) session;
    impl.raw = (ID3D12ProtectedResourceSessionRaw*) session;
    impl.version = version;
    return impl;
}

fn Dx_D3D12_RESOURCE_DESC1? ID3D12ResourceImpl.get_desc1(&self) @dynamic
{
    validate_version(self.version, ResourceVersion.RESOURCE2)!;
    Dx_D3D12_RESOURCE_DESC1 desc;
    self.vtbl.get_desc1(self.raw, &desc);
    return desc;
}

struct ID3D12DescriptorHeapVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12DescriptorHeap methods
    GetDescriptorHeapDesc get_desc;
    GetCPUDescriptorHandleForHeapStart get_cpu_descriptor_handle_for_heap_start;
    GetGPUDescriptorHandleForHeapStart get_gpu_descriptor_handle_for_heap_start;
}

interface ID3D12DescriptorHeap : ID3D12Pageable
{
    fn Dx_D3D12_DESCRIPTOR_HEAP_DESC get_desc();
    fn Dx_D3D12_CPU_DESCRIPTOR_HANDLE get_cpu_descriptor_handle_for_heap_start();
    fn Dx_D3D12_GPU_DESCRIPTOR_HANDLE get_gpu_descriptor_handle_for_heap_start();
}

struct ID3D12DescriptorHeapImpl (ID3D12DescriptorHeap)
{
    ID3D12DescriptorHeapVtbl* vtbl;
    ID3D12DescriptorHeapRaw* raw;
}

fn void* ID3D12DescriptorHeapImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12DescriptorHeapImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12DescriptorHeapImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12DescriptorHeapImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12DescriptorHeapImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12DescriptorHeapImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12DescriptorHeapImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12DescriptorHeapImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12DescriptorHeapImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn Dx_D3D12_DESCRIPTOR_HEAP_DESC ID3D12DescriptorHeapImpl.get_desc(&self) @dynamic
{
    Dx_D3D12_DESCRIPTOR_HEAP_DESC desc;
    self.vtbl.get_desc(self.raw, &desc);
    return desc;
}
fn Dx_D3D12_CPU_DESCRIPTOR_HANDLE ID3D12DescriptorHeapImpl.get_cpu_descriptor_handle_for_heap_start(&self) @dynamic
{
    Dx_D3D12_CPU_DESCRIPTOR_HANDLE handle;
    self.vtbl.get_cpu_descriptor_handle_for_heap_start(self.raw, &handle);
    return handle;
}
fn Dx_D3D12_GPU_DESCRIPTOR_HANDLE ID3D12DescriptorHeapImpl.get_gpu_descriptor_handle_for_heap_start(&self) @dynamic
{
    Dx_D3D12_GPU_DESCRIPTOR_HANDLE handle;
    self.vtbl.get_gpu_descriptor_handle_for_heap_start(self.raw, &handle);
    return handle;
}

struct ID3D12QueryHeapVtbl @private
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

interface ID3D12QueryHeap : ID3D12Pageable
{
}

struct ID3D12QueryHeapImpl (ID3D12QueryHeap)
{
    ID3D12QueryHeapVtbl* vtbl;
    ID3D12QueryHeapRaw* raw;
}

fn void* ID3D12QueryHeapImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12QueryHeapImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12QueryHeapImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12QueryHeapImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12QueryHeapImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12QueryHeapImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12QueryHeapImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12QueryHeapImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12QueryHeapImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

struct ID3D12ProtectedSessionVtbl
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;
    
    GetStatusFence get_status_fence;
    GetSessionStatus get_session_status;
}

interface ID3D12ProtectedSession : ID3D12DeviceChild
{
    fn ID3D12Fence? get_status_fence();
    fn Dx_D3D12_PROTECTED_SESSION_STATUS get_session_status();
}

struct ID3D12ProtectedResourceSessionVtbl
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12ProtectedSession methods
    GetStatusFence get_status_fence;
    GetSessionStatus get_session_status;

    // ID3D12ProtectedResourceSession methods
    GetProtectedResourceSessionDesc get_desc;

    // ID3D12ProtectedResourceSession1 methods
    GetProtectedResourceSessionDesc1 get_desc1;
}

interface ID3D12ProtectedResourceSession : ID3D12ProtectedSession
{
    fn ProtectedResourceSessionVersion get_version();

    fn Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC get_desc();

    fn Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1? get_desc1();
}

struct ID3D12ProtectedResourceSessionImpl (ID3D12ProtectedResourceSession)
{
    ID3D12ProtectedResourceSessionVtbl* vtbl;
    ID3D12ProtectedResourceSessionRaw* raw;
    ProtectedResourceSessionVersion version;
}

fn ProtectedResourceSessionVersion ID3D12ProtectedResourceSessionImpl.get_version(&self) @dynamic => self.version;

fn void* ID3D12ProtectedResourceSessionImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12ProtectedResourceSessionImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12ProtectedResourceSessionImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12ProtectedResourceSessionImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12ProtectedResourceSessionImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12ProtectedResourceSessionImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12ProtectedResourceSessionImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12ProtectedResourceSessionImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12ProtectedResourceSessionImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn ID3D12Fence? ID3D12ProtectedResourceSessionImpl.get_status_fence(&self) @dynamic
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
            hr = self.vtbl.get_status_fence(self.raw, riid, &fence);
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
        Win32_HRESULT hr = self.vtbl.get_status_fence(self.raw, riid, &fence);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(fence != null, "Failed to create fence, no supported version found");
    ID3D12FenceImpl* impl = mem::new(ID3D12FenceImpl);
    impl.vtbl = *(ID3D12FenceVtbl**) fence;
    impl.raw = (ID3D12FenceRaw*) fence;
    impl.version = version;
    return impl;
}

fn Dx_D3D12_PROTECTED_SESSION_STATUS ID3D12ProtectedResourceSessionImpl.get_session_status(&self) @dynamic
{
    Dx_D3D12_PROTECTED_SESSION_STATUS status = self.vtbl.get_session_status(self.raw);
    return status;
}

fn Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC ID3D12ProtectedResourceSessionImpl.get_desc(&self) @dynamic
{
    Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC desc;
    self.vtbl.get_desc(self.raw, &desc);
    return desc;
}

fn Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1? ID3D12ProtectedResourceSessionImpl.get_desc1(&self) @dynamic
{
    validate_version(self.version, ProtectedResourceSessionVersion.PROTECTED_RESOURCE_SESSION1)!;
    Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1 desc;
    self.vtbl.get_desc1(self.raw, &desc);
    return desc;
}

struct ID3D12LifetimeOwnerVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12LifetimeOwner methods
    LifetimeStateUpdated lifetime_state_updated;
}

interface ID3D12LifetimeOwner : IUnknown
{
    fn void lifetime_state_updated(Dx_D3D12_LIFETIME_STATE state);
}

struct ID3D12LifetimeTrackerVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12LifetimeTracker methods
    DestroyOwnedObject destroy_owned_object;
}

interface ID3D12LifetimeTracker : ID3D12DeviceChild
{
    fn void? destroy_owned_object(ID3D12DeviceChild object);
}

struct ID3D12LifetimeTrackerImpl (ID3D12LifetimeTracker)
{
    ID3D12LifetimeTrackerVtbl* vtbl;
    ID3D12LifetimeTrackerRaw* raw;
}

fn void* ID3D12LifetimeTrackerImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12LifetimeTrackerImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12LifetimeTrackerImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12LifetimeTrackerImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12LifetimeTrackerImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12LifetimeTrackerImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12LifetimeTrackerImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12LifetimeTrackerImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12LifetimeTrackerImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn void? ID3D12LifetimeTrackerImpl.destroy_owned_object(&self, ID3D12DeviceChild object) @dynamic
{
    Win32_HRESULT hr = self.vtbl.destroy_owned_object(self.raw, object.get_com_ptr());
    if (hr != S_OK) check_hresult(hr)!;
}

struct ID3D12StateObjectVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12StateObject methods
}

interface ID3D12StateObject : ID3D12Pageable
{
}

struct ID3D12StateObjectImpl (ID3D12StateObject)
{
    ID3D12StateObjectVtbl* vtbl;
    ID3D12StateObjectRaw* raw;
}

fn void* ID3D12StateObjectImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12StateObjectImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12StateObjectImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12StateObjectImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12StateObjectImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12StateObjectImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12StateObjectImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12StateObjectImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12StateObjectImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

struct ID3D12StateObjectPropertiesVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12StateObjectProperties methods
    GetShaderIdentifier get_shader_identifier;
    GetShaderStackSize get_shader_stack_size;
    GetPipelineStackSize get_pipeline_stack_size;
    SetPipelineStackSize set_pipeline_stack_size;

    // ID3D12StateObjectProperties1 methods
    GetProgramIdentifier get_program_identifier;
}

interface ID3D12StateObjectProperties : IUnknown
{
    fn void* get_shader_identifier(WString name);
    fn Win32_UINT64 get_shader_stack_size(WString name);
    fn Win32_UINT64 get_pipeline_stack_size();
    fn void? set_pipeline_stack_size(Win32_UINT64 size);

    // ID3D12StateObjectProperties1 methods
    fn Dx_D3D12_PROGRAM_IDENTIFIER get_program_identifier(WString name);
}

struct ID3D12VirtualizationGuestDeviceVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12VirtualizationGuestDevice methods
    ShareWithHost share_with_host;
    CreateFenceFd create_fence_fd;
}

interface ID3D12VirtualizationGuestDevice : IUnknown
{
    fn Win32_HANDLE? share_with_host(ID3D12DeviceChild object);
    fn int? create_fence_fd(ID3D12Fence fence, Win32_UINT64 value);
}
