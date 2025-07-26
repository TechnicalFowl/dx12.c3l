module d3d12;

import std::os::win32;

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

struct ID3D12RootSignatureVtbl @private
{
    // ID3D12DeviceChild methods
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    GetPrivateData get_private_data;
    SetName set_name;
    GetDevice get_device;

    // ID3D12RootSignature methods
}

interface ID3D12RootSignature : ID3D12DeviceChild
{
}

struct ID3D12RootSignatureImpl (ID3D12RootSignature)
{
    ID3D12RootSignatureVtbl* vtbl;
    ID3D12RootSignatureRaw* raw;
}

fn void* ID3D12RootSignatureImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12RootSignatureImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12RootSignatureImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12RootSignatureImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12RootSignatureImpl.set_private_data(&self, Win32_REFIID id, Win32_UINT size, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, id, size, data);
fn void? ID3D12RootSignatureImpl.set_private_data_interface(&self, Win32_REFIID id, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, id, data);
fn void? ID3D12RootSignatureImpl.get_private_data(&self, Win32_REFIID id, Win32_UINT* size, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, id, size, data);
fn void? ID3D12RootSignatureImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12RootSignatureImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

struct ID3D12RootSignatureDeserializerVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    GetRootSignatureDesc get_root_signature_desc;
}

interface ID3D12RootSignatureDeserializer : IUnknown
{
    <*
     Gets the layout of the root signature. The memory for the returned description is owned by the deserializer.

     @ensure return != null
    *>
    fn Dx_D3D12_ROOT_SIGNATURE_DESC* get_root_signature_desc();
}

struct ID3D12RootSignatureDeserializerImpl (ID3D12RootSignatureDeserializer)
{
    ID3D12RootSignatureDeserializerVtbl* vtbl;
    ID3D12RootSignatureDeserializerRaw* raw;
}

fn void* ID3D12RootSignatureDeserializerImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12RootSignatureDeserializerImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12RootSignatureDeserializerImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12RootSignatureDeserializerImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

<*
 @ensure return != null
*>
fn Dx_D3D12_ROOT_SIGNATURE_DESC* ID3D12RootSignatureDeserializerImpl.get_root_signature_desc(&self) @dynamic
{
    return self.vtbl.get_root_signature_desc(self.raw);
}

struct ID3D12VersionedRootSignatureDeserializerVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    GetRootSignatureDescAtVersion get_root_signature_desc_at_version;
    GetUnconvertedRootSignatureDesc get_unconverted_root_signature_desc;
}

interface ID3D12VersionedRootSignatureDeserializer : IUnknown
{
    <*
     Gets the layout of the root signature at a specific version. The memory for the returned description is owned by the deserializer.

     @ensure return != null
    *>
    fn Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC*? get_root_signature_desc_at_version(Dx_D3D_ROOT_SIGNATURE_VERSION version);

    <*
     Gets the unconverted root signature description. The memory for the returned description is owned by the deserializer.

     @ensure return != null
    *>
    fn Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* get_unconverted_root_signature_desc();
}

struct ID3D12VersionedRootSignatureDeserializerImpl (ID3D12VersionedRootSignatureDeserializer)
{
    ID3D12VersionedRootSignatureDeserializerVtbl* vtbl;
    ID3D12VersionedRootSignatureDeserializerRaw* raw;
}

fn void* ID3D12VersionedRootSignatureDeserializerImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12VersionedRootSignatureDeserializerImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12VersionedRootSignatureDeserializerImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12VersionedRootSignatureDeserializerImpl.release(&self) @dynamic => self.vtbl.release(self.raw);

fn Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC*? ID3D12VersionedRootSignatureDeserializerImpl.get_root_signature_desc_at_version(&self, Dx_D3D_ROOT_SIGNATURE_VERSION version) @dynamic
{
    Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* desc;
    Win32_HRESULT hr = self.vtbl.get_root_signature_desc_at_version(self.raw, version, &desc);
    if (hr != S_OK) check_hresult(hr)!;
    return desc;
}

fn Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* ID3D12VersionedRootSignatureDeserializerImpl.get_unconverted_root_signature_desc(&self) @dynamic
{
    Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* desc = self.vtbl.get_unconverted_root_signature_desc(self.raw);
    if (desc == null) abort("ID3D12VersionedRootSignatureDeserializer.get_unconverted_root_signature_desc returned null");
    return desc;
}

////////////////////////////////////////////////////////////////////////////////
// Loose Functions
////////////////////////////////////////////////////////////////////////////////

extern fn Win32_HRESULT d3d12SerializeRootSignature(Dx_D3D12_ROOT_SIGNATURE_DESC* rootSignature, Dx_D3D_ROOT_SIGNATURE_VERSION version, void** ppBlob, void** ppErrorBlob) @extern("D3D12SerializeRootSignature");
<*
 * Serializes a root signature version 1.0 that can be passed to ID3D12Device.create_root_signature.
 *
 * This function is superceded by serialize_versioned_root_signature as of Windows version 14393.
 *
 * @param [&in] rootSignature
 * @param [in] version : The version of the root signature to serialize.
 *>
fn char[]? serialize_root_signature(Dx_D3D12_ROOT_SIGNATURE_DESC* rootSignature, Dx_D3D_ROOT_SIGNATURE_VERSION version)
{
    ID3DBlob* blob;
    ID3DBlob* errorBlob;
    Win32_HRESULT hr = d3d12SerializeRootSignature(rootSignature, version, &blob, &errorBlob);
    if (hr != S_OK) {
        if (errorBlob) {
            assert("d3d12SerializeRootSignature failed, check errorBlob");
        }
        @safe_release(errorBlob);
        check_hresult(hr)!;
    }
    char[] data = blob.get_buffer();
    @safe_release(blob);
    @safe_release(errorBlob);
    return data;
}

extern fn Win32_HRESULT d3d12CreateRootSignatureDeserializer(void* rootSignatureBlob, Win32_SIZE_T blobSizeInBytes, Win32_REFIID riid, void** ppvRootSignatureDeserializer) @extern("D3D12CreateRootSignatureDeserializer");
<*
 * Deserializes a root signature so you can determine the layout definition (Dx_D3D12_ROOT_SIGNATURE_DESC).
 *
 * This function is superceded by create_versioned_root_signature_deserializer.
 *
 * @param [&in] rootSignatureBlob : A pointer to the source data for the serialized root signature.
 * @param [in] blobSizeInBytes : The size, in bytes, of the block of memory that pSrcData points to.
 *>
fn ID3D12RootSignatureDeserializer? create_root_signature_deserializer(void* rootSignatureBlob, Win32_SIZE_T blobSizeInBytes)
{
    void* deserializer;
    Win32_HRESULT hr = d3d12CreateRootSignatureDeserializer(rootSignatureBlob, blobSizeInBytes, &IID_ID3D12ROOTSIGNATUREDESERIALIZER, &deserializer);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12RootSignatureDeserializerImpl* impl = mem::new(ID3D12RootSignatureDeserializerImpl);
    impl.vtbl = *(ID3D12RootSignatureDeserializerVtbl**) deserializer;
    impl.raw = (ID3D12RootSignatureDeserializerRaw*) deserializer;
    return impl;
}

extern fn Win32_HRESULT d3d12SerializeVersionedRootSignature(Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* rootSignature, void** ppBlob, void** ppErrorBlob) @extern("D3D12SerializeVersionedRootSignature");
<*
 * Serializes a root signature version 1.1 that can be passed to ID3D12Device.create_root_signature.
 *
 * @param [&in] rootSignature : The root signature to serialize.
 *>
fn char[]? serialize_versioned_root_signature(Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC* rootSignature)
{
    ID3DBlob* blob;
    ID3DBlob* errorBlob;
    Win32_HRESULT hr = d3d12SerializeVersionedRootSignature(rootSignature, &blob, &errorBlob);
    if (hr != S_OK) {
        if (errorBlob) {
            assert("d3d12SerializeVersionedRootSignature failed, check errorBlob");
        }
        @safe_release(errorBlob);
        check_hresult(hr)!;
    }
    char[] copy = blob.get_buffer();
    @safe_release(errorBlob);
    @safe_release(blob);
    return copy;
}

extern fn Win32_HRESULT d3d12CreateVersionedRootSignatureDeserializer(void* rootSignatureBlob, Win32_SIZE_T blobSizeInBytes, Win32_REFIID riid, void** ppvRootSignatureDeserializer) @extern("D3D12CreateVersionedRootSignatureDeserializer");
<*
 * Deserializes a root signature so you can determine the layout definition (Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC).
 *
 * @param [&in] rootSignatureBlob : A pointer to the source data for the serialized root signature.
 * @param [in] blobSizeInBytes : The size, in bytes, of the block of memory that pSrcData points to.
 *>
fn ID3D12VersionedRootSignatureDeserializer? create_versioned_root_signature_deserializer(void* rootSignatureBlob, Win32_SIZE_T blobSizeInBytes)
{
    void* deserializer;
    Win32_HRESULT hr = d3d12CreateVersionedRootSignatureDeserializer(rootSignatureBlob, blobSizeInBytes, &IID_ID3D12VERSIONEDROOTSIGNATUREDESERIALIZER, &deserializer);
    if (hr != S_OK) check_hresult(hr)!;
    ID3D12VersionedRootSignatureDeserializerImpl* impl = mem::new(ID3D12VersionedRootSignatureDeserializerImpl);
    impl.vtbl = *(ID3D12VersionedRootSignatureDeserializerVtbl**) deserializer;
    impl.raw = (ID3D12VersionedRootSignatureDeserializerRaw*) deserializer;
    return impl;
}

extern fn Win32_HRESULT d3d12CreateVersionedRootSignatureDeserializerFromSubobjectInLibrary(
    void* pSrcData,
    Win32_SIZE_T srcDataSizeInBytes,
    Win32_LPCWSTR rootSignatureSubobjectName,
    Win32_REFIID pRootSignatureDeserializerInterface,
    void** ppRootSignatureDeserializer) @extern("D3D12CreateVersionedRootSignatureDeserializerFromSubobjectInLibrary");

