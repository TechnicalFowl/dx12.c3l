module d3d12;

import std::os::win32;

struct ID3D12ShaderCacheSessionVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
    GetPrivateData get_private_data;
    SetPrivateData set_private_data;
    SetPrivateDataInterface set_private_data_interface;
    SetName set_name;
    GetDevice get_device;

    // ID3D12ShaderCacheSession methods
    FindValue find_value;
    StoreValue store_value;
    SetDeleteOnDestroy set_delete_on_destroy;
    GetShaderCacheSessionDesc get_desc;
}

interface ID3D12ShaderCacheSession : ID3D12DeviceChild
{
    fn void? find_value(void* key, Win32_UINT key_size, void* value, Win32_UINT* value_size);
    fn void? store_value(void* key, Win32_UINT key_size, void* value, Win32_UINT value_size);
    fn void set_delete_on_destroy();
    fn Dx_D3D12_SHADER_CACHE_SESSION_DESC get_desc();
}

struct ID3D12ShaderCacheSessionImpl (ID3D12ShaderCacheSession)
{
    ID3D12ShaderCacheSessionVtbl* vtbl;
    ID3D12ShaderCacheSessionRaw* raw;
}

fn void* ID3D12ShaderCacheSessionImpl.get_com_ptr(&self) @dynamic => self.raw;
fn void*? ID3D12ShaderCacheSessionImpl.query_interface(&self, Win32_REFIID riid) @dynamic => query_interface_helper(self.raw, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3D12ShaderCacheSessionImpl.add_ref(&self) @dynamic => self.vtbl.add_ref(self.raw);
fn Win32_ULONG ID3D12ShaderCacheSessionImpl.release(&self) @dynamic => self.vtbl.release(self.raw);
fn void? ID3D12ShaderCacheSessionImpl.set_private_data(&self, Win32_REFIID id, Win32_UINT size, void* data) @dynamic => set_private_data_helper(self.raw, self.vtbl.set_private_data, id, size, data);
fn void? ID3D12ShaderCacheSessionImpl.set_private_data_interface(&self, Win32_REFIID id, void* data) @dynamic => set_private_data_interface_helper(self.raw, self.vtbl.set_private_data_interface, id, data);
fn void? ID3D12ShaderCacheSessionImpl.get_private_data(&self, Win32_REFIID id, Win32_UINT* size, void* data) @dynamic => get_private_data_helper(self.raw, self.vtbl.get_private_data, id, size, data);
fn void? ID3D12ShaderCacheSessionImpl.set_name(&self, WString name) @dynamic => set_name_helper(self.raw, self.vtbl.set_name, name);
fn ID3D12Device? ID3D12ShaderCacheSessionImpl.get_device(&self) @dynamic => get_device_helper(self.raw, self.vtbl.get_device);

fn void? ID3D12ShaderCacheSessionImpl.find_value(&self, void* key, Win32_UINT key_size, void* value, Win32_UINT* value_size) @dynamic
{
    Win32_UINT size;
    Win32_HRESULT hr = self.vtbl.find_value(self.raw, key, key_size, null, &size);
    if (hr != S_OK) check_hresult(hr)!;
    if (*value_size < size) {
        *value_size = size;
        return BAD_LENGTH?;
    }
    *value_size = size;
    hr = self.vtbl.find_value(self.raw, key, key_size, value, value_size);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void? ID3D12ShaderCacheSessionImpl.store_value(&self, void* key, Win32_UINT key_size, void* value, Win32_UINT value_size) @dynamic
{
    Win32_HRESULT hr = self.vtbl.store_value(self.raw, key, key_size, value, value_size);
    if (hr != S_OK) check_hresult(hr)!;
}

fn void ID3D12ShaderCacheSessionImpl.set_delete_on_destroy(&self) @dynamic
{
    self.vtbl.set_delete_on_destroy(self.raw);
}

fn Dx_D3D12_SHADER_CACHE_SESSION_DESC ID3D12ShaderCacheSessionImpl.get_desc(&self) @dynamic
{
    Dx_D3D12_SHADER_CACHE_SESSION_DESC desc;
    self.vtbl.get_desc(self.raw, &desc);
    return desc;
}
