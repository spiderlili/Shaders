Shader "Custom/BasicLambert" {
Properties{
		_Colour("Colour", Color) = (1,1,1,1)
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}


		CGPROGRAM
//custom lambert lighting model doesn't need the viewer - just the surface normal and light source direction
		#pragma surface surf BasicLambert 
		
  //attenuation for light intensity - lose intensity as light travels through the air/water
        half4 LightingBasicLambert (SurfaceOutput s, half3 lightDir, half atten) {
	
	//1 if the source is directly over the surface(brightest light), 
              half NdotL = dot (s.Normal, lightDir); //dot product between surface normal and light direction
              half4 c;
	      //normal light is multiplied against the light colour & the surface albedo - light affects the surface colour
              c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
              c.a = s.Alpha;
              return c;
          }

		float4 _Colour;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = _Colour.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
