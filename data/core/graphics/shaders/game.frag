#version 330

layout(std140) uniform fsConstants
{
    vec4 nv_color;
    vec4 nv_desaturation_params;
    vec4 nv_light_params;
    vec2 resolution;
    vec2 zoom_to_world_params;
    float nv_intensity;
    float darkness;
    float timer;
    uint render_darkness;
} _15;

uniform sampler2D gameview;
uniform sampler2D lightmap;

in vec2 vUV;
layout(location = 0) out vec4 fragColor;
bool use_nightvision;

void main()
{
    use_nightvision = _15.nv_intensity > 0.0;
    vec2 uv = vUV;
    vec4 color = texture(gameview, uv);
    if (!(_15.render_darkness != 0u))
    {
        fragColor = color;
        return;
    }
    vec4 light = texture(lightmap, uv);
    if (use_nightvision)
    {
        float luminance = dot(color.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        float lightLuminance = max(light.x, max(light.y, light.z));
        vec3 grayscale = vec3(luminance * _15.nv_intensity);
        float lightIntensity = (smoothstep(_15.nv_desaturation_params.x, _15.nv_desaturation_params.y, lightLuminance) * _15.nv_desaturation_params.z) + _15.nv_desaturation_params.w;
        if (lightLuminance > 0.0)
        {
            vec3 _117 = color.xyz * (((light.xyz / vec3(lightLuminance)) * 0.75) + vec3(0.25));
            color = vec4(_117.x, _117.y, _117.z, color.w);
        }
        vec3 _125 = mix(grayscale, color.xyz, vec3(lightIntensity));
        color = vec4(_125.x, _125.y, _125.z, color.w);
        lightIntensity = (smoothstep(_15.nv_light_params.x, _15.nv_light_params.y, lightLuminance) * _15.nv_light_params.z) + _15.nv_light_params.w;
        fragColor = vec4(color.xyz * lightIntensity, color.w);
    }
    else
    {
        vec3 _156 = color.xyz * light.xyz;
        color = vec4(_156.x, _156.y, _156.z, color.w);
        fragColor = vec4(color.xyz, color.w);
    }
}

