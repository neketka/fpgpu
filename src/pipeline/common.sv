typedef bit [31:0] float32;

typedef struct packed {
    float32 x;
    float32 y;
    float32 z;
    float32 w;
} s_fvec4;

typedef struct packed {
    integer x;
    integer y;
} s_ivec2;

typedef struct packed {
    integer x;
    integer y;
    integer w;
    integer h;
} s_ibox;

typedef struct packed {
    s_fvec4 row0;
    s_fvec4 row1;
    s_fvec4 row2;
    s_fvec4 row3;
} s_fmat4;

typedef enum bit [1:0] {
    CULL_NONE, CULL_BACKFACE, CULL_FRONTFACE, CULL_FRONTBACK  
} e_culling_mode;

typedef enum bit [1:0] {
    ZTEST_NEVER, ZTEST_LESS, ZTEST_GREATER, ZTEST_ALWAYS
} e_ztest_mode;

typedef enum bit [1:0] {
    BLEND_NONE, BLEND_ALPHA, BLEND_ADD, BLEND_SUB
} e_blend_mode;

typedef struct packed {
    s_fvec4 position;
    s_fvec4 normal;
    s_fvec4 texcoord;
    s_fvec4 color;
} s_vertex_common;

typedef struct packed {
    s_fmat4 position_mat;
    s_fmat4 normal_mat;
    s_fmat4 texcoord_mat;
    s_fmat4 color_mat;
} s_vertex_transform_data;

typedef struct packed {
    integer v_first_addr;
    integer v_count;

    integer transform_addr;
    integer color_image_addr;
    integer depth_image_addr;
    s_ibox viewport;
    s_ibox scissor;
    e_culling_mode culling_mode;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_top_to_v_fetch;

typedef struct packed {
    s_vertex_common vertex;

    integer transform_addr;
    integer color_image_addr;
    integer depth_image_addr;
    s_ibox viewport;
    s_ibox scissor;
    e_culling_mode culling_mode;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_v_fetch_to_transform;

typedef struct packed {
    s_vertex_common v1;
    s_vertex_common v2;
    s_vertex_common v3;

    integer color_image_addr;
    integer depth_image_addr;
    s_ibox viewport;
    s_ibox scissor;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_transform_to_clipculling;

typedef struct packed {
    s_vertex_common v1;
    s_vertex_common v2;
    s_vertex_common v3;
    
    integer color_image_addr;
    integer depth_image_addr;
    s_ibox scissor;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_clipculling_to_screenspace;

typedef struct packed {
    s_vertex_common v1;
    s_vertex_common v2;
    s_vertex_common v3;

    integer color_image_addr;
    integer depth_image_addr;
    s_ibox scissor;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_screenspace_to_rasterizer;

typedef struct packed {
    s_vertex_common v_interp;
    s_ivec2 pixelcoord;

    integer color_image_addr;
    integer depth_image_addr;
    s_ibox scissor;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_rasterizer_to_depth_fetch;

typedef struct packed {
    s_vertex_common v_interp;
    s_ivec2 pixelcoord;
    float32 src_depth;

    integer color_image_addr;
    integer depth_image_addr;
    s_ibox scissor;
    e_blend_mode blend_mode;
    e_ztest_mode ztest_mode;
} s_depth_fetch_to_zscissor;

typedef struct packed {
    s_vertex_common v_interp;
    s_ivec2 pixelcoord;

    integer color_image_addr;
    integer depth_image_addr;
    e_blend_mode blend_mode;
} s_zscissor_to_shading;

typedef struct packed {
    s_fvec4 shaded_color;
    s_ivec2 pixelcoord;
    float32 new_depth;

    integer color_image_addr;
    integer depth_image_addr;
    e_blend_mode blend_mode;
} s_shading_to_image_fetch;

typedef struct packed {
    s_fvec4 src_color;
    s_fvec4 shaded_color;
    s_ivec2 pixelcoord;
    float32 new_depth;

    integer color_image_addr;
    integer depth_image_addr;
    e_blend_mode blend_mode;
} s_image_fetch_to_blending;

typedef struct packed {
    s_fvec4 final_color;
    s_ivec2 pixelcoord;
    float32 new_depth;

    integer color_image_addr;
    integer depth_image_addr;
} s_blending_to_write;