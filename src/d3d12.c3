module d3d12;

import std::os::win32;
import dxgi;

alias Dx_D3D12_GPU_VIRTUAL_ADDRESS = Win32_UINT64;
alias Dx_D3D12_PRIMITIVE_TOPOLOGY = Dx_D3D_PRIMITIVE_TOPOLOGY;
alias Dx_D3D12_PRIMITIVE = Dx_D3D_PRIMITIVE;
alias Dx_D3D12_RECT = Win32_RECT;

alias ID3D12CommandAllocatorRaw = void;
alias ID3D12CommandListRaw = void;
alias ID3D12CommandSignatureRaw = void;
alias ID3D12CommandQueueRaw = void;
alias ID3D12DebugRaw = void;
alias ID3D12DebugDeviceRaw = void;
alias ID3D12DescriptorHeapRaw = void;
alias ID3D12DeviceRaw = void;
alias ID3D12DeviceChildRaw = void;
alias ID3D12DeviceFactoryRaw = void;
alias ID3D12DeviceRemovedExtendedDataSettingsRaw = void;
alias ID3D12DSRDeviceFactoryRaw = void;
alias ID3D12FenceRaw = void;
alias ID3D12GBVDiagnosticsRaw = void;
alias ID3D12GraphicsCommandListRaw = void;
alias ID3D12HeapRaw = void;
alias ID3D12InfoQueueRaw = void;
alias ID3D12LifetimeOwnerRaw = void;
alias ID3D12LifetimeTrackerRaw = void;
alias ID3D12MetaCommandRaw = void;
alias ID3D12PageableRaw = void;
alias ID3D12PipelineLibraryRaw = void;
alias ID3D12PipelineStateRaw = void;
alias ID3D12ProtectedResourceSessionRaw = void;
alias ID3D12ProtectedSessionRaw = void;
alias ID3D12ResourceRaw = void;
alias ID3D12RootSignatureDeserializerRaw = void;
alias ID3D12RootSignatureRaw = void;
alias ID3D12ShaderCacheSessionRaw = void;
alias ID3D12StateObjectPropertiesRaw = void;
alias ID3D12StateObjectRaw = void;
alias ID3D12SwapChainAssistantRaw = void;
alias ID3D12QueryHeapRaw = void;
alias ID3D12VersionedRootSignatureDeserializerRaw = void;

////////////////////////////////////////////////////////////////////////////////
// Vtbl function interfaces
////////////////////////////////////////////////////////////////////////////////

module d3d12 @private;

import std::os::win32;
import dxgi;

alias AddToStateObject = fn Win32_HRESULT(void*, Dx_D3D12_STATE_OBJECT_DESC*, ID3D12StateObjectRaw*, Win32_REFIID, void**);
alias ApplyToGlobalState = fn Win32_HRESULT(void*);
alias AtomicCopyBufferUINT = fn void(void*, ID3D12ResourceRaw*, Win32_UINT64, ID3D12ResourceRaw*, Win32_UINT64, Win32_UINT, ID3D12ResourceRaw**, Dx_D3D12_SUBRESOURCE_RANGE_UINT64*);
alias AtomicCopyBufferUINT64 = fn void(void*, ID3D12ResourceRaw*, Win32_UINT64, ID3D12ResourceRaw*, Win32_UINT64, Win32_UINT64, ID3D12ResourceRaw**, Dx_D3D12_SUBRESOURCE_RANGE_UINT64*);
alias Barrier = fn void(void*, Win32_UINT, Dx_D3D12_BARRIER_GROUP*);
alias BeginEvent = fn void(void*, Win32_UINT, void*, Win32_UINT);
alias BeginQuery = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_QUERY_TYPE, Win32_UINT);
alias BeginRenderPass = fn void(void*, Win32_UINT, Dx_D3D12_RENDER_PASS_RENDER_TARGET_DESC*, Dx_D3D12_RENDER_PASS_DEPTH_STENCIL_DESC*, Dx_D3D12_RENDER_PASS_FLAGS);
alias BuildRaytracingAccelerationStructure = fn void(void*, Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC*, Win32_UINT, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC*);
alias CheckDriverMatchingIdentifier = fn Dx_D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS(void*, Dx_D3D12_SERIALIZED_DATA_TYPE, Dx_D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER*);
alias CheckFeatureSupport = fn Win32_HRESULT(void*, Dx_D3D12_FEATURE, void*, Win32_UINT);
alias ClearDepthStencilView = fn void(void*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE, Dx_D3D12_CLEAR_FLAGS, float, Win32_UINT8, Win32_UINT, Dx_D3D12_RECT*);
alias ClearRenderTargetView = fn void(void*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE, float[4], Win32_UINT, Dx_D3D12_RECT*);
alias ClearReservedGPUVARangesList = fn void(void*);
alias ClearState = fn void(void*, ID3D12PipelineStateRaw*);
alias ClearStoredMessages = fn void(void*);
alias ClearUnorderedAccessViewFloat = fn void(void*, Dx_D3D12_GPU_DESCRIPTOR_HANDLE, Dx_D3D12_CPU_DESCRIPTOR_HANDLE, ID3D12ResourceRaw*, float[4], Win32_UINT, Dx_D3D12_RECT*);
alias ClearUnorderedAccessViewUint = fn void(void*, Dx_D3D12_GPU_DESCRIPTOR_HANDLE, Dx_D3D12_CPU_DESCRIPTOR_HANDLE, ID3D12ResourceRaw*, Win32_UINT[4], Win32_UINT, Dx_D3D12_RECT*);
alias Close = fn Win32_HRESULT(void*);
alias CopyBufferRegion = fn void(void*, ID3D12ResourceRaw*, Win32_UINT64, ID3D12ResourceRaw*, Win32_UINT64, Win32_UINT64);
alias CopyDescriptors = fn void(void*, Win32_UINT, Dx_D3D12_CPU_DESCRIPTOR_HANDLE*, Win32_UINT*, Win32_UINT, Dx_D3D12_CPU_DESCRIPTOR_HANDLE*, Win32_UINT*, Dx_D3D12_DESCRIPTOR_HEAP_TYPE);
alias CopyDescriptorsSimple = fn void(void*, Win32_UINT, Dx_D3D12_CPU_DESCRIPTOR_HANDLE, Dx_D3D12_CPU_DESCRIPTOR_HANDLE, Dx_D3D12_DESCRIPTOR_HEAP_TYPE);
alias CopyRaytracingAccelerationStructure = fn void(void*, Dx_D3D12_GPU_VIRTUAL_ADDRESS, Dx_D3D12_GPU_VIRTUAL_ADDRESS, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE);
alias CopyResource = fn void(void*, ID3D12ResourceRaw*, ID3D12ResourceRaw*);
alias CopyTextureRegion = fn void(void*, Dx_D3D12_TEXTURE_COPY_LOCATION*, Win32_UINT, Win32_UINT, Win32_UINT, Dx_D3D12_TEXTURE_COPY_LOCATION*, Dx_D3D12_BOX*);
alias CopyTiles = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_TILED_RESOURCE_COORDINATE*, Dx_D3D12_TILE_REGION_SIZE*, ID3D12ResourceRaw*, Win32_UINT64, Dx_D3D12_TILE_COPY_FLAGS);
alias CopyTileMappings = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_TILED_RESOURCE_COORDINATE*, ID3D12ResourceRaw*, Dx_D3D12_TILED_RESOURCE_COORDINATE*, Dx_D3D12_TILE_REGION_SIZE*, Dx_D3D12_TILE_MAPPING_FLAGS);
alias CreateCommandAllocator = fn Win32_HRESULT(void*, Dx_D3D12_COMMAND_LIST_TYPE, Win32_REFIID, void**);
alias CreateCommandList = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_COMMAND_LIST_TYPE, ID3D12CommandAllocatorRaw*, ID3D12PipelineStateRaw*, Win32_REFIID, void**);
alias CreateCommandList1 = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_COMMAND_LIST_TYPE, Dx_D3D12_COMMAND_LIST_FLAGS, Win32_REFIID, void**);
alias CreateCommandQueue = fn Win32_HRESULT(void*, Dx_D3D12_COMMAND_QUEUE_DESC*, Win32_REFIID, void**);
alias CreateCommandQueue1 = fn Win32_HRESULT(void*, Dx_D3D12_COMMAND_QUEUE_DESC*, Win32_REFIID, Win32_REFIID, void**);
alias CreateCommandSignature = fn Win32_HRESULT(void*, Dx_D3D12_COMMAND_SIGNATURE_DESC*, ID3D12RootSignatureRaw*, Win32_REFIID, void**);
alias CreateCommittedResource = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_PROPERTIES*, Dx_D3D12_HEAP_FLAGS, Dx_D3D12_RESOURCE_DESC*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, Win32_REFIID, void**);
alias CreateCommittedResource1 = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_PROPERTIES*, Dx_D3D12_HEAP_FLAGS, Dx_D3D12_RESOURCE_DESC*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, ID3D12ProtectedResourceSessionRaw*, Win32_REFIID, void**);
alias CreateCommittedResource2 = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_PROPERTIES*, Dx_D3D12_HEAP_FLAGS, Dx_D3D12_RESOURCE_DESC1*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, ID3D12ProtectedResourceSessionRaw*, Win32_REFIID, void**);
alias CreateCommittedResource3 = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_PROPERTIES*, Dx_D3D12_HEAP_FLAGS, Dx_D3D12_RESOURCE_DESC1*, Dx_D3D12_BARRIER_LAYOUT, Dx_D3D12_CLEAR_VALUE*, ID3D12ProtectedResourceSessionRaw*, Win32_UINT, Dx_DXGI_FORMAT*, Win32_REFIID, void**);
alias CreateComputePipelineState = fn Win32_HRESULT(void*, Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC*, Win32_REFIID, void**);
alias CreateConstantBufferView = fn void(void*, Dx_D3D12_CONSTANT_BUFFER_VIEW_DESC*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateDepthStencilView = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_DEPTH_STENCIL_VIEW_DESC*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateDescriptorHeap = fn Win32_HRESULT(void*, Dx_D3D12_DESCRIPTOR_HEAP_DESC*, Win32_REFIID, void**);
alias CreateDevice = fn Win32_HRESULT(void*, IUnknownRaw*, Dx_D3D_FEATURE_LEVEL, Win32_REFIID, void**);
alias CreateDeviceFactory = fn Win32_HRESULT(void*, Win32_UINT, Win32_LPCSTR, Win32_REFIID, void**);
alias CreateDSRDevice = fn Win32_HRESULT(void*, ID3D12DeviceRaw*, Win32_UINT, Win32_REFIID, void**);
alias CreateFence = fn Win32_HRESULT(void*, Win32_UINT64, Dx_D3D12_FENCE_FLAGS, Win32_REFIID, void**);
alias CreateFenceFd = fn Win32_HRESULT(void*, ID3D12FenceRaw*, Win32_UINT64, int*);
alias CreateGraphicsPipelineState = fn Win32_HRESULT(void*, Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC*, Win32_REFIID, void**);
alias CreateHeap = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_DESC*, Win32_REFIID, void**);
alias CreateHeap1 = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_DESC*, ID3D12ProtectedResourceSessionRaw*, Win32_REFIID, void**);
alias CreateLifetimeTracker = fn Win32_HRESULT(void*, ID3D12LifetimeOwnerRaw*, Win32_REFIID, void**);
alias CreateMetaCommand = fn Win32_HRESULT(void*, Win32_REFGUID, Win32_UINT, void*, Win32_SIZE_T, Win32_REFIID, void**);
alias CreatePipelineLibrary = fn Win32_HRESULT(void*, void*, Win32_SIZE_T, Win32_REFIID, void**);
alias CreatePipelineState = fn Win32_HRESULT(void*, Dx_D3D12_PIPELINE_STATE_STREAM_DESC*, Win32_REFIID, void**);
alias CreatePlacedResource = fn Win32_HRESULT(void*, ID3D12HeapRaw*, Win32_UINT64, Dx_D3D12_RESOURCE_DESC*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, Win32_REFIID, void**);
alias CreatePlacedResource1 = fn Win32_HRESULT(void*, ID3D12HeapRaw*, Win32_UINT64, Dx_D3D12_RESOURCE_DESC1*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, Win32_REFIID, void**);
alias CreatePlacedResource2 = fn Win32_HRESULT(void*, ID3D12HeapRaw*, Win32_UINT64, Dx_D3D12_RESOURCE_DESC1*, Dx_D3D12_BARRIER_LAYOUT, Dx_D3D12_CLEAR_VALUE*, Win32_UINT, Dx_DXGI_FORMAT*, Win32_REFIID, void**);
alias CreateProtectedResourceSession = fn Win32_HRESULT(void*, Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC*, Win32_REFIID, void**);
alias CreateProtectedResourceSession1 = fn Win32_HRESULT(void*, Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1*, Win32_REFIID, void**);
alias CreateQueryHeap = fn Win32_HRESULT(void*, Dx_D3D12_QUERY_HEAP_DESC*, Win32_REFIID, void**);
alias CreateRenderTargetView = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_RENDER_TARGET_VIEW_DESC*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateReservedResource = fn Win32_HRESULT(void*, Dx_D3D12_RESOURCE_DESC*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, Win32_REFIID, void**);
alias CreateReservedResource1 = fn Win32_HRESULT(void*, Dx_D3D12_RESOURCE_DESC*, Dx_D3D12_RESOURCE_STATES, Dx_D3D12_CLEAR_VALUE*, ID3D12ProtectedResourceSessionRaw*, Win32_REFIID, void**);
alias CreateReservedResource2 = fn Win32_HRESULT(void*, Dx_D3D12_RESOURCE_DESC1*, Dx_D3D12_BARRIER_LAYOUT, Dx_D3D12_CLEAR_VALUE*, ID3D12ProtectedResourceSessionRaw*, Win32_UINT, Dx_DXGI_FORMAT*, Win32_REFIID, void**);
alias CreateRootSignature = fn Win32_HRESULT(void*, Win32_UINT, void*, Win32_SIZE_T, Win32_REFIID, void**);
alias CreateSampler = fn void(void*, Dx_D3D12_SAMPLER_DESC*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateSampler2 = fn void(void*, Dx_D3D12_SAMPLER_DESC2*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateSamplerFeedbackUnorderedAccessView = fn void(void*, ID3D12ResourceRaw*, ID3D12ResourceRaw*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateShaderCacheSession = fn Win32_HRESULT(void*, Dx_D3D12_SHADER_CACHE_SESSION_DESC*, Win32_REFIID, void**);
alias CreateShaderResourceView = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_SHADER_RESOURCE_VIEW_DESC*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateSharedHandle = fn Win32_HRESULT(void*, ID3D12DeviceChild*, Win32_SECURITY_ATTRIBUTES*, Win32_DWORD, Win32_LPCWSTR, Win32_HANDLE*);
alias CreateStateObject = fn Win32_HRESULT(void*, Dx_D3D12_STATE_OBJECT_DESC*, Win32_REFIID, void**);
alias CreateUnorderedAccessView = fn void(void*, ID3D12ResourceRaw*, ID3D12ResourceRaw*, Dx_D3D12_UNORDERED_ACCESS_VIEW_DESC*, Dx_D3D12_CPU_DESCRIPTOR_HANDLE);
alias CreateVersionedRootSignatureDeserializer = fn Win32_HRESULT(void*, void*, Win32_SIZE_T, Win32_REFIID, void**);
alias CreateVersionedRootSignatureDeserializerFromSubobjectInLibrary = fn Win32_HRESULT(void*, void*, Win32_SIZE_T, Win32_LPCWSTR, Win32_REFIID, void**);
alias D3D12MessageFunc = fn void(Dx_D3D12_MESSAGE_CATEGORY, Dx_D3D12_MESSAGE_SEVERITY, Dx_D3D12_MESSAGE_ID, Win32_LPCSTR, void*);
alias DestroyOwnedObject = fn Win32_HRESULT(void*, ID3D12DeviceChildRaw*);
alias DisableDebugLayer = fn void(void*);
alias DiscardResource = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_DISCARD_REGION*);
alias Dispatch = fn void(void*, Win32_UINT, Win32_UINT, Win32_UINT);
alias DispatchGraph = fn void(void*, Dx_D3D12_DISPATCH_GRAPH_DESC*);
alias DispatchMesh = fn void(void*, Win32_UINT, Win32_UINT, Win32_UINT);
alias DispatchRays = fn void(void*, Dx_D3D12_DISPATCH_RAYS_DESC*);
alias DrawIndexedInstanced = fn void(void*, Win32_UINT, Win32_UINT, Win32_UINT, Win32_INT, Win32_UINT);
alias DrawInstanced = fn void(void*, Win32_UINT, Win32_UINT, Win32_UINT, Win32_UINT);
alias EmitRaytracingAccelerationStructurePostbuildInfo = fn void(void*, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS*);
alias EnableDebugLayer = fn void(void*);
alias EnableExperimentalFeatures = fn Win32_HRESULT(void*, Win32_UINT, Win32_IID*, void*, Win32_UINT*);
alias EnableShaderInstrumentation = fn void(void*, Win32_BOOL);
alias EndEvent = fn void(void*);
alias EndQuery = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_QUERY_TYPE, Win32_UINT);
alias EndRenderPass = fn void(void*);
alias EnumerateMetaCommands = fn Win32_HRESULT(void*, Win32_UINT*, Dx_D3D12_META_COMMAND_DESC*);
alias EnumerateMetaCommandParameters = fn Win32_HRESULT(void*, Win32_REFGUID, Dx_D3D12_META_COMMAND_PARAMETER_STAGE, Win32_UINT*, Win32_UINT*, Dx_D3D12_META_COMMAND_PARAMETER_DESC*);
alias EnqueueMakeResident = fn Win32_HRESULT(void*, Dx_D3D12_RESIDENCY_FLAGS, Win32_UINT, ID3D12PageableRaw**, ID3D12FenceRaw*, Win32_UINT64);
alias Evict = fn Win32_HRESULT(void*, Win32_UINT, ID3D12PageableRaw**);
alias ExecuteBundle = fn void(void*, ID3D12GraphicsCommandListRaw*);
alias ExecuteCommandLists = fn void(void*, Win32_UINT, ID3D12CommandListRaw**);
alias ExecuteIndirect = fn void(void*, ID3D12CommandSignatureRaw*, Win32_UINT, ID3D12ResourceRaw*, Win32_UINT64, ID3D12ResourceRaw*, Win32_UINT64);
alias ExecuteMetaCommand = fn void(void*, ID3D12MetaCommandRaw*, void*, Win32_SIZE_T);
alias FindValue = fn Win32_HRESULT(void*, void*, Win32_UINT, void*, Win32_UINT*);
alias FreeUnusedSDKs = fn void(void*);
alias GBVReserved0 = fn void(void*);
alias GBVReserved1 = fn void(void*);
alias GetAdapterLuid = fn Win32_LUID*(void*,Win32_LUID*);
alias GetAllocation = fn Win32_HRESULT(void*, Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE*);
alias GetApplicationSpecificDriverState = fn Win32_HRESULT(void*, ID3DBlob**);
alias GetApplicationSpecificDriverBlobStatus = fn Dx_D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_STATUS(void*);
alias GetAutoBreadcrumbsOutput = fn Win32_HRESULT(void*, Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT*);
alias GetAutoBreadcrumbsOutput1 = fn Win32_HRESULT(void*, Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1*);
alias GetCachedBlob = fn Win32_HRESULT(void*, ID3DBlob**);
alias GetClockCalibration = fn Win32_HRESULT(void*, Win32_UINT64*, Win32_UINT64*);
alias GetCommandListType = fn Dx_D3D12_COMMAND_LIST_TYPE(void*);
alias GetCommandQueueDesc = fn Dx_D3D12_COMMAND_QUEUE_DESC*(void*,Dx_D3D12_COMMAND_QUEUE_DESC*);
alias GetCompletedValue = fn Win32_UINT64(void*);
alias GetConfigurationInterface = fn Win32_HRESULT(void*, Win32_REFCLSID, Win32_REFIID, void**);
alias GetCopyableFootprints = fn Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT(void*, Dx_D3D12_RESOURCE_DESC*, Win32_UINT, Win32_UINT, Win32_UINT64, Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT*, Win32_UINT*, Win32_UINT64*, Win32_UINT64*);
alias GetCopyableFootprints1 = fn void(void*, Dx_D3D12_RESOURCE_DESC1*, Win32_UINT, Win32_UINT, Win32_UINT64, Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT*, Win32_UINT*, Win32_UINT64*, Win32_UINT64*);
alias GetCPUDescriptorHandleForHeapStart = fn Dx_D3D12_CPU_DESCRIPTOR_HANDLE*(void*,Dx_D3D12_CPU_DESCRIPTOR_HANDLE*);
alias GetCreationFlags = fn Dx_D3D12_FENCE_FLAGS(void*);
alias GetCurrentResourceAndCommandQueue = fn Win32_HRESULT(void*, Win32_REFIID, void**, Win32_REFIID, void**);
alias GetCustomHeapProperties = fn Dx_D3D12_HEAP_PROPERTIES*(void*, Dx_D3D12_HEAP_PROPERTIES*, Win32_UINT, Dx_D3D12_HEAP_TYPE);
alias GetDescriptorHandleIncrementSize = fn Win32_UINT(void*, Dx_D3D12_DESCRIPTOR_HEAP_TYPE);
alias GetDescriptorHeapDesc = fn Dx_D3D12_DESCRIPTOR_HEAP_DESC*(void*,Dx_D3D12_DESCRIPTOR_HEAP_DESC*);
alias GetDevice = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias GetDeviceConfigurationDesc = fn Dx_D3D12_DEVICE_CONFIGURATION_DESC*(void*,Dx_D3D12_DEVICE_CONFIGURATION_DESC*);
alias GetDeviceState = fn Dx_D3D12_DRED_DEVICE_STATE(void*);
alias GetDeviceRemovedReason = fn Win32_HRESULT(void*);
alias GetEnabledExperimentalFeatures = fn Win32_HRESULT(void*, Win32_GUID*, Win32_UINT);
alias GetEntrypointID = fn Dx_D3D12_NODE_ID*(void*, Dx_D3D12_NODE_ID*, Win32_UINT, Win32_UINT);
alias GetEntrypointIndex = fn Win32_UINT(void*, Win32_UINT, Dx_D3D12_NODE_ID);
alias GetEntrypointRecordAlignmentInBytes = fn Win32_UINT(void*, Win32_UINT, Win32_UINT);
alias GetEntrypointRecordSizeInBytes = fn Win32_UINT(void*, Win32_UINT, Win32_UINT);
alias GetFlags = fn Dx_D3D12_COMMAND_LIST_FLAGS(void*);
alias GetGBVEntireSubresourceStatesData = fn Win32_HRESULT(void*, ID3D12ResourceRaw*, int*, Win32_UINT);
alias GetGBVResourceInfo = fn Win32_HRESULT(void*, ID3D12ResourceRaw*, Dx_D3D12_RESOURCE_DESC*, Win32_UINT32*, Win32_UINT32*);
alias GetGBVResourceUniformState = fn Win32_HRESULT(void*, ID3D12ResourceRaw*, int*);
alias GetGBVSubresourceState = fn Win32_HRESULT(void*, ID3D12ResourceRaw*, Win32_UINT, int*);
alias GetGPUDescriptorHandleForHeapStart = fn Dx_D3D12_GPU_DESCRIPTOR_HANDLE*(void*,Dx_D3D12_GPU_DESCRIPTOR_HANDLE*);
alias GetGPUVirtualAddress = fn Dx_D3D12_GPU_VIRTUAL_ADDRESS(void*);
alias GetHeapDesc = fn Dx_D3D12_HEAP_DESC*(void*,Dx_D3D12_HEAP_DESC*);
alias GetHeapProperties = fn Win32_HRESULT(void*, Dx_D3D12_HEAP_PROPERTIES*, Dx_D3D12_HEAP_FLAGS*);
alias GetLUID = fn Win32_LUID*(void*,Win32_LUID*);
alias GetMessage = fn Win32_HRESULT(void*, Win32_UINT64, Dx_D3D12_MESSAGE*, Win32_SIZE_T*);
alias GetNodeCount = fn Win32_UINT(void*);
alias GetNodeID = fn Dx_D3D12_NODE_ID*(void*, Dx_D3D12_NODE_ID*, Win32_UINT, Win32_UINT);
alias GetNodeIndex = fn Win32_UINT(void*, Win32_UINT, Dx_D3D12_NODE_ID);
alias GetNodeLocalRootArgumentsTableIndex = fn Win32_UINT(void*, Win32_UINT, Win32_UINT);
alias GetNumEntrypoints = fn Win32_UINT(void*, Win32_UINT);
alias GetNumNodes = fn Win32_UINT(void*, Win32_UINT);
alias GetNumStoredMessagesAllowedByRetrievalFilter = fn Win32_UINT64(void*);
alias GetNumWorkGraphs = fn Win32_UINT(void*);
alias GetPageFaultAllocationOutput = fn Win32_HRESULT(void*, Dx_D3D12_DRED_PAGE_FAULT_OUTPUT*);
alias GetPageFaultAllocationOutput1 = fn Win32_HRESULT(void*, Dx_D3D12_DRED_PAGE_FAULT_OUTPUT1*);
alias GetPageFaultAllocationOutput2 = fn Win32_HRESULT(void*, Dx_D3D12_DRED_PAGE_FAULT_OUTPUT2*);
alias GetPipelineStackSize = fn Win32_UINT64(void*);
alias GetProgramIdentifier = fn Dx_D3D12_PROGRAM_IDENTIFIER*(void*, Dx_D3D12_PROGRAM_IDENTIFIER*, Win32_LPCWSTR);
alias GetProgramName = fn Win32_LPCWSTR(void*, Win32_UINT);
alias GetProtectedResourceSession = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias GetProtectedResourceSessionDesc = fn Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC*(void*, Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC*);
alias GetProtectedResourceSessionDesc1 = fn Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1*(void*, Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1*);
alias GetRaytracingAccelerationStructurePrebuildInfo = fn Win32_HRESULT(void*, Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS*, Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO*);
alias GetResourceAllocationInfo = fn Dx_D3D12_RESOURCE_ALLOCATION_INFO*(void*, Dx_D3D12_RESOURCE_ALLOCATION_INFO*, Win32_UINT, Win32_UINT, Dx_D3D12_RESOURCE_DESC*);
alias GetResourceAllocationInfo1 = fn Dx_D3D12_RESOURCE_ALLOCATION_INFO*(void*, Dx_D3D12_RESOURCE_ALLOCATION_INFO*, Win32_UINT, Win32_UINT, Dx_D3D12_RESOURCE_DESC*, Dx_D3D12_RESOURCE_ALLOCATION_INFO1*);
alias GetResourceAllocationInfo2 = fn Dx_D3D12_RESOURCE_ALLOCATION_INFO*(void*, Dx_D3D12_RESOURCE_ALLOCATION_INFO*, Win32_UINT, Win32_UINT, Dx_D3D12_RESOURCE_DESC1*, Dx_D3D12_RESOURCE_ALLOCATION_INFO1*);
alias GetResourceAllocationInfo3 = fn Dx_D3D12_RESOURCE_ALLOCATION_INFO*(void*, Dx_D3D12_RESOURCE_ALLOCATION_INFO*, Win32_UINT, Win32_UINT, Dx_D3D12_RESOURCE_DESC1*, Win32_UINT32*, Dx_DXGI_FORMAT**, Dx_D3D12_RESOURCE_ALLOCATION_INFO1*);
alias GetResourceDesc = fn Dx_D3D12_RESOURCE_DESC*(void*, Dx_D3D12_RESOURCE_DESC*);
alias GetResourceDesc1 = fn Dx_D3D12_RESOURCE_DESC1*(void*, Dx_D3D12_RESOURCE_DESC1*);
alias GetResourceTiling = fn Win32_HRESULT(void*, ID3D12ResourceRaw*, Win32_UINT*, Dx_D3D12_PACKED_MIP_INFO*, Dx_D3D12_TILE_SHAPE*, Win32_UINT*, Win32_UINT, Dx_D3D12_SUBRESOURCE_TILING*);
alias GetRequiredParameterResourceSize = fn Win32_UINT64(void*, Dx_D3D12_META_COMMAND_PARAMETER_STAGE, Win32_UINT);
alias GetRootSignatureDesc = fn Dx_D3D12_ROOT_SIGNATURE_DESC*(void*);
alias GetRootSignatureDescAtVersion = fn Win32_HRESULT(void*, Dx_D3D_ROOT_SIGNATURE_VERSION, Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC**);
alias CreateRootSignatureFromSubobjectInLibrary = fn Win32_HRESULT(void*, Win32_UINT, void*, Win32_SIZE_T, Win32_LPCWSTR, Win32_REFIID, void**);
alias GetSerializedSize = fn Win32_SIZE_T(void*);
alias GetSessionStatus = fn Dx_D3D12_PROTECTED_SESSION_STATUS(void*);
alias GetShaderCacheSessionDesc = fn Dx_D3D12_SHADER_CACHE_SESSION_DESC*(void*,Dx_D3D12_SHADER_CACHE_SESSION_DESC*);
alias GetShaderIdentifier = fn void*(void*, Win32_LPCWSTR);
alias GetShaderStackSize = fn Win32_UINT64(void*, Win32_LPCWSTR);
alias GetStatusFence = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias GetSwapChainObject = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias GetTimestampFrequency = fn Win32_HRESULT(void*, Win32_UINT64*);
alias GetUnconvertedRootSignatureDesc = fn Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC*(void*);
alias GetWorkGraphMemoryRequirements = fn void(void*, Win32_UINT, Dx_D3D12_WORK_GRAPH_MEMORY_REQUIREMENTS*);
alias IASetIndexBuffer = fn void(void*, Dx_D3D12_INDEX_BUFFER_VIEW*);
alias IASetIndexBufferStripCutValue = fn void(void*, Dx_D3D12_INDEX_BUFFER_STRIP_CUT_VALUE);
alias IASetPrimitiveTopology = fn void(void*, Dx_D3D_PRIMITIVE_TOPOLOGY);
alias IASetVertexBuffers = fn void(void*, Win32_UINT, Win32_UINT, Dx_D3D12_VERTEX_BUFFER_VIEW*);
alias InitializeFromGlobalState = fn Win32_HRESULT(void*);
alias InitializeMetaCommand = fn void(void*, ID3D12MetaCommandRaw*, void*, Win32_SIZE_T);
alias InsertImplicitSync = fn Win32_HRESULT(void*);
alias LifetimeStateUpdated = fn void(void*, Dx_D3D12_LIFETIME_STATE);
alias LoadComputePipeline = fn Win32_HRESULT(void*, Win32_LPCWSTR, Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC*, Win32_REFIID, void**);
alias LoadGraphicsPipeline = fn Win32_HRESULT(void*, Win32_LPCWSTR, Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC*, Win32_REFIID, void**);
alias LoadPipeline = fn Win32_HRESULT(void*, Win32_LPCWSTR, Dx_D3D12_PIPELINE_STATE_STREAM_DESC*, Win32_REFIID, void**);
alias MakeResident = fn Win32_HRESULT(void*, Win32_UINT, ID3D12PageableRaw**);
alias Map = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_RANGE*, void**);
alias OMSetRenderTargets = fn void(void*, Win32_UINT, Dx_D3D12_CPU_DESCRIPTOR_HANDLE*, bool, Dx_D3D12_CPU_DESCRIPTOR_HANDLE*);
alias OMSetBlendFactor = fn void(void*, float[4]);
alias OMSetDepthBounds = fn void(void*, float, float);
alias OMSetFrontAndBackStencilRef = fn void(void*, Win32_UINT, Win32_UINT);
alias OMSetStencilRef = fn void(void*, Win32_UINT);
alias OpenExistingHeapFromAddress = fn Win32_HRESULT(void*, void*, Win32_REFIID, void**);
alias OpenExistingHeapFromAddress1 = fn Win32_HRESULT(void*, void*, Win32_SIZE_T, Win32_REFIID, void**);
alias OpenExistingHeapFromFileMapping = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_REFIID, void**);
alias OpenSharedHandle = fn Win32_HRESULT(void*, Win32_HANDLE, Win32_REFIID, void**);
alias OpenSharedHandleByName = fn Win32_HRESULT(void*, WString, Win32_DWORD, Win32_HANDLE*);
alias ReadFromSubresource = fn Win32_HRESULT(void*, void*, Win32_UINT, Win32_UINT, Win32_UINT, Dx_D3D12_BOX*);
alias RegisterMessageCallback = fn Win32_HRESULT(void*, D3D12MessageFunc, Dx_D3D12_MESSAGE_CALLBACK_FLAGS, void*, Win32_DWORD*);
alias RemoveDevice = fn Win32_HRESULT(void*);
alias ReportLiveDeviceObjects = fn Win32_HRESULT(void*, Dx_D3D12_RLDO_FLAGS);
alias ReserveGPUVARangesAtCreate = fn Win32_HRESULT(void*, Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE*, Win32_UINT);
alias Reset = fn Win32_HRESULT(void*);
alias ResetCommandList = fn Win32_HRESULT(void*, ID3D12CommandAllocatorRaw*, ID3D12PipelineStateRaw*);
alias ResolveSubresource = fn void(void*, ID3D12ResourceRaw*, Win32_UINT, ID3D12ResourceRaw*, Win32_UINT, Dx_DXGI_FORMAT);
alias ResolveSubresourceRegion = fn void(void*, ID3D12ResourceRaw*, Win32_UINT, Win32_UINT, Win32_UINT, ID3D12ResourceRaw*, Win32_UINT, Dx_D3D12_RECT*, Dx_DXGI_FORMAT, Dx_D3D12_RESOLVE_MODE);
alias ResolveQueryData = fn void(void*, ID3D12ResourceRaw*, Dx_D3D12_QUERY_TYPE, Win32_UINT, Win32_UINT, ID3D12ResourceRaw*, Win32_UINT64);
alias ResourceBarrier = fn void(void*, Win32_UINT, Dx_D3D12_RESOURCE_BARRIER*);
alias RSSetDepthBias = fn void(void*, float, float, float);
alias RSSetScissorRects = fn void(void*, Win32_UINT, Dx_D3D12_RECT*);
alias RSSetShadingRate = fn void(void*, Dx_D3D12_SHADING_RATE, Dx_D3D12_SHADING_RATE_COMBINER*);
alias RSSetShadingRateImage = fn void(void*, ID3D12ResourceRaw*);
alias RSSetViewports = fn void(void*, Win32_UINT, Dx_D3D12_VIEWPORT*);
alias ShaderCacheControl = fn Win32_HRESULT(void*, Dx_D3D12_SHADER_CACHE_KIND_FLAGS, Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS);
alias Serialize = fn Win32_HRESULT(void*, void*, Win32_SIZE_T);
alias SerializeVersionedRootSignature = fn Win32_HRESULT(void*, Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC*, ID3DBlob**, ID3DBlob**);
alias SetApplicationSpecificDriverState = fn Win32_HRESULT(void*, IUnknownRaw*, ID3DBlob*);
alias SetAutoBreadcrumbsEnablement = fn void(void*, Dx_D3D12_DRED_ENABLEMENT);
alias SetBackgroundProcessingMode = fn Win32_HRESULT(void*, Dx_D3D12_BACKGROUND_PROCESSING_MODE, Dx_D3D12_MEASUREMENTS_ACTION, Win32_HANDLE, Win32_BOOL*);
alias SetBreadcrumbContextEnablement = fn void(void*, Dx_D3D12_DRED_ENABLEMENT);
alias SetComputeRoot32BitConstant = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Win32_UINT);
alias SetComputeRoot32BitConstants = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, void*, Win32_UINT);
alias SetComputeRootConstantBufferView = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetComputeRootDescriptorTable = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_DESCRIPTOR_HANDLE);
alias SetComputeRootShaderResourceView = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetComputeRootSignature = fn Win32_HRESULT(void*, ID3D12RootSignatureRaw*);
alias SetComputeRootUnorderedAccessView = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetDeleteOnDestroy = fn void(void*);
alias SetDescriptorHeaps = fn Win32_HRESULT(void*, Win32_UINT, ID3D12DescriptorHeap**);
alias SetEnableAutoName = fn void(void*, Win32_BOOL);
alias SetEnableGPUBasedValidation = fn void (void*, Win32_BOOL);
alias SetEnableSynchronizedCommandQueueValidation = fn void (void*, Win32_BOOL);
alias SetEventOnCompletion = fn Win32_HRESULT(void*, Win32_UINT64, Win32_HANDLE);
alias SetEventOnMultipleFenceCompletion = fn Win32_HRESULT(void*, ID3D12FenceRaw**, Win32_UINT64*, Win32_UINT, Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS, Win32_HANDLE);
alias SetFlags = fn Win32_HRESULT(void*, Dx_D3D12_DEVICE_FACTORY_FLAGS);
alias SetForceLegacyBarrierValidation = fn void(void*, Win32_BOOL);
alias SetGPUBasedValidationFlags = fn void(void*, Dx_D3D12_GPU_BASED_VALIDATION_FLAGS);
alias SetGraphicsRoot32BitConstant = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, Win32_UINT);
alias SetGraphicsRoot32BitConstants = fn Win32_HRESULT(void*, Win32_UINT, Win32_UINT, void*, Win32_UINT);
alias SetGraphicsRootConstantBufferView = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetGraphicsRootDescriptorTable = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_DESCRIPTOR_HANDLE);
alias SetGraphicsRootShaderResourceView = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetGraphicsRootSignature = fn Win32_HRESULT(void*, ID3D12RootSignatureRaw*);
alias SetGraphicsRootUnorderedAccessView = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetMarker = fn void(void*, Win32_UINT, void*, Win32_UINT);
alias SetName = fn Win32_HRESULT(void*, WString);
alias SetNextAllocationAddress = fn void(void*, Dx_D3D12_GPU_VIRTUAL_ADDRESS);
alias SetPageFaultEnablement = fn void(void*, Dx_D3D12_DRED_ENABLEMENT);
alias SetPipelineStackSize = fn void(void*, Win32_UINT64);
alias SetPipelineState = fn void(void*, ID3D12PipelineStateRaw*);
alias SetPipelineState1 = fn void(void*, ID3D12StateObjectRaw*);
alias SetPredication = fn void(void*, ID3D12ResourceRaw*, Win32_UINT64, Dx_D3D12_PREDICATION_OP);
alias SetProgram = fn void(void*, Dx_D3D12_SET_PROGRAM_DESC*);
alias SetProtectedResourceSession = fn void(void*, ID3D12ProtectedResourceSessionRaw*);
alias SetResidencyPriority = fn Win32_HRESULT(void*, Win32_UINT, ID3D12PageableRaw**, Dx_D3D12_RESIDENCY_PRIORITY*);
alias SetSamplePositions = fn void(void*, Win32_UINT, Win32_UINT, Dx_D3D12_SAMPLE_POSITION*);
alias SetSDKVersion = fn Win32_HRESULT(void*, Win32_UINT, Win32_LPCSTR);
alias SetStablePowerState = fn Win32_HRESULT(void*, Win32_BOOL);
alias SetViewInstanceMask = fn void(void*, Win32_UINT);
alias SetWatsonDumpEnablement = fn void(void*, Dx_D3D12_DRED_ENABLEMENT);
alias ShaderInstrumentationEnabled = fn Win32_BOOL(void*);
alias ShareWithHost = fn Win32_HRESULT(void*, ID3D12DeviceChildRaw*, Win32_HANDLE*);
alias Signal = fn Win32_HRESULT(void*, Win32_UINT64);
alias SignalFence = fn Win32_HRESULT(void*, ID3D12Fence*, Win32_UINT64);
alias SOSetTargets = fn void(void*, Win32_UINT, Win32_UINT, Dx_D3D12_STREAM_OUTPUT_BUFFER_VIEW*);
alias StorePipeline = fn Win32_HRESULT(void*, Win32_LPCWSTR, ID3D12PipelineStateRaw*);
alias StoreValue = fn Win32_HRESULT(void*, void*, Win32_UINT, void*, Win32_UINT);
alias Unmap = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_RANGE*);
alias UpdateTileMappings = fn void(void* , ID3D12ResourceRaw*, Win32_UINT, Dx_D3D12_TILED_RESOURCE_COORDINATE*, Dx_D3D12_TILE_REGION_SIZE*, ID3D12HeapRaw*, Win32_UINT, Dx_D3D12_TILE_RANGE_FLAGS*, Win32_UINT*, Win32_UINT*, Dx_D3D12_TILE_MAPPING_FLAGS);
alias UseMarkersOnlyAutoBreadcrumbs = fn void(void*, Dx_D3D12_DRED_ENABLEMENT);
alias Wait = fn Win32_HRESULT(void*, ID3D12Fence*, Win32_UINT64);
alias WriteBufferImmediate = fn void(void*, Win32_UINT, Dx_D3D12_WRITEBUFFERIMMEDIATE_PARAMETER*, Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE*);
alias WriteToSubresource = fn Win32_HRESULT(void*, Win32_UINT, Dx_D3D12_BOX*, void*, Win32_UINT, Win32_UINT);

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

module d3d12;

import std::os::win32;
import dxgi;

struct ID3D12ObjectVtbl @private
{
    // IUnknown methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;

    // ID3D12Object methods
    SetName set_name;
}

interface ID3D12Object : IUnknown
{
    fn void? set_private_data(Win32_REFIID guid, Win32_UINT dataSize, void* data);
    fn void? set_private_data_interface(Win32_REFIID guid, void* data);
    fn void? get_private_data(Win32_REFIID guid, Win32_UINT* dataSize, void* data);
    fn void? set_name(WString name);
}

fn void? set_name_helper(void* this, SetName func, WString name) @private
{
    Win32_HRESULT hr = func(this, name);
    if (hr != S_OK) check_hresult(hr)!;
}

struct ID3D12FenceVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12Fence methods
    GetCompletedValue get_completed_value;
    SetEventOnCompletion set_event_on_completion;
    Signal signal;

    // ID3D12Fence1 methods
    GetCreationFlags get_creation_flags;
}

interface ID3D12Fence : ID3D12DeviceChild
{
    fn FenceVersion get_fence_version();

    <*
     Gets the current value of the fence.
    *>
    fn Win32_UINT64 get_completed_value();
    <*
     Specifies an event that should be fired when the fence reaches a certain value. 
    *>
    fn void? set_event_on_completion(Win32_UINT64 value, Win32_HANDLE eventHandle);
    <*
     Sets the fence to the specified value.
    *>
    fn void? signal(Win32_UINT64 value);

    // Fence1
    <*
     Gets the flags used to create the fence represented by the current instance.

     This method is only available if the FenceVersion is at least FENCE1.
    *>
    fn Dx_D3D12_FENCE_FLAGS? get_creation_flags();
}

struct ID3D12FenceImpl (ID3D12Fence)
{
    ID3D12FenceVtbl* vtbl;
    ID3D12FenceRaw* raw;
    FenceVersion version;
}

fn FenceVersion ID3D12FenceImpl.get_fence_version(&self) @dynamic => self.version;

fn void* ID3D12FenceImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12FenceImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12FenceImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12FenceImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12FenceImpl.get_private_data(&self, Win32_REFIID guid, Win32_UINT* dataSize, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, guid, dataSize, data);
fn void? ID3D12FenceImpl.set_private_data(&self, Win32_REFIID guid, Win32_UINT dataSize, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, guid, dataSize, data);
fn void? ID3D12FenceImpl.set_private_data_interface(&self, Win32_REFIID guid, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, guid, data);
fn void? ID3D12FenceImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12FenceImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn Win32_UINT64 ID3D12FenceImpl.get_completed_value(&self) @dynamic
{
    return self.vtbl.get_completed_value(self.raw);
}

fn void? ID3D12FenceImpl.signal(&self, Win32_UINT64 value) @dynamic
{
    Win32_HRESULT hr = self.vtbl.signal(self.raw, value);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12FenceImpl.set_event_on_completion(&self, Win32_UINT64 value, Win32_HANDLE eventHandle) @dynamic
{
    Win32_HRESULT hr = self.vtbl.set_event_on_completion(self.raw, value, eventHandle);
    if (hr != S_OK) check_hresult(hr)!;
}

fn Dx_D3D12_FENCE_FLAGS? ID3D12FenceImpl.get_creation_flags(&self) @dynamic
{
    validate_version(self.version, FenceVersion.FENCE1)!;
    return self.vtbl.get_creation_flags(self.raw);
}

struct ID3D12SDKConfigurationVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    // ID3D12SDKConfiguration methods
    SetSDKVersion set_sdk_version;

    // ID3D12SDKConfiguration1 methods
    CreateDeviceFactory create_device_factory;
    FreeUnusedSDKs free_unused_sdks;
}

interface ID3D12SDKConfiguration : IUnknown
{
    fn void? set_sdk_version(Win32_UINT sdk_version, Win32_LPCSTR sdk_path);
    
    // ID3D12SDKConfiguration1 methods
    fn ID3D12DeviceFactory? create_device_factory(Win32_UINT sdk_version, Win32_LPCSTR sdk_path);
    fn void? free_unused_sdks();
}

////////////////////////////////////////////////////////////////////////////////
// Loose Functions
////////////////////////////////////////////////////////////////////////////////

extern fn Win32_HRESULT d3d12GetDebugInterface(Win32_REFIID riid, void** pvDebug) @extern("D3D12GetDebugInterface");

fn ID3D12Debug? get_debug_interface()
{
    void* debugInterface;
    DebugVersion version = g_supported_version_tracker.debug_version;
    if (version == NOT_CHECKED_YET)
    {
        // @Todo: Mutex lock here
        Win32_HRESULT hr;
        for (int i = (int) DebugVersion.values.len - 1; i > 1; --i)
        {
            Win32_REFIID riid = DebugVersion.from_ordinal(i).riid;
            hr = d3d12GetDebugInterface(riid, &debugInterface);
            if (hr == S_OK)
            {
                version = DebugVersion.from_ordinal(i);
                g_supported_version_tracker.debug_version = version;
                break;
            }
        }
        if (version == NOT_CHECKED_YET)
        {
            // If we reach here, it means no version was supported.
            g_supported_version_tracker.debug_version = NOT_SUPPORTED;
            return NOINTERFACE?;
        }
    }
    else
    {
        Win32_REFIID riid = version.riid;
        Win32_HRESULT hr = d3d12GetDebugInterface(riid, &debugInterface);
        if (hr != S_OK) check_hresult(hr)!;
    }
    assert(debugInterface != null, "Failed to create debug interface, no supported version found");
    ID3D12DebugImpl* impl = mem::new(ID3D12DebugImpl);
    impl.vtbl = *(ID3D12DebugVtbl**) debugInterface;
    impl.raw = (ID3D12DebugRaw*) debugInterface;
    impl.version = version;
    return impl;
}

////////////////////////////////////////////////////////////////////////////////
// D3D12EnableExperimentalFeatures
//
// Pass in a list of feature GUIDs to be enabled together.
// 
// If a particular feature requires some configuration information on enablement, it will have
// a configuration struct that can be passed alongside the GUID.
// 
// Some features might use an interface IID as the GUID.  For these, once the feature is enabled via
// D3D12EnableExperimentalFeatures, D3D12GetDebugInterface can then be called with the IID to retrieve the interface
// for manipulating the feature.  This allows for control that might not cleanly be expressed by just 
// the configuration struct that D3D12EnableExperimentalFeatures provides.
//
// If this method is called and a change to existing feature enablement is made, 
// all current D3D12 devices are set to DEVICE_REMOVED state, since under the covers there is really only one
// singleton device for a process.  Removing the devices when configuration changes prevents
// mismatched expectations of how a device is supposed to work after it has been created from the app's point of view.
//
// The call returns E_NOINTERFACE if an unrecognized feature is passed in or Windows Developer mode is not on.
// The call returns E_INVALIDARG if the configuration of a feature is incorrect, the set of features passed
// in are known to be incompatible with each other, or other errors.
// Returns S_OK otherwise.
//
////////////////////////////////////////////////////////////////////////////////
extern fn Win32_HRESULT d3d12EnableExperimentalFeatures(Win32_UINT num_features, Win32_IID* pIIDs, void* pConfigurationStructs, Win32_UINT* pConfigurationStructSizes) @extern("D3D12EnableExperimentalFeatures");

////////////////////////////////////////////////////////////////////////////////
// D3D12GetInterface
//
// Retrieve Global D3D12 Interface.
//
extern fn Win32_HRESULT d3d12GetInterface(Win32_REFCLSID rclsid, Win32_REFIID riid, void** pvDebug ) @extern("D3D12GetInterface");




