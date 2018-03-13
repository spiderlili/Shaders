//spread the ramp texture across the model based on the direction of the light and normal.
Shader "Custom/ToonRamp" {
	Properties 
	{ 
		_Color  ("Color", Color) = (1,1,1,1)
		_RampTex ("Ramp Texture", 2D) = "white"{}
	}
	
	SubShader 
	{
		CGPROGRAM
		#pragma surface surf ToonRamp

		float4 _Color;
		sampler2D _RampTex;
		
		float4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
		//brightest where the normal of the surface and the light direction is coming from
			float diff = dot (s.Normal, lightDir); //diffuse lighting set to the dot product
			
		//used as the uv value for pulling out the textured components in the ramp texture
		//when there's a very bright spot with a normal and a light aligning with each other, dot product = 1
			float h = diff * 0.5 + 0.5;
			float2 rh = h;
			
		//1,1 as a uv coordinate is going to be in the white end of the texture	
			float3 ramp = tex2D(_RampTex, rh).rgb; //pluck out a white value
			
		//when the dot product = 0: end up at the dark end of the ramp texture
			float4 c;
		
		//diffuse colour x light colour x ramp
			c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			c.a = s.Alpha;
			return c;
		}

		struct Input 
		{
			float2 uv_MainTex;
		};

//put albedo colour onto the model
		void surf (Input IN, inout SurfaceOutput o) 
		{			
			o.Albedo = _Color.rgb;
		}
		
		ENDCG
	} 
	
	FallBack "Diffuse"

}
