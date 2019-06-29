#version 330

const float _178[3] = float[](0.2874059975147247314453125, 0.42518699169158935546875, 0.2874059975147247314453125);
const float _256[5] = float[](0.1446709930896759033203125, 0.22499300539493560791015625, 0.2606720030307769775390625, 0.22499300539493560791015625, 0.1446709930896759033203125);
const float _336[7] = float[](0.09442000091075897216796875, 0.13819299638271331787109375, 0.17367599904537200927734375, 0.18742300570011138916015625, 0.17367599904537200927734375, 0.13819299638271331787109375, 0.09442000091075897216796875);
const float _411[11] = float[](0.055036999285221099853515625, 0.07280600070953369140625, 0.09050600230693817138671875, 0.1057260036468505859375, 0.1160610020160675048828125, 0.119726002216339111328125, 0.1160610020160675048828125, 0.1057260036468505859375, 0.09050600230693817138671875, 0.07280600070953369140625, 0.055036999285221099853515625);

layout(std140) uniform fsConstants
{
    vec4 globalColor;
    vec2 atlasSize;
    float begin;
    float end;
    float searchRadius;
    float alphaMultiplier;
} _71;

uniform sampler2D tex;

in vec2 vUV1;
in vec2 vUV2;
in vec4 vTint;
layout(location = 0) out vec4 fragColor;

float mipMapLevel(vec2 uv)
{
    vec2 dx_vtc = dFdx(uv);
    vec2 dy_vtc = dFdy(uv);
    float delta_max_sqr = max(dot(dx_vtc, dx_vtc), dot(dy_vtc, dy_vtc));
    return 0.5 * log2(delta_max_sqr);
}

bool insideBounds(vec2 v)
{
    vec4 test = vec4(v.x, v.y, 1.0 - v.x, 1.0 - v.y);
    return all(greaterThan(test, vec4(0.0)));
}

void main()
{
    vec2 param = vUV1 * _71.atlasSize;
    float mipLevel = mipMapLevel(param);
    vec2 dTexel = vec2(1.0) / _71.atlasSize;
    vec2 dUV1 = vec2(dFdx(vUV1).x, dFdy(vUV1).y);
    vec2 dUV2 = vec2(dFdx(vUV2).x, dFdy(vUV2).y) * (dTexel / dUV1);
    vec4 mipIndicator = vec4(0.0);
    float samplingOffset = _71.searchRadius / 5.0;
    float acc = 0.0;
    if (mipLevel > 1.0)
    {
        float uvMultiplier = samplingOffset * 3.6666667461395263671875;
        for (int y = 0; y < 3; y++)
        {
            for (int x = 0; x < 3; x++)
            {
                vec2 mulUV = vec2(float(x - 1), float(y - 1)) * uvMultiplier;
                vec2 param_1 = vUV2 + (dUV2 * mulUV);
                if (insideBounds(param_1))
                {
                    acc += ((textureLod(tex, vUV1 + (dTexel * mulUV), mipLevel).w * _178[x]) * _178[y]);
                }
            }
        }
    }
    else
    {
        if (mipLevel > 0.0)
        {
            float uvMultiplier_1 = samplingOffset * 2.2000000476837158203125;
            for (int y_1 = 0; y_1 < 5; y_1++)
            {
                for (int x_1 = 0; x_1 < 5; x_1++)
                {
                    vec2 mulUV_1 = vec2(float(x_1 - 2), float(y_1 - 2)) * uvMultiplier_1;
                    vec2 param_2 = vUV2 + (dUV2 * mulUV_1);
                    if (insideBounds(param_2))
                    {
                        acc += ((textureLod(tex, vUV1 + (dTexel * mulUV_1), mipLevel).w * _256[x_1]) * _256[y_1]);
                    }
                }
            }
        }
        else
        {
            if (_71.searchRadius < 9.5)
            {
                float uvMultiplier_2 = samplingOffset * 1.5714285373687744140625;
                for (int y_2 = 0; y_2 < 7; y_2++)
                {
                    for (int x_2 = 0; x_2 < 7; x_2++)
                    {
                        vec2 mulUV_2 = vec2(float(x_2 - 3), float(y_2 - 3)) * uvMultiplier_2;
                        vec2 param_3 = vUV2 + (dUV2 * mulUV_2);
                        if (insideBounds(param_3))
                        {
                            acc += ((textureLod(tex, vUV1 + (dTexel * mulUV_2), mipLevel).w * _336[x_2]) * _336[y_2]);
                        }
                    }
                }
            }
            else
            {
                float uvMultiplier_3 = samplingOffset * 1.0;
                for (int y_3 = 0; y_3 < 11; y_3++)
                {
                    for (int x_3 = 0; x_3 < 11; x_3++)
                    {
                        vec2 mulUV_3 = vec2(float(x_3 - 5), float(y_3 - 5)) * uvMultiplier_3;
                        vec2 param_4 = vUV2 + (dUV2 * mulUV_3);
                        if (insideBounds(param_4))
                        {
                            acc += ((textureLod(tex, vUV1 + (dTexel * mulUV_3), mipLevel).w * _411[x_3]) * _411[y_3]);
                        }
                    }
                }
            }
        }
    }
    vec4 tint = vTint;
    vec4 result = tint * clamp(acc * _71.alphaMultiplier, 0.0, 1.0);
    if (result.w < 0.03125)
    {
        discard;
    }
    fragColor = result;
}

