module dxgi;

import std::os::win32;

////////////////////////////////////////////////////////////////////////////////
// Enums and Plain structs
////////////////////////////////////////////////////////////////////////////////

enum Dx_DXGI_GPU_PREFERENCE : const inline CInt
{
    UNSPECIFIED,
    MINIMUM_POWER,
    HIGH_PERFORMANCE,
}

enum Dx_DXGI_MODE_SCANLINE_ORDER : const inline CInt
{
    UNSPECIFIED,
    PROGRESSIVE,
    UPPER_FIELD_FIRST,
    LOWER_FIELD_FIRST,
}

enum Dx_DXGI_MODE_SCALING : const inline CInt
{
    UNSPECIFIED,
    CENTERED,
    STRETCHED,
}

enum Dx_DXGI_MODE_ROTATION : const inline CInt
{
    UNSPECIFIED,
    IDENTITY,
    ROTATE90,
    ROTATE180,
    ROTATE270,
}

enum Dx_DXGI_ADAPTER_FLAG : const inline uint
{
    NONE,
    SOFTWARE,
    UNSUPPORTED,
}

struct Dx_DXGI_FRAME_STATISTICS
{
    Win32_UINT present_count;
    Win32_UINT present_refresh_count;
    Win32_UINT sync_refresh_count;
    Win32_LARGE_INTEGER sync_qpc_time;
    Win32_LARGE_INTEGER sync_gpu_time;
}

struct Dx_DXGI_MAPPED_RECT
{
    Win32_INT pitch;
    Win32_BYTE* bits;
}

struct Dx_DXGI_ADAPTER_DESC
{
    Win32_WCHAR[128] description; // Wide string
    Win32_UINT vendor_id;
    Win32_UINT device_id;
    Win32_UINT sub_sys_id;
    Win32_UINT revision;
    Win32_SIZE_T dedicated_video_memory;
    Win32_SIZE_T dedicated_system_memory;
    Win32_SIZE_T shared_system_memory;
    Win32_LUID adapter_luid;
}

struct Dx_DXGI_ADAPTER_DESC1
{
    Win32_WCHAR[128] description; // Wide string
    Win32_UINT vendor_id;
    Win32_UINT device_id;
    Win32_UINT sub_sys_id;
    Win32_UINT revision;
    Win32_SIZE_T dedicated_video_memory;
    Win32_SIZE_T dedicated_system_memory;
    Win32_SIZE_T shared_system_memory;
    Win32_LUID adapter_luid;
    Dx_DXGI_ADAPTER_FLAG flags;
}

struct Dx_DXGI_OUTPUT_DESC
{
    Win32_WCHAR[32] device_name;
    Win32_RECT desktop_coordinates;
    Win32_BOOL attached_to_desktop;
    Dx_DXGI_MODE_ROTATION rotation;
    Win32_HMONITOR monitor;
}

struct Dx_DXGI_RGB
{
    float red;
    float green;
    float blue;
}

struct Dx_DXGI_RGBA
{
    float r;
    float g;
    float b;
    float a;
}
alias Dx_D3DCOLORVALUE = Dx_DXGI_RGBA;

struct Dx_DXGI_GAMMA_CONTROL
{
    Dx_DXGI_RGB scale;
    Dx_DXGI_RGB offset;
    Dx_DXGI_RGB[1025] gamma_curve;
}

struct Dx_DXGI_GAMMA_CONTROL_CAPABILITIES
{
    Win32_BOOL scale_and_offset_supported;
    float max_converted_value;
    float min_converted_value;
    Win32_UINT num_gamma_control_points;
    float[1025] control_point_positions;
}

struct Dx_DXGI_MODE_DESC
{
    Win32_UINT width;
    Win32_UINT height;
    Dx_DXGI_RATIONAL refresh_rate;
    Dx_DXGI_FORMAT format;
    Dx_DXGI_MODE_SCANLINE_ORDER scanline_ordering;
    Dx_DXGI_MODE_SCALING scaling;
}

struct Dx_DXGI_JPEG_DC_HUFFMAN_TABLE
{
    Win32_BYTE[12] code_counts;
    Win32_BYTE[12] code_values;
}

struct Dx_DXGI_JPEG_AC_HUFFMAN_TABLE
{
    Win32_BYTE[16] code_counts;
    Win32_BYTE[162] code_values;
}

struct Dx_DXGI_JPEG_QUANTIZATION_TABLE
{
    Win32_BYTE[64] elements;
}

enum Dx_DXGI_RESIDENCY : const inline CInt
{
    FULLY_RESIDENT = 1,
    RESIDENT_IN_SHARED_MEMORY = 2,
    NOT_RESIDENT = 3,
}

struct Dx_DXGI_SURFACE_DESC
{
    Win32_UINT width;
    Win32_UINT height;
    Dx_DXGI_FORMAT format;
    Dx_DXGI_SAMPLE_DESC sample_desc;
}

enum Dx_DXGI_SWAP_EFFECT : const inline CInt
{
    DISCARD = 0,
    SEQUENTIAL = 1,
    FLIP_SEQUENTIAL = 3,
    FLIP_DISCARD = 4,
}

bitstruct Dx_DXGI_SWAP_CHAIN_FLAG : CInt
{
    bool nonprerotated;
    bool allow_mode_switch;
    bool gdi_compatible;
    bool restricted_content;
    bool restrict_shared_resource_driver;
    bool display_only;
    bool frame_latency_waitable_object;
    bool foreground_layer;
    bool fullscreen_video;
    bool yuv_video;
    bool hw_protected;
    bool restricted_to_all_holographic_displays;
}
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_NONPREROTATED = { .nonprerotated };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH = { .allow_mode_switch };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE = { .gdi_compatible };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT = { .restricted_content };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER = { .restrict_shared_resource_driver };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY = { .display_only };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT = { .frame_latency_waitable_object };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER = { .foreground_layer };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO = { .fullscreen_video };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO = { .yuv_video };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED = { .hw_protected };
const Dx_DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS = { .restricted_to_all_holographic_displays };

enum Dx_DXGI_USAGE : const inline Win32_UINT
{
    SHADER_INPUT = 0x00000010,
    RENDER_TARGET_OUTPUT = 0x00000020,
    BACK_BUFFER = 0x00000040,
    SHARED = 0x00000080,
    READ_ONLY = 0x00000100,
    DISCARD_ON_PRESENT = 0x00000200,
    UNORDERED_ACCESS = 0x00000400,
}

struct Dx_DXGI_SWAP_CHAIN_DESC
{
    Dx_DXGI_MODE_DESC buffer_desc;
    Dx_DXGI_SAMPLE_DESC sample_desc;
    Dx_DXGI_USAGE buffer_usage;
    Win32_UINT buffer_count;
    Win32_HWND output_window;
    Win32_BOOL windowed;
    Dx_DXGI_SWAP_EFFECT swap_effect;
    Win32_UINT flags;
}

struct Dx_DXGI_DISPLAY_COLOR_SPACE
{
    float[8][2] primary_coordinates;
    float[16][2] white_points;
}

struct Dx_DXGI_OUTDUPL_MOVE_RECT
{
    Win32_POINT source_point;
    Win32_RECT destination_rect;
}

struct Dx_DXGI_OUTDUPL_DESC
{
    Dx_DXGI_MODE_DESC mode_desc;
    Dx_DXGI_MODE_ROTATION rotation;
    Win32_BOOL desktop_image_in_system_memory;
}

struct Dx_DXGI_OUTDUPL_POINTER_POSITION
{
    Win32_POINT position;
    Win32_BOOL visible;
}

bitstruct Dx_DXGI_OUTDUPL_POINTER_SHAPE_TYPE : CInt
{
    bool monochrome;
    bool color;
    bool masked_color;
}
const Dx_DXGI_OUTDUPL_POINTER_SHAPE_TYPE DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME = { .monochrome };
const Dx_DXGI_OUTDUPL_POINTER_SHAPE_TYPE DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR = { .color };
const Dx_DXGI_OUTDUPL_POINTER_SHAPE_TYPE DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR = { .masked_color };

struct Dx_DXGI_OUTDUPL_POINTER_SHAPE_INFO
{
    Win32_UINT type;
    Win32_UINT width;
    Win32_UINT height;
    Win32_UINT pitch;
    Win32_POINT hot_spot;
}

struct Dx_DXGI_OUTDUPL_FRAME_INFO
{
    Win32_LARGE_INTEGER lastPresentTime;
    Win32_LARGE_INTEGER lastMouseUpdateTime;
    Win32_UINT accumulatedFrames;
    Win32_BOOL rectsCoalesced;
    Win32_BOOL protectedContentMaskedOut;
    Dx_DXGI_OUTDUPL_POINTER_POSITION pointerPosition;
    Win32_UINT totalMetadataBufferSize;
    Win32_UINT pointerShapeBufferSize;
}

enum Dx_DXGI_ALPHA_MODE : const inline CInt
{
    UNSPECIFIED = 0,
    PREMULTIPLIED = 1,
    STRAIGHT = 2,
    IGNORE = 3,
}

enum Dx_DXGI_OFFER_RESOURCE_PRIORITY : const inline CInt
{
    LOW = 1,
    NORMAL = 2,
    HIGH = 3,
}

struct Dx_DXGI_MODE_DESC1
{
    Win32_UINT width;
    Win32_UINT height;
    Dx_DXGI_RATIONAL refresh_rate;
    Dx_DXGI_FORMAT format;
    Dx_DXGI_MODE_SCANLINE_ORDER scanline_ordering;
    Dx_DXGI_MODE_SCALING scaling;
    Win32_BOOL stereo;
}

enum Dx_DXGI_SCALING : const inline CInt
{
    STRETCH = 0,
    NONE = 1,
    ASPECT_RATIO_STRETCH = 2,
}

struct Dx_DXGI_SWAP_CHAIN_DESC1
{
    Win32_UINT width;
    Win32_UINT height;
    Dx_DXGI_FORMAT format;
    Win32_BOOL stereo;
    Dx_DXGI_SAMPLE_DESC sample_desc;
    Dx_DXGI_USAGE buffer_usage;
    Win32_UINT buffer_count;
    Dx_DXGI_SCALING scaling;
    Dx_DXGI_SWAP_EFFECT swap_effect;
    Dx_DXGI_ALPHA_MODE alpha_mode;
    Win32_UINT flags;
}

struct Dx_DXGI_SWAP_CHAIN_FULLSCREEN_DESC
{
    Dx_DXGI_RATIONAL refresh_rate;
    Dx_DXGI_MODE_SCANLINE_ORDER scanline_ordering;
    Dx_DXGI_MODE_SCALING scaling;
    Win32_BOOL windowed;
}

struct Dx_DXGI_PRESENT_PARAMETERS
{
    Win32_UINT dirty_rects_count;
    Win32_RECT* dirty_rects;
    Win32_RECT* scroll_rects;
    Win32_POINT* scroll_offset;
}

enum Dx_DXGI_GRAPHICS_PREEMPTION_GRANULARITY : const inline CInt
{
    DMA_BUFFER_BOUNDARY = 0,
    PRIMITIVE_BOUNDARY = 1,
    TRIANGLE_BOUNDARY = 2,
    PIXEL_BOUNDARY = 3,
    INSTRUCTION_BOUNDARY = 4
}

enum Dx_DXGI_COMPUTE_PREEMPTION_GRANULARITY : const inline CInt
{
    DMA_BUFFER_BOUNDARY = 0,
    DISPATCH_BOUNDARY = 1,
    THREAD_GROUP_BOUNDARY = 2,
    THREAD_BOUNDARY = 3,
    INSTRUCTION_BOUNDARY = 4
}

struct Dx_DXGI_ADAPTER_DESC2
{
    Win32_WCHAR[128] description;
    Win32_UINT vendor_id;
    Win32_UINT device_id;
    Win32_UINT sub_sys_id;
    Win32_UINT revision;
    Win32_SIZE_T dedicated_video_memory;
    Win32_SIZE_T dedicated_system_memory;
    Win32_SIZE_T shared_system_memory;
    Win32_LUID adapter_luid;
    Dx_DXGI_ADAPTER_FLAG flags;
    Dx_DXGI_GRAPHICS_PREEMPTION_GRANULARITY graphics_preemption_granularity;
    Dx_DXGI_COMPUTE_PREEMPTION_GRANULARITY compute_preemption_granularity;
}

struct Dx_DXGI_MATRIX_3X2_F
{
    float m11;
    float m12;
    float m21;
    float m22;
    float m31;
    float m32;
}

struct Dx_DXGI_DECODE_SWAP_CHAIN_DESC
{
    Win32_UINT flags;
}

enum Dx_DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS : const inline CInt
{
    NOMINAL_RANGE = 0x1,
    BT709 = 0x2,
    XVYCC709 = 0x4,
}

struct Dx_DXGI_SHARED_RESOURCE
{
    Win32_HANDLE handle;
}

enum Dx_DXGI_FRAME_PRESENTATION_MODE : const inline CInt
{
    COMPOSED = 0,
    OVERLAY = 1,
    NONE = 2,
    COMPOSITION_FAILURE = 3
}

struct Dx_DXGI_FRAME_STATISTICS_MEDIA
{
    Win32_UINT present_count;
    Win32_UINT present_refresh_count;
    Win32_UINT sync_refresh_count;
    Win32_LARGE_INTEGER sync_qpc_time;
    Win32_LARGE_INTEGER sync_gpu_time;
    Dx_DXGI_FRAME_PRESENTATION_MODE composition_mode;
    Win32_UINT approved_present_duration;
}

enum Dx_DXGI_OVERLAY_SUPPORT_FLAG : const inline CInt
{
    DIRECT = 0x1,
    SCALING = 0x2
}

enum Dx_DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG : const inline CInt
{
    PRESENT = 0x1,
    OVERLAY_PRESENT = 0x2,
}

bitstruct Dx_DXGI_MWA : Win32_UINT
{
    bool no_window_changes;
    bool no_alt_enter;
    bool no_print_screen;
}
const Dx_DXGI_MWA DXGI_MWA_NO_WINDOW_CHANGES = { .no_window_changes };
const Dx_DXGI_MWA DXGI_MWA_NO_ALT_ENTER = { .no_alt_enter };
const Dx_DXGI_MWA DXGI_MWA_NO_PRINT_SCREEN = { .no_print_screen };

enum Dx_DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG : const inline CInt
{
    PRESENT = 0x1,
}

enum Dx_DXGI_MEMORY_SEGMENT_GROUP : const inline CInt
{
    LOCAL = 0,
    NON_LOCAL = 1
}

struct Dx_DXGI_QUERY_VIDEO_MEMORY_INFO
{
    Win32_UINT64 budget;
    Win32_UINT64 current_usage;
    Win32_UINT64 available_for_reservation;
    Win32_UINT64 current_reservation;
}

enum Dx_DXGI_HDR_METADATA_TYPE : const inline CInt
{
    NONE = 0,
    HDR10 = 1,
    HDR10PLUS = 2
}

struct Dx_DXGI_HDR_METADATA_HDR10
{
    Win32_UINT16[2] redPrimary;
    Win32_UINT16[2] greenPrimary;
    Win32_UINT16[2] bluePrimary;
    Win32_UINT16[2] whitePoint;
    Win32_UINT max_mastering_luminance;
    Win32_UINT min_mastering_luminance;
    Win32_UINT16 max_content_light_level;
    Win32_UINT16 max_frame_average_light_level;
}

struct Dx_DXGI_HDR_METADATA_HDR10PLUS
{
    Win32_BYTE[72] data;
}

enum Dx_DXGI_OFFER_RESOURCE_FLAGS : const inline CInt
{
    DECOMMIT = 0x1
}

enum Dx_DXGI_RECLAIM_RESOURCE_RESULTS : const inline CInt
{
    OK = 0,
    DISCARDED = 1,
    NOT_COMMITTED = 2
}

enum Dx_DXGI_FEATURE : const inline CInt
{
    PRESENT_ALLOW_TEARING = 0
}

bitstruct Dx_DXGI_ADAPTER_FLAG3 : CInt
{
    bool remote;
    bool software;
    bool acg_compatible;
    bool support_monitored_fences;
    bool support_non_monitored_fences;
    bool keyed_mutex_conformance;
}
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_NONE = {};
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_REMOTE = { .remote };
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_SOFTWARE = { .software };
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE = { .acg_compatible };
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES = { .support_monitored_fences };
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES = { .support_non_monitored_fences };
const Dx_DXGI_ADAPTER_FLAG3 DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE = { .keyed_mutex_conformance };

struct Dx_DXGI_ADAPTER_DESC3
{
    Win32_WCHAR[128] description;
    Win32_UINT vendor_id;
    Win32_UINT device_id;
    Win32_UINT sub_sys_id;
    Win32_UINT revision;
    Win32_SIZE_T dedicated_video_memory;
    Win32_SIZE_T dedicated_system_memory;
    Win32_SIZE_T shared_system_memory;
    Win32_LUID adapter_luid;
    Dx_DXGI_ADAPTER_FLAG3 flags;
    Dx_DXGI_GRAPHICS_PREEMPTION_GRANULARITY graphics_preemption_granularity;
    Dx_DXGI_COMPUTE_PREEMPTION_GRANULARITY compute_preemption_granularity;
}

struct Dx_DXGI_OUTPUT_DESC1
{
    Win32_WCHAR[32] device_name;
    Win32_RECT desktop_coordinates;
    Win32_BOOL attached_to_desktop;
    Dx_DXGI_MODE_ROTATION rotation;
    Win32_HMONITOR monitor;
    Win32_UINT bits_per_color;
    Dx_DXGI_COLOR_SPACE_TYPE color_space;
    float[2] red_primary;
    float[2] green_primary;
    float[2] blue_primary;
    float[2] white_point;
    float min_luminance;
    float max_luminance;
    float max_full_frame_luminance;
}

bitstruct Dx_DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS : Win32_UINT
{
    bool fullscreen;
    bool windowed;
    bool cursor_stretched;
}
const Dx_DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS_FULLSCREEN = { .fullscreen };
const Dx_DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS_WINDOWED = { .windowed };
const Dx_DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS_CURSOR_STRETCHED = { .cursor_stretched };

bitstruct Dx_DXGI_PRESENT : Win32_UINT
{
    bool test : 0;
    bool do_not_sequence : 1;
    bool restart : 2;
    bool do_not_wait : 3;
    bool stereo_prefer_right : 4;
    bool stereo_temporary_mono : 5;
    bool restrict_to_output : 6;
    bool use_duration : 8;
    bool allow_tearing : 9;
}
const Dx_DXGI_PRESENT DXGI_PRESENT_NONE = { };
const Dx_DXGI_PRESENT DXGI_PRESENT_TEST = { .test };
const Dx_DXGI_PRESENT DXGI_PRESENT_DO_NOT_SEQUENCE = { .do_not_sequence };
const Dx_DXGI_PRESENT DXGI_PRESENT_RESTART = { .restart };
const Dx_DXGI_PRESENT DXGI_PRESENT_DO_NOT_WAIT = { .do_not_wait };
const Dx_DXGI_PRESENT DXGI_PRESENT_STEREO_PREFER_RIGHT = { .stereo_prefer_right };
const Dx_DXGI_PRESENT DXGI_PRESENT_STEREO_TEMPORARY_MONO = { .stereo_temporary_mono };
const Dx_DXGI_PRESENT DXGI_PRESENT_RESTRICT_TO_OUTPUT = { .restrict_to_output };
const Dx_DXGI_PRESENT DXGI_PRESENT_USE_DURATION = { .use_duration };
const Dx_DXGI_PRESENT DXGI_PRESENT_ALLOW_TEARING = { .allow_tearing };

bitstruct Dx_DXGI_DEBUG_RLO_FLAGS : CInt
{
    bool summary;
    bool detail;
    bool ignore_internal;
}
const Dx_DXGI_DEBUG_RLO_FLAGS DXGI_DEBUG_RLO_SUMMARY = { .summary };
const Dx_DXGI_DEBUG_RLO_FLAGS DXGI_DEBUG_RLO_DETAIL = { .detail };
const Dx_DXGI_DEBUG_RLO_FLAGS DXGI_DEBUG_RLO_IGNORE_INTERNAL = { .ignore_internal };