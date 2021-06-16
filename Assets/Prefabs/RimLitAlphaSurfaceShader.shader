Shader "Custom/12/RimLitAlphaSurfaceShader"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower ("Rim Power", Range(.5, 8)) = 3
    }

    SubShader
    {

        Pass {
            ColorMask 0
            ZWrite On
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha

        struct Input
        {
            float2 uv_MainTex;
            //float2 uvX_texName; // – UV coordinates (X indicates UV set) applied to texture texName
            float3 viewDir; // - contains view direction, for computing Parallax effects, rim lighting etc.
            //float4 with COLOR semantic - contains interpolated per-vertex color.
            //float4 screenPos; // - contains screen space position for reflection or screenspace effects
            //float3 worldPos; // - contains world space position.
            //float3 worldRefl; // - contains world reflection vector
            //float3 worldNormal; // - contains world normal vector
        };

        fixed4 _RimColor;
        float _RimPower;

        /*
        struct SurfaceOutput
        {
            fixed3 Albedo;  // diffuse color
            fixed3 Normal;  // tangent space normal, if written
            fixed3 Emission;
            half Specular;  // specular power in 0..1 range
            fixed Gloss;    // specular intensity
            fixed Alpha;    // alpha for transparencies
        };
        */

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1-dot(normalize(IN.viewDir), o.Normal);
            o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            o.Alpha = _RimColor.a * pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
