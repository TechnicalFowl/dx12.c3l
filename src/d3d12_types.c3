module d3d12;

import std::os::win32;
import dxgi;

////////////////////////////////////////////////////////////////////////////////
// Enums and Plain structs
////////////////////////////////////////////////////////////////////////////////

enum Dx_D3D12_COMMAND_LIST_TYPE : const inline CInt
{
    DIRECT = 0,
    BUNDLE = 1,
    COMPUTE = 2,
    COPY = 3,
    VIDEO_DECODE = 4,
    VIDEO_PROCESS = 5,
    VIDEO_ENCODE = 6,
    NONE = -1,
}

bitstruct Dx_D3D12_COMMAND_QUEUE_FLAGS : CInt
{
    bool disable_gpu_timeout;
}
const Dx_D3D12_COMMAND_QUEUE_FLAGS D3D12_COMMAND_QUEUE_FLAGS_NONE = {};
const Dx_D3D12_COMMAND_QUEUE_FLAGS D3D12_COMMAND_QUEUE_FLAG_DISABLE_GPU_TIMEOUT = { .disable_gpu_timeout };

enum Dx_D3D12_COMMAND_QUEUE_PRIORITY : const inline CInt
{
    NORMAL = 0,
    HIGH = 100,
    GLOBAL_REALTIME = 10000,
}

struct Dx_D3D12_COMMAND_QUEUE_DESC
{
    Dx_D3D12_COMMAND_LIST_TYPE type;
    Win32_INT priority;
    Dx_D3D12_COMMAND_QUEUE_FLAGS flags;
    Win32_UINT node_mask;
}

enum Dx_D3D12_PRIMITIVE_TOPOLOGY_TYPE : const inline CInt
{
    UNDEFINED,
    POINT,
    LINE,
    TRIANGLE,
    PATCH,
}

enum Dx_D3D12_INPUT_CLASSIFICATION : const inline CInt
{
    PER_VERTEX_DATA,
    PER_INSTANCE_DATA,
}

struct Dx_D3D12_INPUT_ELEMENT_DESC
{
    Win32_LPCSTR semantic_name;
    Win32_UINT semantic_index;
    Dx_DXGI_FORMAT format;
    Win32_UINT input_slot;
    Win32_UINT aligned_byte_offset;
    Dx_D3D12_INPUT_CLASSIFICATION input_slot_class;
    Win32_UINT instance_data_step_rate;
}

enum Dx_D3D12_FILL_MODE : const inline CInt
{
    WIREFRAME = 2,
    SOLID = 3,
}

enum Dx_D3D12_CULL_MODE : const inline CInt
{
    NONE = 1,
    FRONT = 2,
    BACK = 3,
}

struct Dx_D3D12_SO_DECLARATION_ENTRY
{
    Win32_UINT stream;
    ZString semantic_name;
    Win32_UINT semantic_index;
    Win32_BYTE start_component;
    Win32_BYTE component_count;
    Win32_BYTE output_slot;
}

struct Dx_D3D12_VIEWPORT
{
    float top_left_x;
    float top_left_y;
    float width;
    float height;
    float min_depth;
    float max_depth;
}

struct Dx_D3D12_BOX
{
    Win32_UINT left;
    Win32_UINT top;
    Win32_UINT front;
    Win32_UINT right;
    Win32_UINT bottom;
    Win32_UINT back;
}

enum Dx_D3D12_COMPARISON_FUNC : const inline CInt
{
    NEVER = 1,
    LESS = 2,
    EQUAL = 3,
    LESS_EQUAL = 4,
    GREATER = 5,
    NOT_EQUAL = 6,
    GREATER_EQUAL = 7,
    ALWAYS = 8,
}

enum Dx_D3D12_DEPTH_WRITE_MASK : const inline CInt
{
    ZERO = 0,
    ALL = 1,
}

enum Dx_D3D12_STENCIL_OP : const inline CInt
{
    KEEP = 1,
    ZERO = 2,
    REPLACE = 3,
    INCR_SAT = 4,
    DECR_SAT = 5,
    INVERT = 6,
    INCR = 7,
    DECR = 8,
}

struct Dx_D3D12_DEPTH_STENCILOP_DESC
{
    Dx_D3D12_STENCIL_OP stencil_fail_op;
    Dx_D3D12_STENCIL_OP stencil_depth_fail_op;
    Dx_D3D12_STENCIL_OP stencil_pass_op;
    Dx_D3D12_COMPARISON_FUNC stencil_func;
}

struct Dx_D3D12_DEPTH_STENCIL_DESC
{
    Win32_BOOL depth_enable;
    Dx_D3D12_DEPTH_WRITE_MASK depth_write_mask;
    Dx_D3D12_COMPARISON_FUNC depth_func;
    Win32_BOOL stencil_enable;
    Win32_UINT8 stencil_read_mask;
    Win32_UINT8 stencil_write_mask;
    Dx_D3D12_DEPTH_STENCILOP_DESC front_face;
    Dx_D3D12_DEPTH_STENCILOP_DESC back_face;
}

struct Dx_D3D12_DEPTH_STENCIL_DESC1
{
    Win32_BOOL depth_enable;
    Dx_D3D12_DEPTH_WRITE_MASK depth_write_mask;
    Dx_D3D12_COMPARISON_FUNC depth_func;
    Win32_BOOL stencil_enable;
    Win32_UINT8 stencil_read_mask;
    Win32_UINT8 stencil_write_mask;
    Dx_D3D12_DEPTH_STENCILOP_DESC front_face;
    Dx_D3D12_DEPTH_STENCILOP_DESC back_face;
    Win32_BOOL depth_bounds_test_enable;
}

struct Dx_D3D12_DEPTH_STENCILOP_DESC1
{
    Dx_D3D12_STENCIL_OP stencil_fail_op;
    Dx_D3D12_STENCIL_OP stencil_depth_fail_op;
    Dx_D3D12_STENCIL_OP stencil_pass_op;
    Dx_D3D12_COMPARISON_FUNC stencil_func;
    Win32_UINT stencil_read_mask;
    Win32_UINT stencil_write_mask;
}

struct Dx_D3D12_DEPTH_STENCIL_DESC2
{
    Win32_BOOL depth_enable;
    Dx_D3D12_DEPTH_WRITE_MASK depth_write_mask;
    Dx_D3D12_COMPARISON_FUNC depth_func;
    Win32_BOOL stencil_enable;
    Dx_D3D12_DEPTH_STENCILOP_DESC front_face;
    Dx_D3D12_DEPTH_STENCILOP_DESC back_face;
    Win32_BOOL depth_bounds_test_enable;
}

enum Dx_D3D12_BLEND : const inline CInt
{
    ZERO = 1,
    ONE = 2,
    SRC_COLOR = 3,
    INV_SRC_COLOR = 4,
    SRC_ALPHA = 5,
    INV_SRC_ALPHA = 6,
    DEST_ALPHA = 7,
    INV_DEST_ALPHA = 8,
    DEST_COLOR = 9,
    INV_DEST_COLOR = 10,
    SRC_ALPHA_SAT = 11,
    BLEND_FACTOR = 14,
    INV_BLEND_FACTOR = 15,
    SRC1_COLOR = 16,
    INV_SRC1_COLOR = 17,
    SRC1_ALPHA = 18,
    INV_SRC1_ALPHA = 19,
    ALPHA_FACTOR = 20,
    INV_ALPHA_FACTOR = 21
}

enum Dx_D3D12_BLEND_OP : const inline CInt
{
    ADD = 1,
    SUBTRACT = 2,
    REV_SUBTRACT = 3,
    MIN = 4,
    MAX = 5,
}

bitstruct Dx_D3D12_COLOR_WRITE_ENABLE : CInt
{
    bool red;
    bool green;
    bool blue;
    bool alpha;
}
const Dx_D3D12_COLOR_WRITE_ENABLE D3D12_COLOR_WRITE_ENABLE_RED = { .red };
const Dx_D3D12_COLOR_WRITE_ENABLE D3D12_COLOR_WRITE_ENABLE_GREEN = { .green };
const Dx_D3D12_COLOR_WRITE_ENABLE D3D12_COLOR_WRITE_ENABLE_BLUE = { .blue };
const Dx_D3D12_COLOR_WRITE_ENABLE D3D12_COLOR_WRITE_ENABLE_ALPHA = { .alpha };
const Dx_D3D12_COLOR_WRITE_ENABLE D3D12_COLOR_WRITE_ENABLE_ALL = { .red, .green, .blue, .alpha };

enum Dx_D3D12_LOGIC_OP : const inline CInt
{
    CLEAR,
    SET,
    COPY,
    COPY_INVERTED,
    NOOP,
    INVERT,
    AND,
    NAND,
    OR,
    NOR,
    XOR,
    EQUIV,
    AND_REVERSE,
    AND_INVERTED,
    OR_REVERSE,
    OR_INVERTED,
}

struct Dx_D3D12_RENDER_TARGET_BLEND_DESC
{
    Win32_BOOL blend_enable;
    Win32_BOOL logic_op_enable;
    Dx_D3D12_BLEND src_blend;
    Dx_D3D12_BLEND dest_blend;
    Dx_D3D12_BLEND_OP blend_op;
    Dx_D3D12_BLEND src_blend_alpha;
    Dx_D3D12_BLEND dest_blend_alpha;
    Dx_D3D12_BLEND_OP blend_op_alpha;
    Dx_D3D12_LOGIC_OP logic_op;
    Win32_UINT8 render_target_write_mask;
}

struct Dx_D3D12_BLEND_DESC
{
    Win32_BOOL alpha_to_coverage_enable;
    Win32_BOOL independent_blend_enable;
    Dx_D3D12_RENDER_TARGET_BLEND_DESC[D3D12_SIMULTANEOUS_RENDER_TARGET_COUNT] render_target;
}

enum Dx_D3D12_CONSERVATIVE_RASTERIZATION_MODE : const inline CInt
{
    OFF,
    ON,
}

struct Dx_D3D12_RASTERIZER_DESC
{
    Dx_D3D12_FILL_MODE fill_mode;
    Dx_D3D12_CULL_MODE cull_mode;
    Win32_BOOL front_counter_clockwise;
    Win32_INT depth_bias;
    float depth_bias_clamp;
    float slope_scaled_depth_bias;
    Win32_BOOL depth_clip_enable;
    Win32_BOOL multisample_enable;
    Win32_BOOL antialiased_line_enable;
    Win32_UINT forced_sample_count;
    Dx_D3D12_CONSERVATIVE_RASTERIZATION_MODE conservative_raster;
}

struct Dx_D3D12_RASTERIZER_DESC1
{
    Dx_D3D12_FILL_MODE fill_mode;
    Dx_D3D12_CULL_MODE cull_mode;
    Win32_BOOL front_counter_clockwise;
    float depth_bias;
    float depth_bias_clamp;
    float slope_scaled_depth_bias;
    Win32_BOOL depth_clip_enable;
    Win32_BOOL multisample_enable;
    Win32_BOOL antialiased_line_enable;
    Win32_UINT forced_sample_count;
    Dx_D3D12_CONSERVATIVE_RASTERIZATION_MODE conservative_raster;
}

enum Dx_D3D12_LINE_RASTERIZATION_MODE : const inline CInt
{
    ALIASED,
    ALPHA_ANTIALIASED,
    QUADRILATERAL_WIDE,
    QUADRILATERAL_NARROW,
}

struct Dx_D3D12_RASTERIZER_DESC2
{
    Dx_D3D12_FILL_MODE fill_mode;
    Dx_D3D12_CULL_MODE cull_mode;
    Win32_BOOL front_counter_clockwise;
    float depth_bias;
    float depth_bias_clamp;
    float slope_scaled_depth_bias;
    Win32_BOOL depth_clip_enable;
    Dx_D3D12_LINE_RASTERIZATION_MODE line_rasterization_mode;
    Win32_UINT forced_sample_count;
    Dx_D3D12_CONSERVATIVE_RASTERIZATION_MODE conservative_raster;
}

struct Dx_D3D12_SHADER_BYTECODE
{
    void* shader_bytecode;
    Win32_SIZE_T bytecode_length;
}

struct Dx_D3D12_STREAM_OUTPUT_DESC
{
    Dx_D3D12_SO_DECLARATION_ENTRY* declaration;
    Win32_UINT num_entries;
    Win32_UINT* buffer_strides;
    Win32_UINT num_strides;
    Win32_UINT rasterized_stream;
}

struct Dx_D3D12_INPUT_LAYOUT_DESC
{
    Dx_D3D12_INPUT_ELEMENT_DESC* input_element_descs;
    Win32_UINT num_elements;
}

enum Dx_D3D12_INDEX_BUFFER_STRIP_CUT_VALUE : const inline CInt
{
    DISABLED,
    FFFF,
    FFFFFFFF,
}

enum Dx_D3D12_STANDARD_MULTISAMPLE_QUALITY_LEVELS : const uint
{
    D3D12_STANDARD_MULTISAMPLE_PATTERN = 0xffffffff,
    D3D12_CENTER_MULTISAMPLE_PATTERN = 0xfffffffe
}

struct Dx_D3D12_CACHED_PIPELINE_STATE
{
    void* cached_blob;
    Win32_SIZE_T cached_blob_size_in_bytes;
}

bitstruct Dx_D3D12_PIPELINE_STATE_FLAGS : CInt
{
    bool tool_debug : 0;
    bool dynamic_depth_bias : 2;
    bool dynamic_index_buffer_strip_cut : 3;
}
const Dx_D3D12_PIPELINE_STATE_FLAGS D3D12_PIPELINE_STATE_FLAG_NONE = {};
const Dx_D3D12_PIPELINE_STATE_FLAGS D3D12_PIPELINE_STATE_FLAG_TOOL_DEBUG = { .tool_debug };
const Dx_D3D12_PIPELINE_STATE_FLAGS D3D12_PIPELINE_STATE_FLAG_DYNAMIC_DEPTH_BIAS = { .dynamic_depth_bias };
const Dx_D3D12_PIPELINE_STATE_FLAGS D3D12_PIPELINE_STATE_FLAG_DYNAMIC_INDEX_BUFFER_STRIP_CUT = { .dynamic_index_buffer_strip_cut };

struct Dx_D3D12_GRAPHICS_PIPELINE_STATE_DESC
{
    ID3D12RootSignatureRaw* root_signature;
    Dx_D3D12_SHADER_BYTECODE vs;
    Dx_D3D12_SHADER_BYTECODE ps;
    Dx_D3D12_SHADER_BYTECODE ds;
    Dx_D3D12_SHADER_BYTECODE hs;
    Dx_D3D12_SHADER_BYTECODE gs;
    Dx_D3D12_STREAM_OUTPUT_DESC stream_output;
    Dx_D3D12_BLEND_DESC blend_state;
    Win32_UINT sample_mask;
    Dx_D3D12_RASTERIZER_DESC rasterizer_state;
    Dx_D3D12_DEPTH_STENCIL_DESC depth_stencil_state;
    Dx_D3D12_INPUT_LAYOUT_DESC input_layout;
    Dx_D3D12_INDEX_BUFFER_STRIP_CUT_VALUE ib_strip_cut_value;
    Dx_D3D12_PRIMITIVE_TOPOLOGY_TYPE primitive_topology_type;
    Win32_UINT num_render_targets;
    Dx_DXGI_FORMAT[8] rtv_formats;
    Dx_DXGI_FORMAT dsv_format;
    Dx_DXGI_SAMPLE_DESC sample_desc;
    Win32_UINT node_mask;
    Dx_D3D12_CACHED_PIPELINE_STATE cached_pso;
    Dx_D3D12_PIPELINE_STATE_FLAGS flags;
}

struct Dx_D3D12_COMPUTE_PIPELINE_STATE_DESC
{
    ID3D12RootSignatureRaw* root_signature;
    Dx_D3D12_SHADER_BYTECODE cs;
    Win32_UINT node_mask;
    Dx_D3D12_CACHED_PIPELINE_STATE cached_pso;
    Dx_D3D12_PIPELINE_STATE_FLAGS flags;
}

struct Dx_D3D12_RT_FORMAT_ARRAY
{
    Dx_DXGI_FORMAT[8] rt_formats;
    Win32_UINT num_render_targets;
}

struct Dx_D3D12_PIPELINE_STATE_STREAM_DESC
{
    Win32_SIZE_T pipeline_state_subobject_stream_size_in_bytes;
    void* ipeline_state_subobject_stream;
}

enum Dx_D3D12_PIPELINE_STATE_SUBOBJECT_TYPE : const inline CInt
{
    ROOT_SIGNATURE = 0,
    VS = 1,
    PS = 2,
    DS = 3,
    HS = 4,
    GS = 5,
    CS = 6,
    STREAM_OUTPUT = 7,
    BLEND = 8,
    SAMPLE_MASK = 9,
    RASTERIZER = 10,
    DEPTH_STENCIL = 11,
    INPUT_LAYOUT = 12,
    IB_STRIP_CUT_VALUE = 13,
    PRIMITIVE_TOPOLOGY = 14,
    RENDER_TARGET_FORMATS = 15,
    DEPTH_STENCIL_FORMAT = 16,
    SAMPLE_DESC = 17,
    NODE_MASK = 18,
    CACHED_PSO = 19,
    FLAGS = 20,
    DEPTH_STENCIL1 = 21,
    VIEW_INSTANCING = 22,
    AS = 24,
    MS = 25,
    DEPTH_STENCIL2 = 26,
    RASTERIZER1 = 27,
    RASTERIZER2 = 28,
}

enum Dx_D3D12_FEATURE : const inline CInt
{
    D3D12_OPTIONS = 0,
    ARCHITECTURE = 1,
    FEATURE_LEVELS = 2,
    FORMAT_SUPPORT = 3,
    MULTISAMPLE_QUALITY_LEVELS = 4,
    FORMAT_INFO = 5,
    GPU_VIRTUAL_ADDRESS_SUPPORT = 6,
    SHADER_MODEL = 7,
    D3D12_OPTIONS1 = 8,
    PROTECTED_RESOURCE_SESSION_SUPPORT = 10,
    ROOT_SIGNATURE = 12,
    ARCHITECTURE1 = 16,
    D3D12_OPTIONS2 = 18,
    SHADER_CACHE = 19,
    COMMAND_QUEUE_PRIORITY = 20,
    D3D12_OPTIONS3 = 21,
    EXISTING_HEAPS = 22,
    D3D12_OPTIONS4 = 23,
    SERIALIZATION = 24,
    CROSS_NODE = 25,
    D3D12_OPTIONS5 = 27,
    DISPLAYABLE = 28,
    D3D12_OPTIONS6 = 30,
    QUERY_META_COMMAND = 31,
    D3D12_OPTIONS7 = 32,
    PROTECTED_RESOURCE_SESSION_TYPE_COUNT = 33,
    PROTECTED_RESOURCE_SESSION_TYPES = 34,
    D3D12_OPTIONS8 = 36,
    D3D12_OPTIONS9 = 37,
    D3D12_OPTIONS10 = 39,
    D3D12_OPTIONS11 = 40,
    D3D12_OPTIONS12 = 41,
    D3D12_OPTIONS13 = 42,
    D3D12_OPTIONS14 = 43,
    D3D12_OPTIONS15 = 44,
    D3D12_OPTIONS16 = 45,
    D3D12_OPTIONS17 = 46,
    D3D12_OPTIONS18 = 47,
    D3D12_OPTIONS19 = 48,
    D3D12_OPTIONS20 = 49,
    PREDICATION = 50,
    PLACED_RESOURCE_SUPPORT_INFO = 51,
    HARDWARE_COPY = 52,
    D3D12_OPTIONS21 = 53,
    APPLICATION_SPECIFIC_DRIVER_STATE = 56,
    BYTECODE_BYPASS_HASH_SUPPORTED = 57
}

bitstruct Dx_D3D12_SHADER_MIN_PRECISION_SUPPORT : CInt
{
    bool ten_bit;
    bool sixteen_bit;
}
const Dx_D3D12_SHADER_MIN_PRECISION_SUPPORT D3D12_SHADER_MIN_PRECISION_SUPPORT_NONE = {};
const Dx_D3D12_SHADER_MIN_PRECISION_SUPPORT D3D12_SHADER_MIN_PRECISION_SUPPORT_10_BIT = { .ten_bit };
const Dx_D3D12_SHADER_MIN_PRECISION_SUPPORT D3D12_SHADER_MIN_PRECISION_SUPPORT_16_BIT = { .sixteen_bit };

enum Dx_D3D12_TILED_RESOURCES_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
    TIER_4 = 4,
}

enum Dx_D3D12_RESOURCE_BINDING_TIER : const inline CInt
{
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
}

enum Dx_D3D12_CONSERVATIVE_RASTERIZATION_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
}

bitstruct Dx_D3D12_FORMAT_SUPPORT1 : CInt
{
    bool buffer : 0;
    bool ia_vertex_buffer : 1;
    bool ia_index_buffer : 2;
    bool so_buffer : 3;
    bool texture1d : 4;
    bool texture2d : 5;
    bool texture3d : 6;
    bool texturecube : 7;
    bool shader_load : 8;
    bool shader_sample : 9;
    bool shader_sample_comparison : 10;
    bool shader_sample_mono_text : 11;
    bool mip : 12;
    bool render_target : 14;
    bool blendable : 15;
    bool depth_stencil : 16;
    bool multisample_resolve : 18;
    bool display : 19;
    bool cast_within_bit_layout : 20;
    bool multisample_rendertarget : 21;
    bool multisample_load : 22;
    bool shader_gather : 23;
    bool back_buffer_casting : 24;
    bool typed_unordered_access_view : 25;
    bool shader_gather_comparison : 26;
    bool decoder_output : 27;
    bool video_processor_output : 28;
    bool video_processor_input : 29;
    bool video_encoder : 30;
}
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_NONE = {};
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_BUFFER = { .buffer };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_IA_VERTEX_BUFFER = { .ia_vertex_buffer };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_IA_INDEX_BUFFER = { .ia_index_buffer };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SO_BUFFER = { .so_buffer };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_TEXTURE1D = { .texture1d };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_TEXTURE2D = { .texture2d };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_TEXTURE3D = { .texture3d };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_TEXTURECUBE = { .texturecube };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SHADER_LOAD = { .shader_load };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE = { .shader_sample };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_COMPARISON = { .shader_sample_comparison };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_MONO_TEXT = { .shader_sample_mono_text };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_MIP = { .mip };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_RENDER_TARGET = { .render_target };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_BLENDABLE = { .blendable };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_DEPTH_STENCIL = { .depth_stencil };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_MULTISAMPLE_RESOLVE = { .multisample_resolve };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_DISPLAY = { .display };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_CAST_WITHIN_BIT_LAYOUT = { .cast_within_bit_layout };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_MULTISAMPLE_RENDERTARGET = { .multisample_rendertarget };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_MULTISAMPLE_LOAD = { .multisample_load };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SHADER_GATHER = { .shader_gather };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_BACK_BUFFER_CASTING = { .back_buffer_casting };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_TYPED_UNORDERED_ACCESS_VIEW = { .typed_unordered_access_view };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_SHADER_GATHER_COMPARISON = { .shader_gather_comparison };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_DECODER_OUTPUT = { .decoder_output };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_VIDEO_PROCESSOR_OUTPUT = { .video_processor_output };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_VIDEO_PROCESSOR_INPUT = { .video_processor_input };
const Dx_D3D12_FORMAT_SUPPORT1 D3D12_FORMAT_SUPPORT1_VIDEO_ENCODER = { .video_encoder };

bitstruct Dx_D3D12_FORMAT_SUPPORT2 : CInt
{
    bool uav_atomic_add : 0;
    bool uav_atomic_bitwise_ops : 1;
    bool uav_atomic_compare_store_or_compare_exchange : 2;
    bool uav_atomic_exchange : 3;
    bool uav_atomic_signed_min_max : 4;
    bool uav_atomic_unsigned_min_max : 5;
    bool uav_typed_load : 6;
    bool uav_typed_store : 7;
    bool output_merger_logic_op : 8;
    bool tiled : 9;
    bool multiplane_overlay : 14;
    bool sampler_feedback : 15;
}
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_NONE = {};
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_ADD = { .uav_atomic_add };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS = { .uav_atomic_bitwise_ops };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE = { .uav_atomic_compare_store_or_compare_exchange };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE = { .uav_atomic_exchange };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_MAX = { .uav_atomic_signed_min_max };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_MAX = { .uav_atomic_unsigned_min_max };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_TYPED_LOAD = { .uav_typed_load };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_UAV_TYPED_STORE = { .uav_typed_store };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_OUTPUT_MERGER_LOGIC_OP = { .output_merger_logic_op };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_TILED = { .tiled };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_MULTIPLANE_OVERLAY = { .multiplane_overlay };
const Dx_D3D12_FORMAT_SUPPORT2 D3D12_FORMAT_SUPPORT2_SAMPLER_FEEDBACK = { .sampler_feedback };

bitstruct Dx_D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS : CInt
{
    bool tiled_resource : 0;
}
const Dx_D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS D3D12_MULTISAMPLE_QUALITY_LEVELS_FLAG_NONE = {};
const Dx_D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS D3D12_MULTISAMPLE_QUALITY_LEVELS_FLAG_TILED_RESOURCE = { .tiled_resource };

enum Dx_D3D12_CROSS_NODE_SHARING_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1_EMULATED = 1,
    TIER_1 = 2,
    TIER_2 = 3,
    TIER_3 = 4,
}

enum Dx_D3D12_RESOURCE_HEAP_TIER : const inline CInt
{
    TIER_1 = 1,
    TIER_2 = 2,
}

enum Dx_D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
}

enum Dx_D3D12_VIEW_INSTANCING_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
}

enum Dx_D3D12_WORK_GRAPHS_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1_0 = 10
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS
{
    Win32_BOOL double_precision_float_shader_ops;
    Win32_BOOL output_merger_logic_op;
    Dx_D3D12_SHADER_MIN_PRECISION_SUPPORT min_precision_support;
    Dx_D3D12_TILED_RESOURCES_TIER tiled_resources_tier;
    Dx_D3D12_RESOURCE_BINDING_TIER resource_binding_tier;
    Win32_BOOL ps_specified_stencil_ref_supported;
    Win32_BOOL typed_uav_load_additional_formats;
    Win32_BOOL rovs_supported;
    Dx_D3D12_CONSERVATIVE_RASTERIZATION_TIER conservative_rasterization_tier;
    Win32_UINT max_gpu_virtual_address_bits_per_resource;
    Win32_BOOL standard_swizzle_64KB_supported;
    Dx_D3D12_CROSS_NODE_SHARING_TIER cross_node_sharing_tier;
    Win32_BOOL cross_adapter_row_major_texture_supported;
    Win32_BOOL vp_and_rt_array_index_from_any_shader_feeding_rasterizer_supported_without_gs_emulation;
    Dx_D3D12_RESOURCE_HEAP_TIER resource_heap_tier;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS1
{
    Win32_BOOL wave_ops;
    Win32_UINT wave_lane_count_min;
    Win32_UINT wave_lane_count_max;
    Win32_UINT total_lane_count;
    Win32_BOOL expanded_compute_resource_states;
    Win32_BOOL int64_shader_ops;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS2
{
    Win32_BOOL depth_bounds_test_supported;
    Dx_D3D12_PROGRAMMABLE_SAMPLE_POSITIONS_TIER programmable_sample_positions_tier;
}

enum Dx_D3D_ROOT_SIGNATURE_VERSION : const inline CInt
{
    VERSION_1 = 1,
    VERSION_1_0 = 1,
    VERSION_1_1 = 2,
    VERSION_1_2 = 3,
}

struct Dx_D3D12_FEATURE_DATA_ROOT_SIGNATURE
{
    Dx_D3D_ROOT_SIGNATURE_VERSION highest_version;
}

struct Dx_D3D12_FEATURE_DATA_ARCHITECTURE
{
    Win32_UINT node_index;
    Win32_BOOL tile_based_renderer;
    Win32_BOOL uma;
    Win32_BOOL cache_coherent_uma;
}

struct Dx_D3D12_FEATURE_DATA_ARCHITECTURE1
{
    Win32_UINT node_index;
    Win32_BOOL tile_based_renderer;
    Win32_BOOL uma;
    Win32_BOOL cache_coherent_uma;
    Win32_BOOL isolated_mmu;
}

struct Dx_D3D12_FEATURE_DATA_FEATURE_LEVELS
{
    Win32_UINT num_feature_levels;
    Dx_D3D_FEATURE_LEVEL* feature_levels_requested;
    Dx_D3D_FEATURE_LEVEL max_supported_feature_level;
}

enum Dx_D3D_SHADER_MODEL : const inline CInt
{
    SM_5_1 = 0x51,
    SM_6_0 = 0x60,
    SM_6_1 = 0x61,
    SM_6_2 = 0x62,
    SM_6_3 = 0x63,
    SM_6_4 = 0x64,
    SM_6_5 = 0x65,
    SM_6_6 = 0x66,
    SM_6_7 = 0x67,
    SM_6_8 = 0x68,
    SM_6_9 = 0x69,
}
const D3D_HIGHEST_SHADER_MODEL = Dx_D3D_SHADER_MODEL.SM_6_9;

struct Dx_D3D12_FEATURE_DATA_SHADER_MODEL
{
    Dx_D3D_SHADER_MODEL highest_shader_model;
}

struct Dx_D3D12_FEATURE_DATA_FORMAT_SUPPORT
{
    Dx_DXGI_FORMAT format;
    Dx_D3D12_FORMAT_SUPPORT1 support1;
    Dx_D3D12_FORMAT_SUPPORT2 support2;
}

struct Dx_D3D12_FEATURE_DATA_MULTISAMPLE_QUALITY_LEVELS
{
    Dx_DXGI_FORMAT format;
    Win32_UINT sample_count;
    Dx_D3D12_MULTISAMPLE_QUALITY_LEVEL_FLAGS flags;
    Win32_UINT num_quality_levels;
}

struct Dx_D3D12_FEATURE_DATA_FORMAT_INFO
{
    Dx_DXGI_FORMAT format;
    Win32_UINT8 plane_count;
}

struct Dx_D3D12_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT
{
    Win32_UINT max_gpu_virtual_address_bits_per_resource;
    Win32_UINT max_gpu_virtual_address_bits_per_process;
}

bitstruct Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS : CInt
{
    bool single_pso : 0;
    bool library : 1;
    bool automatic_inproc_cache : 2;
    bool automatic_disk_cache : 3;
    bool driver_managed_cache : 4;
    bool shader_control_clear : 5;
    bool shader_session_delete : 6;
}
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_NONE = {};
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_SINGLE_PSO = { .single_pso };
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_LIBRARY = { .library };
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_AUTOMATIC_INPROC_CACHE = { .automatic_inproc_cache };
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_AUTOMATIC_DISK_CACHE = { .automatic_disk_cache };
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_DRIVER_MANAGED_CACHE = { .driver_managed_cache };
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_SHADER_CONTROL_CLEAR = { .shader_control_clear };
const Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS D3D12_SHADER_CACHE_SUPPORT_FLAG_SHADER_SESSION_DELETE = { .shader_session_delete };

struct Dx_D3D12_FEATURE_DATA_SHADER_CACHE
{
    Dx_D3D12_SHADER_CACHE_SUPPORT_FLAGS support_flags;
}

struct Dx_D3D12_FEATURE_DATA_COMMAND_QUEUE_PRIORITY
{
    Dx_D3D12_COMMAND_LIST_TYPE command_list_type;
    Win32_UINT priority;
    Win32_BOOL priority_for_type_is_supported;
}
bitstruct Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS : CInt
{
    bool direct : 0;
    bool bundle : 1;
    bool compute : 2;
    bool copy : 3;
    bool video_decode : 4;
    bool video_process : 5;
    bool video_encode : 6;
}
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_NONE = {};
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_DIRECT = { .direct };
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_BUNDLE = { .bundle };
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_COMPUTE = { .compute };
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_COPY = { .copy };
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_DECODE = { .video_decode };
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_PROCESS = { .video_process };
const Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS D3D12_COMMAND_LIST_SUPPORT_FLAG_VIDEO_ENCODE = { .video_encode };

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS3
{
    Win32_BOOL copy_queue_timestamp_queries_supported;
    Win32_BOOL casting_fully_typed_format_supported;
    Dx_D3D12_COMMAND_LIST_SUPPORT_FLAGS write_buffer_immediate_support_flags;
    Dx_D3D12_VIEW_INSTANCING_TIER view_instancing_tier;
    Win32_BOOL barycentrics_supported;
}

struct Dx_D3D12_FEATURE_DATA_EXISTING_HEAPS
{
    Win32_BOOL existing_heaps_supported;
}

enum Dx_D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER : const inline CInt
{
    TIER_0 = 0,
    TIER_1 = 1,
    TIER_2 = 2,
}

struct Dx_D3D12_FEATURE_DATA_DISPLAYABLE
{
    Win32_BOOL displayable_texture;
    Dx_D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER shared_resource_compatibility_tier;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS4
{
    Win32_BOOL msaa_64kb_aligned_texture_supported;
    Dx_D3D12_SHARED_RESOURCE_COMPATIBILITY_TIER shared_resource_compatibility_tier;
    Win32_BOOL native_16bit_shader_ops_supported;
}

enum Dx_D3D12_HEAP_SERIALIZATION_TIER : const inline CInt
{
    TIER_0 = 0,
    TIER_10 = 10,
}

struct Dx_D3D12_FEATURE_DATA_SERIALIZATION
{
    Win32_UINT node_index;
    Dx_D3D12_HEAP_SERIALIZATION_TIER serialization_tier;
}

struct Dx_D3D12_FEATURE_DATA_CROSS_NODE
{
    Dx_D3D12_CROSS_NODE_SHARING_TIER sharing_tier;
    Win32_BOOL atomic_shader_instructions;
}

enum Dx_D3D12_RENDER_PASS_TIER : const inline CInt
{
    TIER_0 = 0,
    TIER_1 = 1,
    TIER_2 = 2,
}

enum Dx_D3D12_RAYTRACING_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1_0 = 10,
    TIER_1_1 = 11,
    TIER_1_2 = 12,
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS5
{
    Win32_BOOL srv_only_tiled_resource_tier3;
    Dx_D3D12_RENDER_PASS_TIER render_pass_tier;
    Dx_D3D12_RAYTRACING_TIER raytracing_tier;
}

enum Dx_D3D12_VARIABLE_SHADING_RATE_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS6
{
    Win32_BOOL additional_shading_rates_supported;
    Win32_BOOL per_primitive_shading_rate_supported_with_viewport_indexing;
    Dx_D3D12_VARIABLE_SHADING_RATE_TIER variable_shading_rate_tier;
    Win32_UINT shading_rate_image_tile_size;
    Win32_BOOL background_processing_supported;
}

enum Dx_D3D12_MESH_SHADER_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 10
}

enum Dx_D3D12_SAMPLER_FEEDBACK_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_0_9 = 90,
    TIER_1_0 = 100
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS7
{
    Dx_D3D12_MESH_SHADER_TIER mesh_shader_tier;
    Dx_D3D12_SAMPLER_FEEDBACK_TIER sampler_feedback_tier;
}

struct Dx_D3D12_FEATURE_DATA_QUERY_META_COMMAND
{
    Win32_GUID command_id;
    Win32_UINT node_mask;
    void* query_input_data;
    Win32_SIZE_T query_input_data_size_in_bytes;
    void* query_output_data;
    Win32_SIZE_T query_output_data_size_in_bytes;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS8
{
    Win32_BOOL unaligned_block_textures_supported;
}

enum Dx_D3D12_WAVE_MMA_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1_0 = 10
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS9
{
    Win32_BOOL mesh_shader_pipeline_stats_supported;
    Win32_BOOL mesh_shader_supports_full_range_render_target_array_index;
    Win32_BOOL atomic_int64_on_typed_resource_supported;
    Win32_BOOL atomic_int64_on_group_shared_supported;
    Win32_BOOL derivatives_in_mesh_and_amplification_shaders_supported;
    Dx_D3D12_WAVE_MMA_TIER wave_mma_tier;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS10
{
    Win32_BOOL variable_rate_shading_sum_combiner_supported;
    Win32_BOOL mesh_shader_per_primitive_shading_rate_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS11
{
    Win32_BOOL atomic_int64_on_descriptor_heap_resource_supported;
}

enum Dx_D3D12_TRI_STATE : const inline CInt
{
    UNKNOWN = -1,
    FALSE = 0,
    TRUE = 1
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS12
{
    Dx_D3D12_TRI_STATE ms_primitives_pipeline_statistic_includes_culled_primitives;
    Win32_BOOL enhanced_barriers_supported;
    Win32_BOOL relaxed_format_casting_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS13
{
    Win32_BOOL unrestricted_buffer_texture_copy_pitch_supported;
    Win32_BOOL inrestricted_vertex_element_alignment_supported;
    Win32_BOOL inverted_viewport_height_flips_y_supported;
    Win32_BOOL inverted_viewport_depth_flips_z_supported;
    Win32_BOOL texture_copy_between_dimensions_supported;
    Win32_BOOL alpha_blend_factor_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS14
{
    Win32_BOOL advanced_texture_ops_supported;
    Win32_BOOL writeable_msaa_textures_supported;
    Win32_BOOL independent_front_and_back_stencil_ref_mask_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS15
{
    Win32_BOOL triangle_fan_supported;
    Win32_BOOL dynamic_index_buffer_strip_cut_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS16
{
    Win32_BOOL dynamic_depth_bias_supported;
    Win32_BOOL gpu_upload_heap_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS17
{
    Win32_BOOL non_normalized_coordinate_samplers_supported;
    Win32_BOOL manual_write_tracking_resource_supported;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS18
{
    Win32_BOOL render_passes_valid;
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS19
{
    Win32_BOOL mismatching_output_dimensions_supported;
    Win32_UINT supported_sample_counts_with_no_outputs;
    Win32_BOOL point_sampling_addresses_never_round_up;
    Win32_BOOL rasterizer_desc2_supported;
    Win32_BOOL narrow_quadrilateral_lines_supported;
    Win32_BOOL aniso_filter_with_point_mip_supported;
    Win32_UINT max_sampler_descriptor_heap_size;
    Win32_UINT max_sampler_descriptor_heap_size_with_static_samplers;
    Win32_UINT max_viewDescriptorHeap_size;
    Win32_BOOL compute_only_custom_heap_supported;
}

enum Dx_D3D12_RECREATE_AT_TIER : const inline CInt
{
    NOT_SUPPORTED = 0,
    TIER_1 = 1
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS20
{
    Win32_BOOL compute_only_write_watch_supported;
    Dx_D3D12_RECREATE_AT_TIER recreate_at_tier;
}

enum Dx_D3D12_EXECUTE_INDIRECT_TIER : const inline CInt
{
    TIER_1_0 = 10,
    TIER_1_1 = 11
}

struct Dx_D3D12_FEATURE_DATA_D3D12_OPTIONS21
{
    Dx_D3D12_WORK_GRAPHS_TIER work_graphs_tier;
    Dx_D3D12_EXECUTE_INDIRECT_TIER execute_indirect_tier;
    Win32_BOOL sample_cmp_gradient_and_bias_supported;
    Win32_BOOL extended_command_info_supported;
}

struct Dx_D3D12_FEATURE_DATA_PREDICATION
{
    Win32_BOOL supported;
}

struct Dx_D3D12_FEATURE_DATA_HARDWARE_COPY
{
    Win32_BOOL supported;
}

struct Dx_D3D12_FEATURE_DATA_APPLICATION_SPECIFIC_DRIVER_STATE
{
    Win32_BOOL supported;
}

struct Dx_D3D12_FEATURE_DATA_BYTECODE_BYPASS_HASH_SUPPORTED
{
    Win32_BOOL supported;
}

struct Dx_D3D12_RESOURCE_ALLOCATION_INFO
{
    Win32_UINT64 size_in_bytes;
    Win32_UINT64 alignment;
}

struct Dx_D3D12_RESOURCE_ALLOCATION_INFO1
{
    Win32_UINT64 offset;
    Win32_UINT64 alignment;
    Win32_UINT64 size_in_bytes;
}

enum Dx_D3D12_HEAP_TYPE : const inline CInt
{
    DEFAULT = 1,
    UPLOAD = 2,
    READBACK = 3,
    CUSTOM = 4,
    GPU_UPLOAD = 5,
}

enum Dx_D3D12_CPU_PAGE_PROPERTY : const inline CInt
{
    UNKNOWN = 0,
    NOT_AVAILABLE = 1,
    WRITE_COMBINE = 2,
    WRITE_BACK = 3,
}

enum Dx_D3D12_MEMORY_POOL : const inline CInt
{
    UNKNOWN = 0,
    L0 = 1,
    L1 = 2,
}

struct Dx_D3D12_HEAP_PROPERTIES
{
    Dx_D3D12_HEAP_TYPE type;
    Dx_D3D12_CPU_PAGE_PROPERTY cpu_page_property;
    Dx_D3D12_MEMORY_POOL memory_pool;
    Win32_UINT creation_node_mask;
    Win32_UINT visible_node_mask;
}

bitstruct Dx_D3D12_HEAP_FLAGS : CInt
{
    bool shared : 0;
    bool deny_buffers : 2;
    bool allow_display : 3;
    bool shared_cross_adapter : 5;
    bool deny_rt_ds_textures : 6;
    bool deny_non_rt_ds_textures : 7;
    bool hardware_protected : 8;
    bool allow_write_watching : 9;
    bool allow_shader_atomics : 10;
    bool create_not_resident : 11;
    bool create_not_zeroed : 12;
    bool tools_use_manual_write_tracking : 13;
}
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_NONE = {};
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_SHARED = { .shared };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_DENY_BUFFERS = { .deny_buffers };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_DISPLAY = { .allow_display };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_SHARED_CROSS_ADAPTER = { .shared_cross_adapter };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES = { .deny_rt_ds_textures };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_DENY_NON_RT_DS_TEXTURES = { .deny_non_rt_ds_textures };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_HARDWARE_PROTECTED = { .hardware_protected };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_WRITE_WATCHING = { .allow_write_watching };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_SHADER_ATOMICS = { .allow_shader_atomics };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_CREATE_NOT_RESIDENT = { .create_not_resident };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_CREATE_NOT_ZEROED = { .create_not_zeroed };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_TOOLS_USE_MANUAL_WRITE_TRACKING = { .tools_use_manual_write_tracking };
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_ALL_BUFFERS_AND_TEXTURES = {};
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_ONLY_BUFFERS = D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES | D3D12_HEAP_FLAG_DENY_NON_RT_DS_TEXTURES;
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_ONLY_NON_RT_DS_TEXTURES = D3D12_HEAP_FLAG_DENY_RT_DS_TEXTURES | D3D12_HEAP_FLAG_DENY_BUFFERS;
const Dx_D3D12_HEAP_FLAGS D3D12_HEAP_FLAG_ALLOW_ONLY_RT_DS_TEXTURES = D3D12_HEAP_FLAG_DENY_NON_RT_DS_TEXTURES | D3D12_HEAP_FLAG_DENY_BUFFERS;

struct Dx_D3D12_HEAP_DESC
{
    Win32_UINT64 size_in_bytes;
    Dx_D3D12_HEAP_PROPERTIES properties;
    Win32_UINT64 alignment;
    Dx_D3D12_HEAP_FLAGS flags;
}

enum Dx_D3D12_RESOURCE_DIMENSION : const inline CInt
{
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE2D = 3,
    TEXTURE3D = 4,
}

struct Dx_D3D12_FEATURE_DATA_PLACED_RESOURCE_SUPPORT_INFO
{
    Dx_DXGI_FORMAT format;
    Dx_D3D12_RESOURCE_DIMENSION dimension;
    Dx_D3D12_HEAP_PROPERTIES dest_heap_properties;
    Win32_BOOL supported;
}

enum Dx_D3D12_TEXTURE_LAYOUT : const inline CInt
{
    UNKNOWN = 0,
    ROW_MAJOR = 1,
    UNDEFINED_SWIZZLE_64KB = 2,
    STANDARD_SWIZZLE_64KB = 3,
}

bitstruct Dx_D3D12_RESOURCE_FLAGS : CInt
{
    bool allow_render_target;
    bool allow_depth_stencil;
    bool allow_unordered_access;
    bool deny_shader_resource;
    bool allow_cross_adapter;
    bool allow_simultaneous_access;
    bool video_decode_reference_only;
    bool video_encode_reference_only;
    bool raytracing_acceleration_structure;
}
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_NONE = {};
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_ALLOW_RENDER_TARGET = { .allow_render_target };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_ALLOW_DEPTH_STENCIL = { .allow_depth_stencil };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_ALLOW_UNORDERED_ACCESS = { .allow_unordered_access };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_DENY_SHADER_RESOURCE = { .deny_shader_resource };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_ALLOW_CROSS_ADAPTER = { .allow_cross_adapter };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_ALLOW_SIMULTANEOUS_ACCESS = { .allow_simultaneous_access };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_VIDEO_DECODE_REFERENCE_ONLY = { .video_decode_reference_only };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_VIDEO_ENCODE_REFERENCE_ONLY = { .video_encode_reference_only };
const Dx_D3D12_RESOURCE_FLAGS D3D12_RESOURCE_FLAG_RAYTRACING_ACCELERATION_STRUCTURE = { .raytracing_acceleration_structure };

struct Dx_D3D12_MIP_REGION
{
    Win32_UINT width;
    Win32_UINT height;
    Win32_UINT depth;
}

struct Dx_D3D12_RESOURCE_DESC
{
    Dx_D3D12_RESOURCE_DIMENSION dimension;
    Win32_UINT64 alignment;
    Win32_UINT64 width;
    Win32_UINT height;
    Win32_UINT16 depth_or_array_size;
    Win32_UINT16 mip_levels;
    Dx_DXGI_FORMAT format;
    Dx_DXGI_SAMPLE_DESC sample_desc;
    Dx_D3D12_TEXTURE_LAYOUT layout;
    Dx_D3D12_RESOURCE_FLAGS flags;
}

struct Dx_D3D12_RESOURCE_DESC1
{
    Dx_D3D12_RESOURCE_DIMENSION dimension;
    Win32_UINT64 alignment;
    Win32_UINT64 width;
    Win32_UINT height;
    Win32_UINT16 depth_or_array_size;
    Win32_UINT16 mip_levels;
    Dx_DXGI_FORMAT format;
    Dx_DXGI_SAMPLE_DESC sample_desc;
    Dx_D3D12_TEXTURE_LAYOUT layout;
    Dx_D3D12_RESOURCE_FLAGS flags;
    Dx_D3D12_MIP_REGION sampler_feedback_mip_region;
}

struct Dx_D3D12_DEPTH_STENCIL_VALUE
{
    float depth;
    Win32_UINT8 stencil;
}

struct Dx_D3D12_CLEAR_VALUE
{
    Dx_DXGI_FORMAT format;
    union
    {
        float[4] color;
        Dx_D3D12_DEPTH_STENCIL_VALUE depth_stencil;
    }
}

struct Dx_D3D12_RANGE
{
    Win32_SIZE_T begin;
    Win32_SIZE_T end;
}

struct Dx_D3D12_RANGE_UINT64
{
    Win32_UINT64 begin;
    Win32_UINT64 end;
}

struct Dx_D3D12_SUBRESOURCE_RANGE_UINT64
{
    Win32_UINT subresource;
    Dx_D3D12_RANGE_UINT64 range;
}

struct Dx_D3D12_SUBRESOURCE_INFO
{
    Win32_UINT64 offset;
    Win32_UINT row_pitch;
    Win32_UINT depth_pitch;
}

struct Dx_D3D12_TILED_REOURCE_COORDINATE
{
    Win32_UINT x;
    Win32_UINT y;
    Win32_UINT z;
    Win32_UINT subresource;
}

struct Dx_D3D12_TILE_REGION_SIZE
{
    Win32_UINT num_tiles;
    Win32_BOOL use_box;
    Win32_UINT width;
    Win32_UINT16 height;
    Win32_UINT16 depth;
}

bitstruct Dx_D3D12_TILE_RANGE_FLAGS : CInt
{
    bool null_range;
    bool skip;
    bool reuse_single_tile;
}
const Dx_D3D12_TILE_RANGE_FLAGS D3D12_TILE_RANGE_FLAG_NONE = {};
const Dx_D3D12_TILE_RANGE_FLAGS D3D12_TILE_RANGE_FLAG_NULL = { .null_range };
const Dx_D3D12_TILE_RANGE_FLAGS D3D12_TILE_RANGE_FLAG_SKIP = { .skip };
const Dx_D3D12_TILE_RANGE_FLAGS D3D12_TILE_RANGE_FLAG_REUSE_SINGLE_TILE = { .reuse_single_tile };

struct Dx_D3D12_SUBRESOURCE_TILING
{
    Win32_UINT width_in_tiles;
    Win32_UINT16 height_in_tiles;
    Win32_UINT16 depth_in_tiles;
    Win32_UINT start_tile_index_in_overall_resource;
    Dx_D3D12_TILE_RANGE_FLAGS flags;
}

struct Dx_D3D12_TILE_SHAPE
{
    Win32_UINT width_in_texels;
    Win32_UINT height_in_texels;
    Win32_UINT depth_in_texels;
}

struct Dx_D3D12_PACKED_MIP_INFO
{
    Win32_UINT8 num_standard_mips;
    Win32_UINT8 num_packed_mips;
    Win32_UINT num_tiles_for_packed_mips;
    Win32_UINT8 start_tile_index_in_overall_resource;
}

bitstruct Dx_D3D12_TILE_MAPPING_FLAGS : CInt
{
    bool no_hazard;
}
const Dx_D3D12_TILE_MAPPING_FLAGS D3D12_TILE_MAPPING_FLAG_NONE = {};
const Dx_D3D12_TILE_MAPPING_FLAGS D3D12_TILE_MAPPING_FLAG_NO_HAZARD = { .no_hazard };

bitstruct Dx_D3D12_TILE_COPY_FLAGS : CInt
{
    bool no_hazard;
    bool linear_buffer_to_swizzled_tiled_resource;
    bool swizzled_tiled_resource_to_linear_buffer;
}
const Dx_D3D12_TILE_COPY_FLAGS D3D12_TILE_COPY_FLAG_NONE = {};
const Dx_D3D12_TILE_COPY_FLAGS D3D12_TILE_COPY_FLAG_NO_HAZARD = { .no_hazard };
const Dx_D3D12_TILE_COPY_FLAGS D3D12_TILE_COPY_FLAG_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE = { .linear_buffer_to_swizzled_tiled_resource };
const Dx_D3D12_TILE_COPY_FLAGS D3D12_TILE_COPY_FLAG_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER = { .swizzled_tiled_resource_to_linear_buffer };

bitstruct Dx_D3D12_RESOURCE_STATES : CInt
{
    bool vertex_and_constant_buffer : 0;
    bool index_buffer : 1;
    bool render_target : 2;
    bool unordered_access : 3;
    bool depth_write : 4;
    bool depth_read : 5;
    bool non_pixel_shader_resource : 6;
    bool pixel_shader_resource : 7;
    bool stream_out : 8;
    bool indirect_argument : 9;
    bool copy_dest : 10;
    bool copy_source : 11;
    bool resolve_dest : 12;
    bool resolve_source : 13;
    bool video_decode_read : 16;
    bool video_decode_write : 17;
    bool video_process_read : 18;
    bool video_process_write : 19;
    bool video_encode_read : 21;
    bool raytracing_acceleration_structure : 22;
    bool video_encode_write : 23;
    bool shading_rate_source : 24;
}
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_COMMON = {};
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_PRESENT = {};
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VERTEX_AND_CONSTANT_BUFFER = { .vertex_and_constant_buffer };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_INDEX_BUFFER = { .index_buffer };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_RENDER_TARGET = { .render_target };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_UNORDERED_ACCESS = { .unordered_access };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_DEPTH_WRITE = { .depth_write };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_DEPTH_READ = { .depth_read };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE = { .non_pixel_shader_resource };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE = { .pixel_shader_resource };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_STREAM_OUT = { .stream_out };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_INDIRECT_ARGUMENT = { .indirect_argument };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_COPY_DEST = { .copy_dest };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_COPY_SOURCE = { .copy_source };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_RESOLVE_DEST = { .resolve_dest };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_RESOLVE_SOURCE = { .resolve_source };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VIDEO_DECODE_READ = { .video_decode_read };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VIDEO_DECODE_WRITE = { .video_decode_write };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VIDEO_PROCESS_READ = { .video_process_read };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VIDEO_PROCESS_WRITE = { .video_process_write };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VIDEO_ENCODE_READ = { .video_encode_read };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_VIDEO_ENCODE_WRITE = { .video_encode_write };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_RAYTRACING_ACCELERATION_STRUCTURE = { .raytracing_acceleration_structure };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_SHADING_RATE_SOURCE = { .shading_rate_source };
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_GENERIC_READ = D3D12_RESOURCE_STATE_VERTEX_AND_CONSTANT_BUFFER | D3D12_RESOURCE_STATE_INDEX_BUFFER | D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE | D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE | D3D12_RESOURCE_STATE_INDIRECT_ARGUMENT | D3D12_RESOURCE_STATE_COPY_SOURCE;
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_ALL_SHADER_RESOURCE = D3D12_RESOURCE_STATE_NON_PIXEL_SHADER_RESOURCE | D3D12_RESOURCE_STATE_PIXEL_SHADER_RESOURCE;
const Dx_D3D12_RESOURCE_STATES D3D12_RESOURCE_STATE_PREDICATION = { .indirect_argument };

enum Dx_D3D12_RESOURCE_BARRIER_TYPE : const inline CInt
{
    TRANSITION,
    ALIASING,
    UAV,
}

struct Dx_D3D12_RESOURCE_TRANSITION_BARRIER
{
    ID3D12ResourceRaw* resource;
    Win32_UINT subresource;
    Dx_D3D12_RESOURCE_STATES state_before;
    Dx_D3D12_RESOURCE_STATES state_after;
}

struct Dx_D3D12_RESOURCE_ALIASING_BARRIER
{
    ID3D12ResourceRaw* resource_before;
    ID3D12ResourceRaw* resource_after;
}

struct Dx_D3D12_RESOURCE_UAV_BARRIER
{
    ID3D12ResourceRaw* resource;
}

bitstruct Dx_D3D12_RESOURCE_BARRIER_FLAGS : CInt
{
    bool begin_only : 1;
    bool end_only : 2;
}
const Dx_D3D12_RESOURCE_BARRIER_FLAGS D3D12_RESOURCE_BARRIER_FLAG_NONE = {};
const Dx_D3D12_RESOURCE_BARRIER_FLAGS D3D12_RESOURCE_BARRIER_FLAG_BEGIN_ONLY = { .begin_only };
const Dx_D3D12_RESOURCE_BARRIER_FLAGS D3D12_RESOURCE_BARRIER_FLAG_END_ONLY = { .end_only };

struct Dx_D3D12_RESOURCE_BARRIER
{
    Dx_D3D12_RESOURCE_BARRIER_TYPE type;
    Dx_D3D12_RESOURCE_BARRIER_FLAGS flags;
    union
    {
        Dx_D3D12_RESOURCE_TRANSITION_BARRIER transition;
        Dx_D3D12_RESOURCE_ALIASING_BARRIER aliasing;
        Dx_D3D12_RESOURCE_UAV_BARRIER uav;
    }
}

struct Dx_D3D12_SUBRESOURCE_FOOTPRINT
{
    Dx_DXGI_FORMAT format;
    Win32_UINT width;
    Win32_UINT height;
    Win32_UINT depth;
    Win32_UINT row_pitch;
}

struct Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT
{
    Win32_UINT64 offset;
    Dx_D3D12_SUBRESOURCE_FOOTPRINT footprint;
}

enum Dx_D3D12_TEXTURE_COPY_TYPE : const inline CInt
{
    SUBRESOURCE_INDEX,
    PLACED_FOOTPRINT,
}

struct Dx_D3D12_TEXTURE_COPY_LOCATION
{
    ID3D12ResourceRaw* resource;
    Dx_D3D12_TEXTURE_COPY_TYPE type;
    union
    {
        Win32_UINT subresource_index; // for SUBRESOURCE_INDEX
        Dx_D3D12_PLACED_SUBRESOURCE_FOOTPRINT placed_footprint; // for PLACED_FOOTPRINT
    }
}

enum Dx_D3D12_RESOLVE_MODE : const inline CInt
{
    DECOMPRESS,
    MIN,
    MAX,
    AVERAGE,
    ENCODE_SAMPLER_FEEDBACK,
    DECODE_SAMPLER_FEEDBACK
}

struct Dx_D3D12_SAMPLE_POSITION
{
    Win32_INT8 x;
    Win32_INT8 y;
}

struct Dx_D3D12_VIEW_INSTANCE_LOCATION
{
    Win32_UINT viewport_array_index;
    Win32_UINT render_target_array_index;
}

bitstruct Dx_D3D12_VIEW_INSTANCING_FLAGS : CInt
{
    bool allow_view_instance_masking;
}
const Dx_D3D12_VIEW_INSTANCING_FLAGS D3D12_VIEW_INSTANCING_FLAG_NONE = {};
const Dx_D3D12_VIEW_INSTANCING_FLAGS D3D12_VIEW_INSTANCING_FLAG_ALLOW_VIEW_INSTANCE_MASKING = { .allow_view_instance_masking };

struct Dx_D3D12_VIEW_INSTANCING_DESC
{
    Win32_UINT view_instance_count;
    Dx_D3D12_VIEW_INSTANCE_LOCATION* view_instance_locations;
    Dx_D3D12_VIEW_INSTANCING_FLAGS flags;
}

enum Dx_D3D12_SHADER_COMPONENT_MAPPING : const inline CInt
{
    FROM_MEMORY_COMPONENT_0,
    FROM_MEMORY_COMPONENT_1,
    FROM_MEMORY_COMPONENT_2,
    FROM_MEMORY_COMPONENT_3,
    FORCE_VALUE_0,
    FORCE_VALUE_1,
}

bitstruct Dx_D3D12_SHADER_4_COMPONENT_MAPPING : Win32_UINT
{
    Dx_D3D12_SHADER_COMPONENT_MAPPING src0 : 0..2;
    Dx_D3D12_SHADER_COMPONENT_MAPPING src1 : 3..5;
    Dx_D3D12_SHADER_COMPONENT_MAPPING src2 : 6..8;
    Dx_D3D12_SHADER_COMPONENT_MAPPING src3 : 9..11;
    bool always_set : 12;
}
const Dx_D3D12_SHADER_4_COMPONENT_MAPPING D3D12_DEFAULT_SHADER_4_COMPONENT_MAPPING = { .src0=FROM_MEMORY_COMPONENT_0, .src1=FROM_MEMORY_COMPONENT_1, .src2=FROM_MEMORY_COMPONENT_2, .src3=FROM_MEMORY_COMPONENT_3, .always_set=true };

bitstruct Dx_D3D12_BUFFER_SRV_FLAGS : CInt
{
    bool raw;
}
const Dx_D3D12_BUFFER_SRV_FLAGS D3D12_BUFFER_SRV_FLAG_NONE = {};
const Dx_D3D12_BUFFER_SRV_FLAGS D3D12_BUFFER_SRV_FLAG_RAW = { .raw };

struct Dx_D3D12_BUFFER_SRV
{
    Win32_UINT64 first_element;
    Win32_UINT num_elements;
    Win32_UINT structure_byte_stride;
    Dx_D3D12_BUFFER_SRV_FLAGS flags;
}

struct Dx_D3D12_TEX1D_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEX1D_ARRAY_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEX2D_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    Win32_UINT plane_slice;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEX2D_ARRAY_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
    Win32_UINT plane_slice;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEX3D_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEXCUBE_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEXCUBE_ARRAY_SRV
{
    Win32_UINT most_detailed_mip;
    Win32_UINT mip_levels;
    Win32_UINT first_2d_array_slice;
    Win32_UINT num_cubes;
    float resource_min_lod_clamp;
}

struct Dx_D3D12_TEX2DMS_SRV
{
    Win32_UINT nothing_to_define;
}

struct Dx_D3D12_TEX2DMS_ARRAY_SRV
{
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_SRV
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS location;
}

enum Dx_D3D12_SRV_DIMENSION : const inline CInt
{
    UNKNOWN,
    BUFFER,
    TEXTURE1D,
    TEXTURE1D_ARRAY,
    TEXTURE2D,
    TEXTURE2D_ARRAY,
    TEXTURE2DMS,
    TEXTURE2DMS_ARRAY,
    TEXTURE3D,
    TEXTURECUBE,
    TEXTURECUBE_ARRAY,
    RAYTRACING_ACCELERATION_STRUCTURE,
}

struct Dx_D3D12_SHADER_RESOURCE_VIEW_DESC
{
    Dx_DXGI_FORMAT format;
    Dx_D3D12_SRV_DIMENSION view_dimension;
    Dx_D3D12_SHADER_4_COMPONENT_MAPPING shader_4_component_mapping;
    union
    {
        Dx_D3D12_BUFFER_SRV buffer;
        Dx_D3D12_TEX1D_SRV tex1d;
        Dx_D3D12_TEX1D_ARRAY_SRV tex1d_array;
        Dx_D3D12_TEX2D_SRV tex2d;
        Dx_D3D12_TEX2D_ARRAY_SRV tex2d_array;
        Dx_D3D12_TEX3D_SRV tex3d;
        Dx_D3D12_TEXCUBE_SRV texcube;
        Dx_D3D12_TEXCUBE_ARRAY_SRV texcube_array;
        Dx_D3D12_TEX2DMS_SRV tex2dms;
        Dx_D3D12_TEX2DMS_ARRAY_SRV tex2dms_array;
        Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_SRV raytracing_acceleration_structure;
    }
}

struct Dx_D3D12_CONSTANT_BUFFER_VIEW_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS buffer_location;
    Win32_UINT size_in_bytes;
}

enum Dx_D3D12_FILTER : const inline CInt
{
    MIN_MAG_MIP_POINT = 0,
    MIN_MAG_POINT_MIP_LINEAR = 0x1,
    MIN_POINT_MAG_LINEAR_MIP_POINT = 0x4,
    MIN_POINT_MAG_MIP_LINEAR = 0x5,
    MIN_LINEAR_MAG_MIP_POINT = 0x10,
    MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x11,
    MIN_MAG_LINEAR_MIP_POINT = 0x14,
    MIN_MAG_MIP_LINEAR = 0x15,
    MIN_MAG_ANISOTROPIC_MIP_POINT = 0x54,
    ANISOTROPIC = 0x55,
    COMPARISON_MIN_MAG_MIP_POINT = 0x80,
    COMPARISON_MIN_MAG_POINT_MIP_LINEAR = 0x81,
    COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT = 0x84,
    COMPARISON_MIN_POINT_MAG_MIP_LINEAR = 0x85,
    COMPARISON_MIN_LINEAR_MAG_MIP_POINT = 0x90,
    COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x91,
    COMPARISON_MIN_MAG_LINEAR_MIP_POINT = 0x94,
    COMPARISON_MIN_MAG_MIP_LINEAR = 0x95,
    COMPARISON_MIN_MAG_ANISOTROPIC_MIP_POINT = 0xd4,
    COMPARISON_ANISOTROPIC = 0xd5,
    MINIMUM_MIN_MAG_MIP_POINT = 0x100,
    MINIMUM_MIN_MAG_POINT_MIP_LINEAR = 0x101,
    MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT = 0x104,
    MINIMUM_MIN_POINT_MAG_MIP_LINEAR = 0x105,
    MINIMUM_MIN_LINEAR_MAG_MIP_POINT = 0x110,
    MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x111,
    MINIMUM_MIN_MAG_LINEAR_MIP_POINT = 0x114,
    MINIMUM_MIN_MAG_MIP_LINEAR = 0x115,
    MINIMUM_MIN_MAG_ANISOTROPIC_MIP_POINT = 0x154,
    MINIMUM_ANISOTROPIC = 0x155,
    MAXIMUM_MIN_MAG_MIP_POINT = 0x180,
    MAXIMUM_MIN_MAG_POINT_MIP_LINEAR = 0x181,
    MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT = 0x184,
    MAXIMUM_MIN_POINT_MAG_MIP_LINEAR = 0x185,
    MAXIMUM_MIN_LINEAR_MAG_MIP_POINT = 0x190,
    MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x191,
    MAXIMUM_MIN_MAG_LINEAR_MIP_POINT = 0x194,
    MAXIMUM_MIN_MAG_MIP_LINEAR = 0x195,
    MAXIMUM_MIN_MAG_ANISOTROPIC_MIP_POINT = 0x1d4,
    MAXIMUM_ANISOTROPIC = 0x1d5,
}

enum Dx_D3D12_FILTER_TYPE : const inline CInt
{
    POINT,
    LINEAR,
}

enum Dx_D3D12_FILTER_REDUCTION_TYPE : const inline CInt
{
    STANDARD,
    COMPARISON,
    MINIMUM,
    MAXIMUM,
}

bitstruct Dx_D3D12_FILTER_DECODE : CInt
{
    Dx_D3D12_FILTER_TYPE mip_filter : 0..1;
    Dx_D3D12_FILTER_TYPE mag_filter : 2..3;
    Dx_D3D12_FILTER_TYPE min_filter : 4..5;
    bool anisotropic : 6;
    Dx_D3D12_FILTER_REDUCTION_TYPE reduction_type : 7..8;
}

enum Dx_D3D12_TEXTURE_ADDRESS_MODE : const inline CInt
{
    WRAP = 1,
    MIRROR = 2,
    CLAMP = 3,
    BORDER = 4,
    MIRROR_ONCE = 5,
}

struct Dx_D3D12_SAMPLER_DESC
{
    Dx_D3D12_FILTER filter;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_u;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_v;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_w;
    float mip_lod_bias;
    Win32_UINT max_anisotropy;
    Dx_D3D12_COMPARISON_FUNC comparison_func;
    float[4] border_color;
    float min_lod;
    float max_lod;
}

bitstruct Dx_D3D12_SAMPLER_FLAGS : CInt
{
    bool border_color;
    bool non_normalized_coordinates;
}
const Dx_D3D12_SAMPLER_FLAGS D3D12_SAMPLER_FLAG_NONE = {};
const Dx_D3D12_SAMPLER_FLAGS D3D12_SAMPLER_FLAG_BORDER_COLOR = { .border_color };
const Dx_D3D12_SAMPLER_FLAGS D3D12_SAMPLER_FLAG_NON_NORMALIZED_COORDINATES = { .non_normalized_coordinates };

struct Dx_D3D12_SAMPLER_DESC2
{
    Dx_D3D12_FILTER filter;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_u;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_v;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_w;
    float mip_lod_bias;
    Win32_UINT max_anisotropy;
    Dx_D3D12_COMPARISON_FUNC comparison_func;
    union 
    {
        float[4] float_border_color;
        Win32_UINT[4] uint_border_color;
    }
    float min_lod;
    float max_lod;
    Dx_D3D12_SAMPLER_FLAGS flags;
}

bitstruct Dx_D3D12_BUFFER_UAV_FLAGS : CInt
{
    bool raw;
}
const Dx_D3D12_BUFFER_UAV_FLAGS D3D12_UAV_FLAG_NONE = {};
const Dx_D3D12_BUFFER_UAV_FLAGS D3D12_UAV_FLAG_RAW = { .raw };

struct Dx_D3D12_BUFFER_UAV
{
    Win32_UINT64 first_element;
    Win32_UINT num_elements;
    Win32_UINT structure_byte_stride;
    Win32_UINT64 counter_offset_in_bytes;
    Dx_D3D12_BUFFER_UAV_FLAGS flags;
}

struct Dx_D3D12_TEX1D_UAV
{
    Win32_UINT mip_slice;
}

struct Dx_D3D12_TEX1D_ARRAY_UAV
{
    Win32_UINT mip_slice;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_TEX2D_UAV
{
    Win32_UINT mip_slice;
    Win32_UINT plane_slice;
}

struct Dx_D3D12_TEX2D_ARRAY_UAV
{
    Win32_UINT mip_slice;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
    Win32_UINT plane_slice;
}

struct Dx_D3D12_TEX2DMS_UAV
{
    Win32_UINT nothing_to_define;
}

struct Dx_D3D12_TEX2DMS_ARRAY_UAV
{
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_TEX3D_UAV
{
    Win32_UINT mip_slice;
    Win32_UINT first_w_slice;
    Win32_UINT w_size;
}

enum Dx_D3D12_UAV_DIMENSION : const inline CInt
{
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE1D_ARRAY = 3,
    TEXTURE2D = 4,
    TEXTURE2D_ARRAY = 5,
    TEXTURE2DMS = 6,
    TEXTURE2DMS_ARRAY = 7,
    TEXTURE3D = 8,
}

struct Dx_D3D12_UNORDERED_ACCESS_VIEW_DESC
{
    Dx_DXGI_FORMAT format;
    Dx_D3D12_UAV_DIMENSION view_dimension;
    union
    {
        Dx_D3D12_BUFFER_UAV buffer;
        Dx_D3D12_TEX1D_UAV texture1d;
        Dx_D3D12_TEX1D_ARRAY_UAV texture1d_array;
        Dx_D3D12_TEX2D_UAV texture2d;
        Dx_D3D12_TEX2D_ARRAY_UAV texture2d_array;
        Dx_D3D12_TEX2DMS_UAV texture2dms;
        Dx_D3D12_TEX2DMS_ARRAY_UAV texture2dms_array;
        Dx_D3D12_TEX3D_UAV texture3d;
    }
}

struct Dx_D3D12_BUFFER_RTV
{
    Win32_UINT64 first_element;
    Win32_UINT num_elements;
}

struct Dx_D3D12_TEX1D_RTV
{
    Win32_UINT mip_slice;
}

struct Dx_D3D12_TEX1D_ARRAY_RTV
{
    Win32_UINT mip_slice;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_TEX2D_RTV
{
    Win32_UINT mip_slice;
    Win32_UINT plane_slice;
}

struct Dx_D3D12_TEX2D_ARRAY_RTV
{
    Win32_UINT mip_slice;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
    Win32_UINT plane_slice;
}

struct Dx_D3D12_TEX2DMS_RTV
{
    Win32_UINT nothing_to_define;
}

struct Dx_D3D12_TEX2DMS_ARRAY_RTV
{
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_TEX3D_RTV
{
    Win32_UINT mip_slice;
    Win32_UINT first_w_slice;
    Win32_UINT w_size;
}

enum Dx_D3D12_RTV_DIMENSION : const inline CInt
{
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE1D_ARRAY = 3,
    TEXTURE2D = 4,
    TEXTURE2D_ARRAY = 5,
    TEXTURE2DMS = 6,
    TEXTURE2DMS_ARRAY = 7,
    TEXTURE3D = 8,
}

struct Dx_D3D12_RENDER_TARGET_VIEW_DESC
{
    Dx_DXGI_FORMAT format;
    Dx_D3D12_RTV_DIMENSION view_dimension;
    union
    {
        Dx_D3D12_BUFFER_RTV buffer;
        Dx_D3D12_TEX1D_RTV texture1d;
        Dx_D3D12_TEX1D_ARRAY_RTV texture1d_array;
        Dx_D3D12_TEX2D_RTV texture2d;
        Dx_D3D12_TEX2D_ARRAY_RTV texture2d_array;
        Dx_D3D12_TEX2DMS_RTV texture2dms;
        Dx_D3D12_TEX2DMS_ARRAY_RTV texture2dms_array;
        Dx_D3D12_TEX3D_RTV texture3d;
    }
}

struct Dx_D3D12_TEX1D_DSV
{
    Win32_UINT mip_slice;
}

struct Dx_D3D12_TEX1D_ARRAY_DSV
{
    Win32_UINT mip_slice;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_TEX2D_DSV
{
    Win32_UINT mip_slice;
}

struct Dx_D3D12_TEX2D_ARRAY_DSV
{
    Win32_UINT mip_slice;
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

struct Dx_D3D12_TEX2DMS_DSV
{
    Win32_UINT nothing_to_define;
}

struct Dx_D3D12_TEX2DMS_ARRAY_DSV
{
    Win32_UINT first_array_slice;
    Win32_UINT array_size;
}

bitstruct Dx_D3D12_DSV_FLAGS : CInt
{
    bool read_only_depth;
    bool read_only_stencil;
}
const Dx_D3D12_DSV_FLAGS D3D12_DSV_FLAG_NONE = {};
const Dx_D3D12_DSV_FLAGS D3D12_DSV_FLAG_READ_ONLY_DEPTH = { .read_only_depth };
const Dx_D3D12_DSV_FLAGS D3D12_DSV_FLAG_READ_ONLY_STENCIL = { .read_only_stencil };

enum Dx_D3D12_DSV_DIMENSION : const inline CInt
{
    UNKNOWN = 0,
    TEXTURE1D = 1,
    TEXTURE1D_ARRAY = 2,
    TEXTURE2D = 3,
    TEXTURE2D_ARRAY = 4,
    TEXTURE2DMS = 5,
    TEXTURE2DMS_ARRAY = 6,
}

struct Dx_D3D12_DEPTH_STENCIL_VIEW_DESC
{
    Dx_DXGI_FORMAT format;
    Dx_D3D12_DSV_DIMENSION view_dimension;
    Dx_D3D12_DSV_FLAGS flags;
    union
    {
        Dx_D3D12_TEX1D_DSV texture1d;
        Dx_D3D12_TEX1D_ARRAY_DSV texture1d_array;
        Dx_D3D12_TEX2D_DSV texture2d;
        Dx_D3D12_TEX2D_ARRAY_DSV texture2d_array;
        Dx_D3D12_TEX2DMS_DSV texture2dms;
        Dx_D3D12_TEX2DMS_ARRAY_DSV texture2dms_array;
    }
}

bitstruct Dx_D3D12_CLEAR_FLAGS : CInt
{
    bool depth;
    bool stencil;
}
const Dx_D3D12_CLEAR_FLAGS D3D12_CLEAR_FLAG_NONE = {};
const Dx_D3D12_CLEAR_FLAGS D3D12_CLEAR_FLAG_DEPTH = { .depth };
const Dx_D3D12_CLEAR_FLAGS D3D12_CLEAR_FLAG_STENCIL = { .stencil };

bitstruct Dx_D3D12_FENCE_FLAGS : CInt
{
    bool shared;
    bool shared_cross_adapter;
    bool non_monitored;
}
const Dx_D3D12_FENCE_FLAGS D3D12_FENCE_FLAG_NONE = {};
const Dx_D3D12_FENCE_FLAGS D3D12_FENCE_FLAG_SHARED = { .shared };
const Dx_D3D12_FENCE_FLAGS D3D12_FENCE_FLAG_SHARED_CROSS_ADAPTER = { .shared_cross_adapter };
const Dx_D3D12_FENCE_FLAGS D3D12_FENCE_FLAG_NON_MONITORED = { .non_monitored };

enum Dx_D3D12_DESCRIPTOR_HEAP_TYPE : const inline CInt
{
    CBV_SRV_UAV,
    SAMPLER,
    RTV,
    DSV,
}

bitstruct Dx_D3D12_DESCRIPTOR_HEAP_FLAGS : CInt
{
    bool shader_visible;
}
const Dx_D3D12_DESCRIPTOR_HEAP_FLAGS D3D12_DESCRIPTOR_HEAP_FLAG_NONE = {};
const Dx_D3D12_DESCRIPTOR_HEAP_FLAGS D3D12_DESCRIPTOR_HEAP_FLAG_SHADER_VISIBLE = { .shader_visible };

struct Dx_D3D12_DESCRIPTOR_HEAP_DESC
{
    Dx_D3D12_DESCRIPTOR_HEAP_TYPE type;
    Win32_UINT num_descriptors;
    Dx_D3D12_DESCRIPTOR_HEAP_FLAGS flags;
    Win32_UINT node_mask;
}

enum Dx_D3D12_DESCRIPTOR_RANGE_TYPE : const inline CInt
{
    SRV,
    UAV,
    CBV,
    SAMPLER,
}

struct Dx_D3D12_DESCRIPTOR_RANGE
{
    Dx_D3D12_DESCRIPTOR_RANGE_TYPE range_type;
    Win32_UINT num_descriptors;
    Win32_UINT base_shader_register;
    Win32_UINT register_space;
    Win32_UINT offset_in_descriptors_from_table_start;
}

struct Dx_D3D12_ROOT_DESCRIPTOR_TABLE
{
    Win32_UINT num_descriptor_ranges;
    Dx_D3D12_DESCRIPTOR_RANGE* descriptor_ranges;
}

struct Dx_D3D12_ROOT_CONSTANTS
{
    Win32_UINT shader_register;
    Win32_UINT register_space;
    Win32_UINT num_32_bit_values;
}

struct Dx_D3D12_ROOT_DESCRIPTOR
{
    Win32_UINT shader_register;
    Win32_UINT register_space;
}

enum Dx_D3D12_SHADER_VISIBILITY : const inline CInt
{
    ALL,
    VERTEX,
    HULL,
    DOMAIN,
    GEOMETRY,
    PIXEL,
    AMPLIFICATION,
    MESH,
}

enum Dx_D3D12_ROOT_PARAMETER_TYPE : const inline CInt
{
    DESCRIPTOR_TABLE,
    CONSTANTS_32BIT,
    CBV,
    SRV,
    UAV,
}

struct Dx_D3D12_ROOT_PARAMETER
{
    Dx_D3D12_ROOT_PARAMETER_TYPE parameter_type;
    union
    {
        Dx_D3D12_ROOT_DESCRIPTOR_TABLE descriptor_table; // for DESCRIPTOR_TABLE
        Dx_D3D12_ROOT_CONSTANTS constants; // for CONSTANTS_32BIT
        Dx_D3D12_ROOT_DESCRIPTOR descriptor; // for CBV, SRV, UAV
    }
    Dx_D3D12_SHADER_VISIBILITY shader_visibility;
}

bitstruct Dx_D3D12_ROOT_SIGNATURE_FLAGS : CInt
{
    bool allow_input_assembler_input_layout;
    bool deny_vertex_shader_root_access;
    bool deny_hull_shader_root_access;
    bool deny_domain_shader_root_access;
    bool deny_geometry_shader_root_access;
    bool deny_pixel_shader_root_access;
    bool allow_stream_output;
    bool local_root_signature;
    bool deny_amplification_shader_root_access;
    bool deny_mesh_shader_root_access;
    bool cbv_srv_uav_heap_directly_indexed;
    bool sampler_heap_directly_indexed;
}
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_NONE = {};
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_ALLOW_INPUT_ASSEMBLER_INPUT_LAYOUT = { .allow_input_assembler_input_layout };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_VERTEX_SHADER_ROOT_ACCESS = { .deny_vertex_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_HULL_SHADER_ROOT_ACCESS = { .deny_hull_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_DOMAIN_SHADER_ROOT_ACCESS = { .deny_domain_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_GEOMETRY_SHADER_ROOT_ACCESS = { .deny_geometry_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_PIXEL_SHADER_ROOT_ACCESS = { .deny_pixel_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_ALLOW_STREAM_OUTPUT = { .allow_stream_output };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_LOCAL_ROOT_SIGNATURE = { .local_root_signature };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_AMPLIFICATION_SHADER_ROOT_ACCESS = { .deny_amplification_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_DENY_MESH_SHADER_ROOT_ACCESS = { .deny_mesh_shader_root_access };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_CBV_SRV_UAV_HEAP_DIRECTLY_INDEXED = { .cbv_srv_uav_heap_directly_indexed };
const Dx_D3D12_ROOT_SIGNATURE_FLAGS D3D12_ROOT_SIGNATURE_FLAG_SAMPLER_HEAP_DIRECTLY_INDEXED = { .sampler_heap_directly_indexed };

enum Dx_D3D12_STATIC_BORDER_COLOR : const inline CInt
{
    TRANSPARENT_BLACK,
    OPAQUE_BLACK,
    OPAQUE_WHITE,
    BLACK_UINT,
    OPAQUE_WHITE_UINT, 
}

struct Dx_D3D12_STATIC_SAMPLER_DESC
{
    Dx_D3D12_FILTER filter;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_u;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_v;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_w;
    float mip_lod_bias;
    Win32_UINT max_anisotropy;
    Dx_D3D12_COMPARISON_FUNC comparison_func;
    Dx_D3D12_STATIC_BORDER_COLOR border_color;
    float min_lod;
    float max_lod;
    Win32_UINT shader_register;
    Win32_UINT register_space;
    Dx_D3D12_SHADER_VISIBILITY shader_visibility;
}

struct Dx_D3D12_STATIC_SAMPLER_DESC1
{
    Dx_D3D12_FILTER filter;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_u;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_v;
    Dx_D3D12_TEXTURE_ADDRESS_MODE address_w;
    float mip_lod_bias;
    Win32_UINT max_anisotropy;
    Dx_D3D12_COMPARISON_FUNC comparison_func;
    Dx_D3D12_STATIC_BORDER_COLOR border_color;
    float min_lod;
    float max_lod;
    Win32_UINT shader_register;
    Win32_UINT register_space;
    Dx_D3D12_SHADER_VISIBILITY shader_visibility;
    Dx_D3D12_SAMPLER_FLAGS flags;
}

struct Dx_D3D12_ROOT_SIGNATURE_DESC
{
    Win32_UINT num_parameters;
    Dx_D3D12_ROOT_PARAMETER* arameters;
    Win32_UINT num_static_samplers;
    Dx_D3D12_STATIC_SAMPLER_DESC* static_samplers;
    Dx_D3D12_ROOT_SIGNATURE_FLAGS flags;
}

bitstruct Dx_D3D12_DESCRIPTOR_RANGE_FLAGS : CInt
{
    bool descriptor_volatile : 0;
    bool data_volatile : 1;
    bool data_static_when_set_at_execution : 2;
    bool data_static : 3;
    bool descriptors_static_keeping_buffer_bounds_checks : 16;
}
const Dx_D3D12_DESCRIPTOR_RANGE_FLAGS D3D12_DESCRIPTOR_RANGE_FLAG_NONE = {};
const Dx_D3D12_DESCRIPTOR_RANGE_FLAGS D3D12_DESCRIPTOR_RANGE_FLAG_DESCRIPTORS_VOLATILE = { .descriptor_volatile };
const Dx_D3D12_DESCRIPTOR_RANGE_FLAGS D3D12_DESCRIPTOR_RANGE_FLAG_DATA_VOLATILE = { .data_volatile };
const Dx_D3D12_DESCRIPTOR_RANGE_FLAGS D3D12_DESCRIPTOR_RANGE_FLAG_DATA_STATIC_WHEN_SET_AT_EXECUTION = { .data_static_when_set_at_execution };
const Dx_D3D12_DESCRIPTOR_RANGE_FLAGS D3D12_DESCRIPTOR_RANGE_FLAG_DATA_STATIC = { .data_static };
const Dx_D3D12_DESCRIPTOR_RANGE_FLAGS D3D12_DESCRIPTOR_RANGE_FLAG_DESCRIPTORS_STATIC_KEEPING_BUFFER_BOUNDS_CHECKS = { .descriptors_static_keeping_buffer_bounds_checks };

struct Dx_D3D12_DESCRIPTOR_RANGE1
{
    Dx_D3D12_DESCRIPTOR_RANGE_TYPE range_type;
    Win32_UINT num_descriptors;
    Win32_UINT base_shader_register;
    Win32_UINT register_space;
    Dx_D3D12_DESCRIPTOR_RANGE_FLAGS flags;
    Win32_UINT offset_in_descriptors_from_table_start;
}

struct Dx_D3D12_ROOT_DESCRIPTOR_TABLE1
{
    Win32_UINT num_descriptor_ranges;
    Dx_D3D12_DESCRIPTOR_RANGE1* descriptor_ranges;
}

bitstruct Dx_D3D12_ROOT_DESCRIPTOR_FLAGS : CInt
{
    bool data_volatile : 1;
    bool data_static_when_set_at_execution : 2;
    bool data_static : 3;
}
const Dx_D3D12_ROOT_DESCRIPTOR_FLAGS D3D12_ROOT_DESCRIPTOR_FLAG_NONE = {};
const Dx_D3D12_ROOT_DESCRIPTOR_FLAGS D3D12_ROOT_DESCRIPTOR_FLAG_DATA_VOLATILE = { .data_volatile };
const Dx_D3D12_ROOT_DESCRIPTOR_FLAGS D3D12_ROOT_DESCRIPTOR_FLAG_DATA_STATIC_WHEN_SET_AT_EXECUTION = { .data_static_when_set_at_execution };
const Dx_D3D12_ROOT_DESCRIPTOR_FLAGS D3D12_ROOT_DESCRIPTOR_FLAG_DATA_STATIC = { .data_static };

struct Dx_D3D12_ROOT_DESCRIPTOR1
{
    Win32_UINT shader_register;
    Win32_UINT register_space;
    Dx_D3D12_ROOT_DESCRIPTOR_FLAGS flags;
}

struct Dx_D3D12_ROOT_PARAMETER1
{
    Dx_D3D12_ROOT_PARAMETER_TYPE parameter_type;
    union
    {
        Dx_D3D12_ROOT_DESCRIPTOR_TABLE1 descriptor_table; // for DESCRIPTOR_TABLE
        Dx_D3D12_ROOT_CONSTANTS constants; // for CONSTANTS_32BIT
        Dx_D3D12_ROOT_DESCRIPTOR1 descriptor; // for CBV, SRV, UAV
    }
    Dx_D3D12_SHADER_VISIBILITY shader_visibility;
}

struct Dx_D3D12_ROOT_SIGNATURE_DESC1
{
    Win32_UINT num_parameters;
    Dx_D3D12_ROOT_PARAMETER1* arameters;
    Win32_UINT num_static_samplers;
    Dx_D3D12_STATIC_SAMPLER_DESC* static_samplers;
    Dx_D3D12_ROOT_SIGNATURE_FLAGS flags;
}

struct Dx_D3D12_ROOT_SIGNATURE_DESC2
{
    Win32_UINT num_parameters;
    Dx_D3D12_ROOT_PARAMETER1* arameters;
    Win32_UINT num_static_samplers;
    Dx_D3D12_STATIC_SAMPLER_DESC* static_samplers;
    Dx_D3D12_ROOT_SIGNATURE_FLAGS flags;
}

struct Dx_D3D12_VERSIONED_ROOT_SIGNATURE_DESC
{
    Dx_D3D_ROOT_SIGNATURE_VERSION version;
    union 
    {
        Dx_D3D12_ROOT_SIGNATURE_DESC desc_1_0; // for D3D_ROOT_SIGNATURE_VERSION_1_0
        Dx_D3D12_ROOT_SIGNATURE_DESC1 desc_1_1; // for D3D_ROOT_SIGNATURE_VERSION_1_1
        Dx_D3D12_ROOT_SIGNATURE_DESC2 desc_1_2; // for D3D_ROOT_SIGNATURE_VERSION_1_2
    }
}

struct Dx_D3D12_CPU_DESCRIPTOR_HANDLE
{
    Win32_SIZE_T ptr;
}

struct Dx_D3D12_GPU_DESCRIPTOR_HANDLE
{
    Win32_UINT64 ptr;
}

// If rects are supplied in D3D12_DISCARD_REGION, below, the resource 
// must have 2D subresources with all specified subresources the same dimension.
struct Dx_D3D12_DISCARD_REGION
{
    Win32_UINT num_rects;
    Dx_D3D12_RECT* rects;
    Win32_UINT first_subresource;
    Win32_UINT num_subresources;
}
enum Dx_D3D12_QUERY_HEAP_TYPE : const inline CInt
{
    OCCLUSION = 0,
    TIMESTAMP = 1,
    PIPELINE_STATISTICS = 2,
    SO_STATISTICS = 3,
    VIDEO_DECODE_STATISTICS = 4,
    COPY_QUEUE_TIMESTAMP = 5,
    PIPELINE_STATISTICS1 = 7,
}

struct Dx_D3D12_QUERY_HEAP_DESC
{
    Dx_D3D12_QUERY_HEAP_TYPE type;
    Win32_UINT count;
    Win32_UINT node_mask;
}

enum Dx_D3D12_QUERY_TYPE : const inline CInt
{
    OCCLUSION = 0,
    BINARY_OCCLUSION = 1,
    TIMESTAMP = 2,
    PIPELINE_STATISTICS = 3,
    SO_STATISTICS_STREAM0 = 4,
    SO_STATISTICS_STREAM1 = 5,
    SO_STATISTICS_STREAM2 = 6,
    SO_STATISTICS_STREAM3 = 7,
    VIDEO_DECODE_STATISTICS = 8,
    PIPELINE_STATISTICS1 = 10,
}

enum Dx_D3D12_PREDICATION_OP : const inline CInt
{
    EQUAL_ZERO,
    NOT_EQUAL_ZERO,
}

struct Dx_D3D12_QUERY_DATA_PIPELINE_STATISTICS
{
    Win32_UINT64 ia_vertices;
    Win32_UINT64 ia_primitives;
    Win32_UINT64 vs_invocations;
    Win32_UINT64 gs_invocations;
    Win32_UINT64 gs_primitives;
    Win32_UINT64 c_invocations;
    Win32_UINT64 c_primitives;
    Win32_UINT64 ps_invocations;
    Win32_UINT64 hs_invocations;
    Win32_UINT64 ds_invocations;
    Win32_UINT64 cs_invocations;
}

struct Dx_D3D12_QUERY_DATA_PIPELINE_STATISTICS1
{
    Win32_UINT64 ia_vertices;
    Win32_UINT64 ia_primitives;
    Win32_UINT64 vs_invocations;
    Win32_UINT64 gs_invocations;
    Win32_UINT64 gs_primitives;
    Win32_UINT64 c_invocations;
    Win32_UINT64 c_primitives;
    Win32_UINT64 ps_invocations;
    Win32_UINT64 hs_invocations;
    Win32_UINT64 ds_invocations;
    Win32_UINT64 cs_invocations;
    Win32_UINT64 as_invocations;
    Win32_UINT64 ms_invocations;
    Win32_UINT64 ms_primitives;
}

struct Dx_D3D12_QUERY_DATA_SO_STATISTICS
{
    Win32_UINT64 num_primitives_written;
    Win32_UINT64 primitives_storage_needed;
}

struct Dx_D3D12_STREAM_OUTPUT_BUFFER_VIEW
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS buffer_location;
    Win32_UINT64 size_in_bytes;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS buffer_filled_size_location;
}

struct Dx_D3D12_DRAW_ARGUMENTS
{
    Win32_UINT vertex_count_per_instance;
    Win32_UINT instance_count;
    Win32_UINT start_vertex_location;
    Win32_UINT start_instance_location;
}

struct Dx_D3D12_DRAW_INDEXED_ARGUMENTS
{
    Win32_UINT index_count_per_instance;
    Win32_UINT instance_count;
    Win32_UINT start_index_location;
    Win32_INT base_vertex_location;
    Win32_UINT start_instance_location;
}

struct Dx_D3D12_DISPATCH_ARGUMENTS
{
    Win32_UINT thread_group_count_x;
    Win32_UINT thread_group_count_y;
    Win32_UINT thread_group_count_z;
}

struct Dx_D3D12_VERTEX_BUFFER_VIEW
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS buffer_location;
    Win32_UINT size_in_bytes;
    Win32_UINT stride_in_bytes;
}

struct Dx_D3D12_INDEX_BUFFER_VIEW
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS buffer_location;
    Win32_UINT size_in_bytes;
    Dx_DXGI_FORMAT format;
}

enum Dx_D3D12_INDIRECT_ARGUMENT_TYPE : const inline CInt
{
    DRAW,
    DRAW_INDEXED,
    DISPATCH,
    VERTEX_BUFFER_VIEW,
    INDEX_BUFFER_VIEW,
    CONSTANT,
    CONSTANT_BUFFER_VIEW,
    SHADER_RESOURCE_VIEW,
    UNORDERED_ACCESS_VIEW,
    DISPATCH_RAYS,
    DISPATCH_MESH,
    INCREMENTING_CONSTANT,
}

struct Dx_D3D12_INDIRECT_ARGUMENT_DESC
{
    Dx_D3D12_INDIRECT_ARGUMENT_TYPE type;
    union
    {
        struct vertex_buffer
        {
            Win32_UINT slot;
        }
        struct constant
        {
            Win32_UINT root_parameter_index;
            Win32_UINT dest_offset_in_32bit_values;
            Win32_UINT num_32bit_values_to_set;
        }
        struct constant_buffer_view
        {
            Win32_UINT root_parameter_index;
        }
        struct shader_resource_view
        {
            Win32_UINT root_parameter_index;
        }
        struct unordered_access_view
        {
            Win32_UINT root_parameter_index;
        }
        struct incrementing_constant
        {
            Win32_UINT root_parameter_index;
            Win32_UINT dest_offset_in_32bit_values;
        }
    }
}

struct Dx_D3D12_COMMAND_SIGNATURE_DESC
{
    Win32_UINT byte_stride;
    Win32_UINT num_argument_descs;
    Dx_D3D12_INDIRECT_ARGUMENT_DESC* argument_descs;
    Win32_UINT node_mask;
}

struct Dx_D3D12_WRITEBUFFERIMMEDIATE_PARAMETER
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS dest;
    Win32_UINT32 value;
}

bitstruct Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE : CInt
{
    bool marker_in;
    bool marker_out;
}
const Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE D3D12_WRITEBUFFERIMMEDIATE_MODE_DEFAULT = {};
const Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_IN = { .marker_in };
const Dx_D3D12_WRITEBUFFERIMMEDIATE_MODE D3D12_WRITEBUFFERIMMEDIATE_MODE_MARKER_OUT = { .marker_out };

bitstruct Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS : CInt
{
    bool wait_any;
}
const Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS D3D12_MULTIPLE_FENCE_WAIT_FLAG_NONE = {};
const Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS D3D12_MULTIPLE_FENCE_WAIT_FLAG_WAIT_ANY = { .wait_any };
const Dx_D3D12_MULTIPLE_FENCE_WAIT_FLAGS D3D12_MULTIPLE_FENCE_WAIT_FLAG_ALL = {};

enum Dx_D3D12_RESIDENCY_PRIORITY : const uint
{
    MINIMUM = 0x28000000,
    LOW = 0x50000000,
    NORMAL = 0x78000000,
    HIGH = 0xa0010000,
    MAXIMUM = 0xc8000000,
}

bitstruct Dx_D3D12_RESIDENCY_FLAGS : CInt
{
    bool deny_overbudget;
}
const Dx_D3D12_RESIDENCY_FLAGS D3D12_RESIDENCY_FLAG_NONE = {};
const Dx_D3D12_RESIDENCY_FLAGS D3D12_RESIDENCY_FLAG_DENY_OVERBUDGET = { .deny_overbudget };

enum Dx_D3D12_COMMAND_LIST_FLAGS : const inline CInt
{
    NONE,
}

enum Dx_D3D12_COMMAND_POOL_FLAGS : const inline CInt
{
    NONE,
}

enum Dx_D3D12_COMMAND_RECORDER_FLAGS : const inline CInt
{
    NONE,
}

enum Dx_D3D12_PROTECTED_SESSION_STATUS : const inline CInt
{
    OK,
    INVALID,
}

bitstruct Dx_D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS : CInt
{
    bool supported;
}
const Dx_D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAG_NONE = {};
const Dx_D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAG_SUPPORTED = { .supported };

struct Dx_D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_SUPPORT
{
    Win32_UINT node_index;
    Dx_D3D12_PROTECTED_RESOURCE_SESSION_SUPPORT_FLAGS flags;
}

enum Dx_D3D12_PROTECTED_RESOURCE_SESSION_FLAGS : const inline CInt
{
    NONE,
}

struct Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC
{
    Win32_UINT node_mask;
    Dx_D3D12_PROTECTED_RESOURCE_SESSION_FLAGS flags;
}

enum Dx_D3D12_LIFETIME_STATE : const inline CInt
{
    IN_USE,
    NOT_IN_USE,
}

enum Dx_D3D12_META_COMMAND_PARAMETER_TYPE : const inline CInt
{
    FLOAT,
    UINT64,
    GPU_VIRTUAL_ADDRESS,
    CPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV,
    GPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV,
}

bitstruct Dx_D3D12_META_COMMAND_PARAMETER_FLAGS : CInt
{
    bool input;
    bool output;
}
const Dx_D3D12_META_COMMAND_PARAMETER_FLAGS D3D12_META_COMMAND_PARAMETER_FLAG_NONE = {};
const Dx_D3D12_META_COMMAND_PARAMETER_FLAGS D3D12_META_COMMAND_PARAMETER_FLAG_INPUT = { .input };
const Dx_D3D12_META_COMMAND_PARAMETER_FLAGS D3D12_META_COMMAND_PARAMETER_FLAG_OUTPUT = { .output };

enum Dx_D3D12_META_COMMAND_PARAMETER_STAGE : const inline CInt
{
    CREATION,
    INITIALIZATION,
    EXECUTION,
}

struct Dx_D3D12_META_COMMAND_PARAMETER_DESC
{
    Win32_LPCWSTR name;
    Dx_D3D12_META_COMMAND_PARAMETER_TYPE type;
    Dx_D3D12_META_COMMAND_PARAMETER_FLAGS flags;
    Dx_D3D12_RESOURCE_STATES required_resource_state;
    Win32_UINT structure_offset;
}

bitstruct Dx_D3D12_GRAPHICS_STATES : CInt
{
    bool ia_vertex_buffers;
    bool ia_index_buffer;
    bool ia_primitive_topology;
    bool descriptor_heap;
    bool graphics_root_signature;
    bool compute_root_signature;
    bool rs_viewports;
    bool rs_scissor_rects;
    bool predication;
    bool om_render_targets;
    bool om_stencil_ref;
    bool om_blend_factor;
    bool pipeline_state;
    bool so_targets;
    bool om_depth_bounds;
    bool sample_positions;
    bool view_instance_mask;
}
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_NONE = {};
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_IA_VERTEX_BUFFERS = { .ia_vertex_buffers };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_IA_INDEX_BUFFER = { .ia_index_buffer };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_IA_PRIMITIVE_TOPOLOGY = { .ia_primitive_topology };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_DESCRIPTOR_HEAP = { .descriptor_heap };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_GRAPHICS_ROOT_SIGNATURE = { .graphics_root_signature };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_COMPUTE_ROOT_SIGNATURE = { .compute_root_signature };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_RS_VIEWPORTS = { .rs_viewports };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_RS_SCISSOR_RECTS = { .rs_scissor_rects };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_PREDICATION = { .predication };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_OM_RENDER_TARGETS = { .om_render_targets };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_OM_STENCIL_REF = { .om_stencil_ref };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_OM_BLEND_FACTOR = { .om_blend_factor };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_PIPELINE_STATE = { .pipeline_state };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_SO_TARGETS = { .so_targets };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_OM_DEPTH_BOUNDS = { .om_depth_bounds };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_SAMPLE_POSITIONS = { .sample_positions };
const Dx_D3D12_GRAPHICS_STATES D3D12_GRAPHICS_STATES_VIEW_INSTANCE_MASK = { .view_instance_mask };

struct Dx_D3D12_META_COMMAND_DESC
{
    Win32_GUID id;
    Win32_LPCWSTR name;
    Dx_D3D12_GRAPHICS_STATES initialization_dirty_state;
    Dx_D3D12_GRAPHICS_STATES execution_dirty_state;
}

struct Dx_D3D12_PROGRAM_IDENTIFIER
{
    Win32_UINT64[4] opaque_data;
}

struct Dx_D3D12_NODE_ID
{
    Win32_LPCWSTR name;
    Win32_UINT array_index;
}

struct Dx_D3D12_WORK_GRAPH_MEMORY_REQUIREMENTS
{
    Win32_UINT64 min_size_in_bytes;
    Win32_UINT64 max_size_in_bytes;
    Win32_UINT size_granularity_in_bytes;
}

enum Dx_D3D12_STATE_SUBOBJECT_TYPE : const inline CInt
{
    STATE_OBJECT_CONFIG = 0,
    GLOBAL_ROOT_SIGNATURE = 1,
    LOCAL_ROOT_SIGNATURE = 2,
    NODE_MASK = 3,
    DXIL_LIBRARY = 5,
    EXISTING_COLLECTION = 6,
    SUBOBJECT_TO_EXPORTS_ASSOCIATION = 7,
    DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION = 8,
    RAYTRACING_SHADER_CONFIG = 9,
    RAYTRACING_PIPELINE_CONFIG = 10,
    HIT_GROUP = 11,
    RAYTRACING_PIPELINE_CONFIG1 = 12,
    WORK_GRAPH = 13,
    STREAM_OUTPUT = 14,
    BLEND = 15,
    SAMPLE_MASK = 16,
    RASTERIZER = 17,
    DEPTH_STENCIL = 18,
    INPUT_LAYOUT = 19,
    IB_STRIP_CUT_VALUE = 20,
    PRIMITIVE_TOPOLOGY = 21,
    RENDER_TARGET_FORMATS = 22,
    DEPTH_STENCIL_FORMAT = 23,
    SAMPLE_DESC = 24,
    FLAGS = 26,
    DEPTH_STENCIL1 = 27,
    VIEW_INSTANCING = 28,
    GENERIC_PROGRAM = 29,
    DEPTH_STENCIL2 = 30,
}

struct Dx_D3D12_STATE_SUBOBJECT
{
    Dx_D3D12_STATE_SUBOBJECT_TYPE type;
    void* desc;
}

bitstruct Dx_D3D12_STATE_OBJECT_FLAGS : CInt
{
    bool allow_local_dependencies_on_external_definitions;
    bool alloy_external_dependencies_on_local_definitions;
    bool allow_state_object_additions;
}
const Dx_D3D12_STATE_OBJECT_FLAGS D3D12_STATE_OBJECT_FLAG_NONE = {};
const Dx_D3D12_STATE_OBJECT_FLAGS D3D12_STATE_OBJECT_FLAG_ALLOW_LOCAL_DEPENDENCIES_ON_EXTERNAL_DEFINITIONS = { .allow_local_dependencies_on_external_definitions };
const Dx_D3D12_STATE_OBJECT_FLAGS D3D12_STATE_OBJECT_FLAG_ALLOW_EXTERNAL_DEPENDENCIES_ON_LOCAL_DEFINITIONS = { .alloy_external_dependencies_on_local_definitions };
const Dx_D3D12_STATE_OBJECT_FLAGS D3D12_STATE_OBJECT_FLAG_ALLOW_STATE_OBJECT_ADDITIONS = { .allow_state_object_additions };

struct Dx_D3D12_STATE_OBJECT_CONFIG
{
    Dx_D3D12_STATE_OBJECT_FLAGS flags;
}

struct Dx_D3D12_GLOBAL_ROOT_SIGNATURE
{
    ID3D12RootSignatureRaw* global_root_signature;
}

struct Dx_D3D12_LOCAL_ROOT_SIGNATURE
{
    ID3D12RootSignatureRaw* local_root_signature;
}

struct Dx_D3D12_NODE_MASK
{
    Win32_UINT node_mask;
}

struct Dx_D3D12_SAMPLE_MASK
{
    Win32_UINT sample_mask;
}

struct Dx_D3D12_IB_STRIP_CUT_VALUE
{
    Dx_D3D12_INDEX_BUFFER_STRIP_CUT_VALUE index_buffer_strip_cut_value;
}

struct Dx_D3D12_PRIMITIVE_TOPOLOGY_DESC
{
    Dx_D3D12_PRIMITIVE_TOPOLOGY_TYPE primitive_topology;
}

struct Dx_D3D12_DEPTH_STENCIL_FORMAT
{
    Dx_DXGI_FORMAT depth_stencil_format;
}

enum Dx_D3D12_EXPORT_FLAGS : const inline CInt
{
    NONE,
}

struct Dx_D3D12_EXPORT_DESC
{
    Win32_LPCWSTR name;
    Win32_LPCWSTR export_to_rename;
    Dx_D3D12_EXPORT_FLAGS flags;
}

struct Dx_D3D12_DXIL_LIBRARY_DESC
{
    Dx_D3D12_SHADER_BYTECODE dxil_library;
    Win32_UINT num_exports;
    Dx_D3D12_EXPORT_DESC* exports;
}

struct Dx_D3D12_EXISTING_COLLECTION_DESC
{
    ID3D12StateObjectRaw* existing_collection;
    Win32_UINT num_exports;
    Dx_D3D12_EXPORT_DESC* exports;
}

struct Dx_D3D12_SUBOBJECT_TO_EXPORTS_ASSOCIATION
{
    Dx_D3D12_STATE_SUBOBJECT* subobject_to_associate;
    Win32_UINT num_exports;
    Win32_LPCWSTR* exports;
}

struct Dx_D3D12_DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION
{
    Win32_LPCWSTR subobject_to_associate;
    Win32_UINT num_exports;
    Win32_LPCWSTR* exports;
}

enum Dx_D3D12_HIT_GROUP_TYPE : const inline CInt
{
    TRIANGLES,
    PROCEDURAL_PRIMITIVE,
}

struct Dx_D3D12_HIT_GROUP_DESC
{
    Win32_LPCWSTR hit_group_export;
    Dx_D3D12_HIT_GROUP_TYPE type;
    Win32_LPCWSTR any_hit_shader_import;
    Win32_LPCWSTR closest_hit_shader_import;
    Win32_LPCWSTR intersection_shader_import;
}

struct Dx_D3D12_RAYTRACING_SHADER_CONFIG
{
    Win32_UINT max_payload_size_in_bytes;
    Win32_UINT max_attribute_size_in_bytes;
}

struct Dx_D3D12_RAYTRACING_PIPELINE_CONFIG
{
    Win32_UINT max_trace_recursion_depth;
}

bitstruct Dx_D3D12_RAYTRACING_PIPELINE_FLAGS : CInt
{
    bool skip_triangles : 8;
    bool skip_procedural_primitives : 9;
    bool allow_opacity_micromap : 10;
}

struct Dx_D3D12_RAYTRACING_PIPELINE_CONFIG1
{
    Win32_UINT max_trace_recursion_depth;
    Dx_D3D12_RAYTRACING_PIPELINE_FLAGS flags;
}

struct Dx_D3D12_NODE_OUTPUT_OVERRIDES
{
    Win32_UINT output_index;
    Dx_D3D12_NODE_ID* new_name;
    Win32_BOOL* allow_sparse_nodes;
    Win32_UINT* max_records;
    Win32_UINT* max_records_shared_with_output_index;
}

struct Dx_D3D12_BROADCASTING_LAUNCH_OVERRIDES
{
    Win32_UINT* local_root_arguments_table_index;
    Win32_BOOL* program_entry;
    Dx_D3D12_NODE_ID* new_name;
    Dx_D3D12_NODE_ID* share_input_of;
    Win32_UINT* dispatch_grid;
    Win32_UINT* max_dispatch_grid;
    Win32_UINT num_output_overrides;
    Dx_D3D12_NODE_OUTPUT_OVERRIDES* output_overrides;
}

struct Dx_D3D12_COALESCING_LAUNCH_OVERRIDES
{
    Win32_UINT* local_root_arguments_table_index;
    Win32_BOOL* program_entry;
    Dx_D3D12_NODE_ID* new_name;
    Dx_D3D12_NODE_ID* share_input_of;
    Win32_UINT num_output_overrides;
    Dx_D3D12_NODE_OUTPUT_OVERRIDES* output_overrides;
}

struct Dx_D3D12_THREAD_LAUNCH_OVERRIDES
{
    Win32_UINT* local_root_arguments_table_index;
    Win32_BOOL* program_entry;
    Dx_D3D12_NODE_ID* new_name;
    Dx_D3D12_NODE_ID* share_input_of;
    Win32_UINT num_output_overrides;
    Dx_D3D12_NODE_OUTPUT_OVERRIDES* output_overrides;
}

struct Dx_D3D12_COMMON_COMPUTE_NODE_OVERRIDES
{
    Win32_UINT* local_root_arguments_table_index;
    Win32_BOOL* program_entry;
    Dx_D3D12_NODE_ID* new_name;
    Dx_D3D12_NODE_ID* share_input_of;
    Win32_UINT num_output_overrides;
    Dx_D3D12_NODE_OUTPUT_OVERRIDES* output_overrides;
}

enum Dx_D3D12_NODE_OVERRIDES_TYPE : const inline CInt
{
    NONE,
    BROADCASTING_LAUNCH,
    COALESCING_LAUNCH,
    THREAD_LAUNCH,
    COMMON_COMPUTE,
}

struct Dx_D3D12_SHADER_NODE
{
    Win32_LPCWSTR shader;
    Dx_D3D12_NODE_OVERRIDES_TYPE overrides_type;
    union 
    {
        Dx_D3D12_BROADCASTING_LAUNCH_OVERRIDES* broadcasting_launch_overrides;
        Dx_D3D12_COALESCING_LAUNCH_OVERRIDES* coalescing_launch_overrides;
        Dx_D3D12_THREAD_LAUNCH_OVERRIDES* thread_launch_overrides;
        Dx_D3D12_COMMON_COMPUTE_NODE_OVERRIDES* common_compute_node_overrides;
    }
}

enum Dx_D3D12_NODE_TYPE : const inline CInt
{
    SHADER,
}

struct Dx_D3D12_NODE
{
    Dx_D3D12_NODE_TYPE node_type;
    union 
    {
        Dx_D3D12_SHADER_NODE shader;
    }
}

bitstruct Dx_D3D12_WORK_GRAPH_FLAGS : CInt
{
    bool include_all_available_nodes;
}
const Dx_D3D12_WORK_GRAPH_FLAGS D3D12_WORK_GRAPH_FLAG_NONE = {};
const Dx_D3D12_WORK_GRAPH_FLAGS D3D12_WORK_GRAPH_FLAG_INCLUDE_ALL_AVAILABLE_NODES = { .include_all_available_nodes };

struct Dx_D3D12_WORK_GRAPH_DESC
{
    Win32_LPCWSTR program_name;
    Dx_D3D12_WORK_GRAPH_FLAGS flags;
    Win32_UINT num_entrypoints;
    Dx_D3D12_NODE_ID* entrypoints;
    Win32_UINT num_explicitly_defined_nodes;
    Dx_D3D12_NODE* explicitly_defined_nodes;
}

struct Dx_D3D12_GENERIC_PROGRAM_DESC
{
    Win32_LPCWSTR program_name;
    Win32_UINT num_exports;
    Win32_LPCWSTR* exports;
    Win32_UINT num_subobjects;
    Dx_D3D12_STATE_SUBOBJECT** subobjects;
}

enum Dx_D3D12_STATE_OBJECT_TYPE : const inline CInt
{
    COLLECTION = 0,
    RAYTRACING_PIPELINE = 3,
    EXECUTABLE = 4
}

struct Dx_D3D12_STATE_OBJECT_DESC
{
    Dx_D3D12_STATE_OBJECT_TYPE type;
    Win32_UINT num_subobjects;
    Dx_D3D12_STATE_SUBOBJECT* subobjects;
}

bitstruct Dx_D3D12_RAYTRACING_GEOMETRY_FLAGS : CInt
{
    bool opaque;
    bool no_duplicate_anyhit_invocation;
}
const Dx_D3D12_RAYTRACING_GEOMETRY_FLAGS D3D12_RAYTRACING_GEOMETRY_FLAG_NONE = {};
const Dx_D3D12_RAYTRACING_GEOMETRY_FLAGS D3D12_RAYTRACING_GEOMETRY_FLAG_OPAQUE = { .opaque };
const Dx_D3D12_RAYTRACING_GEOMETRY_FLAGS D3D12_RAYTRACING_GEOMETRY_FLAG_NO_DUPLICATE_ANYHIT_INVOCATION = { .no_duplicate_anyhit_invocation };

enum Dx_D3D12_RAYTRACING_GEOMETRY_TYPE : const inline CInt
{
    TRIANGLES,
    PROCEDURAL_PRIMITIVE_AABBS,
    OMM_TRIANGLES,
}

bitstruct Dx_D3D12_RAYTRACING_INSTANCE_FLAGS : CInt
{
    bool triangle_cull_disable;
    bool triangle_front_counterclockwise;
    bool force_opaque;
    bool force_non_opaque;
    bool force_omm_2_state;
    bool disable_omms;
}
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_NONE = {};
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_CULL_DISABLE = { .triangle_cull_disable };
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_TRIANGLE_FRONT_COUNTERCLOCKWISE = { .triangle_front_counterclockwise };
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_OPAQUE = { .force_opaque };
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_NON_OPAQUE = { .force_non_opaque };
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_FORCE_OMM_2_STATE = { .force_omm_2_state };
const Dx_D3D12_RAYTRACING_INSTANCE_FLAGS D3D12_RAYTRACING_INSTANCE_FLAG_DISABLE_OMMS = { .disable_omms };

struct Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS start_address;
    Win32_UINT64 stride_in_bytes;
}

struct Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS start_address;
    Win32_UINT64 size_in_bytes;
}

struct Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS start_address;
    Win32_UINT64 size_in_bytes;
    Win32_UINT64 stride_in_bytes;
}

struct Dx_D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS transform3x4;
    Dx_DXGI_FORMAT index_format;
    Dx_DXGI_FORMAT vertex_format;
    Win32_UINT index_count;
    Win32_UINT vertex_count;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS index_buffer;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE vertex_buffer;
}

struct Dx_D3D12_RAYTRACING_AABB
{
    float minX;
    float minY;
    float minZ;
    float maxX;
    float maxY;
    float maxZ;
}

struct Dx_D3D12_RAYTRACING_GEOMETRY_AABBS_DESC
{
    Win32_UINT64 aabb_count;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE aabbs;
}

enum Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_SPECIAL_INDEX : const inline CInt
{
    FULLY_TRANSPARENT = -1,
    FULLY_OPAQUE = -2,
    FULLY_UNKNOWN_TRANSPARENT = -3,
    FULLY_UNKNOWN_OPAQUE = -4
}

enum Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_STATE : const inline CInt
{
    TRANSPARENT,
    OPAQUE,
    UNKNOWN_TRANSPARENT,
    UNKNOWN_OPAQUE,
}

enum Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT : const inline CInt
{
    OC1_2_STATE = 1,
    OC1_4_STATE = 2,
}

bitstruct Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_DESC : ulong
{
    Win32_UINT byte_offset : 0..31;
    Win32_UINT subdivision_level : 32..47;
    Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT format : 48..63;
}

struct Dx_D3D12_RAYTRACING_GEOMETRY_OMM_LINKAGE_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE opacity_micromap_index_buffer;
    Dx_DXGI_FORMAT opacity_micromap_index_format;
    Win32_UINT opacity_micromap_base_location;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS opacity_micromap_array;
}

struct Dx_D3D12_RAYTRACING_GEOMETRY_OMM_TRIANGLES_DESC
{
    Dx_D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC* triangles;
    Dx_D3D12_RAYTRACING_GEOMETRY_OMM_LINKAGE_DESC* omm_linkage;
}

bitstruct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS : CInt
{
    bool allow_update;
    bool allow_compaction;
    bool prefer_fast_trace;
    bool prefer_fast_build;
    bool minimize_memory;
    bool perform_update;
    bool allow_omm_update;
    bool allow_disable_omms;
}
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_NONE = {};
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_UPDATE = { .allow_update };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_COMPACTION = { .allow_compaction };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_TRACE = { .prefer_fast_trace };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PREFER_FAST_BUILD = { .prefer_fast_build };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_MINIMIZE_MEMORY = { .minimize_memory };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_PERFORM_UPDATE = { .perform_update };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_OMM_UPDATE = { .allow_omm_update };
const Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAG_ALLOW_DISABLE_OMMS = { .allow_disable_omms };

enum Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE : const inline CInt
{
    CLONE,
    COMPACT,
    VISUALIZATION_DECODE_FOR_TOOLS,
    SERIALIZE,
    DESERIALIZE,
}

enum Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE : const inline CInt
{
    TOP_LEVEL,
    BOTTOM_LEVEL,
    OPACITY_MICROMAP_ARRAY,
}

enum Dx_D3D12_ELEMENTS_LAYOUT : const inline CInt
{
    ARRAY,
    ARRAY_OF_POINTERS,
}

enum Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE : const inline CInt
{
    COMPACTED_SIZE,
    TOOLS_VISUALIZATION,
    SERIALIZATION,
    CURRENT_SIZE,
}

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS dest_buffer;
    Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE info_type;
}

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE_DESC
{
    Win32_UINT64 compacted_size_in_bytes;
}

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC
{
    Win32_UINT64 decoded_size_in_bytes;
}

struct Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_TOOLS_VISUALIZATION_HEADER
{
    Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE type;
    Win32_UINT num_descs;
}

// Regarding D3D12_BUILD_RAY_TRACING_ACCELERATION_STRUCTURE_TOOLS_VISUALIZATION_HEADER above,
// depending on Type field, NumDescs above is followed by either:
//       D3D12_RAY_TRACING_INSTANCE_DESC InstanceDescs[NumDescs]
//    or D3D12_RAY_TRACING_GEOMETRY_DESC GeometryDescs[NumDescs].
//    or D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_DESC (NumDescs == 1 in this case).
//
// For D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_DESC, the pOmmHistogram pointer becomes a GPUVA instead of CPU pointer
//
// There is 4 bytes of padding between GeometryDesc structs in the array so alignment is natural when viewed by CPU.

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION_DESC
{
    Win32_UINT64 serialized_size_in_bytes;
    union 
    {
        Win32_UINT64 num_bottom_level_acceleration_structure_pointers;
        Win32_UINT64 num_bottom_level_acceleration_structure_header_and_pointer_list_pairs;
    }
}

struct Dx_D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER
{
    Win32_GUID driver_opaque_guid;
    Win32_BYTE[16] driver_opaque_versioning_data;
}

enum Dx_D3D12_SERIALIZED_DATA_TYPE : const inline CInt
{
    RAYTRACING_ACCELERATION_STRUCTURE,
    APPLICATION_SPECIFIC_DRIVER_STATE,
}

enum Dx_D3D12_DRIVER_MATCHING_IDENTIFIER_STATUS : const inline CInt
{
    COMPATIBLE_WITH_DEVICE,
    UNSUPPORTED_TYPE,
    UNRECOGNIZED,
    INCOMPATIBLE_VERSION,
    INCOMPATIBLE_TYPE,
}

struct Dx_D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER
{
    Dx_D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER driver_matching_identifier;
    Win32_UINT64 serialized_size_in_bytes_including_header;
    Win32_UINT64 deserialized_size_in_bytes;
    Win32_UINT64 num_bottom_level_acceleration_structure_pointers_after_header;
}

enum Dx_D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE : const uint
{
    NONE = 0,
    BOTTOM_LEVEL_POINTERS = 0,
    BLOCKS = 0xffffffff,
}

struct Dx_D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER1
{
    Dx_D3D12_SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER driver_matching_identifier;
    Win32_UINT64 serialized_size_in_bytes_including_header;
    Win32_UINT64 deserialized_size_in_bytes;
    union 
    {
        Win32_UINT num_bottom_level_acceleration_structure_pointers_after_header;
        Win32_UINT num_blocks;
    }
    Dx_D3D12_SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER_POSTAMBLE_TYPE header_postamble_type;
}

enum Dx_D3D12_RAYTRACING_SERIALIZED_BLOCK_TYPE : const inline CInt
{
    OPACITY_MICROMAPS,
}

struct Dx_D3D12_RAYTRACING_SERIALIZED_BLOCK
{
    Dx_D3D12_RAYTRACING_SERIALIZED_BLOCK_TYPE type;
    Win32_UINT64 num_block_pointers_after_header;
}

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_CURRENT_SIZE_DESC
{
    Win32_UINT64 current_size_in_bytes;
}

struct Dx_D3D12_RAYTRACING_INSTANCE_DESC
{
    float[3][4] transform;
    Win32_UINT instanceID24_mask8;
    Win32_UINT instance_contribution_to_hit_group_index24_flags8;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS acceleration_structure;
}

struct Dx_D3D12_RAYTRACING_GEOMETRY_DESC
{
    Dx_D3D12_RAYTRACING_GEOMETRY_TYPE type;
    Dx_D3D12_RAYTRACING_GEOMETRY_FLAGS flags;
    union 
    {
        Dx_D3D12_RAYTRACING_GEOMETRY_TRIANGLES_DESC triangles;
        Dx_D3D12_RAYTRACING_GEOMETRY_AABBS_DESC aabbs;
        Dx_D3D12_RAYTRACING_GEOMETRY_OMM_TRIANGLES_DESC omm_triangles;
    }
}

struct Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_HISTOGRAM_ENTRY
{
    Win32_UINT count;
    Win32_UINT subdivision_level;
    Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_FORMAT format;
}

struct Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_DESC
{
    Win32_UINT num_omm_histogram_entries;
    Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_HISTOGRAM_ENTRY* omm_histogram;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS input_buffer;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE per_omm_descs;
}

struct Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS
{
    Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_TYPE type;
    Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS flags;
    Win32_UINT num_descs;
    Dx_D3D12_ELEMENTS_LAYOUT descs_layout;
    union 
    {
        Dx_D3D12_GPU_VIRTUAL_ADDRESS instance_descs;
        Dx_D3D12_RAYTRACING_GEOMETRY_DESC* geometry_descs;
        Dx_D3D12_RAYTRACING_GEOMETRY_DESC** geometry_descs_ptr;
        Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_DESC* opacity_micromap_array_desc;
    }
}

struct Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS dest_acceleration_structure_data;
    Dx_D3D12_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS inputs;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS source_acceleration_structure_data;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS scratch_acceleration_structure_data;
}

struct Dx_D3D12_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO
{
    Win32_UINT64 result_data_max_size_in_bytes_;
    Win32_UINT64 scratch_data_size_in_bytes_;
    Win32_UINT64 update_scratch_data_size_in_bytes_;
}

enum Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TYPE : const inline CInt
{
    CURRENT_SIZE,
    TOOLS_VISUALIZATION,
}

struct Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS destBuffer;
    Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TYPE infoType;
}

struct Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_CURRENT_SIZE_DESC
{
    Win32_UINT64 currentSizeInBytes;
}

struct Dx_D3D12_RAYTRACING_OPACITY_MICROMAP_ARRAY_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC
{
    Win32_UINT64 decodedSizeInBytes;
}

bitstruct Dx_D3D12_RAY_FLAGS : CInt
{
    bool force_opaque;
    bool force_non_opaque;
    bool accept_first_hit_and_end_search;
    bool skip_closest_hit_shader;
    bool cull_back_facing_triangles;
    bool cull_front_facing_triangles;
    bool cull_opaque;
    bool cull_non_opaque;
    bool skip_triangles;
    bool skip_procedural_primitives;
    bool force_omm_2_state;
}
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_NONE = {};
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_FORCE_OPAQUE = { .force_opaque };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_FORCE_NON_OPAQUE = { .force_non_opaque };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_ACCEPT_FIRST_HIT_AND_END_SEARCH = { .accept_first_hit_and_end_search };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_SKIP_CLOSEST_HIT_SHADER = { .skip_closest_hit_shader };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_CULL_BACK_FACING_TRIANGLES = { .cull_back_facing_triangles };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_CULL_FRONT_FACING_TRIANGLES = { .cull_front_facing_triangles };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_CULL_OPAQUE = { .cull_opaque };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_CULL_NON_OPAQUE = { .cull_non_opaque };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_SKIP_TRIANGLES = { .skip_triangles };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_SKIP_PROCEDURAL_PRIMITIVES = { .skip_procedural_primitives };
const Dx_D3D12_RAY_FLAGS D3D12_RAY_FLAG_FORCE_OMM_2_STATE = { .force_omm_2_state };

enum Dx_D3D12_HIT_KIND : const inline CInt
{
    TRIANGLE_FRONT_FACE = 0xfe,
    TRIANGLE_BACK_FACE = 0xff,
}

enum Dx_D3D12_AUTO_BREADCRUMB_OP : const inline CInt
{
    SETMARKER = 0,
    BEGINEVENT = 1,
    ENDEVENT = 2,
    DRAWINSTANCED = 3,
    DRAWINDEXEDINSTANCED = 4,
    EXECUTEINDIRECT = 5,
    DISPATCH = 6,
    COPYBUFFERREGION = 7,
    COPYTEXTUREREGION = 8,
    COPYRESOURCE = 9,
    COPYTILES = 10,
    RESOLVESUBRESOURCE = 11,
    CLEARRENDERTARGETVIEW = 12,
    CLEARUNORDEREDACCESSVIEW = 13,
    CLEARDEPTHSTENCILVIEW = 14,
    RESOURCEBARRIER = 15,
    EXECUTEBUNDLE = 16,
    PRESENT = 17,
    RESOLVEQUERYDATA = 18,
    BEGINSUBMISSION = 19,
    ENDSUBMISSION = 20,
    DECODEFRAME = 21,
    PROCESSFRAMES = 22,
    ATOMICCOPYBUFFERUINT = 23,
    ATOMICCOPYBUFFERUINT64 = 24,
    RESOLVESUBRESOURCEREGION = 25,
    WRITEBUFFERIMMEDIATE = 26,
    DECODEFRAME1 = 27,
    SETPROTECTEDRESOURCESESSION = 28,
    DECODEFRAME2 = 29,
    PROCESSFRAMES1 = 30,
    BUILDRAYTRACINGACCELERATIONSTRUCTURE = 31,
    EMITRAYTRACINGACCELERATIONSTRUCTUREPOSTBUILDINFO = 32,
    COPYRAYTRACINGACCELERATIONSTRUCTURE = 33,
    DISPATCHRAYS = 34,
    INITIALIZEMETACOMMAND = 35,
    EXECUTEMETACOMMAND = 36,
    ESTIMATEMOTION = 37,
    RESOLVEMOTIONVECTORHEAP = 38,
    SETPIPELINESTATE1 = 39,
    INITIALIZEEXTENSIONCOMMAND = 40,
    EXECUTEEXTENSIONCOMMAND = 41,
    DISPATCHMESH = 42,
    ENCODEFRAME = 43,
    RESOLVEENCODEROUTPUTMETADATA = 44,
    BARRIER = 45,
    BEGIN_COMMAND_LIST = 46,
    DISPATCHGRAPH = 47,
    SETPROGRAM = 48,
    PROCESSFRAMES2 = 52
}

struct Dx_D3D12_AUTO_BREADCRUMB_NODE
{
    char* commandlist_debug_name_a;
    Char16* commandlist_debug_name_w;
    char* commandqueue_debug_name_a;
    Char16* commandqueue_debug_name_w;
    ID3D12GraphicsCommandListRaw* command_list;
    ID3D12CommandQueueRaw* command_queue;
    Win32_UINT breadcrumb_count;
    Win32_UINT* last_breadcrumb_value;
    Dx_D3D12_AUTO_BREADCRUMB_OP* command_history;
    Dx_D3D12_AUTO_BREADCRUMB_NODE1* next;
}

struct Dx_D3D12_DRED_BREADCRUMB_CONTEXT
{
    Win32_UINT breadcrumbIndex;
    Char16* contextString;
}

struct Dx_D3D12_AUTO_BREADCRUMB_NODE1
{
    char* commandlist_debug_name_a;
    Char16* commandlist_debug_name_w;
    char* commandqueue_debug_name_a;
    Char16* commandqueue_debug_name_w;
    ID3D12GraphicsCommandListRaw* command_list;
    ID3D12CommandQueueRaw* command_queue;
    Win32_UINT breadcrumb_count;
    Win32_UINT* last_breadcrumb_value;
    Dx_D3D12_AUTO_BREADCRUMB_OP* command_history;
    Dx_D3D12_AUTO_BREADCRUMB_NODE1* next;
    Win32_UINT nreadcrumb_contexts_count;
    Dx_D3D12_DRED_BREADCRUMB_CONTEXT* breadcrumb_contexts;
}

enum Dx_D3D12_DRED_VERSION : const inline CInt
{
    VERSION_1_0 = 0x1,
    VERSION_1_1 = 0x2,
    VERSION_1_2 = 0x3,
    VERSION_1_3 = 0x4
}

enum Dx_D3D12_DRED_FLAGS : const inline CInt
{
    NONE,
    FORCE_ENABLE,
    DISABLE_AUTOBREADCRUMBS,
}

enum Dx_D3D12_DRED_ENABLEMENT : const inline CInt
{
    SYSTEM_CONTROLLED,
    FORCED_OFF,
    FORCED_ON,
}

struct Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA
{
    Dx_D3D12_DRED_FLAGS flags;
    Dx_D3D12_AUTO_BREADCRUMB_NODE* head_auto_breadcrumb_node;
}

enum Dx_D3D12_DRED_ALLOCATION_TYPE : const uint
{
    COMMAND_QUEUE = 19,
    COMMAND_ALLOCATOR = 20,
    PIPELINE_STATE = 21,
    COMMAND_LIST = 22,
    FENCE = 23,
    DESCRIPTOR_HEAP = 24,
    HEAP = 25,
    QUERY_HEAP = 27,
    COMMAND_SIGNATURE = 28,
    PIPELINE_LIBRARY = 29,
    VIDEO_DECODER = 30,
    VIDEO_PROCESSOR = 32,
    RESOURCE = 34,
    PASS = 35,
    CRYPTOSESSION = 36,
    CRYPTOSESSIONPOLICY = 37,
    PROTECTEDRESOURCESESSION = 38,
    VIDEO_DECODER_HEAP = 39,
    COMMAND_POOL = 40,
    COMMAND_RECORDER = 41,
    STATE_OBJECT = 42,
    METACOMMAND = 43,
    SCHEDULINGGROUP = 44,
    VIDEO_MOTION_ESTIMATOR = 45,
    VIDEO_MOTION_VECTOR_HEAP = 46,
    VIDEO_EXTENSION_COMMAND = 47,
    VIDEO_ENCODER = 48,
    VIDEO_ENCODER_HEAP = 49,
    INVALID = 0xffffffff
}

struct Dx_D3D12_DRED_ALLOCATION_NODE
{
    char* object_name_a;
    Char16* object_name_w;
    Dx_D3D12_DRED_ALLOCATION_TYPE allocation_type;
    Dx_D3D12_DRED_ALLOCATION_NODE* next;
}

struct Dx_D3D12_DRED_ALLOCATION_NODE1
{
    char* object_name_a;
    Char16* object_name_w;
    Dx_D3D12_DRED_ALLOCATION_TYPE allocation_type;
    Dx_D3D12_DRED_ALLOCATION_NODE1* next;
    IUnknownRaw* object;
}

struct Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT
{
    Dx_D3D12_AUTO_BREADCRUMB_NODE* head_auto_breadcrumb_node;
}

struct Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1
{
    Dx_D3D12_AUTO_BREADCRUMB_NODE1* head_auto_breadcrumb_node;
}

struct Dx_D3D12_DRED_PAGE_FAULT_OUTPUT
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS page_fault_va;
    Dx_D3D12_DRED_ALLOCATION_NODE1* head_existing_allocation_node;
    Dx_D3D12_DRED_ALLOCATION_NODE1* head_recent_freed_allocation_node;
}

struct Dx_D3D12_DRED_PAGE_FAULT_OUTPUT1
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS page_fault_va;
    Dx_D3D12_DRED_ALLOCATION_NODE1* head_existing_allocation_node;
    Dx_D3D12_DRED_ALLOCATION_NODE1* head_recent_freed_allocation_node;
}

enum Dx_D3D12_DRED_PAGE_FAULT_FLAGS : const inline CInt
{
    NONE,
}

enum Dx_D3D12_DRED_DEVICE_STATE : const inline CInt
{
    UNKNOWN = 0,
    HUNG = 3,
    FAULT = 6,
    PAGEFAULT = 7
}

struct Dx_D3D12_DRED_PAGE_FAULT_OUTPUT2
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS page_fault_va;
    Dx_D3D12_DRED_ALLOCATION_NODE1* head_existing_allocation_node;
    Dx_D3D12_DRED_ALLOCATION_NODE1* head_recent_freed_allocation_node;
    Dx_D3D12_DRED_PAGE_FAULT_FLAGS page_fault_output;
}

struct Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA1
{
    Win32_HRESULT device_removed_reason;
    Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT auto_breadcrumbs_output;
    Dx_D3D12_DRED_PAGE_FAULT_OUTPUT page_fault_output;
}

struct Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA2
{
    Win32_HRESULT device_removed_reason;
    Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1 auto_breadcrumbs_output;
    Dx_D3D12_DRED_PAGE_FAULT_OUTPUT1 page_fault_output;
}

struct Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA3
{
    Win32_HRESULT device_removed_reason;
    Dx_D3D12_DRED_AUTO_BREADCRUMBS_OUTPUT1 auto_breadcrumbs_output;
    Dx_D3D12_DRED_PAGE_FAULT_OUTPUT2 page_fault_output;
    Dx_D3D12_DRED_DEVICE_STATE device_state;
}

struct Dx_D3D12_VERSIONED_DEVICE_REMOVED_EXTENDED_DATA
{
    Dx_D3D12_DRED_VERSION version;
    union 
    {
        Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA dred_1_0;
        Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA1 dred_1_1;
        Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA2 dred_1_2;
        Dx_D3D12_DEVICE_REMOVED_EXTENDED_DATA3 dred_1_3;
    }
}

enum Dx_D3D12_BACKGROUND_PROCESSING_MODE : const inline CInt
{
    ALLOWED,
    ALLOW_INTRUSIVE_MEASUREMENTS,
    DISABLE_BACKGROUND_WORK,
    DISABLE_PROFILING_BY_SYSTEM,
}

enum Dx_D3D12_MEASUREMENTS_ACTION : const inline CInt
{
    KEEP_ALL,
    COMMIT_RESULTS,
    COMMIT_RESULTS_HIGH_PRIORITY,
    DISCARD_PREVIOUS,
}

struct Dx_D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_TYPE_COUNT
{
    Win32_UINT node_index;
    Win32_UINT count;
}

struct Dx_D3D12_FEATURE_DATA_PROTECTED_RESOURCE_SESSION_TYPES
{
    Win32_UINT node_index;
    Win32_UINT count;
    Win32_GUID* types;
}

struct Dx_D3D12_PROTECTED_RESOURCE_SESSION_DESC1
{
    Win32_UINT node_mask;
    Dx_D3D12_PROTECTED_RESOURCE_SESSION_FLAGS flags;
    Win32_GUID protection_type;
}

enum Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE : const inline CInt
{
    DISCARD,
    PRESERVE,
    CLEAR,
    NO_ACCESS,
    PRESERVE_LOCAL_RENDER,
    PRESERVE_LOCAL_SRV,
    PRESERVE_LOCAL_UAV,
}

struct Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS
{
    Dx_D3D12_CLEAR_VALUE clear_value;
}

struct Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS_PRESERVE_LOCAL_PARAMETERS
{
    Win32_UINT additional_width;
    Win32_UINT additional_height;
}

struct Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS
{
    Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS_TYPE type;
    union 
    {
        Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS clear;
        Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS_PRESERVE_LOCAL_PARAMETERS preserve_local;
    }
}

enum Dx_D3D12_RENDER_PASS_ENDING_ACCESS_TYPE : const inline CInt
{
    DISCARD,
    PRESERVE,
    RESOLVE,
    NO_ACCESS,
    PRESERVE_LOCAL_RENDER,
    PRESERVE_LOCAL_SRV,
    PRESERVE_LOCAL_UAV,
}

struct Dx_D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS
{
    Win32_UINT src_subresource;
    Win32_UINT dst_subresource;
    Win32_UINT dst_X;
    Win32_UINT dst_Y;
    Dx_D3D12_RECT src_rect;
}

struct Dx_D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS
{
    ID3D12ResourceRaw* src_resource;
    ID3D12ResourceRaw* dst_resource;
    Win32_UINT subresource_count;
    Dx_D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS* subresource_parameters;
    Dx_DXGI_FORMAT format;
    Dx_D3D12_RESOLVE_MODE resolve_mode;
    Win32_BOOL preserve_resolve_source;
}

struct Dx_D3D12_RENDER_PASS_ENDING_ACCESS_PRESERVE_LOCAL_PARAMETERS
{
    Win32_UINT additional_width;
    Win32_UINT additional_height;
}

struct Dx_D3D12_RENDER_PASS_ENDING_ACCESS
{
    Dx_D3D12_RENDER_PASS_ENDING_ACCESS_TYPE type;
    union 
    {
        Dx_D3D12_RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS resolve;
        Dx_D3D12_RENDER_PASS_ENDING_ACCESS_PRESERVE_LOCAL_PARAMETERS preserve_local;
    }
}

struct Dx_D3D12_RENDER_PASS_RENDER_TARGET_DESC
{
    Dx_D3D12_CPU_DESCRIPTOR_HANDLE cpu_descriptor;
    Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS beginning_access;
    Dx_D3D12_RENDER_PASS_ENDING_ACCESS ending_access;
}

struct Dx_D3D12_RENDER_PASS_DEPTH_STENCIL_DESC
{
    Dx_D3D12_CPU_DESCRIPTOR_HANDLE cpu_descriptor;
    Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS depth_beginning_access;
    Dx_D3D12_RENDER_PASS_BEGINNING_ACCESS stencil_beginning_access;
    Dx_D3D12_RENDER_PASS_ENDING_ACCESS depth_ending_access;
    Dx_D3D12_RENDER_PASS_ENDING_ACCESS stencil_ending_access;
}

bitstruct Dx_D3D12_RENDER_PASS_FLAGS : CInt
{
    bool allow_uav_writes;
    bool suspending_pass;
    bool resuming_pass;
    bool bind_read_only_depth;
    bool bind_read_only_stencil;
}
const Dx_D3D12_RENDER_PASS_FLAGS D3D12_RENDER_PASS_FLAG_NONE = {};
const Dx_D3D12_RENDER_PASS_FLAGS D3D12_RENDER_PASS_FLAG_ALLOW_UAV_WRITES = { .allow_uav_writes };
const Dx_D3D12_RENDER_PASS_FLAGS D3D12_RENDER_PASS_FLAG_SUSPENDING_PASS = { .suspending_pass };
const Dx_D3D12_RENDER_PASS_FLAGS D3D12_RENDER_PASS_FLAG_RESUMING_PASS = { .resuming_pass };
const Dx_D3D12_RENDER_PASS_FLAGS D3D12_RENDER_PASS_FLAG_BIND_READ_ONLY_DEPTH = { .bind_read_only_depth };
const Dx_D3D12_RENDER_PASS_FLAGS D3D12_RENDER_PASS_FLAG_BIND_READ_ONLY_STENCIL = { .bind_read_only_stencil };

struct Dx_D3D12_DISPATCH_RAYS_DESC
{
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE ray_generation_shader_record;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE miss_shader_table;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE hit_group_table;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE callable_shader_table;
    Win32_UINT width;
    Win32_UINT height;
    Win32_UINT depth;
}

bitstruct Dx_D3D12_SET_WORK_GRAPH_FLAGS : CInt
{
    bool initialize;
}
const Dx_D3D12_SET_WORK_GRAPH_FLAGS D3D12_SET_WORK_GRAPH_FLAG_NONE = {};
const Dx_D3D12_SET_WORK_GRAPH_FLAGS D3D12_SET_WORK_GRAPH_FLAG_INITIALIZE = { .initialize };

struct Dx_D3D12_SET_WORK_GRAPH_DESC
{
    Dx_D3D12_PROGRAM_IDENTIFIER program_identifier;
    Dx_D3D12_SET_WORK_GRAPH_FLAGS flags;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE backing_memory;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE node_local_root_arguments_table;
}

struct Dx_D3D12_SET_RAYTRACING_PIPELINE_DESC
{
    Dx_D3D12_PROGRAM_IDENTIFIER program_identifier;
}

struct Dx_D3D12_SET_GENERIC_PIPELINE_DESC
{
    Dx_D3D12_PROGRAM_IDENTIFIER program_identifier;
}

enum Dx_D3D12_PROGRAM_TYPE : const inline CInt
{
    GENERIC_PIPELINE = 1,
    RAYTRACING_PIPELINE = 4,
    WORK_GRAPH = 5,
}

struct Dx_D3D12_SET_PROGRAM_DESC
{
    Dx_D3D12_PROGRAM_TYPE type;
    union 
    {
        Dx_D3D12_SET_GENERIC_PIPELINE_DESC generic_pipeline;
        Dx_D3D12_SET_RAYTRACING_PIPELINE_DESC raytracing_pipeline;
        Dx_D3D12_SET_WORK_GRAPH_DESC work_graph;
    }
}

enum Dx_D3D12_DISPATCH_MODE : const inline CInt
{
    NODE_CPU_INPUT,
    NODE_GPU_INPUT,
    MULTI_NODE_CPU_INPUT,
    MULTI_NODE_GPU_INPUT,
}

struct Dx_D3D12_NODE_CPU_INPUT
{
    Win32_UINT entrypoint_index;
    Win32_UINT num_records;
    void* records;
    Win32_UINT64 record_stride_in_bytes;
}

struct Dx_D3D12_NODE_GPU_INPUT
{
    Win32_UINT entrypoint_index;
    Win32_UINT num_records;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE records;
}

struct Dx_D3D12_MULTI_NODE_CPU_INPUT
{
    Win32_UINT num_node_inputs;
    Dx_D3D12_NODE_CPU_INPUT* node_inputs;
    Win32_UINT64 node_input_stride_in_bytes;
}

struct Dx_D3D12_MULTI_NODE_GPU_INPUT
{
    Win32_UINT num_node_inputs;
    Dx_D3D12_GPU_VIRTUAL_ADDRESS_AND_STRIDE node_inputs;
}

struct Dx_D3D12_DISPATCH_GRAPH_DESC
{
    Dx_D3D12_DISPATCH_MODE mode;
    union 
    {
        Dx_D3D12_NODE_CPU_INPUT node_CPUinput;
        Dx_D3D12_GPU_VIRTUAL_ADDRESS node_GPUinput;
        Dx_D3D12_MULTI_NODE_CPU_INPUT multi_node_CPUinput;
        Dx_D3D12_GPU_VIRTUAL_ADDRESS multi_node_GPUinput;
    }
}

enum Dx_D3D12_SHADER_CACHE_MODE : const inline CInt
{
    MEMORY,
    DISK,
}

bitstruct Dx_D3D12_SHADER_CACHE_FLAGS : CInt
{
    bool driver_versioned;
    bool use_working_dir;
}
const Dx_D3D12_SHADER_CACHE_FLAGS D3D12_SHADER_CACHE_FLAG_NONE = {};
const Dx_D3D12_SHADER_CACHE_FLAGS D3D12_SHADER_CACHE_FLAG_DRIVER_VERSIONED = { .driver_versioned };
const Dx_D3D12_SHADER_CACHE_FLAGS D3D12_SHADER_CACHE_FLAG_USE_WORKING_DIR = { .use_working_dir };

struct Dx_D3D12_SHADER_CACHE_SESSION_DESC
{
    Win32_GUID identifier;
    Dx_D3D12_SHADER_CACHE_MODE mode;
    Dx_D3D12_SHADER_CACHE_FLAGS flags;
    Win32_UINT maximum_in_memory_cache_size_bytes;
    Win32_UINT maximum_in_memory_cache_entries;
    Win32_UINT maximum_value_file_size_bytes;
    Win32_UINT64 version;
}

enum Dx_D3D12_BARRIER_LAYOUT : const uint
{
    UNDEFINED = 0xffffffff,
    COMMON = 0,
    PRESENT = 0,
    GENERIC_READ = 1,
    RENDER_TARGET = 2,
    UNORDERED_ACCESS = 3,
    DEPTH_STENCIL_WRITE = 4,
    DEPTH_STENCIL_READ = 5,
    SHADER_RESOURCE = 6,
    COPY_SOURCE = 7,
    COPY_DEST = 8,
    RESOLVE_SOURCE = 9,
    RESOLVE_DEST = 10,
    SHADING_RATE_SOURCE = 11,
    VIDEO_DECODE_READ = 12,
    VIDEO_DECODE_WRITE = 13,
    VIDEO_PROCESS_READ = 14,
    VIDEO_PROCESS_WRITE = 15,
    VIDEO_ENCODE_READ = 16,
    VIDEO_ENCODE_WRITE = 17,
    DIRECT_QUEUE_COMMON = 18,
    DIRECT_QUEUE_GENERIC_READ = 19,
    DIRECT_QUEUE_UNORDERED_ACCESS = 20,
    DIRECT_QUEUE_SHADER_RESOURCE = 21,
    DIRECT_QUEUE_COPY_SOURCE = 22,
    DIRECT_QUEUE_COPY_DEST = 23,
    COMPUTE_QUEUE_COMMON = 24,
    COMPUTE_QUEUE_GENERIC_READ = 25,
    COMPUTE_QUEUE_UNORDERED_ACCESS = 26,
    COMPUTE_QUEUE_SHADER_RESOURCE = 27,
    COMPUTE_QUEUE_COPY_SOURCE = 28,
    COMPUTE_QUEUE_COPY_DEST = 29,
    VIDEO_QUEUE_COMMON = 30,
}

bitstruct Dx_D3D12_BARRIER_SYNC : uint
{
    bool all : 0;
    bool draw : 1;
    bool index_input : 2;
    bool vertex_shading : 3;
    bool pixel_shading : 4;
    bool depth_stencil : 5;
    bool render_target : 6;
    bool compute_shading : 7;
    bool raytracing : 8;
    bool copy : 9;
    bool resolve : 10;
    bool execute_indirect : 11;
    bool all_shading : 12;
    bool non_pixel_shading : 13;
    bool emit_raytracing_acceleration_structure_postbuild_info : 14;
    bool clear_unordered_access_view : 15;
    bool video_decode : 20;
    bool video_process : 21;
    bool video_encode : 22;
    bool build_raytracing_acceleration_structure : 23;
    bool copy_raytracing_acceleration_structure : 24;
    bool split : 31;
}
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_NONE = {};
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_ALL = { .all };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_DRAW = { .draw };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_INDEX_INPUT = { .index_input };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_VERTEX_SHADING = { .vertex_shading };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_PIXEL_SHADING = { .pixel_shading };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_DEPTH_STENCIL = { .depth_stencil };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_RENDER_TARGET = { .render_target };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_COMPUTE_SHADING = { .compute_shading };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_RAYTRACING = { .raytracing };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_COPY = { .copy };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_RESOLVE = { .resolve };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_EXECUTE_INDIRECT = { .execute_indirect };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_PREDICATION = { .execute_indirect };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_ALL_SHADING = { .all_shading };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_NON_PIXEL_SHADING = { .non_pixel_shading };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_EMIT_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO = { .emit_raytracing_acceleration_structure_postbuild_info };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_CLEAR_UNORDERED_ACCESS_VIEW = { .clear_unordered_access_view };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_VIDEO_DECODE = { .video_decode };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_VIDEO_PROCESS = { .video_process };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_VIDEO_ENCODE = { .video_encode };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_BUILD_RAYTRACING_ACCELERATION_STRUCTURE = { .build_raytracing_acceleration_structure };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_COPY_RAYTRACING_ACCELERATION_STRUCTURE = { .copy_raytracing_acceleration_structure };
const Dx_D3D12_BARRIER_SYNC D3D12_BARRIER_SYNC_SPLIT = { .split };

bitstruct Dx_D3D12_BARRIER_ACCESS : uint
{
    bool vertex_buffer : 0;
    bool constant_buffer : 1;
    bool index_buffer : 2;
    bool render_target : 3;
    bool unordered_access : 4;
    bool depth_stencil_write : 5;
    bool depth_stencil_read : 6;
    bool shader_resource : 7;
    bool stream_output : 8;
    bool indirect_argument : 9;
    bool copy_dest : 10;
    bool copy_source : 11;
    bool resolve_dest : 12;
    bool resolve_source : 13;
    bool raytracing_acceleration_structure_read : 14;
    bool raytracing_acceleration_structure_write : 15;
    bool shading_rate_source : 16;
    bool video_decode_read : 17;
    bool video_decode_write : 18;
    bool video_process_read : 19;
    bool video_process_write : 20;
    bool video_encode_read : 21;
    bool video_encode_write : 22;
    bool no_access : 31;
}
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_COMMON = {};
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VERTEX_BUFFER = { .vertex_buffer };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_CONSTANT_BUFFER = { .constant_buffer };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_INDEX_BUFFER = { .index_buffer };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_RENDER_TARGET = { .render_target };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_UNORDERED_ACCESS = { .unordered_access };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_DEPTH_STENCIL_WRITE = { .depth_stencil_write };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_DEPTH_STENCIL_READ = { .depth_stencil_read };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_SHADER_RESOURCE = { .shader_resource };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_STREAM_OUTPUT = { .stream_output };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_INDIRECT_ARGUMENT = { .indirect_argument };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_PREDICATION = { .indirect_argument };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_COPY_DEST = { .copy_dest };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_COPY_SOURCE = { .copy_source };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_RESOLVE_DEST = { .resolve_dest };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_RESOLVE_SOURCE = { .resolve_source };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_RAYTRACING_ACCELERATION_STRUCTURE_READ = { .raytracing_acceleration_structure_read };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_RAYTRACING_ACCELERATION_STRUCTURE_WRITE = { .raytracing_acceleration_structure_write };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_SHADING_RATE_SOURCE = { .shading_rate_source };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VIDEO_DECODE_READ = { .video_decode_read };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VIDEO_DECODE_WRITE = { .video_decode_write };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VIDEO_PROCESS_READ = { .video_process_read };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VIDEO_PROCESS_WRITE = { .video_process_write };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VIDEO_ENCODE_READ = { .video_encode_read };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_VIDEO_ENCODE_WRITE = { .video_encode_write };
const Dx_D3D12_BARRIER_ACCESS D3D12_BARRIER_ACCESS_NO_ACCESS = { .no_access };

enum Dx_D3D12_BARRIER_TYPE : const inline CInt
{
    GLOBAL,
    TEXTURE,
    BUFFER,
}

bitstruct Dx_D3D12_TEXTURE_BARRIER_FLAGS : CInt
{
    bool discard;
}
const Dx_D3D12_TEXTURE_BARRIER_FLAGS D3D12_TEXTURE_BARRIER_FLAG_NONE = {};
const Dx_D3D12_TEXTURE_BARRIER_FLAGS D3D12_TEXTURE_BARRIER_FLAG_DISCARD = { .discard };

struct Dx_D3D12_BARRIER_SUBRESOURCE_RANGE
{
    Win32_UINT index_or_first_mip_level;
    Win32_UINT num_mip_levels;
    Win32_UINT first_array_slice;
    Win32_UINT num_array_slices;
    Win32_UINT first_plane;
    Win32_UINT num_planes;
}

struct Dx_D3D12_GLOBAL_BARRIER
{
    Dx_D3D12_BARRIER_SYNC sync_before;
    Dx_D3D12_BARRIER_SYNC sync_after;
    Dx_D3D12_BARRIER_ACCESS access_before;
    Dx_D3D12_BARRIER_ACCESS access_after;
}

struct Dx_D3D12_TEXTURE_BARRIER
{
    Dx_D3D12_BARRIER_SYNC sync_before;
    Dx_D3D12_BARRIER_SYNC sync_after;
    Dx_D3D12_BARRIER_ACCESS access_before;
    Dx_D3D12_BARRIER_ACCESS access_after;
    Dx_D3D12_BARRIER_LAYOUT layout_before;
    Dx_D3D12_BARRIER_LAYOUT layout_after;
    ID3D12ResourceRaw* resource;
    Dx_D3D12_BARRIER_SUBRESOURCE_RANGE subresources;
    Dx_D3D12_TEXTURE_BARRIER_FLAGS flags;
}

struct Dx_D3D12_BUFFER_BARRIER
{
    Dx_D3D12_BARRIER_SYNC sync_before;
    Dx_D3D12_BARRIER_SYNC sync_after;
    Dx_D3D12_BARRIER_ACCESS access_before;
    Dx_D3D12_BARRIER_ACCESS access_after;
    ID3D12ResourceRaw* resource;
    Win32_UINT64 offset;
    Win32_UINT64 size;
}

struct Dx_D3D12_BARRIER_GROUP
{
    Dx_D3D12_BARRIER_TYPE type;
    Win32_UINT32 num_barriers;
    union 
    {
        Dx_D3D12_GLOBAL_BARRIER* global_barriers;
        Dx_D3D12_TEXTURE_BARRIER* texture_barriers;
        Dx_D3D12_BUFFER_BARRIER* buffer_barriers;
    }
}

bitstruct Dx_D3D12_SHADER_CACHE_KIND_FLAGS : CInt
{
    bool implicit_d3d_cache_for_driver : 0;
    bool implicit_d3d_conversions : 1;
    bool implicit_driver_managed : 2;
    bool application_managed : 3;
}
const Dx_D3D12_SHADER_CACHE_KIND_FLAGS D3D12_SHADER_CACHE_KIND_FLAG_IMPLICIT_D3D_CACHE_FOR_DRIVER = { .implicit_d3d_cache_for_driver };
const Dx_D3D12_SHADER_CACHE_KIND_FLAGS D3D12_SHADER_CACHE_KIND_FLAG_IMPLICIT_D3D_CONVERSIONS = { .implicit_d3d_conversions };
const Dx_D3D12_SHADER_CACHE_KIND_FLAGS D3D12_SHADER_CACHE_KIND_FLAG_IMPLICIT_DRIVER_MANAGED = { .implicit_driver_managed };
const Dx_D3D12_SHADER_CACHE_KIND_FLAGS D3D12_SHADER_CACHE_KIND_FLAG_APPLICATION_MANAGED = { .application_managed };

bitstruct Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS : CInt
{
    bool disable : 0;
    bool enable : 1;
    bool clear : 2;
}
const Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS D3D12_SHADER_CACHE_CONTROL_FLAG_DISABLE = { .disable };
const Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS D3D12_SHADER_CACHE_CONTROL_FLAG_ENABLE = { .enable };
const Dx_D3D12_SHADER_CACHE_CONTROL_FLAGS D3D12_SHADER_CACHE_CONTROL_FLAG_CLEAR = { .clear };

enum Dx_D3D12_APPLICATION_SPECIFIC_DRIVER_BLOB_STATUS : const inline CInt
{
    UNKNOWN = 1,
    USED = 2,
    IGNORED = 3,
    NOT_SPECIFIED = 4
}

struct Dx_D3D12_SUBRESOURCE_DATA
{
    void* data;
    Win32_LONG_PTR row_pitch;
    Win32_LONG_PTR slice_pitch;
}

struct Dx_D3D12_MEMCPY_DEST
{
    void* data;
    Win32_SIZE_T row_pitch;
    Win32_SIZE_T slice_pitch;
}

bitstruct Dx_D3D12_DEVICE_FACTORY_FLAGS : CInt
{
    bool allow_returning_existing_device;
    bool allow_returning_incompatible_existing_device;
    bool disallow_storing_new_device_as_singleton;
}
const Dx_D3D12_DEVICE_FACTORY_FLAGS D3D12_DEVICE_FACTORY_FLAG_NONE = {};
const Dx_D3D12_DEVICE_FACTORY_FLAGS D3D12_DEVICE_FACTORY_FLAG_ALLOW_RETURNING_EXISTING_DEVICE = { .allow_returning_existing_device };
const Dx_D3D12_DEVICE_FACTORY_FLAGS D3D12_DEVICE_FACTORY_FLAG_ALLOW_RETURNING_INCOMPATIBLE_EXISTING_DEVICE = { .allow_returning_incompatible_existing_device };
const Dx_D3D12_DEVICE_FACTORY_FLAGS D3D12_DEVICE_FACTORY_FLAG_DISALLOW_STORING_NEW_DEVICE_AS_SINGLETON = { .disallow_storing_new_device_as_singleton };

bitstruct Dx_D3D12_DEVICE_FLAGS : CInt
{
    bool debug_layer_enabled;
    bool gpu_based_validation_enabled;
    bool synchronized_command_queue_validation_disabled;
    bool dred_auto_breadcrumbs_enabled;
    bool dred_page_fault_reporting_enabled;
    bool dred_watson_reporting_enabled;
    bool dred_breadcrumb_context_enabled;
    bool dred_use_markers_only_breadcrumbs;
    bool shader_instrumentation_enabled;
    bool auto_debug_name_enabled;
    bool force_lagacy_state_validation;
}
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_NONE = {};
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_DEBUG_LAYER_ENABLED = { .debug_layer_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_GPU_BASED_VALIDATION_ENABLED = { .gpu_based_validation_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_SYNCHRONIZED_COMMAND_QUEUE_VALIDATION_DISABLED = { .synchronized_command_queue_validation_disabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_DRED_AUTO_BREADCRUMBS_ENABLED = { .dred_auto_breadcrumbs_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_DRED_PAGE_FAULT_REPORTING_ENABLED = { .dred_page_fault_reporting_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_DRED_WATSON_REPORTING_ENABLED = { .dred_watson_reporting_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_DRED_BREADCRUMB_CONTEXT_ENABLED = { .dred_breadcrumb_context_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_DRED_USE_MARKERS_ONLY_BREADCRUMBS = { .dred_use_markers_only_breadcrumbs };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_SHADER_INSTRUMENTATION_ENABLED = { .shader_instrumentation_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_AUTO_DEBUG_NAME_ENABLED = { .auto_debug_name_enabled };
const Dx_D3D12_DEVICE_FLAGS D3D12_DEVICE_FLAG_FORCE_LAGACY_STATE_VALIDATION = { .force_lagacy_state_validation };

struct Dx_D3D12_DEVICE_CONFIGURATION_DESC
{
    Dx_D3D12_DEVICE_FLAGS flags;
    Win32_UINT gpu_based_validation_flags;
    Win32_UINT sdk_version;
    Win32_UINT num_enabled_experimental_features;
}

enum Dx_D3D12_AXIS_SHADING_RATE : const inline CInt
{
    RATE_1X,
    RATE_2X,
    RATE_4X,
}

enum Dx_D3D12_SHADING_RATE : const inline CInt
{
    RATE_1X1 = 0,
    RATE_1X2 = 0x1,
    RATE_2X1 = 0x4,
    RATE_2X2 = 0x5,
    RATE_2X4 = 0x6,
    RATE_4X2 = 0x9,
    RATE_4X4 = 0xa,
}

enum Dx_D3D12_SHADING_RATE_COMBINER : const inline CInt
{
    PASSTHROUGH,
    OVERRIDE,
    MIN,
    MAX,
    SUM,
}

struct Dx_D3D12_DISPATCH_MESH_ARGUMENTS
{
    Win32_UINT thread_group_count_x;
    Win32_UINT thread_group_count_y;
    Win32_UINT thread_group_count_z;
}

struct Dx_D3D12_TILED_RESOURCE_COORDINATE
{
    Win32_UINT x;
    Win32_UINT y;
    Win32_UINT z;
    Win32_UINT subresource;
}

bitstruct Dx_D3D12_GPU_BASED_VALIDATION_FLAGS : CInt
{
    bool disable_state_tracking;
}
const Dx_D3D12_GPU_BASED_VALIDATION_FLAGS D3D12_GPU_BASED_VALIDATION_FLAG_NONE = {};
const Dx_D3D12_GPU_BASED_VALIDATION_FLAGS D3D12_GPU_BASED_VALIDATION_FLAG_DISABLE_STATE_TRACKING = { .disable_state_tracking };

bitstruct Dx_D3D12_RLDO_FLAGS : CInt
{
    bool summary;
    bool detail;
    bool ignore_internal;
}
const Dx_D3D12_RLDO_FLAGS D3D12_RLDO_FLAG_NONE = {};
const Dx_D3D12_RLDO_FLAGS D3D12_RLDO_FLAG_SUMMARY = { .summary };
const Dx_D3D12_RLDO_FLAGS D3D12_RLDO_FLAG_DETAIL = { .detail };
const Dx_D3D12_RLDO_FLAGS D3D12_RLDO_FLAG_IGNORE_INTERNAL = { .ignore_internal };

bitstruct Dx_D3D12_MESSAGE_CALLBACK_FLAGS : Win32_DWORD
{
    bool ignore_filters;
}
const Dx_D3D12_MESSAGE_CALLBACK_FLAGS D3D12_MESSAGE_CALLBACK_FLAG_NONE = {};
const Dx_D3D12_MESSAGE_CALLBACK_FLAGS D3D12_MESSAGE_CALLBACK_FLAG_IGNORE_FILTERS = { .ignore_filters };

enum Dx_D3D12_MESSAGE_CATEGORY : const inline CInt
{
    APPLICATION_DEFINED,
    MISCELLANEOUS,
    INITIALIZATION,
    CLEANUP,
    COMPILATION,
    STATE_CREATION,
    STATE_SETTING,
    STATE_GETTING,
    RESOURCE_MANIPULATION,
    EXECUTION,
    SHADER,
}

enum Dx_D3D12_MESSAGE_SEVERITY : const inline CInt
{
    CORRUPTION,
    ERROR,
    WARNING,
    INFO,
    MESSAGE, 
}

enum Dx_D3D12_MESSAGE_ID : const inline CInt
{
    UNKNOWN = 0,
    STRING_FROM_APPLICATION = 1,
    CORRUPTED_THIS = 2,
    CORRUPTED_PARAMETER1 = 3,
    CORRUPTED_PARAMETER2 = 4,
    CORRUPTED_PARAMETER3 = 5,
    CORRUPTED_PARAMETER4 = 6,
    CORRUPTED_PARAMETER5 = 7,
    CORRUPTED_PARAMETER6 = 8,
    CORRUPTED_PARAMETER7 = 9,
    CORRUPTED_PARAMETER8 = 10,
    CORRUPTED_PARAMETER9 = 11,
    CORRUPTED_PARAMETER10 = 12,
    CORRUPTED_PARAMETER11 = 13,
    CORRUPTED_PARAMETER12 = 14,
    CORRUPTED_PARAMETER13 = 15,
    CORRUPTED_PARAMETER14 = 16,
    CORRUPTED_PARAMETER15 = 17,
    CORRUPTED_MULTITHREADING = 18,
    MESSAGE_REPORTING_OUTOFMEMORY = 19,
    GETPRIVATEDATA_MOREDATA = 20,
    SETPRIVATEDATA_INVALIDFREEDATA = 21,
    SETPRIVATEDATA_CHANGINGPARAMS = 24,
    SETPRIVATEDATA_OUTOFMEMORY = 25,
    CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT = 26,
    CREATESHADERRESOURCEVIEW_INVALIDDESC = 27,
    CREATESHADERRESOURCEVIEW_INVALIDFORMAT = 28,
    CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANESLICE = 29,
    CREATESHADERRESOURCEVIEW_INVALIDPLANESLICE = 30,
    CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS = 31,
    CREATESHADERRESOURCEVIEW_INVALIDRESOURCE = 32,
    CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT = 35,
    CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT = 36,
    CREATERENDERTARGETVIEW_INVALIDDESC = 37,
    CREATERENDERTARGETVIEW_INVALIDFORMAT = 38,
    CREATERENDERTARGETVIEW_INVALIDVIDEOPLANESLICE = 39,
    CREATERENDERTARGETVIEW_INVALIDPLANESLICE = 40,
    CREATERENDERTARGETVIEW_INVALIDDIMENSIONS = 41,
    CREATERENDERTARGETVIEW_INVALIDRESOURCE = 42,
    CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT = 45,
    CREATEDEPTHSTENCILVIEW_INVALIDDESC = 46,
    CREATEDEPTHSTENCILVIEW_INVALIDFORMAT = 47,
    CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS = 48,
    CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE = 49,
    CREATEINPUTLAYOUT_OUTOFMEMORY = 52,
    CREATEINPUTLAYOUT_TOOMANYELEMENTS = 53,
    CREATEINPUTLAYOUT_INVALIDFORMAT = 54,
    CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT = 55,
    CREATEINPUTLAYOUT_INVALIDSLOT = 56,
    CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS = 57,
    CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH = 58,
    CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE = 59,
    CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE = 60,
    CREATEINPUTLAYOUT_INVALIDALIGNMENT = 61,
    CREATEINPUTLAYOUT_DUPLICATESEMANTIC = 62,
    CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE = 63,
    CREATEINPUTLAYOUT_NULLSEMANTIC = 64,
    CREATEINPUTLAYOUT_MISSINGELEMENT = 65,
    CREATEVERTEXSHADER_OUTOFMEMORY = 66,
    CREATEVERTEXSHADER_INVALIDSHADERBYTECODE = 67,
    CREATEVERTEXSHADER_INVALIDSHADERTYPE = 68,
    CREATEGEOMETRYSHADER_OUTOFMEMORY = 69,
    CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE = 70,
    CREATEGEOMETRYSHADER_INVALIDSHADERTYPE = 71,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY = 72,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE = 73,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE = 74,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES = 75,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED = 76,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED = 79,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT = 80,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT = 81,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT = 82,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT = 83,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION = 84,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT = 85,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE = 86,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC = 87,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH = 88,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS = 89,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX = 90,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE = 91,
    CREATEPIXELSHADER_OUTOFMEMORY = 92,
    CREATEPIXELSHADER_INVALIDSHADERBYTECODE = 93,
    CREATEPIXELSHADER_INVALIDSHADERTYPE = 94,
    CREATERASTERIZERSTATE_INVALIDFILLMODE = 95,
    CREATERASTERIZERSTATE_INVALIDCULLMODE = 96,
    CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP = 97,
    CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS = 98,
    CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK = 100,
    CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC = 101,
    CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP = 102,
    CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP = 103,
    CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP = 104,
    CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC = 105,
    CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP = 106,
    CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP = 107,
    CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP = 108,
    CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC = 109,
    CREATEBLENDSTATE_INVALIDSRCBLEND = 111,
    CREATEBLENDSTATE_INVALIDDESTBLEND = 112,
    CREATEBLENDSTATE_INVALIDBLENDOP = 113,
    CREATEBLENDSTATE_INVALIDSRCBLENDALPHA = 114,
    CREATEBLENDSTATE_INVALIDDESTBLENDALPHA = 115,
    CREATEBLENDSTATE_INVALIDBLENDOPALPHA = 116,
    CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK = 117,
    GET_PROGRAM_IDENTIFIER_ERROR = 118,
    GET_WORK_GRAPH_PROPERTIES_ERROR = 119,
    SET_PROGRAM_ERROR = 120,
    CLEARDEPTHSTENCILVIEW_INVALID = 135,
    COMMAND_LIST_DRAW_ROOT_SIGNATURE_NOT_SET = 200,
    COMMAND_LIST_DRAW_ROOT_SIGNATURE_MISMATCH = 201,
    COMMAND_LIST_DRAW_VERTEX_BUFFER_NOT_SET = 202,
    COMMAND_LIST_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL = 209,
    COMMAND_LIST_DRAW_VERTEX_BUFFER_TOO_SMALL = 210,
    COMMAND_LIST_DRAW_INDEX_BUFFER_NOT_SET = 211,
    COMMAND_LIST_DRAW_INDEX_BUFFER_FORMAT_INVALID = 212,
    COMMAND_LIST_DRAW_INDEX_BUFFER_TOO_SMALL = 213,
    COMMAND_LIST_DRAW_INVALID_PRIMITIVETOPOLOGY = 219,
    COMMAND_LIST_DRAW_VERTEX_STRIDE_UNALIGNED = 221,
    COMMAND_LIST_DRAW_INDEX_OFFSET_UNALIGNED = 222,
    DEVICE_REMOVAL_PROCESS_AT_FAULT = 232,
    DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT = 233,
    DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT = 234,
    CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC = 239,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC = 240,
    CREATEINPUTLAYOUT_TYPE_MISMATCH = 245,
    CREATEINPUTLAYOUT_EMPTY_LAYOUT = 253,
    LIVE_OBJECT_SUMMARY = 255,
    LIVE_DEVICE = 274,
    LIVE_SWAPCHAIN = 275,
    CREATEDEPTHSTENCILVIEW_INVALIDFLAGS = 276,
    CREATEVERTEXSHADER_INVALIDCLASSLINKAGE = 277,
    CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE = 278,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER = 280,
    CREATEPIXELSHADER_INVALIDCLASSLINKAGE = 283,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM = 284,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES = 285,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES = 286,
    CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES = 287,
    CREATEHULLSHADER_OUTOFMEMORY = 289,
    CREATEHULLSHADER_INVALIDSHADERBYTECODE = 290,
    CREATEHULLSHADER_INVALIDSHADERTYPE = 291,
    CREATEHULLSHADER_INVALIDCLASSLINKAGE = 292,
    CREATEDOMAINSHADER_OUTOFMEMORY = 294,
    CREATEDOMAINSHADER_INVALIDSHADERBYTECODE = 295,
    CREATEDOMAINSHADER_INVALIDSHADERTYPE = 296,
    CREATEDOMAINSHADER_INVALIDCLASSLINKAGE = 297,
    RESOURCE_UNMAP_NOTMAPPED = 310,
    DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE = 318,
    CREATECOMPUTESHADER_OUTOFMEMORY = 321,
    CREATECOMPUTESHADER_INVALIDSHADERBYTECODE = 322,
    CREATECOMPUTESHADER_INVALIDCLASSLINKAGE = 323,
    DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED = 331,
    DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED = 332,
    DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED = 333,
    DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED = 334,
    DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED = 335,
    DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED = 336,
    DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED = 337,
    CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE = 340,
    CREATEUNORDEREDACCESSVIEW_INVALIDDESC = 341,
    CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT = 342,
    CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANESLICE = 343,
    CREATEUNORDEREDACCESSVIEW_INVALIDPLANESLICE = 344,
    CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS = 345,
    CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT = 346,
    CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS = 354,
    CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT = 401,
    CREATEBLENDSTATE_INVALIDLOGICOPS = 403,
    DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = 410,
    DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = 412,
    DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = 414,
    DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = 416,
    DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED = 418,
    DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = 420,
    DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED = 422,
    DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED = 425,
    DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED = 426,
    DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED = 427,
    DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED = 428,
    DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED = 429,
    DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED = 430,
    DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED = 431,
    DEVICE_CLEARVIEW_INVALIDSOURCERECT = 447,
    DEVICE_CLEARVIEW_EMPTYRECT = 448,
    UPDATETILEMAPPINGS_INVALID_PARAMETER = 493,
    COPYTILEMAPPINGS_INVALID_PARAMETER = 494,
    CREATEDEVICE_INVALIDARGS = 506,
    CREATEDEVICE_WARNING = 507,
    RESOURCE_BARRIER_INVALID_TYPE = 519,
    RESOURCE_BARRIER_NULL_POINTER = 520,
    RESOURCE_BARRIER_INVALID_SUBRESOURCE = 521,
    RESOURCE_BARRIER_RESERVED_BITS = 522,
    RESOURCE_BARRIER_MISSING_BIND_FLAGS = 523,
    RESOURCE_BARRIER_MISMATCHING_MISC_FLAGS = 524,
    RESOURCE_BARRIER_MATCHING_STATES = 525,
    RESOURCE_BARRIER_INVALID_COMBINATION = 526,
    RESOURCE_BARRIER_BEFORE_AFTER_MISMATCH = 527,
    RESOURCE_BARRIER_INVALID_RESOURCE = 528,
    RESOURCE_BARRIER_SAMPLE_COUNT = 529,
    RESOURCE_BARRIER_INVALID_FLAGS = 530,
    RESOURCE_BARRIER_INVALID_COMBINED_FLAGS = 531,
    RESOURCE_BARRIER_INVALID_FLAGS_FOR_FORMAT = 532,
    RESOURCE_BARRIER_INVALID_SPLIT_BARRIER = 533,
    RESOURCE_BARRIER_UNMATCHED_END = 534,
    RESOURCE_BARRIER_UNMATCHED_BEGIN = 535,
    RESOURCE_BARRIER_INVALID_FLAG = 536,
    RESOURCE_BARRIER_INVALID_COMMAND_LIST_TYPE = 537,
    INVALID_SUBRESOURCE_STATE = 538,
    COMMAND_ALLOCATOR_CONTENTION = 540,
    COMMAND_ALLOCATOR_RESET = 541,
    COMMAND_ALLOCATOR_RESET_BUNDLE = 542,
    COMMAND_ALLOCATOR_CANNOT_RESET = 543,
    COMMAND_LIST_OPEN = 544,
    INVALID_BUNDLE_API = 546,
    COMMAND_LIST_CLOSED = 547,
    WRONG_COMMAND_ALLOCATOR_TYPE = 549,
    COMMAND_ALLOCATOR_SYNC = 552,
    COMMAND_LIST_SYNC = 553,
    SET_DESCRIPTOR_HEAP_INVALID = 554,
    CREATE_COMMANDQUEUE = 557,
    CREATE_COMMANDALLOCATOR = 558,
    CREATE_PIPELINESTATE = 559,
    CREATE_COMMANDLIST12 = 560,
    CREATE_RESOURCE = 562,
    CREATE_DESCRIPTORHEAP = 563,
    CREATE_ROOTSIGNATURE = 564,
    CREATE_LIBRARY = 565,
    CREATE_HEAP = 566,
    CREATE_MONITOREDFENCE = 567,
    CREATE_QUERYHEAP = 568,
    CREATE_COMMANDSIGNATURE = 569,
    LIVE_COMMANDQUEUE = 570,
    LIVE_COMMANDALLOCATOR = 571,
    LIVE_PIPELINESTATE = 572,
    LIVE_COMMANDLIST12 = 573,
    LIVE_RESOURCE = 575,
    LIVE_DESCRIPTORHEAP = 576,
    LIVE_ROOTSIGNATURE = 577,
    LIVE_LIBRARY = 578,
    LIVE_HEAP = 579,
    LIVE_MONITOREDFENCE = 580,
    LIVE_QUERYHEAP = 581,
    LIVE_COMMANDSIGNATURE = 582,
    DESTROY_COMMANDQUEUE = 583,
    DESTROY_COMMANDALLOCATOR = 584,
    DESTROY_PIPELINESTATE = 585,
    DESTROY_COMMANDLIST12 = 586,
    DESTROY_RESOURCE = 588,
    DESTROY_DESCRIPTORHEAP = 589,
    DESTROY_ROOTSIGNATURE = 590,
    DESTROY_LIBRARY = 591,
    DESTROY_HEAP = 592,
    DESTROY_MONITOREDFENCE = 593,
    DESTROY_QUERYHEAP = 594,
    DESTROY_COMMANDSIGNATURE = 595,
    CREATERESOURCE_INVALIDDIMENSIONS = 597,
    CREATERESOURCE_INVALIDMISCFLAGS = 599,
    CREATERESOURCE_INVALIDARG_RETURN = 602,
    CREATERESOURCE_OUTOFMEMORY_RETURN = 603,
    CREATERESOURCE_INVALIDDESC = 604,
    POSSIBLY_INVALID_SUBRESOURCE_STATE = 607,
    INVALID_USE_OF_NON_RESIDENT_RESOURCE = 608,
    POSSIBLE_INVALID_USE_OF_NON_RESIDENT_RESOURCE = 609,
    BUNDLE_PIPELINE_STATE_MISMATCH = 610,
    PRIMITIVE_TOPOLOGY_MISMATCH_PIPELINE_STATE = 611,
    RENDER_TARGET_FORMAT_MISMATCH_PIPELINE_STATE = 613,
    RENDER_TARGET_SAMPLE_DESC_MISMATCH_PIPELINE_STATE = 614,
    DEPTH_STENCIL_FORMAT_MISMATCH_PIPELINE_STATE = 615,
    DEPTH_STENCIL_SAMPLE_DESC_MISMATCH_PIPELINE_STATE = 616,
    CREATESHADER_INVALIDBYTECODE = 622,
    CREATEHEAP_NULLDESC = 623,
    CREATEHEAP_INVALIDSIZE = 624,
    CREATEHEAP_UNRECOGNIZEDHEAPTYPE = 625,
    CREATEHEAP_UNRECOGNIZEDCPUPAGEPROPERTIES = 626,
    CREATEHEAP_UNRECOGNIZEDMEMORYPOOL = 627,
    CREATEHEAP_INVALIDPROPERTIES = 628,
    CREATEHEAP_INVALIDALIGNMENT = 629,
    CREATEHEAP_UNRECOGNIZEDMISCFLAGS = 630,
    CREATEHEAP_INVALIDMISCFLAGS = 631,
    CREATEHEAP_INVALIDARG_RETURN = 632,
    CREATEHEAP_OUTOFMEMORY_RETURN = 633,
    CREATERESOURCEANDHEAP_NULLHEAPPROPERTIES = 634,
    CREATERESOURCEANDHEAP_UNRECOGNIZEDHEAPTYPE = 635,
    CREATERESOURCEANDHEAP_UNRECOGNIZEDCPUPAGEPROPERTIES = 636,
    CREATERESOURCEANDHEAP_UNRECOGNIZEDMEMORYPOOL = 637,
    CREATERESOURCEANDHEAP_INVALIDHEAPPROPERTIES = 638,
    CREATERESOURCEANDHEAP_UNRECOGNIZEDHEAPMISCFLAGS = 639,
    CREATERESOURCEANDHEAP_INVALIDHEAPMISCFLAGS = 640,
    CREATERESOURCEANDHEAP_INVALIDARG_RETURN = 641,
    CREATERESOURCEANDHEAP_OUTOFMEMORY_RETURN = 642,
    GETCUSTOMHEAPPROPERTIES_UNRECOGNIZEDHEAPTYPE = 643,
    GETCUSTOMHEAPPROPERTIES_INVALIDHEAPTYPE = 644,
    CREATE_DESCRIPTOR_HEAP_INVALID_DESC = 645,
    INVALID_DESCRIPTOR_HANDLE = 646,
    CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE = 647,
    CREATE_CONSTANT_BUFFER_VIEW_INVALID_RESOURCE = 649,
    CREATE_CONSTANT_BUFFER_VIEW_INVALID_DESC = 650,
    CREATE_UNORDEREDACCESS_VIEW_INVALID_COUNTER_USAGE = 652,
    COPY_DESCRIPTORS_INVALID_RANGES = 653,
    COPY_DESCRIPTORS_WRITE_ONLY_DESCRIPTOR = 654,
    CREATEGRAPHICSPIPELINESTATE_RTV_FORMAT_NOT_UNKNOWN = 655,
    CREATEGRAPHICSPIPELINESTATE_INVALID_RENDER_TARGET_COUNT = 656,
    CREATEGRAPHICSPIPELINESTATE_VERTEX_SHADER_NOT_SET = 657,
    CREATEGRAPHICSPIPELINESTATE_INPUTLAYOUT_NOT_SET = 658,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_HS_DS_SIGNATURE_MISMATCH = 659,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_REGISTERINDEX = 660,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_COMPONENTTYPE = 661,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_REGISTERMASK = 662,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_SYSTEMVALUE = 663,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS = 664,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_MINPRECISION = 665,
    CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND = 666,
    CREATEGRAPHICSPIPELINESTATE_HS_XOR_DS_MISMATCH = 667,
    CREATEGRAPHICSPIPELINESTATE_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH = 668,
    CREATEGRAPHICSPIPELINESTATE_HS_DS_CONTROL_POINT_COUNT_MISMATCH = 669,
    CREATEGRAPHICSPIPELINESTATE_HS_DS_TESSELLATOR_DOMAIN_MISMATCH = 670,
    CREATEGRAPHICSPIPELINESTATE_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN = 671,
    CREATEGRAPHICSPIPELINESTATE_INVALID_USE_OF_FORCED_SAMPLE_COUNT = 672,
    CREATEGRAPHICSPIPELINESTATE_INVALID_PRIMITIVETOPOLOGY = 673,
    CREATEGRAPHICSPIPELINESTATE_INVALID_SYSTEMVALUE = 674,
    CREATEGRAPHICSPIPELINESTATE_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0 = 675,
    CREATEGRAPHICSPIPELINESTATE_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING = 676,
    CREATEGRAPHICSPIPELINESTATE_PS_OUTPUT_TYPE_MISMATCH = 677,
    CREATEGRAPHICSPIPELINESTATE_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS = 678,
    CREATEGRAPHICSPIPELINESTATE_RENDERTARGETVIEW_NOT_SET = 679,
    CREATEGRAPHICSPIPELINESTATE_DEPTHSTENCILVIEW_NOT_SET = 680,
    CREATEGRAPHICSPIPELINESTATE_GS_INPUT_PRIMITIVE_MISMATCH = 681,
    CREATEGRAPHICSPIPELINESTATE_POSITION_NOT_PRESENT = 682,
    CREATEGRAPHICSPIPELINESTATE_MISSING_ROOT_SIGNATURE_FLAGS = 683,
    CREATEGRAPHICSPIPELINESTATE_INVALID_INDEX_BUFFER_PROPERTIES = 684,
    CREATEGRAPHICSPIPELINESTATE_INVALID_SAMPLE_DESC = 685,
    CREATEGRAPHICSPIPELINESTATE_HS_ROOT_SIGNATURE_MISMATCH = 686,
    CREATEGRAPHICSPIPELINESTATE_DS_ROOT_SIGNATURE_MISMATCH = 687,
    CREATEGRAPHICSPIPELINESTATE_VS_ROOT_SIGNATURE_MISMATCH = 688,
    CREATEGRAPHICSPIPELINESTATE_GS_ROOT_SIGNATURE_MISMATCH = 689,
    CREATEGRAPHICSPIPELINESTATE_PS_ROOT_SIGNATURE_MISMATCH = 690,
    CREATEGRAPHICSPIPELINESTATE_MISSING_ROOT_SIGNATURE = 691,
    EXECUTE_BUNDLE_OPEN_BUNDLE = 692,
    EXECUTE_BUNDLE_DESCRIPTOR_HEAP_MISMATCH = 693,
    EXECUTE_BUNDLE_TYPE = 694,
    DRAW_EMPTY_SCISSOR_RECTANGLE = 695,
    CREATE_ROOT_SIGNATURE_BLOB_NOT_FOUND = 696,
    CREATE_ROOT_SIGNATURE_DESERIALIZE_FAILED = 697,
    CREATE_ROOT_SIGNATURE_INVALID_CONFIGURATION = 698,
    CREATE_ROOT_SIGNATURE_NOT_SUPPORTED_ON_DEVICE = 699,
    CREATERESOURCEANDHEAP_NULLRESOURCEPROPERTIES = 700,
    CREATERESOURCEANDHEAP_NULLHEAP = 701,
    GETRESOURCEALLOCATIONINFO_INVALIDRDESCS = 702,
    MAKERESIDENT_NULLOBJECTARRAY = 703,
    EVICT_NULLOBJECTARRAY = 705,
    SET_DESCRIPTOR_TABLE_INVALID = 708,
    SET_ROOT_CONSTANT_INVALID = 709,
    SET_ROOT_CONSTANT_BUFFER_VIEW_INVALID = 710,
    SET_ROOT_SHADER_RESOURCE_VIEW_INVALID = 711,
    SET_ROOT_UNORDERED_ACCESS_VIEW_INVALID = 712,
    SET_VERTEX_BUFFERS_INVALID_DESC = 713,
    SET_INDEX_BUFFER_INVALID_DESC = 715,
    SET_STREAM_OUTPUT_BUFFERS_INVALID_DESC = 717,
    CREATERESOURCE_UNRECOGNIZEDDIMENSIONALITY = 718,
    CREATERESOURCE_UNRECOGNIZEDLAYOUT = 719,
    CREATERESOURCE_INVALIDDIMENSIONALITY = 720,
    CREATERESOURCE_INVALIDALIGNMENT = 721,
    CREATERESOURCE_INVALIDMIPLEVELS = 722,
    CREATERESOURCE_INVALIDSAMPLEDESC = 723,
    CREATERESOURCE_INVALIDLAYOUT = 724,
    SET_INDEX_BUFFER_INVALID = 725,
    SET_VERTEX_BUFFERS_INVALID = 726,
    SET_STREAM_OUTPUT_BUFFERS_INVALID = 727,
    SET_RENDER_TARGETS_INVALID = 728,
    CREATEQUERY_HEAP_INVALID_PARAMETERS = 729,
    BEGIN_END_QUERY_INVALID_PARAMETERS = 731,
    CLOSE_COMMAND_LIST_OPEN_QUERY = 732,
    RESOLVE_QUERY_DATA_INVALID_PARAMETERS = 733,
    SET_PREDICATION_INVALID_PARAMETERS = 734,
    TIMESTAMPS_NOT_SUPPORTED = 735,
    CREATERESOURCE_UNRECOGNIZEDFORMAT = 737,
    CREATERESOURCE_INVALIDFORMAT = 738,
    GETCOPYABLEFOOTPRINTS_INVALIDSUBRESOURCERANGE = 739,
    GETCOPYABLEFOOTPRINTS_INVALIDBASEOFFSET = 740,
    GETCOPYABLELAYOUT_INVALIDSUBRESOURCERANGE = 739,
    GETCOPYABLELAYOUT_INVALIDBASEOFFSET = 740,
    RESOURCE_BARRIER_INVALID_HEAP = 741,
    CREATE_SAMPLER_INVALID = 742,
    CREATECOMMANDSIGNATURE_INVALID = 743,
    EXECUTE_INDIRECT_INVALID_PARAMETERS = 744,
    GETGPUVIRTUALADDRESS_INVALID_RESOURCE_DIMENSION = 745,
    CREATERESOURCE_INVALIDCLEARVALUE = 815,
    CREATERESOURCE_UNRECOGNIZEDCLEARVALUEFORMAT = 816,
    CREATERESOURCE_INVALIDCLEARVALUEFORMAT = 817,
    CREATERESOURCE_CLEARVALUEDENORMFLUSH = 818,
    CLEARRENDERTARGETVIEW_MISMATCHINGCLEARVALUE = 820,
    CLEARDEPTHSTENCILVIEW_MISMATCHINGCLEARVALUE = 821,
    MAP_INVALIDHEAP = 822,
    UNMAP_INVALIDHEAP = 823,
    MAP_INVALIDRESOURCE = 824,
    UNMAP_INVALIDRESOURCE = 825,
    MAP_INVALIDSUBRESOURCE = 826,
    UNMAP_INVALIDSUBRESOURCE = 827,
    MAP_INVALIDRANGE = 828,
    UNMAP_INVALIDRANGE = 829,
    MAP_INVALIDDATAPOINTER = 832,
    MAP_INVALIDARG_RETURN = 833,
    MAP_OUTOFMEMORY_RETURN = 834,
    EXECUTECOMMANDLISTS_BUNDLENOTSUPPORTED = 835,
    EXECUTECOMMANDLISTS_COMMANDLISTMISMATCH = 836,
    EXECUTECOMMANDLISTS_OPENCOMMANDLIST = 837,
    EXECUTECOMMANDLISTS_FAILEDCOMMANDLIST = 838,
    COPYBUFFERREGION_NULLDST = 839,
    COPYBUFFERREGION_INVALIDDSTRESOURCEDIMENSION = 840,
    COPYBUFFERREGION_DSTRANGEOUTOFBOUNDS = 841,
    COPYBUFFERREGION_NULLSRC = 842,
    COPYBUFFERREGION_INVALIDSRCRESOURCEDIMENSION = 843,
    COPYBUFFERREGION_SRCRANGEOUTOFBOUNDS = 844,
    COPYBUFFERREGION_INVALIDCOPYFLAGS = 845,
    COPYTEXTUREREGION_NULLDST = 846,
    COPYTEXTUREREGION_UNRECOGNIZEDDSTTYPE = 847,
    COPYTEXTUREREGION_INVALIDDSTRESOURCEDIMENSION = 848,
    COPYTEXTUREREGION_INVALIDDSTRESOURCE = 849,
    COPYTEXTUREREGION_INVALIDDSTSUBRESOURCE = 850,
    COPYTEXTUREREGION_INVALIDDSTOFFSET = 851,
    COPYTEXTUREREGION_UNRECOGNIZEDDSTFORMAT = 852,
    COPYTEXTUREREGION_INVALIDDSTFORMAT = 853,
    COPYTEXTUREREGION_INVALIDDSTDIMENSIONS = 854,
    COPYTEXTUREREGION_INVALIDDSTROWPITCH = 855,
    COPYTEXTUREREGION_INVALIDDSTPLACEMENT = 856,
    COPYTEXTUREREGION_INVALIDDSTDSPLACEDFOOTPRINTFORMAT = 857,
    COPYTEXTUREREGION_DSTREGIONOUTOFBOUNDS = 858,
    COPYTEXTUREREGION_NULLSRC = 859,
    COPYTEXTUREREGION_UNRECOGNIZEDSRCTYPE = 860,
    COPYTEXTUREREGION_INVALIDSRCRESOURCEDIMENSION = 861,
    COPYTEXTUREREGION_INVALIDSRCRESOURCE = 862,
    COPYTEXTUREREGION_INVALIDSRCSUBRESOURCE = 863,
    COPYTEXTUREREGION_INVALIDSRCOFFSET = 864,
    COPYTEXTUREREGION_UNRECOGNIZEDSRCFORMAT = 865,
    COPYTEXTUREREGION_INVALIDSRCFORMAT = 866,
    COPYTEXTUREREGION_INVALIDSRCDIMENSIONS = 867,
    COPYTEXTUREREGION_INVALIDSRCROWPITCH = 868,
    COPYTEXTUREREGION_INVALIDSRCPLACEMENT = 869,
    COPYTEXTUREREGION_INVALIDSRCDSPLACEDFOOTPRINTFORMAT = 870,
    COPYTEXTUREREGION_SRCREGIONOUTOFBOUNDS = 871,
    COPYTEXTUREREGION_INVALIDDSTCOORDINATES = 872,
    COPYTEXTUREREGION_INVALIDSRCBOX = 873,
    COPYTEXTUREREGION_FORMATMISMATCH = 874,
    COPYTEXTUREREGION_EMPTYBOX = 875,
    COPYTEXTUREREGION_INVALIDCOPYFLAGS = 876,
    RESOLVESUBRESOURCE_INVALID_SUBRESOURCE_INDEX = 877,
    RESOLVESUBRESOURCE_INVALID_FORMAT = 878,
    RESOLVESUBRESOURCE_RESOURCE_MISMATCH = 879,
    RESOLVESUBRESOURCE_INVALID_SAMPLE_COUNT = 880,
    CREATECOMPUTEPIPELINESTATE_INVALID_SHADER = 881,
    CREATECOMPUTEPIPELINESTATE_CS_ROOT_SIGNATURE_MISMATCH = 882,
    CREATECOMPUTEPIPELINESTATE_MISSING_ROOT_SIGNATURE = 883,
    CREATEPIPELINESTATE_INVALIDCACHEDBLOB = 884,
    CREATEPIPELINESTATE_CACHEDBLOBADAPTERMISMATCH = 885,
    CREATEPIPELINESTATE_CACHEDBLOBDRIVERVERSIONMISMATCH = 886,
    CREATEPIPELINESTATE_CACHEDBLOBDESCMISMATCH = 887,
    CREATEPIPELINESTATE_CACHEDBLOBIGNORED = 888,
    WRITETOSUBRESOURCE_INVALIDHEAP = 889,
    WRITETOSUBRESOURCE_INVALIDRESOURCE = 890,
    WRITETOSUBRESOURCE_INVALIDBOX = 891,
    WRITETOSUBRESOURCE_INVALIDSUBRESOURCE = 892,
    WRITETOSUBRESOURCE_EMPTYBOX = 893,
    READFROMSUBRESOURCE_INVALIDHEAP = 894,
    READFROMSUBRESOURCE_INVALIDRESOURCE = 895,
    READFROMSUBRESOURCE_INVALIDBOX = 896,
    READFROMSUBRESOURCE_INVALIDSUBRESOURCE = 897,
    READFROMSUBRESOURCE_EMPTYBOX = 898,
    TOO_MANY_NODES_SPECIFIED = 899,
    INVALID_NODE_INDEX = 900,
    GETHEAPPROPERTIES_INVALIDRESOURCE = 901,
    NODE_MASK_MISMATCH = 902,
    COMMAND_LIST_OUTOFMEMORY = 903,
    COMMAND_LIST_MULTIPLE_SWAPCHAIN_BUFFER_REFERENCES = 904,
    COMMAND_LIST_TOO_MANY_SWAPCHAIN_REFERENCES = 905,
    COMMAND_QUEUE_TOO_MANY_SWAPCHAIN_REFERENCES = 906,
    EXECUTECOMMANDLISTS_WRONGSWAPCHAINBUFFERREFERENCE = 907,
    COMMAND_LIST_SETRENDERTARGETS_INVALIDNUMRENDERTARGETS = 908,
    CREATE_QUEUE_INVALID_TYPE = 909,
    CREATE_QUEUE_INVALID_FLAGS = 910,
    CREATESHAREDRESOURCE_INVALIDFLAGS = 911,
    CREATESHAREDRESOURCE_INVALIDFORMAT = 912,
    CREATESHAREDHEAP_INVALIDFLAGS = 913,
    REFLECTSHAREDPROPERTIES_UNRECOGNIZEDPROPERTIES = 914,
    REFLECTSHAREDPROPERTIES_INVALIDSIZE = 915,
    REFLECTSHAREDPROPERTIES_INVALIDOBJECT = 916,
    KEYEDMUTEX_INVALIDOBJECT = 917,
    KEYEDMUTEX_INVALIDKEY = 918,
    KEYEDMUTEX_WRONGSTATE = 919,
    CREATE_QUEUE_INVALID_PRIORITY = 920,
    OBJECT_DELETED_WHILE_STILL_IN_USE = 921,
    CREATEPIPELINESTATE_INVALID_FLAGS = 922,
    HEAP_ADDRESS_RANGE_HAS_NO_RESOURCE = 923,
    COMMAND_LIST_DRAW_RENDER_TARGET_DELETED = 924,
    CREATEGRAPHICSPIPELINESTATE_ALL_RENDER_TARGETS_HAVE_UNKNOWN_FORMAT = 925,
    HEAP_ADDRESS_RANGE_INTERSECTS_MULTIPLE_BUFFERS = 926,
    EXECUTECOMMANDLISTS_GPU_WRITTEN_READBACK_RESOURCE_MAPPED = 927,
    UNMAP_RANGE_NOT_EMPTY = 929,
    MAP_INVALID_NULLRANGE = 930,
    UNMAP_INVALID_NULLRANGE = 931,
    NO_GRAPHICS_API_SUPPORT = 932,
    NO_COMPUTE_API_SUPPORT = 933,
    RESOLVESUBRESOURCE_RESOURCE_FLAGS_NOT_SUPPORTED = 934,
    GPU_BASED_VALIDATION_ROOT_ARGUMENT_UNINITIALIZED = 935,
    GPU_BASED_VALIDATION_DESCRIPTOR_HEAP_INDEX_OUT_OF_BOUNDS = 936,
    GPU_BASED_VALIDATION_DESCRIPTOR_TABLE_REGISTER_INDEX_OUT_OF_BOUNDS = 937,
    GPU_BASED_VALIDATION_DESCRIPTOR_UNINITIALIZED = 938,
    GPU_BASED_VALIDATION_DESCRIPTOR_TYPE_MISMATCH = 939,
    GPU_BASED_VALIDATION_SRV_RESOURCE_DIMENSION_MISMATCH = 940,
    GPU_BASED_VALIDATION_UAV_RESOURCE_DIMENSION_MISMATCH = 941,
    GPU_BASED_VALIDATION_INCOMPATIBLE_RESOURCE_STATE = 942,
    COPYRESOURCE_NULLDST = 943,
    COPYRESOURCE_INVALIDDSTRESOURCE = 944,
    COPYRESOURCE_NULLSRC = 945,
    COPYRESOURCE_INVALIDSRCRESOURCE = 946,
    RESOLVESUBRESOURCE_NULLDST = 947,
    RESOLVESUBRESOURCE_INVALIDDSTRESOURCE = 948,
    RESOLVESUBRESOURCE_NULLSRC = 949,
    RESOLVESUBRESOURCE_INVALIDSRCRESOURCE = 950,
    PIPELINE_STATE_TYPE_MISMATCH = 951,
    COMMAND_LIST_DISPATCH_ROOT_SIGNATURE_NOT_SET = 952,
    COMMAND_LIST_DISPATCH_ROOT_SIGNATURE_MISMATCH = 953,
    RESOURCE_BARRIER_ZERO_BARRIERS = 954,
    BEGIN_END_EVENT_MISMATCH = 955,
    RESOURCE_BARRIER_POSSIBLE_BEFORE_AFTER_MISMATCH = 956,
    RESOURCE_BARRIER_MISMATCHING_BEGIN_END = 957,
    GPU_BASED_VALIDATION_INVALID_RESOURCE = 958,
    USE_OF_ZERO_REFCOUNT_OBJECT = 959,
    OBJECT_EVICTED_WHILE_STILL_IN_USE = 960,
    GPU_BASED_VALIDATION_ROOT_DESCRIPTOR_ACCESS_OUT_OF_BOUNDS = 961,
    CREATEPIPELINELIBRARY_INVALIDLIBRARYBLOB = 962,
    CREATEPIPELINELIBRARY_DRIVERVERSIONMISMATCH = 963,
    CREATEPIPELINELIBRARY_ADAPTERVERSIONMISMATCH = 964,
    CREATEPIPELINELIBRARY_UNSUPPORTED = 965,
    CREATE_PIPELINELIBRARY = 966,
    LIVE_PIPELINELIBRARY = 967,
    DESTROY_PIPELINELIBRARY = 968,
    STOREPIPELINE_NONAME = 969,
    STOREPIPELINE_DUPLICATENAME = 970,
    LOADPIPELINE_NAMENOTFOUND = 971,
    LOADPIPELINE_INVALIDDESC = 972,
    PIPELINELIBRARY_SERIALIZE_NOTENOUGHMEMORY = 973,
    CREATEGRAPHICSPIPELINESTATE_PS_OUTPUT_RT_OUTPUT_MISMATCH = 974,
    SETEVENTONMULTIPLEFENCECOMPLETION_INVALIDFLAGS = 975,
    CREATE_QUEUE_VIDEO_NOT_SUPPORTED = 976,
    CREATE_COMMAND_ALLOCATOR_VIDEO_NOT_SUPPORTED = 977,
    CREATEQUERY_HEAP_VIDEO_DECODE_STATISTICS_NOT_SUPPORTED = 978,
    CREATE_VIDEODECODECOMMANDLIST = 979,
    CREATE_VIDEODECODER = 980,
    CREATE_VIDEODECODESTREAM = 981,
    LIVE_VIDEODECODECOMMANDLIST = 982,
    LIVE_VIDEODECODER = 983,
    LIVE_VIDEODECODESTREAM = 984,
    DESTROY_VIDEODECODECOMMANDLIST = 985,
    DESTROY_VIDEODECODER = 986,
    DESTROY_VIDEODECODESTREAM = 987,
    DECODE_FRAME_INVALID_PARAMETERS = 988,
    DEPRECATED_API = 989,
    RESOURCE_BARRIER_MISMATCHING_COMMAND_LIST_TYPE = 990,
    COMMAND_LIST_DESCRIPTOR_TABLE_NOT_SET = 991,
    COMMAND_LIST_ROOT_CONSTANT_BUFFER_VIEW_NOT_SET = 992,
    COMMAND_LIST_ROOT_SHADER_RESOURCE_VIEW_NOT_SET = 993,
    COMMAND_LIST_ROOT_UNORDERED_ACCESS_VIEW_NOT_SET = 994,
    DISCARD_INVALID_SUBRESOURCE_RANGE = 995,
    DISCARD_ONE_SUBRESOURCE_FOR_MIPS_WITH_RECTS = 996,
    DISCARD_NO_RECTS_FOR_NON_TEXTURE2D = 997,
    COPY_ON_SAME_SUBRESOURCE = 998,
    SETRESIDENCYPRIORITY_INVALID_PAGEABLE = 999,
    GPU_BASED_VALIDATION_UNSUPPORTED = 1000,
    STATIC_DESCRIPTOR_INVALID_DESCRIPTOR_CHANGE = 1001,
    DATA_STATIC_DESCRIPTOR_INVALID_DATA_CHANGE = 1002,
    DATA_STATIC_WHILE_SET_AT_EXECUTE_DESCRIPTOR_INVALID_DATA_CHANGE = 1003,
    EXECUTE_BUNDLE_STATIC_DESCRIPTOR_DATA_STATIC_NOT_SET = 1004,
    GPU_BASED_VALIDATION_RESOURCE_ACCESS_OUT_OF_BOUNDS = 1005,
    GPU_BASED_VALIDATION_SAMPLER_MODE_MISMATCH = 1006,
    CREATE_FENCE_INVALID_FLAGS = 1007,
    RESOURCE_BARRIER_DUPLICATE_SUBRESOURCE_TRANSITIONS = 1008,
    SETRESIDENCYPRIORITY_INVALID_PRIORITY = 1009,
    CREATE_DESCRIPTOR_HEAP_LARGE_NUM_DESCRIPTORS = 1013,
    BEGIN_EVENT = 1014,
    END_EVENT = 1015,
    CREATEDEVICE_DEBUG_LAYER_STARTUP_OPTIONS = 1016,
    CREATEDEPTHSTENCILSTATE_DEPTHBOUNDSTEST_UNSUPPORTED = 1017,
    CREATEPIPELINESTATE_DUPLICATE_SUBOBJECT = 1018,
    CREATEPIPELINESTATE_UNKNOWN_SUBOBJECT = 1019,
    CREATEPIPELINESTATE_ZERO_SIZE_STREAM = 1020,
    CREATEPIPELINESTATE_INVALID_STREAM = 1021,
    CREATEPIPELINESTATE_CANNOT_DEDUCE_TYPE = 1022,
    COMMAND_LIST_STATIC_DESCRIPTOR_RESOURCE_DIMENSION_MISMATCH = 1023,
    CREATE_COMMAND_QUEUE_INSUFFICIENT_PRIVILEGE_FOR_GLOBAL_REALTIME = 1024,
    CREATE_COMMAND_QUEUE_INSUFFICIENT_HARDWARE_SUPPORT_FOR_GLOBAL_REALTIME = 1025,
    ATOMICCOPYBUFFER_INVALID_ARCHITECTURE = 1026,
    ATOMICCOPYBUFFER_NULL_DST = 1027,
    ATOMICCOPYBUFFER_INVALID_DST_RESOURCE_DIMENSION = 1028,
    ATOMICCOPYBUFFER_DST_RANGE_OUT_OF_BOUNDS = 1029,
    ATOMICCOPYBUFFER_NULL_SRC = 1030,
    ATOMICCOPYBUFFER_INVALID_SRC_RESOURCE_DIMENSION = 1031,
    ATOMICCOPYBUFFER_SRC_RANGE_OUT_OF_BOUNDS = 1032,
    ATOMICCOPYBUFFER_INVALID_OFFSET_ALIGNMENT = 1033,
    ATOMICCOPYBUFFER_NULL_DEPENDENT_RESOURCES = 1034,
    ATOMICCOPYBUFFER_NULL_DEPENDENT_SUBRESOURCE_RANGES = 1035,
    ATOMICCOPYBUFFER_INVALID_DEPENDENT_RESOURCE = 1036,
    ATOMICCOPYBUFFER_INVALID_DEPENDENT_SUBRESOURCE_RANGE = 1037,
    ATOMICCOPYBUFFER_DEPENDENT_SUBRESOURCE_OUT_OF_BOUNDS = 1038,
    ATOMICCOPYBUFFER_DEPENDENT_RANGE_OUT_OF_BOUNDS = 1039,
    ATOMICCOPYBUFFER_ZERO_DEPENDENCIES = 1040,
    DEVICE_CREATE_SHARED_HANDLE_INVALIDARG = 1041,
    DESCRIPTOR_HANDLE_WITH_INVALID_RESOURCE = 1042,
    SETDEPTHBOUNDS_INVALIDARGS = 1043,
    GPU_BASED_VALIDATION_RESOURCE_STATE_IMPRECISE = 1044,
    COMMAND_LIST_PIPELINE_STATE_NOT_SET = 1045,
    CREATEGRAPHICSPIPELINESTATE_SHADER_MODEL_MISMATCH = 1046,
    OBJECT_ACCESSED_WHILE_STILL_IN_USE = 1047,
    PROGRAMMABLE_MSAA_UNSUPPORTED = 1048,
    SETSAMPLEPOSITIONS_INVALIDARGS = 1049,
    RESOLVESUBRESOURCEREGION_INVALID_RECT = 1050,
    CREATE_VIDEODECODECOMMANDQUEUE = 1051,
    CREATE_VIDEOPROCESSCOMMANDLIST = 1052,
    CREATE_VIDEOPROCESSCOMMANDQUEUE = 1053,
    LIVE_VIDEODECODECOMMANDQUEUE = 1054,
    LIVE_VIDEOPROCESSCOMMANDLIST = 1055,
    LIVE_VIDEOPROCESSCOMMANDQUEUE = 1056,
    DESTROY_VIDEODECODECOMMANDQUEUE = 1057,
    DESTROY_VIDEOPROCESSCOMMANDLIST = 1058,
    DESTROY_VIDEOPROCESSCOMMANDQUEUE = 1059,
    CREATE_VIDEOPROCESSOR = 1060,
    CREATE_VIDEOPROCESSSTREAM = 1061,
    LIVE_VIDEOPROCESSOR = 1062,
    LIVE_VIDEOPROCESSSTREAM = 1063,
    DESTROY_VIDEOPROCESSOR = 1064,
    DESTROY_VIDEOPROCESSSTREAM = 1065,
    PROCESS_FRAME_INVALID_PARAMETERS = 1066,
    COPY_INVALIDLAYOUT = 1067,
    CREATE_CRYPTO_SESSION = 1068,
    CREATE_CRYPTO_SESSION_POLICY = 1069,
    CREATE_PROTECTED_RESOURCE_SESSION = 1070,
    LIVE_CRYPTO_SESSION = 1071,
    LIVE_CRYPTO_SESSION_POLICY = 1072,
    LIVE_PROTECTED_RESOURCE_SESSION = 1073,
    DESTROY_CRYPTO_SESSION = 1074,
    DESTROY_CRYPTO_SESSION_POLICY = 1075,
    DESTROY_PROTECTED_RESOURCE_SESSION = 1076,
    PROTECTED_RESOURCE_SESSION_UNSUPPORTED = 1077,
    FENCE_INVALIDOPERATION = 1078,
    CREATEQUERY_HEAP_COPY_QUEUE_TIMESTAMPS_NOT_SUPPORTED = 1079,
    SAMPLEPOSITIONS_MISMATCH_DEFERRED = 1080,
    SAMPLEPOSITIONS_MISMATCH_RECORDTIME_ASSUMEDFROMFIRSTUSE = 1081,
    SAMPLEPOSITIONS_MISMATCH_RECORDTIME_ASSUMEDFROMCLEAR = 1082,
    CREATE_VIDEODECODERHEAP = 1083,
    LIVE_VIDEODECODERHEAP = 1084,
    DESTROY_VIDEODECODERHEAP = 1085,
    OPENEXISTINGHEAP_INVALIDARG_RETURN = 1086,
    OPENEXISTINGHEAP_OUTOFMEMORY_RETURN = 1087,
    OPENEXISTINGHEAP_INVALIDADDRESS = 1088,
    OPENEXISTINGHEAP_INVALIDHANDLE = 1089,
    WRITEBUFFERIMMEDIATE_INVALID_DEST = 1090,
    WRITEBUFFERIMMEDIATE_INVALID_MODE = 1091,
    WRITEBUFFERIMMEDIATE_INVALID_ALIGNMENT = 1092,
    WRITEBUFFERIMMEDIATE_NOT_SUPPORTED = 1093,
    SETVIEWINSTANCEMASK_INVALIDARGS = 1094,
    VIEW_INSTANCING_UNSUPPORTED = 1095,
    VIEW_INSTANCING_INVALIDARGS = 1096,
    COPYTEXTUREREGION_MISMATCH_DECODE_REFERENCE_ONLY_FLAG = 1097,
    COPYRESOURCE_MISMATCH_DECODE_REFERENCE_ONLY_FLAG = 1098,
    CREATE_VIDEO_DECODE_HEAP_CAPS_FAILURE = 1099,
    CREATE_VIDEO_DECODE_HEAP_CAPS_UNSUPPORTED = 1100,
    VIDEO_DECODE_SUPPORT_INVALID_INPUT = 1101,
    CREATE_VIDEO_DECODER_UNSUPPORTED = 1102,
    CREATEGRAPHICSPIPELINESTATE_METADATA_ERROR = 1103,
    CREATEGRAPHICSPIPELINESTATE_VIEW_INSTANCING_VERTEX_SIZE_EXCEEDED = 1104,
    CREATEGRAPHICSPIPELINESTATE_RUNTIME_INTERNAL_ERROR = 1105,
    NO_VIDEO_API_SUPPORT = 1106,
    VIDEO_PROCESS_SUPPORT_INVALID_INPUT = 1107,
    CREATE_VIDEO_PROCESSOR_CAPS_FAILURE = 1108,
    VIDEO_PROCESS_SUPPORT_UNSUPPORTED_FORMAT = 1109,
    VIDEO_DECODE_FRAME_INVALID_ARGUMENT = 1110,
    ENQUEUE_MAKE_RESIDENT_INVALID_FLAGS = 1111,
    OPENEXISTINGHEAP_UNSUPPORTED = 1112,
    VIDEO_PROCESS_FRAMES_INVALID_ARGUMENT = 1113,
    VIDEO_DECODE_SUPPORT_UNSUPPORTED = 1114,
    CREATE_COMMANDRECORDER = 1115,
    LIVE_COMMANDRECORDER = 1116,
    DESTROY_COMMANDRECORDER = 1117,
    CREATE_COMMAND_RECORDER_VIDEO_NOT_SUPPORTED = 1118,
    CREATE_COMMAND_RECORDER_INVALID_SUPPORT_FLAGS = 1119,
    CREATE_COMMAND_RECORDER_INVALID_FLAGS = 1120,
    CREATE_COMMAND_RECORDER_MORE_RECORDERS_THAN_LOGICAL_PROCESSORS = 1121,
    CREATE_COMMANDPOOL = 1122,
    LIVE_COMMANDPOOL = 1123,
    DESTROY_COMMANDPOOL = 1124,
    CREATE_COMMAND_POOL_INVALID_FLAGS = 1125,
    CREATE_COMMAND_LIST_VIDEO_NOT_SUPPORTED = 1126,
    COMMAND_RECORDER_SUPPORT_FLAGS_MISMATCH = 1127,
    COMMAND_RECORDER_CONTENTION = 1128,
    COMMAND_RECORDER_USAGE_WITH_CREATECOMMANDLIST_COMMAND_LIST = 1129,
    COMMAND_ALLOCATOR_USAGE_WITH_CREATECOMMANDLIST1_COMMAND_LIST = 1130,
    CANNOT_EXECUTE_EMPTY_COMMAND_LIST = 1131,
    CANNOT_RESET_COMMAND_POOL_WITH_OPEN_COMMAND_LISTS = 1132,
    CANNOT_USE_COMMAND_RECORDER_WITHOUT_CURRENT_TARGET = 1133,
    CANNOT_CHANGE_COMMAND_RECORDER_TARGET_WHILE_RECORDING = 1134,
    COMMAND_POOL_SYNC = 1135,
    EVICT_UNDERFLOW = 1136,
    CREATE_META_COMMAND = 1137,
    LIVE_META_COMMAND = 1138,
    DESTROY_META_COMMAND = 1139,
    COPYBUFFERREGION_INVALID_DST_RESOURCE = 1140,
    COPYBUFFERREGION_INVALID_SRC_RESOURCE = 1141,
    ATOMICCOPYBUFFER_INVALID_DST_RESOURCE = 1142,
    ATOMICCOPYBUFFER_INVALID_SRC_RESOURCE = 1143,
    CREATEPLACEDRESOURCEONBUFFER_NULL_BUFFER = 1144,
    CREATEPLACEDRESOURCEONBUFFER_NULL_RESOURCE_DESC = 1145,
    CREATEPLACEDRESOURCEONBUFFER_UNSUPPORTED = 1146,
    CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_DIMENSION = 1147,
    CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_FLAGS = 1148,
    CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_OFFSET = 1149,
    CREATEPLACEDRESOURCEONBUFFER_INVALID_RESOURCE_DIMENSION = 1150,
    CREATEPLACEDRESOURCEONBUFFER_INVALID_RESOURCE_FLAGS = 1151,
    CREATEPLACEDRESOURCEONBUFFER_OUTOFMEMORY_RETURN = 1152,
    CANNOT_CREATE_GRAPHICS_AND_VIDEO_COMMAND_RECORDER = 1153,
    UPDATETILEMAPPINGS_POSSIBLY_MISMATCHING_PROPERTIES = 1154,
    CREATE_COMMAND_LIST_INVALID_COMMAND_LIST_TYPE = 1155,
    CLEARUNORDEREDACCESSVIEW_INCOMPATIBLE_WITH_STRUCTURED_BUFFERS = 1156,
    COMPUTE_ONLY_DEVICE_OPERATION_UNSUPPORTED = 1157,
    BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INVALID = 1158,
    EMIT_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_INVALID = 1159,
    COPY_RAYTRACING_ACCELERATION_STRUCTURE_INVALID = 1160,
    DISPATCH_RAYS_INVALID = 1161,
    GET_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO_INVALID = 1162,
    CREATE_LIFETIMETRACKER = 1163,
    LIVE_LIFETIMETRACKER = 1164,
    DESTROY_LIFETIMETRACKER = 1165,
    DESTROYOWNEDOBJECT_OBJECTNOTOWNED = 1166,
    CREATE_TRACKEDWORKLOAD = 1167,
    LIVE_TRACKEDWORKLOAD = 1168,
    DESTROY_TRACKEDWORKLOAD = 1169,
    RENDER_PASS_ERROR = 1170,
    META_COMMAND_ID_INVALID = 1171,
    META_COMMAND_UNSUPPORTED_PARAMS = 1172,
    META_COMMAND_FAILED_ENUMERATION = 1173,
    META_COMMAND_PARAMETER_SIZE_MISMATCH = 1174,
    UNINITIALIZED_META_COMMAND = 1175,
    META_COMMAND_INVALID_GPU_VIRTUAL_ADDRESS = 1176,
    CREATE_VIDEOENCODECOMMANDLIST = 1177,
    LIVE_VIDEOENCODECOMMANDLIST = 1178,
    DESTROY_VIDEOENCODECOMMANDLIST = 1179,
    CREATE_VIDEOENCODECOMMANDQUEUE = 1180,
    LIVE_VIDEOENCODECOMMANDQUEUE = 1181,
    DESTROY_VIDEOENCODECOMMANDQUEUE = 1182,
    CREATE_VIDEOMOTIONESTIMATOR = 1183,
    LIVE_VIDEOMOTIONESTIMATOR = 1184,
    DESTROY_VIDEOMOTIONESTIMATOR = 1185,
    CREATE_VIDEOMOTIONVECTORHEAP = 1186,
    LIVE_VIDEOMOTIONVECTORHEAP = 1187,
    DESTROY_VIDEOMOTIONVECTORHEAP = 1188,
    MULTIPLE_TRACKED_WORKLOADS = 1189,
    MULTIPLE_TRACKED_WORKLOAD_PAIRS = 1190,
    OUT_OF_ORDER_TRACKED_WORKLOAD_PAIR = 1191,
    CANNOT_ADD_TRACKED_WORKLOAD = 1192,
    INCOMPLETE_TRACKED_WORKLOAD_PAIR = 1193,
    CREATE_STATE_OBJECT_ERROR = 1194,
    GET_SHADER_IDENTIFIER_ERROR = 1195,
    GET_SHADER_STACK_SIZE_ERROR = 1196,
    GET_PIPELINE_STACK_SIZE_ERROR = 1197,
    SET_PIPELINE_STACK_SIZE_ERROR = 1198,
    GET_SHADER_IDENTIFIER_SIZE_INVALID = 1199,
    CHECK_DRIVER_MATCHING_IDENTIFIER_INVALID = 1200,
    CHECK_DRIVER_MATCHING_IDENTIFIER_DRIVER_REPORTED_ISSUE = 1201,
    RENDER_PASS_INVALID_RESOURCE_BARRIER = 1202,
    RENDER_PASS_DISALLOWED_API_CALLED = 1203,
    RENDER_PASS_CANNOT_NEST_RENDER_PASSES = 1204,
    RENDER_PASS_CANNOT_END_WITHOUT_BEGIN = 1205,
    RENDER_PASS_CANNOT_CLOSE_COMMAND_LIST = 1206,
    RENDER_PASS_GPU_WORK_WHILE_SUSPENDED = 1207,
    RENDER_PASS_MISMATCHING_SUSPEND_RESUME = 1208,
    RENDER_PASS_NO_PRIOR_SUSPEND_WITHIN_EXECUTECOMMANDLISTS = 1209,
    RENDER_PASS_NO_SUBSEQUENT_RESUME_WITHIN_EXECUTECOMMANDLISTS = 1210,
    TRACKED_WORKLOAD_COMMAND_QUEUE_MISMATCH = 1211,
    TRACKED_WORKLOAD_NOT_SUPPORTED = 1212,
    RENDER_PASS_MISMATCHING_NO_ACCESS = 1213,
    RENDER_PASS_UNSUPPORTED_RESOLVE = 1214,
    CLEARUNORDEREDACCESSVIEW_INVALID_RESOURCE_PTR = 1215,
    WINDOWS7_FENCE_OUTOFORDER_SIGNAL = 1216,
    WINDOWS7_FENCE_OUTOFORDER_WAIT = 1217,
    VIDEO_CREATE_MOTION_ESTIMATOR_INVALID_ARGUMENT = 1218,
    VIDEO_CREATE_MOTION_VECTOR_HEAP_INVALID_ARGUMENT = 1219,
    ESTIMATE_MOTION_INVALID_ARGUMENT = 1220,
    RESOLVE_MOTION_VECTOR_HEAP_INVALID_ARGUMENT = 1221,
    GETGPUVIRTUALADDRESS_INVALID_HEAP_TYPE = 1222,
    SET_BACKGROUND_PROCESSING_MODE_INVALID_ARGUMENT = 1223,
    CREATE_COMMAND_LIST_INVALID_COMMAND_LIST_TYPE_FOR_FEATURE_LEVEL = 1224,
    CREATE_VIDEOEXTENSIONCOMMAND = 1225,
    LIVE_VIDEOEXTENSIONCOMMAND = 1226,
    DESTROY_VIDEOEXTENSIONCOMMAND = 1227,
    INVALID_VIDEO_EXTENSION_COMMAND_ID = 1228,
    VIDEO_EXTENSION_COMMAND_INVALID_ARGUMENT = 1229,
    CREATE_ROOT_SIGNATURE_NOT_UNIQUE_IN_DXIL_LIBRARY = 1230,
    VARIABLE_SHADING_RATE_NOT_ALLOWED_WITH_TIR = 1231,
    GEOMETRY_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE = 1232,
    RSSETSHADING_RATE_INVALID_SHADING_RATE = 1233,
    RSSETSHADING_RATE_SHADING_RATE_NOT_PERMITTED_BY_CAP = 1234,
    RSSETSHADING_RATE_INVALID_COMBINER = 1235,
    RSSETSHADINGRATEIMAGE_REQUIRES_TIER_2 = 1236,
    RSSETSHADINGRATE_REQUIRES_TIER_1 = 1237,
    SHADING_RATE_IMAGE_INCORRECT_FORMAT = 1238,
    SHADING_RATE_IMAGE_INCORRECT_ARRAY_SIZE = 1239,
    SHADING_RATE_IMAGE_INCORRECT_MIP_LEVEL = 1240,
    SHADING_RATE_IMAGE_INCORRECT_SAMPLE_COUNT = 1241,
    SHADING_RATE_IMAGE_INCORRECT_SAMPLE_QUALITY = 1242,
    NON_RETAIL_SHADER_MODEL_WONT_VALIDATE = 1243,
    CREATEGRAPHICSPIPELINESTATE_AS_ROOT_SIGNATURE_MISMATCH = 1244,
    CREATEGRAPHICSPIPELINESTATE_MS_ROOT_SIGNATURE_MISMATCH = 1245,
    ADD_TO_STATE_OBJECT_ERROR = 1246,
    CREATE_PROTECTED_RESOURCE_SESSION_INVALID_ARGUMENT = 1247,
    CREATEGRAPHICSPIPELINESTATE_MS_PSO_DESC_MISMATCH = 1248,
    CREATEPIPELINESTATE_MS_INCOMPLETE_TYPE = 1249,
    CREATEGRAPHICSPIPELINESTATE_AS_NOT_MS_MISMATCH = 1250,
    CREATEGRAPHICSPIPELINESTATE_MS_NOT_PS_MISMATCH = 1251,
    NONZERO_SAMPLER_FEEDBACK_MIP_REGION_WITH_INCOMPATIBLE_FORMAT = 1252,
    CREATEGRAPHICSPIPELINESTATE_INPUTLAYOUT_SHADER_MISMATCH = 1253,
    EMPTY_DISPATCH = 1254,
    RESOURCE_FORMAT_REQUIRES_SAMPLER_FEEDBACK_CAPABILITY = 1255,
    SAMPLER_FEEDBACK_MAP_INVALID_MIP_REGION = 1256,
    SAMPLER_FEEDBACK_MAP_INVALID_DIMENSION = 1257,
    SAMPLER_FEEDBACK_MAP_INVALID_SAMPLE_COUNT = 1258,
    SAMPLER_FEEDBACK_MAP_INVALID_SAMPLE_QUALITY = 1259,
    SAMPLER_FEEDBACK_MAP_INVALID_LAYOUT = 1260,
    SAMPLER_FEEDBACK_MAP_REQUIRES_UNORDERED_ACCESS_FLAG = 1261,
    SAMPLER_FEEDBACK_CREATE_UAV_NULL_ARGUMENTS = 1262,
    SAMPLER_FEEDBACK_UAV_REQUIRES_SAMPLER_FEEDBACK_CAPABILITY = 1263,
    SAMPLER_FEEDBACK_CREATE_UAV_REQUIRES_FEEDBACK_MAP_FORMAT = 1264,
    CREATEMESHSHADER_INVALIDSHADERBYTECODE = 1265,
    CREATEMESHSHADER_OUTOFMEMORY = 1266,
    CREATEMESHSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE = 1267,
    RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_TRANSCODE_INVALID_FORMAT = 1268,
    RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_INVALID_MIP_LEVEL_COUNT = 1269,
    RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_TRANSCODE_ARRAY_SIZE_MISMATCH = 1270,
    SAMPLER_FEEDBACK_CREATE_UAV_MISMATCHING_TARGETED_RESOURCE = 1271,
    CREATEMESHSHADER_OUTPUTEXCEEDSMAXSIZE = 1272,
    CREATEMESHSHADER_GROUPSHAREDEXCEEDSMAXSIZE = 1273,
    VERTEX_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE = 1274,
    MESH_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE = 1275,
    CREATEMESHSHADER_MISMATCHEDASMSPAYLOADSIZE = 1276,
    CREATE_ROOT_SIGNATURE_UNBOUNDED_STATIC_DESCRIPTORS = 1277,
    CREATEAMPLIFICATIONSHADER_INVALIDSHADERBYTECODE = 1278,
    CREATEAMPLIFICATIONSHADER_OUTOFMEMORY = 1279,
    CREATE_SHADERCACHESESSION = 1280,
    LIVE_SHADERCACHESESSION = 1281,
    DESTROY_SHADERCACHESESSION = 1282,
    CREATESHADERCACHESESSION_INVALIDARGS = 1283,
    CREATESHADERCACHESESSION_DISABLED = 1284,
    CREATESHADERCACHESESSION_ALREADYOPEN = 1285,
    SHADERCACHECONTROL_DEVELOPERMODE = 1286,
    SHADERCACHECONTROL_INVALIDFLAGS = 1287,
    SHADERCACHECONTROL_STATEALREADYSET = 1288,
    SHADERCACHECONTROL_IGNOREDFLAG = 1289,
    SHADERCACHESESSION_STOREVALUE_ALREADYPRESENT = 1290,
    SHADERCACHESESSION_STOREVALUE_HASHCOLLISION = 1291,
    SHADERCACHESESSION_STOREVALUE_CACHEFULL = 1292,
    SHADERCACHESESSION_FINDVALUE_NOTFOUND = 1293,
    SHADERCACHESESSION_CORRUPT = 1294,
    SHADERCACHESESSION_DISABLED = 1295,
    OVERSIZED_DISPATCH = 1296,
    CREATE_VIDEOENCODER = 1297,
    LIVE_VIDEOENCODER = 1298,
    DESTROY_VIDEOENCODER = 1299,
    CREATE_VIDEOENCODERHEAP = 1300,
    LIVE_VIDEOENCODERHEAP = 1301,
    DESTROY_VIDEOENCODERHEAP = 1302,
    COPYTEXTUREREGION_MISMATCH_ENCODE_REFERENCE_ONLY_FLAG = 1303,
    COPYRESOURCE_MISMATCH_ENCODE_REFERENCE_ONLY_FLAG = 1304,
    ENCODE_FRAME_INVALID_PARAMETERS = 1305,
    ENCODE_FRAME_UNSUPPORTED_PARAMETERS = 1306,
    RESOLVE_ENCODER_OUTPUT_METADATA_INVALID_PARAMETERS = 1307,
    RESOLVE_ENCODER_OUTPUT_METADATA_UNSUPPORTED_PARAMETERS = 1308,
    CREATE_VIDEO_ENCODER_INVALID_PARAMETERS = 1309,
    CREATE_VIDEO_ENCODER_UNSUPPORTED_PARAMETERS = 1310,
    CREATE_VIDEO_ENCODER_HEAP_INVALID_PARAMETERS = 1311,
    CREATE_VIDEO_ENCODER_HEAP_UNSUPPORTED_PARAMETERS = 1312,
    CREATECOMMANDLIST_NULL_COMMANDALLOCATOR = 1313,
    CLEAR_UNORDERED_ACCESS_VIEW_INVALID_DESCRIPTOR_HANDLE = 1314,
    DESCRIPTOR_HEAP_NOT_SHADER_VISIBLE = 1315,
    CREATEBLENDSTATE_BLENDOP_WARNING = 1316,
    CREATEBLENDSTATE_BLENDOPALPHA_WARNING = 1317,
    WRITE_COMBINE_PERFORMANCE_WARNING = 1318,
    RESOLVE_QUERY_INVALID_QUERY_STATE = 1319,
    SETPRIVATEDATA_NO_ACCESS = 1320,
    COMMAND_LIST_STATIC_DESCRIPTOR_SAMPLER_MODE_MISMATCH = 1321,
    GETCOPYABLEFOOTPRINTS_UNSUPPORTED_BUFFER_WIDTH = 1322,
    CREATEMESHSHADER_TOPOLOGY_MISMATCH = 1323,
    VRS_SUM_COMBINER_REQUIRES_CAPABILITY = 1324,
    SETTING_SHADING_RATE_FROM_MS_REQUIRES_CAPABILITY = 1325,
    SHADERCACHESESSION_SHADERCACHEDELETE_NOTSUPPORTED = 1326,
    SHADERCACHECONTROL_SHADERCACHECLEAR_NOTSUPPORTED = 1327,
    CREATERESOURCE_STATE_IGNORED = 1328,
    UNUSED_CROSS_EXECUTE_SPLIT_BARRIER = 1329,
    DEVICE_OPEN_SHARED_HANDLE_ACCESS_DENIED = 1330,
    INCOMPATIBLE_BARRIER_VALUES = 1331,
    INCOMPATIBLE_BARRIER_ACCESS = 1332,
    INCOMPATIBLE_BARRIER_SYNC = 1333,
    INCOMPATIBLE_BARRIER_LAYOUT = 1334,
    INCOMPATIBLE_BARRIER_TYPE = 1335,
    OUT_OF_BOUNDS_BARRIER_SUBRESOURCE_RANGE = 1336,
    INCOMPATIBLE_BARRIER_RESOURCE_DIMENSION = 1337,
    SET_SCISSOR_RECTS_INVALID_RECT = 1338,
    SHADING_RATE_SOURCE_REQUIRES_DIMENSION_TEXTURE2D = 1339,
    BUFFER_BARRIER_SUBREGION_OUT_OF_BOUNDS = 1340,
    UNSUPPORTED_BARRIER_LAYOUT = 1341,
    CREATERESOURCEANDHEAP_INVALID_PARAMETERS = 1342,
    ENHANCED_BARRIERS_NOT_SUPPORTED = 1343,
    LEGACY_BARRIER_VALIDATION_FORCED_ON = 1346,
    EMPTY_ROOT_DESCRIPTOR_TABLE = 1347,
    COMMAND_LIST_DRAW_ELEMENT_OFFSET_UNALIGNED = 1348,
    ALPHA_BLEND_FACTOR_NOT_SUPPORTED = 1349,
    BARRIER_INTEROP_INVALID_LAYOUT = 1350,
    BARRIER_INTEROP_INVALID_STATE = 1351,
    GRAPHICS_PIPELINE_STATE_DESC_ZERO_SAMPLE_MASK = 1352,
    INDEPENDENT_STENCIL_REF_NOT_SUPPORTED = 1353,
    CREATEDEPTHSTENCILSTATE_INDEPENDENT_MASKS_UNSUPPORTED = 1354,
    TEXTURE_BARRIER_SUBRESOURCES_OUT_OF_BOUNDS = 1355,
    NON_OPTIMAL_BARRIER_ONLY_EXECUTE_COMMAND_LISTS = 1356,
    EXECUTE_INDIRECT_ZERO_COMMAND_COUNT = 1357,
    GPU_BASED_VALIDATION_INCOMPATIBLE_TEXTURE_LAYOUT = 1358,
    DYNAMIC_INDEX_BUFFER_STRIP_CUT_NOT_SUPPORTED = 1359,
    PRIMITIVE_TOPOLOGY_TRIANGLE_FANS_NOT_SUPPORTED = 1360,
    CREATE_SAMPLER_COMPARISON_FUNC_IGNORED = 1361,
    CREATEHEAP_INVALIDHEAPTYPE = 1362,
    CREATERESOURCEANDHEAP_INVALIDHEAPTYPE = 1363,
    DYNAMIC_DEPTH_BIAS_NOT_SUPPORTED = 1364,
    CREATERASTERIZERSTATE_NON_WHOLE_DYNAMIC_DEPTH_BIAS = 1365,
    DYNAMIC_DEPTH_BIAS_FLAG_MISSING = 1366,
    DYNAMIC_DEPTH_BIAS_NO_PIPELINE = 1367,
    DYNAMIC_INDEX_BUFFER_STRIP_CUT_FLAG_MISSING = 1368,
    DYNAMIC_INDEX_BUFFER_STRIP_CUT_NO_PIPELINE = 1369,
    NONNORMALIZED_COORDINATE_SAMPLING_NOT_SUPPORTED = 1370,
    INVALID_CAST_TARGET = 1371,
    RENDER_PASS_COMMANDLIST_INVALID_END_STATE = 1372,
    RENDER_PASS_COMMANDLIST_INVALID_START_STATE = 1373,
    RENDER_PASS_MISMATCHING_ACCESS = 1374,
    RENDER_PASS_MISMATCHING_LOCAL_PRESERVE_PARAMETERS = 1375,
    RENDER_PASS_LOCAL_PRESERVE_RENDER_PARAMETERS_ERROR = 1376,
    RENDER_PASS_LOCAL_DEPTH_STENCIL_ERROR = 1377,
    DRAW_POTENTIALLY_OUTSIDE_OF_VALID_RENDER_AREA = 1378,
    CREATERASTERIZERSTATE_INVALID_LINERASTERIZATIONMODE = 1379,
    CREATERESOURCE_INVALIDALIGNMENT_SMALLRESOURCE = 1380,
    GENERIC_DEVICE_OPERATION_UNSUPPORTED = 1381,
    CREATEGRAPHICSPIPELINESTATE_RENDER_TARGET_WRONG_WRITE_MASK = 1382,
    PROBABLE_PIX_EVENT_LEAK = 1383,
    PIX_EVENT_UNDERFLOW = 1384,
    RECREATEAT_INVALID_TARGET = 1385,
    RECREATEAT_INSUFFICIENT_SUPPORT = 1386,
    GPU_BASED_VALIDATION_STRUCTURED_BUFFER_STRIDE_MISMATCH = 1387,
    DISPATCH_GRAPH_INVALID = 1388,
    DIRECTSR_SUPERRES_TARGET_FORMAT_INVALID = 1389,
    DIRECTSR_SUPERRES_TARGET_DIMENSION_INVALID = 1390,
    DIRECTSR_SUPERRES_SOURCE_COLOR_FORMAT_INVALID = 1391,
    DIRECTSR_SUPERRES_SOURCE_DEPTH_FORMAT_INVALID = 1392,
    DIRECTSR_SUPERRES_EXPOSURE_SCALE_FORMAT_INVALID = 1393,
    DIRECTSR_SUPERRES_ENGINE_CREATE_FLAGS_INVALID = 1394,
    DIRECTSR_SUPERRES_EXTENSION_INTERNAL_LOAD_FAILURE = 1395,
    DIRECTSR_SUPERRES_EXTENSION_INTERNAL_ENGINE_CREATION_ERROR = 1396,
    DIRECTSR_SUPERRES_EXTENSION_INTERNAL_UPSCALER_CREATION_ERROR = 1397,
    DIRECTSR_SUPERRES_EXTENSION_INTERNAL_UPSCALER_EXECUTION_ERROR = 1398,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_REGION_INVALID = 1399,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_TIME_DELTA_INVALID = 1400,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_REQUIRED_TEXTURE_IS_NULL = 1401,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_MOTION_VECTORS_FORMAT_INVALID = 1402,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_FLAGS_INVALID = 1403,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_FORMAT_INVALID = 1404,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_EXPOSURE_SCALE_TEXTURE_SIZE_INVALID = 1405,
    DIRECTSR_SUPERRES_VARIANT_INDEX_OUT_OF_BOUNDS = 1406,
    DIRECTSR_SUPERRES_VARIANT_ID_NOT_FOUND = 1407,
    DIRECTSR_SUPERRES_DUPLICATE_VARIANT_ID = 1408,
    DIRECTSR_OUT_OF_MEMORY = 1409,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_UNEXPECTED_TEXTURE_IS_IGNORED = 1410,
    DIRECTSR_SUPERRES_UPSCALER_EVICT_UNDERFLOW = 1411,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_OPTIONAL_TEXTURE_IS_NULL = 1412,
    DIRECTSR_SUPERRES_UPSCALER_EXECUTE_INVALID_CAMERA_JITTER = 1413,
    CREATE_STATE_OBJECT_WARNING = 1414,
    GUID_TEXTURE_LAYOUT_UNSUPPORTED = 1415,
    RESOLVE_ENCODER_INPUT_PARAM_LAYOUT_INVALID_PARAMETERS = 1416,
    INVALID_BARRIER_ACCESS = 1417,
    COMMAND_LIST_DRAW_INSTANCE_COUNT_ZERO = 1418,
    DESCRIPTOR_HEAP_NOT_SET_BEFORE_ROOT_SIGNATURE_WITH_DIRECTLY_INDEXED_FLAG = 1419,
    DIFFERENT_DESCRIPTOR_HEAP_SET_AFTER_ROOT_SIGNATURE_WITH_DIRECTLY_INDEXED_FLAG = 1420,
    APPLICATION_SPECIFIC_DRIVER_STATE_NOT_SUPPORTED = 1421,
    RENDER_TARGET_OR_DEPTH_STENCIL_RESOUCE_NOT_INITIALIZED = 1422,
    BYTECODE_VALIDATION_ERROR = 1423,
    FENCE_ZERO_WAIT = 1424,
    NON_COMMON_RESOURCE_IN_COPY_QUEUE = 1425,
}
fn String Dx_D3D12_MESSAGE_ID.get_name(&self)
{
	foreach (i, &val : Dx_D3D12_MESSAGE_ID.values)
	{
		if (*self == *val)
		{
			return Dx_D3D12_MESSAGE_ID.names[i];
		}
	}
	return "Unknown";
}

struct Dx_D3D12_MESSAGE
{
    Dx_D3D12_MESSAGE_CATEGORY category;
    Dx_D3D12_MESSAGE_SEVERITY severity;
    Dx_D3D12_MESSAGE_ID id;
    char* description;
    Win32_SIZE_T description_byte_length;
}
