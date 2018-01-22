Shader "Custom/BasicBlinn" {
Properties{
		_Colour("Colour", Color) = (1,1,1,1)
		
		//colour of the light in the specular reflection. Defined in Unity include files
		_SpecColor("Colour", Color) = (1,1,1,1)
		
		//size of the specular coverage: higher values makes the highlight tighter with less coverage(shiny)
		//defines how compact / tightly packed / diffuses out of the surface 
		_Spec("Specular", Range(0,1)) = 0.5
		
		//power to apply to the specular for changing the strength in the defined highlight area
		_Gloss("Gloss", Range(0,1)) = 0.5
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}


		CGPROGRAM
		#pragma surface surf BlinnPhong

		float4 _Colour;
		half _Spec;
		fixed _Gloss;

		struct Input {
			float2 uv_MainTex;
		};

//apply specular and gloss to surface output
		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = _Colour.rgb;
			o.Specular = _Spec;
			o.Gloss = _Gloss;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
