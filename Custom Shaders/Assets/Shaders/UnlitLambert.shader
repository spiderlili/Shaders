Shader "Unlit/UnlitLambert"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "LightMode"="ForwardAdd" "RenderType" = "Opaque"}
        LOD 100
		Blend One One //basic photoshop blending mode

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fowardadd //support shadows and multiple lights

            #include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				o.worldNormal = worldNormal;
                return o;
            }

			fixed4 _Color;

            fixed4 frag (v2f i) : SV_Target
            {
				float NormalDotLight = max(0, dot(i.worldNormal, _WorldSpaceLightPos0.xyz));
				float4 diff = NormalDotLight * _LightColor0;
				float4 col = _Color * diff;
                return col;
            }
            ENDCG
        }
    }
}
