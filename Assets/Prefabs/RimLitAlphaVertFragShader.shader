Shader "Custom/12/RimLitAlphaVertFragShader"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower ("Rim Power", Range(.5, 8)) = 3
    }

    SubShader
    {
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float3 viewDir : TEXCOORD1;
                float3 normal : NORMAL;
            };

            fixed4 _RimColor;
            float _RimPower;

            v2f vert (appdata vertexIn)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertexIn.vertex);
                o.normal = UnityObjectToWorldNormal(vertexIn.normal);
                float3 worldPos = mul(unity_ObjectToWorld, vertexIn.vertex).xyz;
                o.viewDir = normalize(UnityWorldSpaceViewDir(worldPos));
                return o;
            }

            fixed4 frag (v2f vIn) : SV_Target
            {
                half rim = 1-dot(normalize(vIn.viewDir), vIn.normal);
                return _RimColor * pow(rim, _RimPower);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
