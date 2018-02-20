Shader "Custom/StencilWall" {
	Properties {
		_MainTex ("Diffuse", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" }	 //draw after the geometry for the hole	
		//requires a stencil
		//don't draw if you do find a 1 in the stencil buffer for this pixel
		//if not equal to 1, draw over it

		//turn off the pixel colour being drawn into the frame buffer for the stencil shader to work
		ColorMask 0
		
		//turn off the writing to the depth buffer because the hole doesn't have any depth 
		ZWrite off
		Stencil
		{
			Ref 1 //write 1 into the stencil buffer - where the wall has drawn
			
			//keep pixels that belong to the wall if stencil ref 1 does not equal to what's already in the stencil buffer
			Comp notequal 
			Pass keep
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
