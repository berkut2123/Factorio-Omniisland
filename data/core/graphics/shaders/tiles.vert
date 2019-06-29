#version 330

layout(std140) uniform vsConstants
{
    mat4 projection;
} _143;

uniform samplerBuffer maskTexCoordTable;

flat out uint vFlags;
layout(location = 3) in uint flags;
layout(location = 2) in uvec2 masks;
out vec4 maskUVs;
flat out vec3 vTint;
out vec2 vUV;
layout(location = 1) in vec2 uv;
layout(location = 0) in vec2 position;

vec2 getMaskUV(vec2 corner, uint maskIndex)
{
    vec4 mask = texelFetch(maskTexCoordTable, int(maskIndex));
    return mask.xy + (corner * mask.zw);
}

vec3 decodeRGB565(int rgb5)
{
    ivec3 colorUnpacked = (ivec3(rgb5) >> ivec3(11, 5, 0)) & ivec3(31, 63, 31);
    return vec3(vec3(colorUnpacked) / vec3(31.0, 63.0, 31.0));
}

void main()
{
    vFlags = flags;
    uint vertexID = uint(gl_VertexID) % 4u;
    uint i = vertexID / 2u;
    uint j = vertexID % 2u;
    vec2 corner = vec2(float(i), float(j));
    vec2 param = corner;
    uint param_1 = masks.x;
    vec2 mask1 = getMaskUV(param, param_1);
    vec2 param_2 = corner;
    uint param_3 = masks.y;
    vec2 mask2 = getMaskUV(param_2, param_3);
    maskUVs = vec4(mask1, mask2);
    int param_4 = int(flags >> uint(16));
    vTint = decodeRGB565(param_4);
    vUV = uv;
    gl_Position = _143.projection * vec4(position, 0.0, 1.0);
}

