#version 330

layout(std140) uniform vsConstants
{
    mat4 projection;
} _19;

layout(location = 0) in vec3 position;
out vec2 vUV1;
layout(location = 1) in vec2 uv1;
out vec2 vUV2;
out vec4 vTint;
layout(location = 2) in vec4 tint;

void main()
{
    gl_Position = _19.projection * vec4(position, 1.0);
    uint vertexID = uint(gl_VertexID) % 4u;
    uint i = vertexID / 2u;
    uint j = vertexID % 2u;
    vec2 uv2 = vec2(float(i), float(j));
    vUV1 = uv1;
    vUV2 = uv2 + (((uv2 * 2.0) - vec2(1.0)) * 0.5);
    vTint = tint;
}

