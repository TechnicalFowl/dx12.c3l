module d3d12;

import std::os::win32;

////////////////////////////////////////////////////////////////////////////////
// Vtbl function interfaces
////////////////////////////////////////////////////////////////////////////////

alias IUnknownRaw = void;

// IUnknown
alias QueryInterface = fn Win32_HRESULT(void*, Win32_REFIID, void**);
alias AddRef = fn Win32_ULONG(void*);
alias Release = fn Win32_ULONG(void*);
alias SetPrivateData = fn Win32_HRESULT(void*, Win32_REFIID, Win32_UINT, void*);
alias SetPrivateDataInterface = fn Win32_HRESULT(void*, Win32_REFIID, IUnknownRaw*);
alias GetPrivateData = fn Win32_HRESULT(void*, Win32_REFIID, Win32_UINT*, void*);
alias GetParent = fn Win32_HRESULT(void*, Win32_REFIID, void**);

////////////////////////////////////////////////////////////////////////////////
// Loose Functions
////////////////////////////////////////////////////////////////////////////////

struct IUnknownVtbl @private
{
    QueryInterface query_interface;
    AddRef add_ref;
    Release release;
}

interface IUnknown
{
    fn void* get_com_ptr();
    fn void*? query_interface(Win32_REFIID riid);
    fn Win32_ULONG add_ref();
    fn Win32_ULONG release();
}

fn void*? query_interface_helper(void* this, QueryInterface func, Win32_REFIID id)
{
    void* result;
    Win32_HRESULT hr = func(this, id, &result);
    check_hresult(hr)!;
    return result;
}

fn void? set_private_data_helper(void* this, SetPrivateData func, Win32_REFIID id, Win32_UINT size, void* data)
{
    Win32_HRESULT hr = func(this, id, size, data);
    check_hresult(hr)!;
}

fn void? set_private_data_interface_helper(void* this, SetPrivateDataInterface func, Win32_REFIID id, void* data)
{
    Win32_HRESULT hr = func(this, id, data);
    check_hresult(hr)!;
}

fn void? get_private_data_helper(void* this, GetPrivateData func, Win32_REFIID id, Win32_UINT* size, void* data)
{
    // Note: This will increment the reference count of the returned object
    Win32_HRESULT hr = func(this, id, size, data);
    check_hresult(hr)!;
}

fn void*? get_parent_helper(void* this, GetParent func, Win32_REFIID id)
{
    void* result;
    Win32_HRESULT hr = func(this, id, &result);
    check_hresult(hr)!;
    return result;
}

macro @safe_release(#var)
{
    if (#var != null)
    {
        #var.release();
        #var = null;
    }
}
