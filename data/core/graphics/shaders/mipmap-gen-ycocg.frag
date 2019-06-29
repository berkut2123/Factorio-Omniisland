#version 330

layout(std140) uniform mipMapGenParams
{
    ivec2 offset;
    int unusedLevel;
} _189;

uniform sampler2D tex;
uniform sampler2D tex2;

layout(location = 0) out vec4 fragColor;
in vec2 vUV;

vec4 YCoCgToRGB(vec4 ycocg, float alpha)
{
    float Y = ycocg.w;
    float scale = 1.0 / ((31.875 * ycocg.z) + 1.0);
    float Co = (ycocg.x - 0.501960813999176025390625) * scale;
    float Cg = (ycocg.y - 0.501960813999176025390625) * scale;
    float R = (Y + Co) - Cg;
    float G = Y + Cg;
    float B = (Y - Co) - Cg;
    return vec4(R, G, B, alpha);
}

vec4 toLinear(vec4 sRGB_A)
{
    float a = sRGB_A.w;
    float rcpA = 1.0 / ((a != 0.0) ? a : 1.0);
    vec3 sRGB = sRGB_A.xyz * rcpA;
    bvec3 cutoff = lessThan(sRGB, vec3(0.040449999272823333740234375));
    vec3 higher = pow((abs(sRGB) + vec3(0.054999999701976776123046875)) / vec3(1.05499994754791259765625), vec3(2.400000095367431640625));
    vec3 lower = sRGB / vec3(12.9200000762939453125);
    return vec4(vec3(cutoff.x ? lower.x : higher.x, cutoff.y ? lower.y : higher.y, cutoff.z ? lower.z : higher.z) * a, a);
}

vec4 fromLinear(vec4 linearRGB_A)
{
    float a = linearRGB_A.w;
    float rcpA = 1.0 / ((a != 0.0) ? a : 1.0);
    vec3 linearRGB = linearRGB_A.xyz * rcpA;
    bvec3 cutoff = lessThan(linearRGB, vec3(0.003130800090730190277099609375));
    vec3 higher = (vec3(1.05499994754791259765625) * pow(abs(linearRGB), vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
    vec3 lower = linearRGB * vec3(12.9200000762939453125);
    return vec4(vec3(cutoff.x ? lower.x : higher.x, cutoff.y ? lower.y : higher.y, cutoff.z ? lower.z : higher.z) * a, a);
}

void main()
{
    vec4 color = vec4(0.0);
    ivec2 coord = (ivec2(2) * ivec2(gl_FragCoord.xy)) + _189.offset;
    for (int y = 0; y < 2; y++)
    {
        for (int x = 0; x < 2; x++)
        {
            vec4 t1 = texelFetch(tex, coord + ivec2(x, y), 0);
            float a1 = texelFetch(tex2, coord + ivec2(x, y), 0).x;
            vec4 param = t1;
            float param_1 = a1;
            t1 = YCoCgToRGB(param, param_1);
            vec4 param_2 = t1;
            color += toLinear(param_2);
        }
    }
    vec4 param_3 = color * 0.25;
    fragColor = fromLinear(param_3);
}

