//vertex fragment material shader for distortion in glass

Shader "Custom/VFMat"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		
		//slider to control the amount of ripple effect
		_ScaleUVX ("Scale X", Range(1,10)) = 1
		_ScaleUVY ("Scale Y", Range(1,10)) = 1
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		GrabPass{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			//the material needs uv values 
			//so the shader system knows how to put the material / texture coming in onto the mesh surface
			//can have multiple materials on the surface of an object.
			struct appdata //coming into the vert function
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			
			struct v2f //coming out into the fragment
			//new set of uvs - converted by the vert function before they get to the frag so they can be used
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _ScaleUVX;
			float _ScaleUVY;
			
			v2f vert (appdata v)
			{
			//create own version of the struct o
				v2f o;
				//vertex is setting the vertices to the clip space by UnityObjectToClipPos
				o.vertex = UnityObjectToClipPos(v.vertex);
				
				//transform the uvs by taking the existing uv values along with the texture itself
				//creating a set of uv values that can be used by the fragment shader function frag()
				//disturb the uvs and create a ripple effect across the surface
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				
				//sin function will produce a wave like structure from the feeded data
				o.uv.x = sin(o.uv.x * _ScaleUVX);
				o.uv.y = sin(o.uv.y * _ScaleUVY);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_GrabTexture, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
