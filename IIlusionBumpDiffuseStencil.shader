//use stencils to create an optical illusion - different content depending on viewing angle
//using stencils to restrict what can be seen from each side
//put the stencil buffer on the sides of the wall to see the effect - must turn off receive shadows 

Shader "Custom/IIlusionBumpDiffuseStencil" 
{
    Properties {
        _Color("Color", Color) = (1,1,1,1) //invisible
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,10)) = 1

        _SRef("Stencil Ref", Float) = 1 //stencil reference
        [Enum(UnityEngine.Rendering.CompareFunction)]  _SComp("Stencil Comp", Float)   = 8
        [Enum(UnityEngine.Rendering.StencilOp)]        _SOp("Stencil Op", Float)      = 2
    }
    SubShader {

      Stencil
        {
            Ref[_SRef]
            Comp[_SComp] 
            Pass[_SOp] 
        }  
      
      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myDiffuse;
        sampler2D _myBump;
        half _mySlider;
        float4 _Color;

        struct Input {
            float2 uv_myDiffuse;
            float2 uv_myBump;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb * _Color.rgb;
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
            
            //slider to modify the impact of the normals
            o.Normal *= float3(_mySlider,_mySlider,1);
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
