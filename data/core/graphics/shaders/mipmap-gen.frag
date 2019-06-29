#version 330

layout(std140) uniform mipMapGenParams
{
    ivec2 offset;
    int unusedLevel;
} _135;

uniform sampler2D tex;

layout(location = 0) out vec4 fragColor;
in vec2 vUV;

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
    ivec2 coord = (ivec2(2) * ivec2(gl_FragCoord.xy)) + _135.offset;
    for (int y = 0; y < 2; y++)
    {
        for (int x = 0; x < 2; x++)
        {
            vec4 t1 = texelFetch(tex, coord + ivec2(x, y), 0);
            vec4 param = t1;
            color += toLinear(param);
        }
    }
    vec4 param_1 = color * 0.25;
    fragColor = fromLinear(param_1);
}

