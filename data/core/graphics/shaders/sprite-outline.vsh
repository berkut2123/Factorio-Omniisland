cbuffer _19
{
    row_major float4x4 _19_projection : packoffset(c0);
};

static float4 gl_Position;
static int gl_VertexIndex;
static float3 position;
static float2 vUV1;
static float2 uv1;
static float2 vUV2;
static float4 vTint;
static float4 tint;

struct SPIRV_Cross_Input
{
    float3 position : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float4 tint : TEXCOORD2;
    uint gl_VertexIndex : SV_VertexID;
};

struct SPIRV_Cross_Output
{
    float2 vUV1 : TEXCOORD0;
    float2 vUV2 : TEXCOORD1;
    float4 vTint : TEXCOORD2;
    float4 gl_Position : SV_Position;
};

void vert_main()
{
    gl_Position = mul(float4(position, 1.0f), _19_projection);
    uint vertexID = uint(gl_VertexIndex) % 4u;
    uint i = vertexID / 2u;
    uint j = vertexID % 2u;
    float2 uv2 = float2(float(i), float(j));
    vUV1 = uv1;
    vUV2 = uv2 + (((uv2 * 2.0f) - 1.0f.xx) * 0.5f);
    vTint = tint;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_VertexIndex = int(stage_input.gl_VertexIndex);
    position = stage_input.position;
    uv1 = stage_input.uv1;
    tint = stage_input.tint;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.vUV1 = vUV1;
    stage_output.vUV2 = vUV2;
    stage_output.vTint = vTint;
    return stage_output;
}
