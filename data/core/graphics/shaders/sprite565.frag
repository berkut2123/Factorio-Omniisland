#version 330

uniform usampler2D tex;

in vec2 vUV;
layout(location = 0) out vec4 fragColor;
in vec4 vTint;

vec3 decodeRGB565(int rgb5)
{
    ivec3 colorUnpacked = (ivec3(rgb5) >> ivec3(11, 5, 0)) & ivec3(31, 63, 31);
    return vec3(vec3(colorUnpacked) / vec3(31.0, 63.0, 31.0));
}

void main()
{
    ivec2 size = textureSize(tex, 0);
    vec2 coord = floor(vUV * vec2(size));
    int rgb5 = int(texelFetch(tex, ivec2(coord), 0).x);
    int param = rgb5;
    vec3 _81 = decodeRGB565(param) * vTint.xyz;
    fragColor = vec4(_81.x, _81.y, _81.z, fragColor.w);
    fragColor.w = vTint.w;
}

