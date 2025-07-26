module dxgi;

import std::io;
import std::os::win32;
import d3d12 @public;

alias IDXGIAdapterRaw = void;
alias IDXGIDebugRaw = void;
alias IDXGIDecodeSwapChainRaw = void;
alias IDXGIDeviceRaw = void;
alias IDXGIDeviceSubObjectRaw = void;
alias IDXGIFactoryRaw = void;
alias IDXGIKeyedMutexRaw = void;
alias IDXGIOutputRaw = void;
alias IDXGIOutputDuplicationRaw = void;
alias IDXGIResourceRaw = void;
alias IDXGISurfaceRaw = void;
alias IDXGISwapChainRaw = void;

////////////////////////////////////////////////////////////////////////////////
// Vtbl function interfaces
////////////////////////////////////////////////////////////////////////////////

alias AcquireNextFrame = fn Win32_HRESULT(void*, Win32_UINT, Dx_DXGI_OUTDUPL_FRAME_INFO*, IDXGIResourceRaw**);
alias AcquireSync = fn Win32_HRESULT(void*, Win32_UINT64, Win32_DWORD);
alias CheckColorSpaceSupport = fn Win32_HRESULT(void*, Dx_DXGI_COLOR_SPACE_TYPE, Win32_UINT*);
alias CheckFeatureSupport = fn Win32_HRESULT(void*, Dx_DXGI_FEATURE, void*, Win32_UINT);
alias CheckHardwareCompositionSupport = fn Win32_HRESULT(void*, Win32_UINT*);
alias CheckInterfaceSupport = fn Win32_HRESULT(void*, Win32_REFIID, Win32_UINT64*);
alias CheckOverlayColorSpaceSupport = fn Win32_HRESULT(void*, Dx_DXGI_FORMAT, Dx_DXGI_COLOR_SPACE_TYPE, IUnknownRaw*, Win32_UINT*);
alias CheckOverlaySupport = fn Win32_HRESULT(void*, Dx_DXGI_FORMAT, IDXGIOutputRaw*, Win32_UINT*);
alias CheckPresentDurationSupport = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT*, Win32_UINT*);
alias CreateSharedHandle = fn Win32_HRESULT(void*, Win32_SECURITY_ATTRIBUTES*, Win32_DWORD, Win32_LPCWSTR, Win32_HANDLE*);
alias CreateSoftwareAdapter = fn Win32_HRESULT(void*, Win32_HANDLE, IDXGIAdapterRaw**);
alias CreateSubresourceSurface = fn Win32_HRESULT(void*, Win32_UINT, IDXGISurfaceRaw**);
alias CreateSurface = fn Win32_HRESULT(void*, Dx_DXGI_SURFACE_DESC*, Win32_UINT, Dx_DXGI_USAGE, Dx_DXGI_SHARED_RESOURCE*, IDXGISurface**);
alias CreateSwapChain = fn Win32_HRESULT(void*, IUnknownRaw*, Dx_DXGI_SWAP_CHAIN_DESC*, IDXGISwapChainRaw**);
alias CreateSwapChainForComposition = fn Win32_HRESULT(void*, IUnknownRaw*, Dx_DXGI_SWAP_CHAIN_DESC1*, IDXGIOutputRaw*, IDXGISwapChainRaw**);
alias CreateSwapChainForCoreWindow = fn Win32_HRESULT(void*, IUnknownRaw*, IUnknownRaw*, Dx_DXGI_SWAP_CHAIN_DESC1*, IDXGIOutput*, IDXGISwapChainRaw**);
alias CreateSwapChainForHwnd = fn Win32_HRESULT(void*, IUnknownRaw*, Win32_HWND, Dx_DXGI_SWAP_CHAIN_DESC1*, Dx_DXGI_SWAP_CHAIN_FULLSCREEN_DESC*, IDXGIOutputRaw*, IDXGISwapChainRaw**);
alias DuplicateOutput = fn Win32_HRESULT(void*, IUnknownRaw*, IDXGIOutputDuplicationRaw**);
alias DuplicateOutput1 = fn Win32_HRESULT(void*, IUnknownRaw*, Win32_UINT, Win32_UINT, Dx_DXGI_FORMAT*, IDXGIOutputDuplicationRaw**);
alias EnumOutputs = fn Win32_HRESULT(void*, Win32_UINT, IDXGIOutputRaw**);
alias EnumAdapters = fn Win32_HRESULT(void*, Win32_UINT, IDXGIAdapterRaw**);
alias EnumAdapters1 = fn Win32_HRESULT(void*, Win32_UINT, IDXGIAdapterRaw**);
alias EnumAdapterByGpuPreference = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Win32_REFIID, void**);
alias EnumAdapterByLuid = fn Win32_HRESULT(void*, Win32_LUID, Win32_REFIID, void**);
alias EnumWarpAdapter = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias EnqueueSetEvent = fn Win32_HRESULT(void*, Win32_HANDLE);
alias FindClosestMatchingMode = fn Win32_HRESULT(void*, Dx_DXGI_MODE_DESC*, Dx_DXGI_MODE_DESC*, IUnknownRaw*);
alias FindClosestMatchingMode1 = fn Win32_HRESULT(void*, Dx_DXGI_MODE_DESC1*, Dx_DXGI_MODE_DESC1*, IUnknownRaw*);
alias GetAdapter = fn Win32_HRESULT(void*, IDXGIAdapterRaw**);
alias GetAdapterDesc = fn Win32_HRESULT(void*, Dx_DXGI_ADAPTER_DESC*);
alias GetBackgroundColor = fn Win32_HRESULT(void*, Dx_DXGI_RGBA* pColor);
alias GetBuffer = fn Win32_HRESULT(void*, Win32_UINT, Win32_REFIID, void**);
alias GetColorSpace = fn Dx_DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS(void*);
alias GetContainingOutput = fn Win32_HRESULT(void*, IDXGIOutputRaw**);
alias GetCoreWindow = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias GetCreationFlags = fn Win32_UINT(void*);
alias GetCurrentBackBufferIndex = fn Win32_UINT(void*);
alias GetDesc1 = fn Win32_HRESULT(void*, Dx_DXGI_ADAPTER_DESC1*);
alias GetDesc2 = fn Win32_HRESULT(void*, Dx_DXGI_ADAPTER_DESC2*);
alias GetDesc3 = fn Win32_HRESULT(void*, Dx_DXGI_ADAPTER_DESC3*);
alias GetDestSize = fn Win32_HRESULT(void*, Win32_UINT*, Win32_UINT*);
alias GetDevice = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias GetDisplayModeList = fn Win32_HRESULT(void*, Dx_DXGI_FORMAT, Win32_UINT, Win32_UINT*, Dx_DXGI_MODE_DESC*);
alias GetDisplayModeList1 = fn Win32_HRESULT(void*, Dx_DXGI_FORMAT, Win32_UINT, Win32_UINT*, Dx_DXGI_MODE_DESC1*);
alias GetDisplaySurfaceData = fn Win32_HRESULT(void*, IDXGISurfaceRaw*);
alias GetDisplaySurfaceData1 = fn Win32_HRESULT(void*, IDXGIResourceRaw*);
alias GetEvictionPriority = fn Win32_HRESULT(void*, Win32_UINT*);
alias GetFrameDirtyRects = fn Win32_HRESULT(void*, Win32_UINT, Win32_RECT*, Win32_UINT*);
alias GetFrameLatencyWaitableObject = fn Win32_HANDLE(void*);
alias GetFrameMoveRects = fn Win32_HRESULT(void*, Win32_UINT, Win32_RECT*, Win32_UINT*);
alias GetFramePointerShape = fn Win32_HRESULT(void*, Win32_UINT, void*, Win32_UINT*, Dx_DXGI_OUTDUPL_POINTER_SHAPE_INFO*);
alias GetFrameStatistics = fn Win32_HRESULT(void*, Dx_DXGI_FRAME_STATISTICS*);
alias GetFrameStatisticsMedia = fn Win32_HRESULT(void*, Dx_DXGI_FRAME_STATISTICS_MEDIA*);
alias GetFullscreenDesc = fn Win32_HRESULT(void*, Dx_DXGI_SWAP_CHAIN_FULLSCREEN_DESC*);
alias GetFullscreenState = fn Win32_HRESULT(void*, Win32_BOOL*, IDXGIOutputRaw**);
alias GetGammaControl = fn Win32_HRESULT(void*, Dx_DXGI_GAMMA_CONTROL*);
alias GetGammaControlCapabilities = fn Win32_HRESULT(void*, Dx_DXGI_GAMMA_CONTROL_CAPABILITIES*);
alias GetGPUThreadPriority = fn Win32_HRESULT(void*, Win32_INT*);
alias SetHDRMetaData = fn Win32_HRESULT(void*, Dx_DXGI_HDR_METADATA_TYPE, Win32_UINT, void*);
alias GetHwnd = fn Win32_HRESULT(void*, Win32_HWND* pHwnd);
alias GetLastPresentCount = fn Win32_HRESULT(void*, Win32_UINT*);
alias GetMatrixTransform = fn Win32_HRESULT(void*, Dx_DXGI_MATRIX_3X2_F*);
alias GetMaximumFrameLatency = fn Win32_HRESULT(void*, Win32_UINT*);
alias GetOutputDesc = fn Win32_HRESULT(void*, Dx_DXGI_OUTPUT_DESC*);
alias GetOutputDesc1 = fn Win32_HRESULT(void*, Dx_DXGI_OUTPUT_DESC1* pDesc);
alias GetOutputDuplicationDesc = fn void(void*, Dx_DXGI_OUTDUPL_DESC*);
alias GetResource = fn Win32_HRESULT(void*, Win32_REFIID, void**, Win32_UINT*);
alias GetRestrictToOutput = fn Win32_HRESULT(void*, IDXGIOutputRaw**);
alias GetRotation = fn Win32_HRESULT(void*, Dx_DXGI_MODE_ROTATION*);
alias GetSharedHandle = fn Win32_HRESULT(void*, Win32_HANDLE*);
alias GetSharedResourceAdapterLuid = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_LUID*);
alias GetSourceRect = fn Win32_HRESULT(void*, Win32_RECT*);
alias GetSourceSize = fn Win32_HRESULT(void*, Win32_UINT*, Win32_UINT*);
alias GetSurfaceDC = fn Win32_HRESULT(void*, Win32_BOOL, Win32_HDC*);
alias GetSurfaceDesc = fn Win32_HRESULT(void*, Dx_DXGI_SURFACE_DESC*);
alias GetSwapChainDesc = fn Win32_HRESULT(void*, Dx_DXGI_SWAP_CHAIN_DESC*);
alias GetSwapChainDesc1 = fn Win32_HRESULT(void*, Dx_DXGI_SWAP_CHAIN_DESC1*);
alias GetTargetRect = fn Win32_HRESULT(void*, Win32_RECT* pRect);
alias GetUsage = fn Win32_HRESULT(void*, Dx_DXGI_USAGE*);
alias GetWindowAssociation = fn Win32_HRESULT(void*, Win32_HWND*);
alias IsCurrent = fn Win32_BOOL(void*);
alias IsStereoEnabled = fn Win32_BOOL(void*);
alias IsTemporaryMonoSupported = fn Win32_BOOL(void*);
alias MakeWindowAssociation = fn Win32_HRESULT(void*, Win32_HWND, Win32_UINT);
alias MapDesktopSurface = fn Win32_HRESULT(void*, Dx_DXGI_MAPPED_RECT*);
alias MapSurface = fn Win32_HRESULT(void*, Dx_DXGI_MAPPED_RECT*, Win32_UINT);
alias OfferResources = fn Win32_HRESULT(void*, Win32_UINT, IDXGIResourceRaw**, Dx_DXGI_OFFER_RESOURCE_PRIORITY);
alias OfferResources1 = fn Win32_HRESULT(void*, Win32_UINT, IDXGIResourceRaw**, Dx_DXGI_OFFER_RESOURCE_PRIORITY, Win32_UINT);
alias Present = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT);
alias Present1 = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Dx_DXGI_PRESENT_PARAMETERS*);
alias PresentBuffer = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Win32_UINT);
alias QueryResourceResidency = fn Win32_HRESULT(void*, IUnknown**, Dx_DXGI_RESIDENCY*, Win32_UINT);
alias QueryVideoMemoryInfo = fn Win32_HRESULT(void*, Win32_UINT, Dx_DXGI_MEMORY_SEGMENT_GROUP, Dx_DXGI_QUERY_VIDEO_MEMORY_INFO*);
alias ReclaimResources = fn Win32_HRESULT(void*, Win32_UINT, IDXGIResourceRaw**, Win32_BOOL*);
alias RegisterAdaptersChangedEvent = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_DWORD*);
alias RegisterHardwareContentProtectionTeardownStatusEvent = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_DWORD*);
alias RegisterOcclusionStatusEvent = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_DWORD*);
alias RegisterOcclusionStatusWindow = fn Win32_HRESULT(void*, Win32_HWND, Win32_UINT, Win32_DWORD*);
alias RegisterStereoStatusEvent = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_DWORD*);
alias RegisterStereoStatusWindow = fn Win32_HRESULT(void*, Win32_HWND, Win32_UINT, Win32_DWORD*);
alias RegisterVideoMemoryBudgetChangeNotificationEvent = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_DWORD*);
alias ReleaseDC = fn Win32_HRESULT(void*, Win32_RECT*);
alias ReleaseFrame = fn Win32_HRESULT(void*);
alias ReleaseOwnership = fn Win32_HRESULT(void*);
alias ReclaimResources1 = fn Win32_HRESULT(void*, Win32_UINT, IDXGIResourceRaw**, Dx_DXGI_RECLAIM_RESOURCE_RESULTS*);
alias ReleaseSync = fn Win32_HRESULT(void*, Win32_UINT64);
alias ReportLiveObjects = fn Win32_HRESULT(void*, Win32_GUID, Dx_DXGI_DEBUG_RLO_FLAGS);
alias ResizeBuffers = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Win32_UINT, Dx_DXGI_FORMAT, Win32_UINT);
alias ResizeBuffers1 = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Win32_UINT, Dx_DXGI_FORMAT, Win32_UINT, Win32_UINT*, IUnknown**);
alias ResizeTarget = fn Win32_HRESULT(void*, Dx_DXGI_MODE_DESC*);
alias SetBackgroundColor = fn Win32_HRESULT(void*, Dx_DXGI_RGBA*);
alias SetColorSpace = fn Win32_HRESULT(void*, Dx_DXGI_COLOR_SPACE_TYPE);
alias SetDestSize = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT);
alias SetDisplaySurface = fn Win32_HRESULT(void*, IDXGISurfaceRaw*);
alias SetEvictionPriority = fn Win32_HRESULT(void*, Win32_UINT);
alias SetFullscreenState = fn Win32_HRESULT(void*, Win32_BOOL, IDXGIOutputRaw*);
alias SetGammaControl = fn Win32_HRESULT(void*, Dx_DXGI_GAMMA_CONTROL*);
alias SetGPUThreadPriority = fn Win32_HRESULT(void*, Win32_INT);
alias SetMatrixTransform = fn Win32_HRESULT(void*, Dx_DXGI_MATRIX_3X2_F*);
alias SetMaximumFrameLatency = fn Win32_HRESULT(void*, Win32_UINT);
alias SetPresentDuration = fn Win32_HRESULT(void*, Win32_UINT);
alias SetRotation = fn Win32_HRESULT(void*, Dx_DXGI_MODE_ROTATION);
alias SetSourceRect = fn Win32_HRESULT(void*, Win32_RECT*);
alias SetSourceSize = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT);
alias SetStereoEnabled = fn void(void*, Win32_BOOL);
alias SetTargetRect = fn Win32_HRESULT(void*, Win32_RECT*);
alias SetVideoMemoryReservation = fn Win32_HRESULT(void*, Win32_UINT, Dx_DXGI_MEMORY_SEGMENT_GROUP, Win32_UINT64);
alias SupportsOverlays = fn Win32_BOOL(void*);
alias TakeOwnership = fn Win32_HRESULT(void*, IUnknownRaw*, Win32_BOOL);
alias Trim = fn void(void*);
alias UnMapDesktopSurface = fn Win32_HRESULT(void*);
alias UnmapSurface = fn Win32_HRESULT(void*);
alias UnregisterAdaptersChangedEvent = fn Win32_HRESULT(void*, Win32_DWORD);
alias UnregisterHardwareContentProtectionTeardownStatus = fn Win32_HRESULT(void*, Win32_DWORD);
alias UnregisterOcclusionStatus = fn Win32_HRESULT(void*, Win32_DWORD);
alias UnregisterStereoStatus = fn Win32_HRESULT(void*, Win32_DWORD);
alias UnregisterVideoMemoryBudgetChangeNotification = fn Win32_HRESULT(void*, Win32_DWORD);
alias WaitForVBlank = fn Win32_HRESULT(void*);

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

interface IDXGIObject : d3d12::IUnknown
{
    fn void? set_private_data(Win32_REFIID guid, Win32_UINT dataSize, void* data);
    fn void? set_private_data_interface(Win32_REFIID guid, void* data);
    fn void? get_private_data(Win32_REFIID guid, Win32_UINT* dataSize, void* data);
    fn void*? get_parent(Win32_REFIID riid);
}

struct IDXGIFactoryVtbl @private
{
    // IDXGIObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;

    // IDXGIFactory methods
    EnumAdapters enum_adapters;
    MakeWindowAssociation make_window_association;
    GetWindowAssociation get_window_association;
    CreateSwapChain create_swap_chain;
    CreateSoftwareAdapter create_software_adapter;

    // IDXGIFactory1 methods
    EnumAdapters1 enum_adapters1;
    IsCurrent is_current;

    // IDXGIFactory2 methods
    IsStereoEnabled is_windowed_stereo_enabled;
    CreateSwapChainForHwnd create_swap_chain_for_hwnd;
    CreateSwapChainForCoreWindow create_swap_chain_for_core_window;
    GetSharedResourceAdapterLuid get_shared_resource_adapter_luid;
    RegisterStereoStatusWindow register_stereo_status_window;
    RegisterStereoStatusEvent register_stereo_status_event;
    UnregisterStereoStatus unregister_stereo_status;
    RegisterOcclusionStatusWindow register_occlusion_status_window;
    RegisterOcclusionStatusEvent register_occlusion_status_event;
    UnregisterOcclusionStatus unregister_occlusion_status;
    CreateSwapChainForComposition create_swap_chain_for_composition;

    // IDXGIFactory3 methods
    GetCreationFlags get_creation_flags;

    // IDXGIFactory4 methods
    EnumAdapterByLuid enum_adapter_by_luid;
    EnumWarpAdapter enum_warp_adapter;

    // IDXGIFactory5 methods
    CheckFeatureSupport check_feature_support;

    // IDXGIFactory6 methods
    EnumAdapterByGpuPreference enum_adapter_by_gpu_preference;

    // IDXGIFactory7 methods
    RegisterAdaptersChangedEvent register_adapters_changed_event;
    UnregisterAdaptersChangedEvent unregister_adapters_changed_event;
}

interface IDXGIFactory : IDXGIObject
{
    fn DxgiFactoryVersion get_version();

    fn IDXGIAdapter? enum_adapters(Win32_UINT adapterIndex);

    fn void? make_window_association(Win32_HWND hwnd, Dx_DXGI_MWA flags);

    fn IDXGIAdapter? enum_adapters1(Win32_UINT adapterIndex);

    fn IDXGISwapChain? create_swap_chain_for_hwnd(d3d12::ID3D12CommandQueue command_queue, Win32_HWND hwnd, Dx_DXGI_SWAP_CHAIN_DESC1* desc, Dx_DXGI_SWAP_CHAIN_FULLSCREEN_DESC* fullscreen_desc, IDXGIOutput restrictToOutput);

    fn IDXGIAdapter? enum_adapter_by_gpu_preference(Win32_UINT adapterIndex, Dx_DXGI_GPU_PREFERENCE gpuPreference);
}

struct IDXGIFactoryImpl (IDXGIFactory)
{
    IDXGIFactoryVtbl* vtbl;
    IDXGIFactoryRaw* raw;
    DxgiFactoryVersion version;
}

fn DxgiFactoryVersion IDXGIFactoryImpl.get_version(&self) @dynamic => self.version;

fn void* IDXGIFactoryImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? IDXGIFactoryImpl.query_interface(&self, Win32_REFIID riid) @dynamic => d3d12::query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG IDXGIFactoryImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG IDXGIFactoryImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? IDXGIFactoryImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => d3d12::set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? IDXGIFactoryImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => d3d12::set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? IDXGIFactoryImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => d3d12::get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void*? IDXGIFactoryImpl.get_parent(&self, Win32_REFIID riid) @dynamic => d3d12::get_parent_helper(self.raw, self.vtbl.get_parent, riid);

fn IDXGIAdapter? IDXGIFactoryImpl.enum_adapters(&self, Win32_UINT adapterIndex) @dynamic
{
    void* output;
    Win32_HRESULT hr = self.vtbl.enum_adapters(self.raw, adapterIndex, &output);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    assert(output != null, "Failed to get adapter by GPU preference, no supported version found");
    IDXGIAdapterImpl* impl = mem::new(IDXGIAdapterImpl);
    impl.vtbl = *(IDXGIAdapterVtbl**) output;
    impl.raw = (IDXGIAdapterRaw*) output;
    impl.version = d3d12::g_supported_version_tracker.get_dxgi_adapter((IUnknown) impl);
    return impl;
}

fn void? IDXGIFactoryImpl.make_window_association(&self, Win32_HWND hwnd, Dx_DXGI_MWA flags) @dynamic
{
    Win32_HRESULT hr = self.vtbl.make_window_association(self.raw, hwnd, (Win32_UINT) flags);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
}

fn IDXGIAdapter? IDXGIFactoryImpl.enum_adapters1(&self, Win32_UINT adapterIndex) @dynamic
{
    void* output;
    Win32_HRESULT hr = self.vtbl.enum_adapters(self.raw, adapterIndex, &output);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    assert(output != null, "Failed to get adapter by GPU preference, no supported version found");
    IDXGIAdapterImpl* impl = mem::new(IDXGIAdapterImpl);
    impl.vtbl = *(IDXGIAdapterVtbl**) output;
    impl.raw = (IDXGIAdapterRaw*) output;
    impl.version = d3d12::g_supported_version_tracker.get_dxgi_adapter((IUnknown) impl);
    return impl;
}

fn IDXGISwapChain? IDXGIFactoryImpl.create_swap_chain_for_hwnd(&self, d3d12::ID3D12CommandQueue command_queue, Win32_HWND hwnd, Dx_DXGI_SWAP_CHAIN_DESC1* desc, Dx_DXGI_SWAP_CHAIN_FULLSCREEN_DESC* fullscreen_desc, IDXGIOutput restrictToOutput) @dynamic
{
    IDXGISwapChainRaw* swap_chain;
    Win32_HRESULT hr = self.vtbl.create_swap_chain_for_hwnd(self.raw, command_queue.get_com_ptr(), hwnd, desc, fullscreen_desc, restrictToOutput ? restrictToOutput.get_com_ptr() : null, &swap_chain);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    IDXGISwapChainImpl* impl = mem::new(IDXGISwapChainImpl);
    impl.vtbl = *(IDXGISwapChainVtbl**) swap_chain;
    impl.raw = (IDXGISwapChainRaw*) swap_chain;
    impl.version = d3d12::g_supported_version_tracker.get_dxgi_swap_chain((IUnknown) impl);
    return impl;
}

fn IDXGIAdapter? IDXGIFactoryImpl.enum_adapter_by_gpu_preference(&self, Win32_UINT adapterIndex, Dx_DXGI_GPU_PREFERENCE gpuPreference) @dynamic
{
    void* output;
    Win32_HRESULT hr = self.vtbl.enum_adapter_by_gpu_preference(self.raw, adapterIndex, gpuPreference, &d3d12::IID_IDXGIADAPTER4, &output);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    assert(output != null, "Failed to get adapter by GPU preference, no supported version found");
    IDXGIAdapterImpl* impl = mem::new(IDXGIAdapterImpl);
    impl.vtbl = *(IDXGIAdapterVtbl**) output;
    impl.raw = (IDXGIAdapterRaw*) output;
    impl.version = d3d12::g_supported_version_tracker.get_dxgi_adapter((IUnknown) impl);
    return impl;
}

struct IDXGIAdapterVtbl
{
    // IDXGIObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;

    // IDXGIAdapter methods
    EnumOutputs enum_outputs;
    GetAdapterDesc get_desc;
    CheckInterfaceSupport check_interface_support;

    // IDXGIAdapter1 methods
    GetDesc1 get_desc1;

    // IDXGIAdapter2 methods
    GetDesc2 get_desc2;

    // IDXGIAdapter3 methods
    RegisterHardwareContentProtectionTeardownStatusEvent register_hardware_content_protection_teardown_status_event;
    UnregisterHardwareContentProtectionTeardownStatus unregister_hardware_content_protection_teardown_status;
    QueryVideoMemoryInfo query_video_memory_info;
    SetVideoMemoryReservation set_video_memory_reservation;
    RegisterVideoMemoryBudgetChangeNotificationEvent register_video_memory_budget_change_notification_event;
    UnregisterVideoMemoryBudgetChangeNotification unregister_video_memory_budget_change_notification;

    // IDXGIAdapter4 methods
    GetDesc3 get_desc3;
}

interface IDXGIAdapter : IDXGIObject
{
    fn IDXGIOutput? enum_outputs(Win32_UINT outputIndex);
    fn Dx_DXGI_ADAPTER_DESC? get_desc();
    fn void? check_interface_support(Win32_REFIID guid, Win32_UINT64* umd_version);
    
    // IDXGIAdapter1 methods
    fn Dx_DXGI_ADAPTER_DESC1? get_desc1();
}

struct IDXGIAdapterImpl (IDXGIAdapter)
{
    IDXGIAdapterVtbl* vtbl;
    IDXGIAdapterRaw* raw;
    DxgiAdapterVersion version;
}

fn DxgiAdapterVersion IDXGIAdapterImpl.get_version(&self) @dynamic => self.version;

fn void* IDXGIAdapterImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? IDXGIAdapterImpl.query_interface(&self, Win32_REFIID riid) @dynamic => d3d12::query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG IDXGIAdapterImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG IDXGIAdapterImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? IDXGIAdapterImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => d3d12::set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? IDXGIAdapterImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => d3d12::set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? IDXGIAdapterImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => d3d12::get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void*? IDXGIAdapterImpl.get_parent(&self, Win32_REFIID riid) @dynamic => d3d12::get_parent_helper(self.raw, self.vtbl.get_parent, riid);

fn IDXGIOutput? IDXGIAdapterImpl.enum_outputs(&self, Win32_UINT outputIndex) @dynamic
{
    IDXGIOutputRaw* output;
    Win32_HRESULT hr = self.vtbl.enum_outputs(self.raw, outputIndex, &output);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    IDXGIOutputImpl* impl = mem::new(IDXGIOutputImpl);
    impl.vtbl = *(IDXGIOutputVtbl**) output;
    impl.raw = (IDXGIOutputRaw*) output;
    impl.version = d3d12::g_supported_version_tracker.get_dxgi_output((IUnknown) impl);
    return impl;
}

fn Dx_DXGI_ADAPTER_DESC? IDXGIAdapterImpl.get_desc(&self) @dynamic
{
    Dx_DXGI_ADAPTER_DESC desc;
    Win32_HRESULT hr = self.vtbl.get_desc(self.raw, &desc);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    return desc;
}

fn void? IDXGIAdapterImpl.check_interface_support(&self, Win32_REFIID guid, Win32_UINT64* umd_version) @dynamic
{
    Win32_HRESULT hr = self.vtbl.check_interface_support(self.raw, guid, umd_version);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
}

fn Dx_DXGI_ADAPTER_DESC1? IDXGIAdapterImpl.get_desc1(&self) @dynamic
{
    d3d12::validate_version(self.version, DxgiAdapterVersion.ADAPTER1)!;
    Dx_DXGI_ADAPTER_DESC1 desc;
    Win32_HRESULT hr = self.vtbl.get_desc1(self.raw, &desc);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    return desc;
}

struct IDXGIDeviceVtbl @private
{
    // IDXGIObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;

    // IDXGIDevice methods
    GetAdapter get_adapter;
    CreateSurface create_surface;
    QueryResourceResidency query_resource_residency;
    SetGPUThreadPriority set_gpu_thread_priority;
    GetGPUThreadPriority get_gpu_thread_priority;

    // IDXGIDevice1 methods
    SetMaximumFrameLatency set_maximum_frame_latency;
    GetMaximumFrameLatency get_maximum_frame_latency;

    // IDXGIDevice2 methods
    OfferResources offer_resources;
    ReclaimResources reclaim_resources;
    EnqueueSetEvent enqueue_set_event;

    // IDXGIDevice3 methods
    Trim trim;

    // IDXGIDevice4 methods
    OfferResources1 offer_resources1;
    ReclaimResources1 reclaim_resources1;
}

interface IDXGIDevice : IDXGIObject
{
    fn DxgiDeviceVersion get_version();

}

struct IDXGIDeviceImpl (IDXGIDevice)
{
    IDXGIDeviceVtbl* vtbl;
    IDXGIDeviceRaw* raw;
    DxgiDeviceVersion version;
}

fn DxgiDeviceVersion IDXGIDeviceImpl.get_version(&self) @dynamic => self.version;

fn void* IDXGIDeviceImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? IDXGIDeviceImpl.query_interface(&self, Win32_REFIID riid) @dynamic => d3d12::query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG IDXGIDeviceImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG IDXGIDeviceImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? IDXGIDeviceImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => d3d12::set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? IDXGIDeviceImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => d3d12::set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? IDXGIDeviceImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => d3d12::get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void*? IDXGIDeviceImpl.get_parent(&self, Win32_REFIID riid) @dynamic => d3d12::get_parent_helper(self.raw, self.vtbl.get_parent, riid);

struct IDXGIDeviceSubObjectVtbl @private
{
    // IDXGIObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;

    // IDXGIDeviceSubObject methods
    GetDevice get_device;
}

interface IDXGIDeviceSubObject : IDXGIObject
{
    fn IDXGIDevice? get_device();
}

fn IDXGIDevice? get_device_helper(void* raw, GetDevice func)
{
    void* device;
    DxgiDeviceVersion version = d3d12::g_supported_version_tracker.dxgi_device_version;
    if (version == NOT_SUPPORTED)
    {
        return d3d12::NOINTERFACE?;
    }
    else if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) DxgiDeviceVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = DxgiDeviceVersion.from_ordinal(i).riid;
            hr = func(raw, riid, &device);
            if (hr == d3d12::S_OK)
            {
                version = DxgiDeviceVersion.from_ordinal(i);
                d3d12::g_supported_version_tracker.dxgi_device_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            d3d12::g_supported_version_tracker.dxgi_device_version = NOT_SUPPORTED;
            return d3d12::NOINTERFACE?;
        }
    }
    else
    {
        Win32_REFIID riid = version.riid;
        Win32_HRESULT hr = func(raw, riid, &device);
        if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    }
    IDXGIDeviceImpl* impl = mem::new(IDXGIDeviceImpl);
    impl.vtbl = *(IDXGIDeviceVtbl**) device;
    impl.raw = (IDXGIDeviceRaw*) device;
    impl.version = version;
    return impl;
}

struct IDXGIResourceVtbl @private
{
    // IDXGIDeviceSubObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;
    GetDevice get_device;

    // IDXGIResource methods
    GetSharedHandle get_shared_handle;
    GetUsage get_usage;
    SetEvictionPriority set_eviction_priority;
    GetEvictionPriority get_eviction_priority;

    // IDXGIResource1 methods
    CreateSubresourceSurface create_subresource_surface;
    CreateSharedHandle create_shared_handle;
}

interface IDXGIResource : IDXGIDeviceSubObject
{
    fn Win32_HANDLE? get_shared_handle();
    fn Dx_DXGI_USAGE? get_usage();
    fn void? set_eviction_priority(Win32_UINT evictionPriority);
    fn Win32_UINT? get_eviction_priority();
}

struct IDXGIKeyedMutexVtbl @private
{
    // IDXGIDeviceSubObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;
    GetDevice get_device;

    // IDXGIKeyedMutex methods
    AcquireSync acquire_sync;
    ReleaseSync release_sync;
}

interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
    fn void? acquire_sync(Win32_UINT64 key, Win32_DWORD timeout);
    fn void? release_sync(Win32_UINT64 key);
}

struct IDXGISurfaceVtbl @private
{
    // IDXGIDeviceSubObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;
    GetDevice get_device;

    // IDXGISurface methods
    GetSurfaceDesc get_desc;
    MapSurface map;
    UnmapSurface unmap;

    // IDXGISurface1 methods
    GetSurfaceDC get_dc;
    ReleaseDC release_dc;

    // IDXGISurface2 methods
    GetResource get_resource;
}

interface IDXGISurface : IDXGIDeviceSubObject
{
    fn Dx_DXGI_SURFACE_DESC? get_desc();
    fn Dx_DXGI_MAPPED_RECT? map(Win32_UINT mapFlags);
    fn void? unmap();

    // IDXGISurface1 methods
    fn Win32_HDC? get_dc(Win32_BOOL discard);
    fn void? release_dc(Win32_RECT* dirtyRect);
}

struct IDXGIOutputVtbl @private
{
    // IDXGIObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;

    // IDXGIOutput methods
    GetOutputDesc get_desc;
    GetDisplayModeList get_display_mode_list;
    FindClosestMatchingMode find_closest_matching_mode;
    WaitForVBlank wait_for_vblank;
    TakeOwnership take_ownership;
    ReleaseOwnership release_ownership;
    GetGammaControlCapabilities get_gamma_control_capabilities;
    SetGammaControl set_gamma_control;
    GetGammaControl get_gamma_control;
    SetDisplaySurface set_display_surface;
    GetDisplaySurfaceData get_display_surface_data;
    GetFrameStatistics get_frame_statistics;

    // IDXGIOutput1 methods
    GetDisplayModeList1 get_display_mode_list1;
    FindClosestMatchingMode1 find_closest_matching_mode1;
    GetDisplaySurfaceData1 get_display_surface_data1;
    DuplicateOutput duplicate_output;

    // IDXGIOutput2 methods
    SupportsOverlays supports_overlays;

    // IDXGIOutput3 methods
    CheckOverlaySupport check_overlay_support;

    // IDXGIOutput4 methods
    CheckOverlayColorSpaceSupport check_overlay_color_space_support;

    // IDXGIOutput5 methods
    DuplicateOutput1 duplicate_output1;

    // IDXGIOutput6 methods
    GetOutputDesc1 get_desc1;
    CheckHardwareCompositionSupport check_hardware_composition_support;
}

interface IDXGIOutput : IDXGIObject
{
}

struct IDXGIOutputImpl (IDXGIOutput)
{
    IDXGIOutputVtbl* vtbl;
    IDXGIOutputRaw* raw;
    DxgiOutputVersion version;
}

fn DxgiOutputVersion IDXGIOutputImpl.get_version(&self) @dynamic => self.version;

fn void* IDXGIOutputImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? IDXGIOutputImpl.query_interface(&self, Win32_REFIID riid) @dynamic => d3d12::query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG IDXGIOutputImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG IDXGIOutputImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? IDXGIOutputImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => d3d12::set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? IDXGIOutputImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => d3d12::set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? IDXGIOutputImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => d3d12::get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void*? IDXGIOutputImpl.get_parent(&self, Win32_REFIID riid) @dynamic => d3d12::get_parent_helper(self.raw, self.vtbl.get_parent, riid);

struct IDXGISwapChainVtbl @private
{
    // IDXGIDeviceSubObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;
    GetDevice get_device;

    // IDXGISwapChain methods
    Present present;
    GetBuffer get_buffer;
    SetFullscreenState set_fullscreen_state;
    GetFullscreenState get_fullscreen_state;
    GetSwapChainDesc get_desc;
    ResizeBuffers resize_buffers;
    ResizeTarget resize_target;
    GetContainingOutput get_containing_output;
    GetFrameStatistics get_frame_statistics;
    GetLastPresentCount get_last_present_count;

    // IDXGISwapChain1 methods
    GetSwapChainDesc1 get_desc1;
    GetFullscreenDesc get_fullscreen_desc;
    GetHwnd get_hwnd;
    GetCoreWindow get_core_window;
    Present1 present1;
    IsTemporaryMonoSupported is_temporary_mono_supported;
    GetRestrictToOutput get_restrict_to_output;
    SetBackgroundColor set_background_color;
    GetBackgroundColor get_background_color;
    SetRotation set_rotation;
    GetRotation get_rotation;

    // IDXGISwapChain2 methods
    SetSourceSize set_source_size;
    GetSourceSize get_source_size;
    SetMaximumFrameLatency set_maximum_frame_latency;
    GetMaximumFrameLatency get_maximum_frame_latency;
    GetFrameLatencyWaitableObject get_frame_latency_waitable_object;
    SetMatrixTransform set_matrix_transform;
    GetMatrixTransform get_matrix_transform;

    // IDXGISwapChain3 methods
    GetCurrentBackBufferIndex get_current_back_buffer_index;
    CheckColorSpaceSupport check_color_space_support;
    SetColorSpace set_color_space1;
    ResizeBuffers1 resize_buffers1;

    // IDXGISwapChain4 methods
    SetHDRMetaData set_hdr_meta_data;
}

interface IDXGISwapChain : IDXGIDeviceSubObject
{
    fn void? present(Win32_UINT syncInterval, Dx_DXGI_PRESENT flags);

    fn ID3D12Resource? get_buffer(Win32_UINT n);

    fn Win32_UINT? get_current_back_buffer_index();
}

struct IDXGISwapChainImpl (IDXGISwapChain)
{
    IDXGISwapChainVtbl* vtbl;
    IDXGISwapChainRaw* raw;
    DxgiSwapChainVersion version;
}

fn DxgiSwapChainVersion IDXGISwapChainImpl.get_version(&self) @dynamic => self.version;

fn void* IDXGISwapChainImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? IDXGISwapChainImpl.query_interface(&self, Win32_REFIID riid) @dynamic => d3d12::query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG IDXGISwapChainImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG IDXGISwapChainImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? IDXGISwapChainImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => d3d12::set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? IDXGISwapChainImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => d3d12::set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? IDXGISwapChainImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => d3d12::get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void*? IDXGISwapChainImpl.get_parent(&self, Win32_REFIID riid) @dynamic => d3d12::get_parent_helper(self.raw, self.vtbl.get_parent, riid);
fn IDXGIDevice? IDXGISwapChainImpl.get_device(&self) @dynamic
{
    return get_device_helper(self.raw, self.vtbl.get_device)!;
}

fn void? IDXGISwapChainImpl.present(&self, Win32_UINT syncInterval, Dx_DXGI_PRESENT flags) @dynamic
{
    Win32_HRESULT hr = self.vtbl.present(self.raw, syncInterval, (Win32_UINT) flags);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
}

fn ID3D12Resource? IDXGISwapChainImpl.get_buffer(&self, Win32_UINT n) @dynamic
{
    void* resource;
    Win32_HRESULT hr = self.vtbl.get_buffer(self.raw, n, &d3d12::IID_ID3D12RESOURCE, &resource);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    assert(resource != null, "Failed to get buffer, no supported version found");
    ID3D12ResourceImpl* impl = mem::new(ID3D12ResourceImpl);
    impl.vtbl = *(ID3D12ResourceVtbl**) resource;
    impl.raw = (ID3D12ResourceRaw*) resource;
    impl.version = d3d12::g_supported_version_tracker.get_resource((IUnknown) impl);
    d3d12::log_trace("Created ID3D12ResourceImpl for IDXGISwapChain buffer %d", n);
    return impl;
}

fn Win32_UINT? IDXGISwapChainImpl.get_current_back_buffer_index(&self) @dynamic
{
    d3d12::validate_version(self.version, DxgiSwapChainVersion.SWAP_CHAIN3)!;
    return self.vtbl.get_current_back_buffer_index(self.raw);
}

struct IDXGIDisplayControlVtbl @private
{
    // IUnknown methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // IDXGIDisplayControl methods
    IsStereoEnabled is_stereo_enabled;
    SetStereoEnabled set_stereo_enabled;
}

struct IDXGIOutputDuplicationVtbl @private
{
    // IDXGIObject methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    GetParent get_parent;

    // IDXGIOutputDuplication methods
    GetOutputDuplicationDesc get_desc;
    AcquireNextFrame acquire_next_frame;
    GetFrameDirtyRects get_frame_dirty_rects;
    GetFramePointerShape get_frame_pointer_shape;
    MapDesktopSurface map_desktop_surface;
    UnMapDesktopSurface unmap_desktop_surface;
    ReleaseFrame release_frame;
}

struct IDXGIDecodeSwapChainVtbl @private
{
    // IUnknown methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // IDXGIDecodeSwapChain methods
    PresentBuffer present_buffer;
    SetSourceRect set_source_rect;
    SetTargetRect set_target_rect;
    SetDestSize set_dest_size;
    GetSourceRect get_source_rect;
    GetTargetRect get_target_rect;
    GetDestSize get_dest_size;
    SetColorSpace set_color_space;
}

interface IDXGIDecodeSwapChain : IUnknown
{

}

struct IDXGISwapChainMediaVtbl @private
{
    // IUnknown methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // IDXGISwapChainMedia methods
    GetFrameStatisticsMedia get_frame_statistics_media;
    SetPresentDuration set_present_duration;
    CheckPresentDurationSupport check_present_duration_support;
}

const Win32_GUID DXGI_DEBUG_ALL = { 0xe48ae283, 0xda80, 0x490b, {0x87, 0xe6, 0x43, 0xe9, 0xa9, 0xcf, 0xda, 0x8} };
const Win32_GUID DXGI_DEBUG_DX = { 0x35cdd7fc, 0x13b2, 0x421d, {0xa5, 0xd7, 0x7e, 0x44, 0x51, 0x28, 0x7d, 0x64} };
const Win32_GUID DXGI_DEBUG_DXGI = { 0x25cddaa4, 0xb1c6, 0x47e1, {0xac, 0x3e, 0x98, 0x87, 0x5b, 0x5a, 0x2e, 0x2a} };

interface IDXGISwapChainMedia : IUnknown
{

}

struct IDXGIDebugVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    ReportLiveObjects report_live_objects;
}

interface IDXGIDebug : IUnknown
{
    fn void? report_live_objects(Win32_GUID riid, Dx_DXGI_DEBUG_RLO_FLAGS rlo);
}

struct IDXGIDebugImpl (IDXGIDebug)
{
    IDXGIDebugVtbl* vtbl;
    IDXGIDebugRaw* raw;
}

fn void* IDXGIDebugImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? IDXGIDebugImpl.query_interface(&self, Win32_REFIID riid) @dynamic => d3d12::query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG IDXGIDebugImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG IDXGIDebugImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

fn void? IDXGIDebugImpl.report_live_objects(&self, Win32_GUID riid, Dx_DXGI_DEBUG_RLO_FLAGS rlo) @dynamic
{
    Win32_HRESULT hr = self.vtbl.report_live_objects(self.raw, riid, rlo);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
}

////////////////////////////////////////////////////////////////////////////////
// Loose Functions
////////////////////////////////////////////////////////////////////////////////

extern fn Win32_HRESULT createDXGIFactory(Win32_REFIID riid, void **ppFactory) @extern("CreateDXGIFactory");
extern fn Win32_HRESULT createDXGIFactory1(Win32_REFIID riid, void **ppFactory) @extern("CreateDXGIFactory1");
extern fn Win32_HRESULT createDXGIFactory2(Win32_UINT flags, Win32_REFIID riid, void **ppFactory) @extern("CreateDXGIFactory2");

fn IDXGIFactory? create_dxgi_factory(Win32_UINT flags=0)
{
    // @Todo: Warn if flags set and not supported by highest factory version
    void* factory;
    DxgiFactoryVersion version = d3d12::g_supported_version_tracker.dxgi_factory_version;
    if (version == NOT_SUPPORTED)
    {
        d3d12::log_error("[D3D12] IDXGIFactory is not supported on this system?!");
        return d3d12::NOINTERFACE?;
    }
    else if (version == NOT_CHECKED_YET)
    {
        Win32_HRESULT hr;
        for (int i = (int) DxgiFactoryVersion.values.len - 1; i > 1; i--)
        {
            DxgiFactoryVersion v = DxgiFactoryVersion.from_ordinal(i);
            Win32_REFIID riid = v.riid;
            switch (v)
            {
            case FACTORY: hr = createDXGIFactory(&d3d12::IID_IDXGIFACTORY, &factory);
            case FACTORY1: hr = createDXGIFactory1(&d3d12::IID_IDXGIFACTORY1, &factory);
            default: hr = createDXGIFactory2(flags, riid, &factory);
            }
            if (hr == d3d12::S_OK)
            {
                d3d12::log_trace("DXGI Factory %s is the highest supported version.", v);
                version = v;
                d3d12::g_supported_version_tracker.dxgi_factory_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            d3d12::log_warn("[D3D12] No supported DXGI Factory version found.");
            d3d12::g_supported_version_tracker.dxgi_factory_version = NOT_SUPPORTED;
            d3d12::check_hresult(hr)!; // try to return an hr specific error
            return d3d12::NOINTERFACE?; // otherwise just fail
        }
    }
    else
    {
        Win32_HRESULT hr;
        switch (version)
        {
        case FACTORY:
            hr = createDXGIFactory(&d3d12::IID_IDXGIFACTORY, &factory);
        case FACTORY1:
            hr = createDXGIFactory1(&d3d12::IID_IDXGIFACTORY1, &factory);
        default:
            hr = createDXGIFactory2(flags, version.riid, &factory);
        }
        if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    }
    assert(factory != null, "Failed to create dxgi factory, no supported version found");
    IDXGIFactoryImpl* impl = mem::new(IDXGIFactoryImpl);
    impl.vtbl = *(IDXGIFactoryVtbl**) factory;
    impl.raw = (IDXGIFactoryRaw*) factory;
    impl.version = d3d12::g_supported_version_tracker.get_dxgi_factory((IUnknown) impl);
    d3d12::log_trace("Created IDXGIFactory with version %s", impl.version);
    return impl;
}

extern fn Win32_HRESULT dxgiGetDebugInterface1(Win32_UINT flags, Win32_REFIID riid, void **pDebug) @extern("DXGIGetDebugInterface1");

fn IDXGIDebug? get_debug_interface()
{
    void* out;
    Win32_HRESULT hr = dxgiGetDebugInterface1(0, &d3d12::IID_IDXGIDEBUG, &out);
    if (hr != d3d12::S_OK) d3d12::check_hresult(hr)!;
    IDXGIDebugImpl* impl = mem::new(IDXGIDebugImpl);
    impl.vtbl = *(IDXGIDebugVtbl**) out;
    impl.raw = (IDXGIDebugRaw*) out;
    return impl;
}

fn IDXGIAdapter? get_hardware_adapter(IDXGIFactory factory, bool request_high_performance_adapter)
{
    IDXGIAdapter adapter;
    Win32_UINT adapterIndex = 0;
    while (try result = factory.enum_adapter_by_gpu_preference(adapterIndex++, request_high_performance_adapter ? HIGH_PERFORMANCE : UNSPECIFIED))
    {
        adapter = result;
        Dx_DXGI_ADAPTER_DESC1? desc = adapter.get_desc1();
        if (try desc && (desc.flags & Dx_DXGI_ADAPTER_FLAG.SOFTWARE) == 0)
        {
            if (d3d12::d3d12CreateDevice(adapter.get_com_ptr(), D3D_FEATURE_LEVEL_12_1, &d3d12::IID_ID3D12DEVICE, null) >= 0)
            {
                break;
            }
        }
        d3d12::@safe_release(adapter);
    }

    if (adapter == null)
    {
        adapterIndex = 0;
        while (try result = factory.enum_adapters1(adapterIndex++))
        {
            adapter = result;
            Dx_DXGI_ADAPTER_DESC1? desc = adapter.get_desc1();
            if (try desc && (desc.flags & Dx_DXGI_ADAPTER_FLAG.SOFTWARE) == 0)
            {
                if (d3d12::d3d12CreateDevice(adapter.get_com_ptr(), D3D_FEATURE_LEVEL_12_1, &d3d12::IID_ID3D12DEVICE, null) >= 0)
                {
                    break;
                }
            }
            d3d12::@safe_release(adapter);
        }
    }
    if (adapter == null)
    {
        return d3d12::NOINTERFACE?;
    }
    d3d12::log_trace("Found hardware adapter: %s", string::tfrom_wstring((WString)adapter.get_desc1().description[..]) ?? "Invalid description");
    return adapter;
}
