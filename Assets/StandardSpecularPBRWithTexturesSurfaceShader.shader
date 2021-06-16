Shader "Custom/04/StandardSpecularPBRWithTexturesSurfaceShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SmoothnessTex ("Smoothness (R)", 2D) = "white" {}
        _SpecColor("Specular", Color) = (1,1,1,1)
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf StandardSpecular

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SmoothnessTex;
            //float2 uvX_texName; // – UV coordinates (X indicates UV set) applied to texture texName
            //float3 viewDir; // - contains view direction, for computing Parallax effects, rim lighting etc.
            //float4 with COLOR semantic - contains interpolated per-vertex color.
            //float4 screenPos; // - contains screen space position for reflection or screenspace effects
            //float3 worldPos; // - contains world space position.
            //float3 worldRefl; // - contains world reflection vector
            //float3 worldNormal; // - contains world normal vector
        };

        sampler2D _MainTex;
        sampler2D _SmoothnessTex;

        /*
        struct SurfaceOutputStandardSpecular
        {
            fixed3 Albedo;      // diffuse color
            fixed3 Specular;    // specular color
            fixed3 Normal;      // tangent space normal, if written
            half3 Emission;
            half Smoothness;    // 0=rough, 1=smooth
            half Occlusion;     // occlusion (default 1)
            fixed Alpha;        // alpha for transparencies
        };
        */

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            o.Smoothness = tex2D(_SmoothnessTex, IN.uv_SmoothnessTex).r;
            o.Specular = _SpecColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
