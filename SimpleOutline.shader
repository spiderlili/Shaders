//create the outline silhouette first then the 3D model on top => 2 passes
//must change the render queue to transparent to get the outline to draw on top of everything
//otherwise the background can overtake it => get lost in the depth test
//simple outline solution if using the transparent queue => potential issues with other transparent objects

Shader "Custom/SimpleOutline" {
	
	 Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _OutlineColor ("Outline Color", Color) = (0,0,0,1)
      
      //set the outliner width with a slider
	  _Outline ("Outline Width", Range (.002, 0.1)) = .005
    }
    
   SubShader {
	  Tags { "Queue"="Transparent" }
   	  ZWrite off //turn off ZBuffer writing to make sure it's drawn behind the other pass

//draw the geometry again in red without the texture
//2 passes without the pass tag because they are vertex and surface 

      CGPROGRAM
      //simple lambert shader with a texture
	      #pragma surface surf Lambert vertex:vert
	      struct Input {
	          float2 uv_MainTex;
	      };
	      
	      float _Outline;
	      float4 _OutlineColor;
	      
	      //vertex shader - extrude the mesh out by the amount of outline, push the vertexes along the normal
	      //use the outline colour in the emission channel to make it red
	      
	      void vert (inout appdata_full v) {
	          v.vertex.xyz += v.normal * _Outline;
	      }
	      sampler2D _MainTex;
	      void surf (Input IN, inout SurfaceOutput o) 
	      {
	          o.Emission = _OutlineColor.rgb;
	      }
      ENDCG

      ZWrite on //turn on ZBuffer writing 

      CGPROGRAM
	      #pragma surface surf Lambert
	      struct Input {
	          float2 uv_MainTex;
	      };

//standard default shader

	      sampler2D _MainTex;
	      void surf (Input IN, inout SurfaceOutput o) {
	          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
	      }
      ENDCG

    } 
    Fallback "Diffuse"
}

