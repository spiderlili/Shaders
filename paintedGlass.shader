// create a blend of the painted glass image with what's behind it. 
// The image distortion ripple effect of what's behind it is based on the distortion of the bump map's values


Shader "Custom/paintedGlass" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap("Normalmap", 2D) = "bump" {}
		_ScaleUV ("Scale", Range(1,20)) = 1
	}
	SubShader {
		Tags{ "Queue" = "Transparent"}
		GrabPass{}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			//UV coordinates
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 uvgrab : TEXCOORD1;
				float2 uvbump: TEXCOORD2;
				float4 vertex : SV_POSITION;
			};
			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;
			sampler2D _MainTex; //for scaling
			float4 _MainTex_ST;
			sampler2D _BumpMap; 
			float4 _BumpMap_ST;
			float _ScaleUV;

			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

			/* take the vertices from the object by putting it down from worldspace into clip space 
			calculates the required UVs for the grab texture 
			by seeing where it positions itself within the screen space */

				o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y) + o.vertex.w) * 0.5;
				o.uvgrab.zw = o.vertex.zw;

			//transform the uvs with the bump the same way as the main texture
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap);

				return o;
			}

			//calculate where the grab should be
			//modify the uv grab uvs on the grab texture before putting the grab texture onto the surface using the bump map

			fixed4 frag (v2f i) : SV_Target
			{	half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;

			//calculate an offset of how much to change the background based on the bump values from the bump map, scale, texelsize of image
				float2 offset = bump * _ScaleUV * _GrabTexture_TexelSize.xy;

			//reset the uvs for the grab texture and create interest 
				i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				fixed4 tint = tex2D(_MainTex, i.uv); //tint colour = main texture, with a separate set of uvs from the grab
				col *= tint; //multiply tint by existing colour from the grab texture
				return col;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}


