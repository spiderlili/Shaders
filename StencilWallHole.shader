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

//each pixel has a corresponding stencil value. 
//before the value can go into the stencil buffer, it needs to check what's already in the stencil buffer
//so it doesn't overwrite the values that are already in the stencil buffer. 

		ColorMask 0
		ZWrite off
		Stencil
		{  
		//write 1 into the stencil buffer for each of the pixel that belong to the quad object
			Ref 1
			
		//comparison between 1 and the value in the stencil buffer
		//always writes 1 into the stencil buffer because this is a hole
			Comp always
			
		//do 1 draw call and replace anything that's in the frame buffer with this pixel pass => draw a hole
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
