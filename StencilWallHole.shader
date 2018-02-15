//use a quad for testing.
//the hole to write itself into the stencil buffer 
//every single pixel on that hole of the quad writes a value into the stencil buffer and make a mask out of it
//force the hole to be drawn first so it makes a hole in the scene.

Shader "Custom/StencilWallHole" {
	Properties {
		_MainTex ("Diffuse", 2D) = "white" {}
	}
	SubShader {
	//gets drawn before the geometry and gets to the stencil buffer first
		Tags { "Queue"="Geometry-1" }

		ColorMask 0
		ZWrite off
		Stencil
		{
			Ref 1
			Comp always
			Pass replace
		}
		
		CGPROGRAM
		#pragma surface surf Lambert


		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
