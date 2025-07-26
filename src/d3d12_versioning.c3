module d3d12;

import std::os::win32;

enum DeviceVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    DEVICE = &IID_ID3D12DEVICE,
    DEVICE1 = &IID_ID3D12DEVICE1,
    DEVICE2 = &IID_ID3D12DEVICE2,
    DEVICE3 = &IID_ID3D12DEVICE3,
    DEVICE4 = &IID_ID3D12DEVICE4,
    DEVICE5 = &IID_ID3D12DEVICE5,
    DEVICE6 = &IID_ID3D12DEVICE6,
    DEVICE7 = &IID_ID3D12DEVICE7,
    DEVICE8 = &IID_ID3D12DEVICE8,
    DEVICE9 = &IID_ID3D12DEVICE9,
    DEVICE10 = &IID_ID3D12DEVICE10,
    DEVICE11 = &IID_ID3D12DEVICE11,
    DEVICE12 = &IID_ID3D12DEVICE12,
    DEVICE13 = &IID_ID3D12DEVICE13,
    DEVICE14 = &IID_ID3D12DEVICE14,
}

enum FenceVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    FENCE = &IID_ID3D12FENCE,
    FENCE1 = &IID_ID3D12FENCE1,
}

enum GraphicsCommandListVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    COMMAND_LIST = &IID_ID3D12GRAPHICSCOMMANDLIST,
    COMMAND_LIST1 = &IID_ID3D12GRAPHICSCOMMANDLIST1,
    COMMAND_LIST2 = &IID_ID3D12GRAPHICSCOMMANDLIST2,
    COMMAND_LIST3 = &IID_ID3D12GRAPHICSCOMMANDLIST3,
    COMMAND_LIST4 = &IID_ID3D12GRAPHICSCOMMANDLIST4,
    COMMAND_LIST5 = &IID_ID3D12GRAPHICSCOMMANDLIST5,
    COMMAND_LIST6 = &IID_ID3D12GRAPHICSCOMMANDLIST6,
    COMMAND_LIST7 = &IID_ID3D12GRAPHICSCOMMANDLIST7,
    COMMAND_LIST8 = &IID_ID3D12GRAPHICSCOMMANDLIST8,
    COMMAND_LIST9 = &IID_ID3D12GRAPHICSCOMMANDLIST9,
    COMMAND_LIST10 = &IID_ID3D12GRAPHICSCOMMANDLIST10,
}

enum PipelineLibraryVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    PIPELINE_LIBRARY = &IID_ID3D12PIPELINELIBRARY,
    PIPELINE_LIBRARY1 = &IID_ID3D12PIPELINELIBRARY1,
}

enum DeviceRemovedExtendedDataSettingsVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    DRED_SETTINGS = &IID_ID3D12DEVICEREMOVEDEXTENDEDDATASETTINGS,
    DRED_SETTINGS1 = &IID_ID3D12DEVICEREMOVEDEXTENDEDDATASETTINGS1,
    DRED_SETTINGS2 = &IID_ID3D12DEVICEREMOVEDEXTENDEDDATASETTINGS2,
}

enum ProtectedResourceSessionVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    PROTECTED_RESOURCE_SESSION = &IID_ID3D12PROTECTEDRESOURCESESSION,
    PROTECTED_RESOURCE_SESSION1 = &IID_ID3D12PROTECTEDRESOURCESESSION1,
}

enum ResourceVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    RESOURCE = &IID_ID3D12RESOURCE,
    RESOURCE1 = &IID_ID3D12RESOURCE1,
    RESOURCE2 = &IID_ID3D12RESOURCE2,
}

enum HeapVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    HEAP = &IID_ID3D12HEAP,
    HEAP1 = &IID_ID3D12HEAP1,
}

enum DebugVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    DEBUG = &IID_ID3D12DEBUG,
    DEBUG1 = &IID_ID3D12DEBUG1,
    //DEBUG2 = &IID_ID3D12DEBUG2, Skip Debug2 as it doesn't actually inherit from Debug1 so handling it's vtable is more complex than typical
    DEBUG3 = &IID_ID3D12DEBUG3,
    DEBUG4 = &IID_ID3D12DEBUG4,
    DEBUG5 = &IID_ID3D12DEBUG5,
    DEBUG6 = &IID_ID3D12DEBUG6,
}

enum DxgiFactoryVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    FACTORY = &IID_IDXGIFACTORY,
    FACTORY1 = &IID_IDXGIFACTORY1,
    FACTORY2 = &IID_IDXGIFACTORY2,
    FACTORY3 = &IID_IDXGIFACTORY3,
    FACTORY4 = &IID_IDXGIFACTORY4,
    FACTORY5 = &IID_IDXGIFACTORY5,
    FACTORY6 = &IID_IDXGIFACTORY6,
    FACTORY7 = &IID_IDXGIFACTORY7,
}

enum DxgiSurfaceVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    SURFACE = &IID_IDXGISURFACE,
    SURFACE1 = &IID_IDXGISURFACE1,
    SURFACE2 = &IID_IDXGISURFACE2,
}

enum DxgiAdapterVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    ADAPTER = &IID_IDXGIADAPTER,
    ADAPTER1 = &IID_IDXGIADAPTER1,
    ADAPTER2 = &IID_IDXGIADAPTER2,
    ADAPTER3 = &IID_IDXGIADAPTER3,
    ADAPTER4 = &IID_IDXGIADAPTER4,
}

enum DxgiDeviceVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    DEVICE = &IID_IDXGIDEVICE,
    DEVICE1 = &IID_IDXGIDEVICE1,
    DEVICE2 = &IID_IDXGIDEVICE2,
    DEVICE3 = &IID_IDXGIDEVICE3,
    DEVICE4 = &IID_IDXGIDEVICE4,
}

enum DxgiOutputVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    OUTPUT = &IID_IDXGIOUTPUT,
    OUTPUT1 = &IID_IDXGIOUTPUT1,
    OUTPUT2 = &IID_IDXGIOUTPUT2,
    OUTPUT3 = &IID_IDXGIOUTPUT3,
    OUTPUT4 = &IID_IDXGIOUTPUT4,
    OUTPUT5 = &IID_IDXGIOUTPUT5,
    OUTPUT6 = &IID_IDXGIOUTPUT6,
}

enum DxgiSwapChainVersion : (Win32_REFIID riid)
{
    NOT_CHECKED_YET = {},
    NOT_SUPPORTED = {},
    SWAP_CHAIN = &IID_IDXGISWAPCHAIN,
    SWAP_CHAIN1 = &IID_IDXGISWAPCHAIN1,
    SWAP_CHAIN2 = &IID_IDXGISWAPCHAIN2,
    SWAP_CHAIN3 = &IID_IDXGISWAPCHAIN3,
    SWAP_CHAIN4 = &IID_IDXGISWAPCHAIN4,
}

struct SupportedVersionTracker
{
    DeviceVersion device_version;
    FenceVersion fence_version;
    GraphicsCommandListVersion graphics_command_list_version;
    PipelineLibraryVersion pipeline_library_version;
    DeviceRemovedExtendedDataSettingsVersion dred_settings_version;
    ProtectedResourceSessionVersion protected_resource_session_version;
    ResourceVersion resource_version;
    HeapVersion heap_version;
    DebugVersion debug_version;
    DxgiFactoryVersion dxgi_factory_version;
    DxgiSurfaceVersion dxgi_surface_version;
    DxgiAdapterVersion dxgi_adapter_version;
    DxgiDeviceVersion dxgi_device_version;
    DxgiOutputVersion dxgi_output_version;
    DxgiSwapChainVersion dxgi_swap_chain_version;
}
SupportedVersionTracker g_supported_version_tracker;

fn DeviceVersion SupportedVersionTracker.get_device(&self, IUnknown obj)
{
    if (self.device_version == NOT_CHECKED_YET && obj != null)
    {
        self.device_version = DeviceVersion.from_ordinal(calculate_version(@get_riids(DeviceVersion), obj));
        log_debug("ID3D12Device version: %s", self.device_version);
        assert(self.device_version != NOT_SUPPORTED, "ID3D12Device not supported!");
    }
    return self.device_version;
}

fn FenceVersion SupportedVersionTracker.get_fence(&self, IUnknown obj)
{
    if (self.fence_version == NOT_CHECKED_YET && obj != null)
    {
        self.fence_version = FenceVersion.from_ordinal(calculate_version(@get_riids(FenceVersion), obj));
        log_debug("ID3D12Fence version: %s", self.fence_version);
        assert(self.fence_version != NOT_SUPPORTED, "ID3D12Fence not supported!");
    }
    return self.fence_version;
}

fn GraphicsCommandListVersion SupportedVersionTracker.get_graphics_command_list(&self, IUnknown obj)
{
    if (self.graphics_command_list_version == NOT_CHECKED_YET && obj != null)
    {
        self.graphics_command_list_version = GraphicsCommandListVersion.from_ordinal(calculate_version(@get_riids(GraphicsCommandListVersion), obj));
        log_debug("ID3D12GraphicsCommandList version: %s", self.graphics_command_list_version);
        assert(self.graphics_command_list_version != NOT_SUPPORTED, "ID3D12GraphicsCommandList not supported!");
    }
    return self.graphics_command_list_version;
}

fn PipelineLibraryVersion SupportedVersionTracker.get_pipeline_library(&self, IUnknown obj)
{
    if (self.pipeline_library_version == NOT_CHECKED_YET && obj != null)
    {
        self.pipeline_library_version = PipelineLibraryVersion.from_ordinal(calculate_version(@get_riids(PipelineLibraryVersion), obj));
        log_debug("ID3D12PipelineLibrary version: %s", self.pipeline_library_version);
        assert(self.pipeline_library_version != NOT_SUPPORTED, "ID3D12PipelineLibrary not supported!"); 
    }
    return self.pipeline_library_version;
}

fn DeviceRemovedExtendedDataSettingsVersion SupportedVersionTracker.get_dred_settings(&self, IUnknown obj)
{
    if (self.dred_settings_version == NOT_CHECKED_YET && obj != null)
    {
        self.dred_settings_version = DeviceRemovedExtendedDataSettingsVersion.from_ordinal(calculate_version(@get_riids(DeviceRemovedExtendedDataSettingsVersion), obj));
        log_debug("ID3D12DeviceRemovedExtendedDataSettings version: %s", self.dred_settings_version);
        assert(self.dred_settings_version != NOT_SUPPORTED, "ID3D12DeviceRemovedExtendedDataSettings not supported!");
    }
    return self.dred_settings_version;
}

fn ProtectedResourceSessionVersion SupportedVersionTracker.get_protected_resource_session(&self, IUnknown obj)
{
    if (self.protected_resource_session_version == ProtectedResourceSessionVersion.NOT_CHECKED_YET && obj != null)
    {
        self.protected_resource_session_version = ProtectedResourceSessionVersion.from_ordinal(calculate_version(@get_riids(ProtectedResourceSessionVersion), obj));
        log_debug("ID3D12ProtectedResourceSession version: %s", self.protected_resource_session_version);
        assert(self.protected_resource_session_version != NOT_SUPPORTED, "ID3D12ProtectedResourceSession not supported!");
    }
    return self.protected_resource_session_version;
}

fn ResourceVersion SupportedVersionTracker.get_resource(&self, IUnknown obj)
{
    if (self.resource_version == NOT_CHECKED_YET && obj != null)
    {
        self.resource_version = ResourceVersion.from_ordinal(calculate_version(@get_riids(ResourceVersion), obj));
        log_debug("ID3D12Resource version: %s", self.resource_version);
        assert(self.resource_version != NOT_SUPPORTED, "ID3D12Resource not supported!");
    }
    return self.resource_version;
}

fn HeapVersion SupportedVersionTracker.get_heap(&self, IUnknown obj)
{
    if (self.heap_version == NOT_CHECKED_YET && obj != null)
    {
        self.heap_version = HeapVersion.from_ordinal(calculate_version(@get_riids(HeapVersion), obj));
        log_debug("ID3D12Heap version: %s", self.heap_version);
        assert(self.heap_version != NOT_SUPPORTED, "ID3D12Heap not supported!");
    }
    return self.heap_version;
}

fn DebugVersion SupportedVersionTracker.get_debug(&self, IUnknown obj)
{
    if (self.debug_version == NOT_CHECKED_YET && obj != null)
    {
        self.debug_version = DebugVersion.from_ordinal(calculate_version(@get_riids(DebugVersion), obj));
        log_debug("ID3D12Debug version: %s", self.debug_version);
        assert(self.debug_version != NOT_SUPPORTED, "ID3D12Debug not supported!");
    }
    return self.debug_version;
}

fn DxgiFactoryVersion SupportedVersionTracker.get_dxgi_factory(&self, IUnknown obj)
{
    if (self.dxgi_factory_version == NOT_CHECKED_YET && obj != null)
    {
        self.dxgi_factory_version = DxgiFactoryVersion.from_ordinal(calculate_version(@get_riids(DxgiFactoryVersion), obj));
        log_debug("IDXGIFactory version: %s", self.dxgi_factory_version);
        assert(self.dxgi_factory_version != NOT_SUPPORTED, "IDXGIFactory not supported!");
    }
    return self.dxgi_factory_version;
}

fn DxgiSurfaceVersion SupportedVersionTracker.get_dxgi_surface(&self, IUnknown obj)
{
    if (self.dxgi_surface_version == NOT_CHECKED_YET && obj != null)
    {
        self.dxgi_surface_version = DxgiSurfaceVersion.from_ordinal(calculate_version(@get_riids(DxgiSurfaceVersion), obj));
        log_debug("IDXGISurface version: %s", self.dxgi_surface_version);
        assert(self.dxgi_surface_version != NOT_SUPPORTED, "IDXGISurface not supported!");
    }
    return self.dxgi_surface_version;
}

fn DxgiAdapterVersion SupportedVersionTracker.get_dxgi_adapter(&self, IUnknown obj)
{
    if (self.dxgi_adapter_version == NOT_CHECKED_YET && obj != null)
    {
        self.dxgi_adapter_version = DxgiAdapterVersion.from_ordinal(calculate_version(@get_riids(DxgiAdapterVersion), obj));
        log_debug("IDXGIAdapter version: %s", self.dxgi_adapter_version);
        assert(self.dxgi_adapter_version != NOT_SUPPORTED, "IDXGIAdapter not supported!");
    }
    return self.dxgi_adapter_version;
}

fn DxgiDeviceVersion SupportedVersionTracker.get_dxgi_device(&self, IUnknown obj)
{
    if (self.dxgi_device_version == NOT_CHECKED_YET && obj != null)
    {
        self.dxgi_device_version = DxgiDeviceVersion.from_ordinal(calculate_version(@get_riids(DxgiDeviceVersion), obj));
        log_debug("IDXGIDevice version: %s", self.dxgi_device_version);
        assert(self.dxgi_device_version != NOT_SUPPORTED, "IDXGIDevice not supported!");
    }
    return self.dxgi_device_version;
}

fn DxgiOutputVersion SupportedVersionTracker.get_dxgi_output(&self, IUnknown obj)
{
    if (self.dxgi_output_version == NOT_CHECKED_YET && obj != null)
    {
        self.dxgi_output_version = DxgiOutputVersion.from_ordinal(calculate_version(@get_riids(DxgiOutputVersion), obj));
        log_debug("IDXGIOutput version: %s", self.dxgi_output_version);
        assert(self.dxgi_output_version != NOT_SUPPORTED, "IDXGIOutput not supported!");
    }
    return self.dxgi_output_version;
}

fn DxgiSwapChainVersion SupportedVersionTracker.get_dxgi_swap_chain(&self, IUnknown obj)
{
    if (self.dxgi_swap_chain_version == NOT_CHECKED_YET && obj != null)
    {
        self.dxgi_swap_chain_version = DxgiSwapChainVersion.from_ordinal(calculate_version(@get_riids(DxgiSwapChainVersion), obj));
        log_debug("IDXGISwapChain version: %s", self.dxgi_swap_chain_version);
        assert(self.dxgi_swap_chain_version != NOT_SUPPORTED, "IDXGISwapChain not supported!");
    }
    return self.dxgi_swap_chain_version;
}

macro void? validate_version(version, require)
{
    if (version.ordinal < require.ordinal)
    {
        return NOINTERFACE?;
    }
}

macro @get_riids($Enum)
{
    Win32_REFIID[$Enum.values.len] ids;
    for (int i = 0; i < $Enum.values.len; ++i)
    {
        $Enum value = $Enum.values[i];
        ids[i] = value.riid;
    }
    return ids[..];
}

fn int calculate_version(Win32_REFIID[] ids, IUnknown base)
{
    IUnknownVtbl* vtbl = *(IUnknownVtbl**) base.ptr;
    for (int i = (int) ids.len - 1; i > 1; --i)
    {
        Win32_REFIID riid = ids[i];
        if (try void* iface = base.query_interface(riid))
        {
            vtbl.release(iface);
            return i;
        }
    }
    return 1;
}
