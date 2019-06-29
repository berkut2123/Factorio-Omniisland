#version 330

layout(std140) uniform fsConstants
{
    vec4 color;
} _29;

uniform sampler2D atlasTexture;

in vec2 vUV;
layout(location = 0) out vec4 fragColor;

void main()
{
    vec4 texColor = texture(atlasTexture, vUV);
    fragColor = _29.color * texColor.x;
}

