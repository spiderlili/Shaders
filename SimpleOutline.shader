//create the outline silhouette first then the 3D model on top => 2 passes

Shader "Custom/SimpleOutline" {
	
	 Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _OutlineColor ("Outline Color", Color) = (0,0,0,1)
      //set the outliner width with a slider
	  _Outline ("Outline Width", Range (.002, 0.1)) = .005
    }
    
   SubShader {
	  Tags { "Queue"="Transparent" }
   	  ZWrite off
      CGPROGRAM
      //simple lambert shader with a texture
	      #pragma surface surf Lambert vertex:vert
	      struct Input {
	          float2 uv_MainTex;
	      };
	      
	      //draw the geometry again in red
	      float _Outline;
	      float4 _OutlineColor;
	      void vert (inout appdata_full v) {
	          v.vertex.xyz += v.normal * _Outline;
	      }
	      sampler2D _MainTex;
	      void surf (Input IN, inout SurfaceOutput o) 
	      {
	          o.Emission = _OutlineColor.rgb;
	      }
      ENDCG

      ZWrite on

      CGPROGRAM
	      #pragma surface surf Lambert
	      struct Input {
	          float2 uv_MainTex;
	      };

	      sampler2D _MainTex;
	      void surf (Input IN, inout SurfaceOutput o) {
	          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
	      }
      ENDCG

    } 
    Fallback "Diffuse"
}

