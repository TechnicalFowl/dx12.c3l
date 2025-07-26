module d3dcompile;

import std::os::win32;
import d3d12;

bitstruct D3DCompileFlags : Win32_UINT {
    bool debug : 0;
    bool skip_validation : 1;
    bool skip_optimization : 2;
    bool pack_matrix_row_major : 3;
    bool pack_matrix_column_major : 4;
    bool partial_precision : 5;
    bool force_vs_software_no_opt : 6;
    bool force_ps_software_no_opt : 7;
    bool no_preshader : 8;
    bool avoid_flow_control : 9;
    bool prefer_flow_control : 10;
    bool enable_strictness : 11;
    bool enable_backwards_compatibility : 12;
    bool ieee_strictness : 13;
    char optimization_level : 14..15;
    bool warnings_are_errors : 18;
    bool resources_may_alias : 19;
    bool enable_unbounded_descriptor_tables : 20;
    bool all_resources_bound : 21;
}

bitstruct D3DCompileFlags2 : Win32_UINT
{
    bool root_signature_1_0 : 4;
    bool root_signature_1_1 : 5;
}

bitstruct D3DCompileSecDataFlags : Win32_UINT
{
    bool merge_uav_slots;
    bool preserve_template_slots;
    bool require_template_match;
}

bitstruct D3DEffectFlags : Win32_UINT
{
    bool child_effect;
    bool allow_slow_ops;
}

alias Dx_D3D_SHADER_MACRO = void;
alias ID3DInclude = void;

extern fn Win32_HRESULT d3dReadFileToBlob(Win32_LPCWSTR file_name, ID3DBlob** blob) @extern("D3DReadFileToBlob");
extern fn Win32_HRESULT d3dWriteBlobToFile(ID3DBlob* blob, Win32_LPCWSTR file_name, Win32_BOOL overwrite) @extern("D3DWriteBlobToFile");
extern fn Win32_HRESULT d3dCompile(void* src_data, Win32_SIZE_T src_data_size, Dx_D3D_SHADER_MACRO* defines,
                                ID3DInclude* include, Win32_LPCSTR entry_point, Win32_LPCSTR target,
                                D3DCompileFlags flags1, D3DCompileFlags2 flags2, ID3DBlob** code,
                                ID3DBlob** error_msgs) @extern("D3DCompile");
extern fn Win32_HRESULT d3dCompile2(void* src_data, Win32_SIZE_T src_data_size, Win32_LPCSTR source_name, Dx_D3D_SHADER_MACRO* defines,
                                ID3DInclude* include, Win32_LPCSTR entry_point, Win32_LPCSTR target,
                                D3DCompileFlags flags1, D3DCompileFlags2 flags2, D3DCompileSecDataFlags secondary_data_flags,
                                void* sec_data, Win32_SIZE_T sec_data_size,
                                ID3DBlob** code, ID3DBlob** error_msgs) @extern("D3DCompile2");
extern fn Win32_HRESULT d3dCompileFromFile(Win32_LPCWSTR file_name, Dx_D3D_SHADER_MACRO* defines,
                                       ID3DInclude* include, Win32_LPCSTR entry_point, Win32_LPCSTR target,
                                       D3DCompileFlags flags1, D3DCompileFlags2 flags2,
                                       ID3DBlob** code, ID3DBlob** error_msgs) @extern("D3DCompileFromFile");

fn char[]? compile_from_file(WString file_name, ZString entry_point, ZString target, D3DCompileFlags flags1)
{
    ID3DBlob* blob;
    ID3DBlob* error_msgs;
    Win32_HRESULT hr = d3dCompileFromFile(file_name, null, null, (Win32_LPCSTR) entry_point, (Win32_LPCSTR) target, flags1, {}, &blob, &error_msgs);
    if (hr != d3d12::S_OK) {
        if (error_msgs) {
            assert("d3d12SerializeRootSignature failed, check error_msgs");
        }
        d3d12::@safe_release(error_msgs);
        d3d12::check_hresult(hr)!;
    }
    char[] data = blob.get_buffer();
    d3d12::@safe_release(blob);
    d3d12::@safe_release(error_msgs);
    return data;
}