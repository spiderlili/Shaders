Shader "Custom/IllusionStencilWindow"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_SRef("Stencil Ref", Float) = 1
		
		//put in float values - comparison operator
		[Enum(UnityEngine.Rendering.CompareFunction)]	_SComp("Stencil Comp", Float)	= 8
		
		//stencil operator
		[Enum(UnityEngine.Rendering.StencilOp)]	_SOp("Stencil Op", Float)		= 2
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry-1" }
	
		ZWrite off
		
		//turn off any colouring being written to the frame buffer
		ColorMask 0

		Stencil
		{
			Ref[_SRef]
			Comp[_SComp]	
			Pass[_SOp]	
		}

		CGPROGRAM
			#pragma surface surf Lambert
        
        	sampler2D _myDiffuse;

        	struct Input {
            	float2 uv_myDiffuse;
        	};
        
	//write a diffuse texture to the albedo channel
        	void surf (Input IN, inout SurfaceOutput o) {
            	o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
        	}
		ENDCG

	}
}

