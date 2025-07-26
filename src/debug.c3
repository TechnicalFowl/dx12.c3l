module d3d12;

import std::io;
import std::os::win32;
import std::thread;

extern fn void outputDebugString(ZString message) @extern("OutputDebugStringA");

fn void message_callback(Dx_D3D12_MESSAGE_CATEGORY category, Dx_D3D12_MESSAGE_SEVERITY sev, Dx_D3D12_MESSAGE_ID id, Win32_LPCSTR description, void* ctx)
{
    log_trace("[%s] %s: %s : %s", Dx_D3D12_MESSAGE_CATEGORY.names[category], 
              Dx_D3D12_MESSAGE_SEVERITY.names[sev],
              id.get_name(),
              description);
}

fn void enable_message_reporting(ID3D12Device device)
{
    void* info_queue = device.query_interface(&IID_ID3D12INFOQUEUE1)!!;
    ID3D12InfoQueueImpl impl;
    impl.vtbl = *(ID3D12InfoQueueVtbl**)info_queue;
    impl.raw = (ID3D12InfoQueueRaw*) info_queue;
    impl.register_message_callback(&message_callback, D3D12_MESSAGE_CALLBACK_FLAG_IGNORE_FILTERS)!!;
    impl.release();
}

macro log_error($fmt, args...)
{
    @stack_mem(512; Allocator allocator)
    {
        DString s;
        s.init(allocator: allocator);
        s.appendf("[D3D12] Error: " +++ $fmt +++ "\n", ...args);
        if (!g_dbg_thread_started) outputDebugString(s.zstr_view());
        io::eprint(s.str_view());
    };
}

macro log_warn($fmt, args...)
{
    @stack_mem(512; Allocator allocator)
    {
        DString s;
        s.init(allocator: allocator);
        s.appendf("[D3D12] Warning: " +++ $fmt +++ "\n", ...args);
        if (!g_dbg_thread_started) outputDebugString(s.zstr_view());
        io::eprint(s.str_view());
    };
}

macro log_info($fmt, args...)
{
    @stack_mem(512; Allocator allocator)
    {
        DString s;
        s.init(allocator: allocator);
        s.appendf("[D3D12] Info: " +++ $fmt +++ "\n", ...args);
        if (!g_dbg_thread_started) outputDebugString(s.zstr_view());
        io::eprint(s.str_view());
    };
}

macro log_debug($fmt, args...)
{
    @stack_mem(512; Allocator allocator)
    {
        DString s;
        s.init(allocator: allocator);
        s.appendf("[D3D12] Debug: " +++ $fmt +++ "\n", ...args);
        if (!g_dbg_thread_started) outputDebugString(s.zstr_view());
        io::eprint(s.str_view());
    };
}

macro log_trace($fmt, args...)
{
    @stack_mem(512; Allocator allocator)
    {
        DString s;
        s.init(allocator: allocator);
        s.appendf("[D3D12] Trace: " +++ $fmt +++ "\n", ...args);
        if (!g_dbg_thread_started) outputDebugString(s.zstr_view());
        io::eprint(s.str_view());
    };
}

struct DBWinBuffer
{
    Win32_DWORD process_id;
    char[4092] data;
}

extern fn Win32_HANDLE openEventA(Win32_DWORD, Win32_BOOL, Win32_LPCSTR) @extern("OpenEventA");
extern fn Win32_HANDLE openFileMappingA(Win32_DWORD, Win32_BOOL, Win32_LPCSTR) @extern("OpenFileMappingA");
extern fn Win32_HANDLE createFileMappingA(Win32_HANDLE, Win32_LPSECURITY_ATTRIBUTES, Win32_DWORD, Win32_DWORD, Win32_DWORD, Win32_LPCSTR) @extern("CreateFileMappingA");
extern fn void* mapViewOfFile(Win32_HANDLE, Win32_DWORD, Win32_DWORD, Win32_DWORD, Win32_SIZE_T) @extern("MapViewOfFile");
extern fn Win32_BOOL unmapViewOfFile(void* lpBaseAddress) @extern("UnmapViewOfFile");
const EVENT_ALL_ACCESS = 0x1F0003;
const FILE_MAP_READ = 0x0004;
const PAGE_READWRITE = 0x04;

Win32_HANDLE g_data_ready;

fn int debug_output_thread(void* ctx)
{
    Win32_HANDLE buffer_ready = win32::createEventA(null, 0, 0, "DBWIN_BUFFER_READY");
    assert(buffer_ready != null, "Failed to create DBWIN_BUFFER_READY event");
    g_data_ready = win32::createEventA(null, 0, 0, "DBWIN_DATA_READY");
    assert(g_data_ready != null, "Failed to create DBWIN_DATA_READY event");
    Win32_HANDLE buffer = createFileMappingA(win32::INVALID_HANDLE_VALUE, null, PAGE_READWRITE, 0, 4096, "DBWIN_BUFFER");
    assert(buffer != null, "Failed to open DBWIN_BUFFER file mapping");
    DBWinBuffer* dbwin_buffer = mapViewOfFile(buffer, FILE_MAP_READ, 0, 0, 0);
    assert(dbwin_buffer != null, "Failed to map DBWIN_BUFFER view");

    Win32_DWORD proc_id = win32::getCurrentProcessId();
    win32::setEvent(buffer_ready);

    while (true)
    {
        Win32_DWORD ret = win32::waitForSingleObject(g_data_ready, win32::INFINITE);
        if (!g_dbg_thread_started) break;
        if (ret == win32::WAIT_OBJECT_0)
        {
            if (dbwin_buffer.process_id == proc_id)
            {
                ZString zstr = (ZString) &dbwin_buffer.data[0];
                io::eprintf("%s", zstr);
            }
            win32::setEvent(buffer_ready); // Signal that we have processed the data
        }
    }
    unmapViewOfFile(dbwin_buffer);
    win32::closeHandle(buffer);
    win32::closeHandle(buffer_ready);
    win32::closeHandle(g_data_ready);
    g_data_ready = null;
    return 0;
}

Thread g_dbg_thread;
bool g_dbg_thread_started = false;

fn void start_debug_output_listener()
{
    if (isDebuggerPresent()) return; // If a debugger is present, we don't need to start the listener

    g_dbg_thread_started = true;
    g_dbg_thread.create(&debug_output_thread, null)!!;
}

fn void shutdown_debug_output_listener() @finalizer
{
    g_dbg_thread_started = false;
    if (g_data_ready) win32::setEvent(g_data_ready);
}