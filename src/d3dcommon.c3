module d3d12;

import std::os::win32;

////////////////////////////////////////////////////////////////////////////////
// Enums and Plain Structs
////////////////////////////////////////////////////////////////////////////////

enum Dx_D3D_FEATURE_LEVEL : const
{
    D3D_FEATURE_LEVEL_1_0_CORE  = 0x1000,
    D3D_FEATURE_LEVEL_9_1       = 0x9100,
    D3D_FEATURE_LEVEL_9_2       = 0x9200,
    D3D_FEATURE_LEVEL_9_3       = 0x9300,
    D3D_FEATURE_LEVEL_10_0      = 0xa000,
    D3D_FEATURE_LEVEL_10_1      = 0xa100,
    D3D_FEATURE_LEVEL_11_0      = 0xb000,
    D3D_FEATURE_LEVEL_11_1      = 0xb100,
    D3D_FEATURE_LEVEL_12_0      = 0xc000,
    D3D_FEATURE_LEVEL_12_1      = 0xc100,
}

enum Dx_D3D_PRIMITIVE_TOPOLOGY : const
{
    UNDEFINED	= 0,
    POINTLIST	= 1,
    LINELIST	= 2,
    LINESTRIP	= 3,
    TRIANGLELIST	= 4,
    TRIANGLESTRIP	= 5,
    TRIANGLEFAN	= 6,
    LINELIST_ADJ	= 10,
    LINESTRIP_ADJ	= 11,
    TRIANGLELIST_ADJ	= 12,
    TRIANGLESTRIP_ADJ	= 13,
    N2_CONTROL_POINT_PATCHLIST	= 34,
    N3_CONTROL_POINT_PATCHLIST	= 35,
    N4_CONTROL_POINT_PATCHLIST	= 36,
    N5_CONTROL_POINT_PATCHLIST	= 37,
    N6_CONTROL_POINT_PATCHLIST	= 38,
    N7_CONTROL_POINT_PATCHLIST	= 39,
    N8_CONTROL_POINT_PATCHLIST	= 40,
    N9_CONTROL_POINT_PATCHLIST	= 41,
    N10_CONTROL_POINT_PATCHLIST	= 42,
    N11_CONTROL_POINT_PATCHLIST	= 43,
    N12_CONTROL_POINT_PATCHLIST	= 44,
    N13_CONTROL_POINT_PATCHLIST	= 45,
    N14_CONTROL_POINT_PATCHLIST	= 46,
    N15_CONTROL_POINT_PATCHLIST	= 47,
    N16_CONTROL_POINT_PATCHLIST	= 48,
    N17_CONTROL_POINT_PATCHLIST	= 49,
    N18_CONTROL_POINT_PATCHLIST	= 50,
    N19_CONTROL_POINT_PATCHLIST	= 51,
    N20_CONTROL_POINT_PATCHLIST	= 52,
    N21_CONTROL_POINT_PATCHLIST	= 53,
    N22_CONTROL_POINT_PATCHLIST	= 54,
    N23_CONTROL_POINT_PATCHLIST	= 55,
    N24_CONTROL_POINT_PATCHLIST	= 56,
    N25_CONTROL_POINT_PATCHLIST	= 57,
    N26_CONTROL_POINT_PATCHLIST	= 58,
    N27_CONTROL_POINT_PATCHLIST	= 59,
    N28_CONTROL_POINT_PATCHLIST	= 60,
    N29_CONTROL_POINT_PATCHLIST	= 61,
    N30_CONTROL_POINT_PATCHLIST	= 62,
    N31_CONTROL_POINT_PATCHLIST	= 63,
    N32_CONTROL_POINT_PATCHLIST	= 64,
}

enum Dx_D3D_PRIMITIVE : const
{
    UNDEFINED	= 0,
    POINT	= 1,
    LINE	= 2,
    TRIANGLE	= 3,
    LINE_ADJ	= 6,
    TRIANGLE_ADJ	= 7,
    N1_CONTROL_POINT_PATCH	= 8,
    N2_CONTROL_POINT_PATCH	= 9,
    N3_CONTROL_POINT_PATCH	= 10,
    N4_CONTROL_POINT_PATCH	= 11,
    N5_CONTROL_POINT_PATCH	= 12,
    N6_CONTROL_POINT_PATCH	= 13,
    N7_CONTROL_POINT_PATCH	= 14,
    N8_CONTROL_POINT_PATCH	= 15,
    N9_CONTROL_POINT_PATCH	= 16,
    N10_CONTROL_POINT_PATCH	= 17,
    N11_CONTROL_POINT_PATCH	= 18,
    N12_CONTROL_POINT_PATCH	= 19,
    N13_CONTROL_POINT_PATCH	= 20,
    N14_CONTROL_POINT_PATCH	= 21,
    N15_CONTROL_POINT_PATCH	= 22,
    N16_CONTROL_POINT_PATCH	= 23,
    N17_CONTROL_POINT_PATCH	= 24,
    N18_CONTROL_POINT_PATCH	= 25,
    N19_CONTROL_POINT_PATCH	= 26,
    N20_CONTROL_POINT_PATCH	= 27,
    N21_CONTROL_POINT_PATCH	= 28,
    N22_CONTROL_POINT_PATCH	= 29,
    N23_CONTROL_POINT_PATCH	= 30,
    N24_CONTROL_POINT_PATCH	= 31,
    N25_CONTROL_POINT_PATCH	= 32,
    N26_CONTROL_POINT_PATCH	= 33,
    N27_CONTROL_POINT_PATCH	= 34,
    N28_CONTROL_POINT_PATCH	= 35,
    N29_CONTROL_POINT_PATCH	= 36,
    N30_CONTROL_POINT_PATCH	= 37,
    N31_CONTROL_POINT_PATCH	= 38,
    N32_CONTROL_POINT_PATCH	= 39,
}

////////////////////////////////////////////////////////////////////////////////
// Vtbl function interfaces
////////////////////////////////////////////////////////////////////////////////

alias GetBufferPointer = fn void*(void*);
alias GetBufferSize = fn Win32_SIZE_T(void*);

////////////////////////////////////////////////////////////////////////////////
// Interfaces
////////////////////////////////////////////////////////////////////////////////

struct ID3DBlobVtbl
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;

    GetBufferPointer get_buffer_pointer;
    GetBufferSize get_buffer_size;
}
struct ID3DBlob
{
    ID3DBlobVtbl* vtbl;
}

fn void*? ID3DBlob.query_interface(&self, Win32_REFIID riid) => query_interface_helper(self, self.vtbl.query_interface, riid);
fn Win32_ULONG ID3DBlob.add_ref(&self) => self.vtbl.add_ref(self);
fn Win32_ULONG ID3DBlob.release(&self) => self.vtbl.release(self);

fn void* ID3DBlob.get_buffer_pointer(&self) => self.vtbl.get_buffer_pointer(self);
fn Win32_SIZE_T ID3DBlob.get_buffer_size(&self) => self.vtbl.get_buffer_size(self);

fn char[] ID3DBlob.get_buffer(&self)
{
    Win32_SIZE_T size = self.get_buffer_size();
    char[] buffer = mem::new_array(char, size);
    if (size != 0) mem::copy(&buffer[0], self.get_buffer_pointer(), size);
    return buffer;
}

extern fn Win32_HRESULT d3dCreateBlob(Win32_SIZE_T size, ID3DBlob** blob) @extern("D3DCreateBlob");

fn ID3DBlob*? create_blob(Win32_SIZE_T size)
{
    ID3DBlob* blob;
    Win32_HRESULT hr = d3dCreateBlob(size, &blob);
    if (hr != S_OK) check_hresult(hr)!;
    return blob;
}