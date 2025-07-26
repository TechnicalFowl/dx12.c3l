module d3d12;

import std::io;
import std::os::win32;

const Win32_HRESULT S_OK = 0x00000000;
const Win32_HRESULT S_FALSE = 0x00000001;

const Win32_HRESULT E_NOTIMPL_ = (int) 0x80000001; 
const Win32_HRESULT E_OUTOFMEMORY_ = (int) 0x80000002; 
const Win32_HRESULT E_INVALIDARG_ = (int) 0x80000003; 
const Win32_HRESULT E_NOINTERFACE_ = (int) 0x80000004; 
const Win32_HRESULT E_POINTER_ = (int) 0x80000005; 
const Win32_HRESULT E_HANDLE_ = (int) 0x80000006;
const Win32_HRESULT E_ABORT_ = (int) 0x80000007;
const Win32_HRESULT E_FAIL_ = (int) 0x80000008;
const Win32_HRESULT E_ACCESSDENIED_ = (int) 0x80000009;

const Win32_HRESULT E_UNEXPECTED = (int) 0x8000FFFF; faultdef UNEXPECTED;
const Win32_HRESULT E_NOTIMPL = (int) 0x80004001; faultdef NOTIMPL;
const Win32_HRESULT E_OUTOFMEMORY = (int) 0x8007000E; faultdef OUTOFMEMORY;
const Win32_HRESULT E_INVALIDARG = (int) 0x80070057; faultdef INVALIDARG;
const Win32_HRESULT E_NOINTERFACE = (int) 0x80004002; faultdef NOINTERFACE;
const Win32_HRESULT E_POINTER = (int) 0x80004003; faultdef POINTER;
const Win32_HRESULT E_HANDLE = (int) 0x80070006; faultdef HANDLE;
const Win32_HRESULT E_ABORT = (int) 0x80004004; faultdef ABORT;
const Win32_HRESULT E_FAIL = (int) 0x80004005; faultdef FAIL;
const Win32_HRESULT E_ACCESSDENIED = (int) 0x80070005; faultdef ACCESSDENIED;
const Win32_HRESULT E_FILE_NOT_FOUND = (int) 0x80070003; faultdef FILE_NOT_FOUND;

const Win32_HRESULT E_PENDING = (int) 0x8000000A; faultdef PENDING;
const Win32_HRESULT E_BAD_LENGTH = (int) 0x80070018; faultdef BAD_LENGTH;
const Win32_HRESULT E_PARTIAL_COPY = (int) 0x8007012b; faultdef PARTIAL_COPY;
const Win32_HRESULT E_NOTFOUND = (int) 0x80070490; faultdef NOTFOUND;
const Win32_HRESULT E_PDB_CORRUPT = (int) 0x806D0014; faultdef PDB_CORRUPT;

faultdef UNKNOWN_HRESULT_ERROR;

alias HRESULTFaultCallback = fn void?(Win32_HRESULT hr);
struct FaultChecker
{
    HRESULTFaultCallback checker;
    FaultChecker* next;
}
FaultChecker* g_next_checker;

fn void? check_hresult(Win32_HRESULT hr)
{
    if (hr >= 0) return; // S_OK or S_FALSE, no error
    switch (hr)
    {
    case E_NOTIMPL: return NOTIMPL?;
    case E_NOTIMPL_: return NOTIMPL?;
    case E_NOINTERFACE: return NOINTERFACE?;
    case E_NOINTERFACE_: return NOINTERFACE?;
    case E_POINTER: return POINTER?;
    case E_POINTER_: return POINTER?;
    case E_ABORT: return ABORT?;
    case E_ABORT_: return ABORT?;
    case E_FAIL: return FAIL?;
    case E_FAIL_: return FAIL?;
    case E_UNEXPECTED: return UNEXPECTED?;
    case E_ACCESSDENIED: return ACCESSDENIED?;
    case E_ACCESSDENIED_: return ACCESSDENIED?;
    case E_FILE_NOT_FOUND: return FILE_NOT_FOUND?;
    case E_HANDLE: return HANDLE?;
    case E_HANDLE_: return HANDLE?;
    case E_OUTOFMEMORY: return OUTOFMEMORY?;
    case E_OUTOFMEMORY_: return OUTOFMEMORY?;
    case E_INVALIDARG: return INVALIDARG?;
    case E_INVALIDARG_: return INVALIDARG?;
    case E_PENDING: return PENDING?;
    case E_BAD_LENGTH: return BAD_LENGTH?;
    case E_PARTIAL_COPY: return PARTIAL_COPY?;
    case E_PDB_CORRUPT: return PDB_CORRUPT?;
    case E_NOTFOUND: return NOTFOUND?;
    default:
        break;
    }
    FaultChecker* check = g_next_checker;
    while (check)
    {
        check.checker(hr)!;
        check = check.next;
    }
    io::printfn("Unknown Win32 error code %X was encountered.", (uint)hr);
    return UNKNOWN_HRESULT_ERROR?;
}
