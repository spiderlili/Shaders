Shader "Custom/RasterizerVertexColours"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float4 color : COLOR;
            };

            v2f vert (appdata v)
            {	
                v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f, o); 
                o.vertex = UnityObjectToClipPos(v.vertex);
				//o.color = v.color;
				o.color.r = v.vertex.x;
				o.color.g = v.vertex.y;
				o.color.g = v.vertex.z;
                return o; 
            }

            fixed4 frag (v2f i) : SV_Target
            {
				fixed4 col = i.color;
                return col;
            }
            ENDCG
        }
    }
}
