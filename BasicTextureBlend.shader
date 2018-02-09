//blending 2 images in the same shader together: put one texture on top of the other

Shader "Custom/BasicTextureBlend" {
Properties{
		_MainTex ("MainTex", 2D) = "white" {}
		_DecalTex ("Decal", 2D) = "white" {}
		
		//turn on the additive decal texture on or off by checker. initially off
		[Toggle] _ShowDecal("Show Decal?", Float) = 0
		
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _DecalTex;
		float _ShowDecal;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 a = tex2D(_MainTex, IN.uv_MainTex); //get the colours from the textures according to the uv map
			fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;  //same uvs as the main texture
			//additive blending
			//o.Albedo = a.rgb + b.rgb;
			o.Albedo = b.r > 0.9 ? b.rgb: a.rgb; //put the colours in the albedo
		}
		ENDCG
	}
	FallBack "Diffuse"

}
