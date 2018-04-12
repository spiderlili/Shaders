Shader "Custom/AddOutline" {

//combine with gradient shader for borderlands style rendering

Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _OutlineColor ("Outline Color", Color) = (0,0,0,1)
	  _Outline ("Outline Width", Range (.002, 0.1)) = .005
    }
    
   SubShader {

      CGPROGRAM
	      #pragma surface surf Lambert
	      struct Input {
	          float2 uv_MainTex;
	      };

	      sampler2D _MainTex;
	      void surf (Input IN, inout SurfaceOutput o) {
	          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
	      }
      ENDCG

//vertex fragment shader after the model has been drawn
      Pass {
      //outline effect - only see the back faces
			Cull Front 

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
				
			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR; //outline colour
			};
			
			float _Outline;
			float4 _OutlineColor;
			
			v2f vert(appdata v) {
				v2f o;
				//set the positions based on the clip space - always needed for vertex shader
				o.pos = UnityObjectToClipPos(v.vertex); 
				
				//calculate a normal based on the world position
				//return the normal in the form of a world space coordinate rather than the normals that belong to the vertex(local spoace)
				//calculate an offset based on the normals' xy position by transforming it into projection mode
				//for nice flat outline over the top of the model
				
				float3 norm   = normalize(mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);

				//pushing the xy values out
				o.pos.xy += offset * o.pos.z * _Outline;
				o.color = _OutlineColor;
				return o;
			}


			fixed4 frag(v2f i) : SV_Target
			{
				return i.color;
			}
			ENDCG
		}

    } 
    Fallback "Diffuse"
}

