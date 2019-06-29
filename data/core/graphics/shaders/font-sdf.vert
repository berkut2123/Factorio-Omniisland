#version 330

layout(std140) uniform vsConstants
{
    mat4 projection;
    vec2 textLineOrigin;
    float sdfScaleFactor;
    float angle;
} _17;

layout(location = 0) in vec2 position;
out vec2 vUV;
layout(location = 1) in vec2 uv;

void main()
{
    vec2 offset = position - _17.textLineOrigin;
    offset /= vec2(_17.sdfScaleFactor);
    vec2 sc = sin(vec2(_17.angle, _17.angle + 1.57079637050628662109375));
    offset = vec2((offset.x * sc.y) - (offset.y * sc.x), (offset.x * sc.x) + (offset.y * sc.y));
    vec2 adjustedPosition = _17.textLineOrigin + offset;
    gl_Position = _17.projection * vec4(adjustedPosition, 0.0, 1.0);
    vUV = uv;
}

