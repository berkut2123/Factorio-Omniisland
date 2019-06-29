#version 330

layout(std140) uniform fsConstants
{
    vec4 nv_color;
    vec4 nv_desaturation_params;
    vec4 nv_light_params;
    vec2 resolution;
    vec2 ztw_params;
    float nv_intensity;
    float darkness;
    float timer;
    uint render_darkness;
} _33;

uniform sampler2D gameview;
uniform sampler2D lightmap;

in vec2 vUV;
layout(location = 0) out vec4 fragColor;
bool use_nightvision;

float hmix(float a, float b)
{
    return fract(sin((a * 12.98980045318603515625) + b) * 43758.546875);
}

float hash3(float a, float b, float c)
{
    float param = a;
    float param_1 = b;
    float ab = hmix(param, param_1);
    float param_2 = a;
    float param_3 = c;
    float ac = hmix(param_2, param_3);
    float param_4 = b;
    float param_5 = c;
    float bc = hmix(param_4, param_5);
    float param_6 = ac;
    float param_7 = bc;
    float param_8 = ab;
    float param_9 = hmix(param_6, param_7);
    return hmix(param_8, param_9);
}

vec3 getnoise3(vec2 p)
{
    float param = p.x;
    float param_1 = p.y;
    float param_2 = floor(_33.timer / 3.0);
    return vec3(hash3(param, param_1, param_2));
}

void main()
{
    use_nightvision = _33.nv_intensity > 0.0;
    vec2 uv = vUV;
    vec4 color = texture(gameview, uv);
    vec2 param = uv;
    vec3 _noise = getnoise3(param);
    vec3 _129 = color.xyz + ((_noise * _33.ztw_params.x) + vec3(_33.ztw_params.y));
    color = vec4(_129.x, _129.y, _129.z, color.w);
    vec4 light = texture(lightmap, uv);
    if (use_nightvision)
    {
        float luminance = dot(color.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        float lightLuminance = max(light.x, max(light.y, light.z));
        vec3 grayscale = vec3(luminance * _33.nv_intensity);
        float lightIntensity = (smoothstep(_33.nv_desaturation_params.x, _33.nv_desaturation_params.y, lightLuminance) * _33.nv_desaturation_params.z) + _33.nv_desaturation_params.w;
        vec3 _184 = mix(grayscale, color.xyz, vec3(lightIntensity));
        color = vec4(_184.x, _184.y, _184.z, color.w);
        lightIntensity = (smoothstep(_33.nv_light_params.x, _33.nv_light_params.y, lightLuminance) * _33.nv_light_params.z) + _33.nv_light_params.w;
        fragColor = vec4(color.xyz * lightIntensity, color.w);
    }
    else
    {
        vec3 _217 = color.xyz * light.xyz;
        color = vec4(_217.x, _217.y, _217.z, color.w);
        fragColor = vec4(color.xyz, color.w);
    }
}

