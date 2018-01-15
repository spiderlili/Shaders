//allows for different shininess values on different parts of the model with the metallic map
//emissive slider makes the model glow in the same areas that are grey and white in the metallic gloss map

Shader "Custom/StandardPBR" {
Properties{
		_Color("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {} //metallic texture 
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0 //metallic range value
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf Standard //standard lighting model changes output structure to SurfaceOutputStandard

        sampler2D _MetallicTex;
        half _Metallic;
        fixed4 _Color;

		struct Input {
			float2 uv_MetallicTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o) { //access smoothness and metallic values for manipulation
            o.Albedo = _Color.rgb;
	    
	    //smoothness will change over the entire surface based on texture appearance and colour
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r; //get the red channel of the texture
	    
	    //set metallicness to range slider 
            o.Metallic = _Metallic;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
