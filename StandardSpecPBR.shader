//specular lighting is controllable and can be blended with the albedo colour

Shader "Custom/StandardSpecPBR" {
Properties{
		_Color("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {} //used for smoothness
        _SpecColor("Specular", Color) = (1,1,1,1) //
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf StandardSpecular //specular lighting model setup 

        sampler2D _MetallicTex;
        fixed4 _Color;

		struct Input {
			float2 uv_MetallicTex;
		};

		void surf(Input IN, inout SurfaceOutputStandardSpecular o) { //change output structure to match lighting model
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r;
            o.Specular = _SpecColor.rgb; //lose metallic value and use specular instead
		}
		ENDCG
	}
	FallBack "Diffuse"

}
