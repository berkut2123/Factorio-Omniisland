cbuffer _17
{
    row_major float4x4 _17_projection : packoffset(c0);
    float2 _17_textLineOrigin : packoffset(c4);
    float _17_sdfScaleFactor : packoffset(c4.z);
    float _17_angle : packoffset(c4.w);
};

static float4 gl_Position;
static float2 position;
static float2 vUV;
static float2 uv;

struct SPIRV_Cross_Input
{
    float2 position : TEXCOORD0;
    float2 uv : TEXCOORD1;
};

struct SPIRV_Cross_Output
{
    float2 vUV : TEXCOORD0;
    float4 gl_Position : SV_Position;
};

void vert_main()
{
    float2 offset = position - _17_textLineOrigin;
    offset /= _17_sdfScaleFactor.xx;
    float2 sc = sin(float2(_17_angle, _17_angle + 1.57079637050628662109375f));
    offset = float2((offset.x * sc.y) - (offset.y * sc.x), (offset.x * sc.x) + (offset.y * sc.y));
    float2 adjustedPosition = _17_textLineOrigin + offset;
    gl_Position = mul(float4(adjustedPosition, 0.0f, 1.0f), _17_projection);
    vUV = uv;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    position = stage_input.position;
    uv = stage_input.uv;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.vUV = vUV;
    return stage_output;
}
