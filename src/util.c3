module d3d12;

extern fn bool isDebuggerPresent() @extern("IsDebuggerPresent") @if(env::WIN32);

fn void waitForDebugger()
{
$if env::WIN32:
    while (!isDebuggerPresent())
    {
        // Wait for the debugger to attach
    }
$else
    int wait_for_debugger = 1;
    while (@volatile_load(wait_for_debugger))
    {
        // Wait for the debugger to attach
    }
$endif
}

struct ExceptionPointers
{
    ExceptionRecord* exception_record;
    ExceptionContext* context_record;
}

struct ExceptionRecord
{
    uint code;
    uint flags;
    void* record;
    void* address;
    uint number_parameters;
    ulong[15] exception_information; // 15 is the maximum number of parameters for exceptions
}

struct ExceptionContext
{
    ulong p1_home;
    ulong p2_home;
    ulong p3_home;
    ulong p4_home;
    ulong p5_home;
    ulong p6_home;
    uint context_flags;
    uint mx_csr;
    ushort seg_cs;
    ushort seg_ds;
    ushort seg_es;
    ushort seg_fs;
    ushort seg_gs;
    ushort seg_ss;
    uint eflags;
    ulong dr0;
    ulong dr1;
    ulong dr2;
    ulong dr3;
    ulong dr6;
    ulong dr7;
    ulong rax;
    ulong rcx;
    ulong rdx;
    ulong rbx;
    ulong rsp;
    ulong rbp;
    ulong rsi;
    ulong rdi;
    ulong r8;
    ulong r9;
    ulong r10;
    ulong r11;
    ulong r12;
    ulong r13;
    ulong r14;
    ulong r15;
    union
    {
        ulong[32] d;
        struct
        {
            int128[2] header;
            int128[8] legacy;
            int128 xmm0;
            int128 xmm1;
            int128 xmm2;
            int128 xmm3;
            int128 xmm4;
            int128 xmm5;
            int128 xmm6;
            int128 xmm7;
            int128 xmm8;
            int128 xmm9;
            int128 xmm10;
            int128 xmm11;
            int128 xmm12;
            int128 xmm13;
            int128 xmm14;
            int128 xmm15;
        }
    }
    int128[26] vector_registers;
    ulong vector_control;
    ulong debug_control;
    ulong last_branch_to_rip;
    ulong last_branch_from_rip;
    ulong last_exception_to_rip;
    ulong last_exception_from_rip;
}

alias UnhandledExceptionFilter = fn int (ExceptionPointers* exception_info);
UnhandledExceptionFilter g_previous_filter;
PanicFn g_previous_panic;
bool g_has_panicked;
extern fn UnhandledExceptionFilter setUnhandledExceptionFilter(UnhandledExceptionFilter filter) @extern("SetUnhandledExceptionFilter") @if(env::WIN32);
const EXCEPTION_EXECUTE_HANDLER = 1;

fn int exceptionHandler(ExceptionPointers* exception_info)
{
    if (!g_has_panicked)
    {
        @stack_mem(512; Allocator allocator)
        {
            DString s;
            s.init(allocator: allocator);
            uint code = exception_info.exception_record.code;
            void* addr = exception_info.exception_record.address;
            switch (code)
            {
            case 0x80000001: s.appendf("Guard page violation at address %p", addr);
            case 0x80000002: s.appendf("Datatype misalignment at address %p", addr);
            case 0xC0000005: s.appendf("Access Violation at address %p", addr);
            case 0xC0000006: s.appendf("In page error at address %p", addr);
            case 0xC000001D: s.appendf("Illegal instruction at address %p", addr);
            case 0xC000008C: s.appendf("Array bounds exceeded at address %p", addr);
            case 0xC000008D: s.appendf("Flt denormal operand at address %p", addr);
            case 0xC000008E: s.appendf("Flt divide by zero at address %p", addr);
            case 0xC0000090: s.appendf("Flt invalid operation at address %p", addr);
            case 0xC0000094: s.appendf("Integer divide by zero at address %p", addr);
            case 0xC00000FD: s.appendf("Stack overflow at address %p", addr);
            case 0xC0000096: s.appendf("Privileged instruction at address %p", addr);
            case 0xC0000374: s.appendf("Heap corruption detected at address %p", addr);
            case 0xC0000409: s.appendf("Stack buffer overflow at address %p", addr);
            case 0xC00004A2: s.appendf("Enclave violation at address %p", addr);
            default:
                s.appendf("Unhandled exception (%X) at %p", code, addr);
            }
            builtin::print_backtrace(s.str_view(), 8);
        };
    }
    if (g_previous_filter)
    {
        return g_previous_filter(exception_info);
    }
    return EXCEPTION_EXECUTE_HANDLER;
}

fn void panic_tracker(String message, String file, String function, uint line)
{
    g_has_panicked = true;
    g_previous_panic(message, file, function, line);
}

fn void initExceptionHandler() @init
{
$if env::WIN32:
    g_previous_filter = setUnhandledExceptionFilter(&exceptionHandler);
    g_previous_panic = builtin::panic;
    builtin::panic = &panic_tracker;
$endif
}