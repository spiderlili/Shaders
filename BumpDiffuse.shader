Shader "Custom/BumpDiffuse" 
{
    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {}
        _bumpSlider ("Bump Amount", Range(0,10)) = 1 //when set to 1 the vector will nor affect normals
        _brightnessSlider ("Brightness", Range(0,10)) = 1
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myDiffuse; //declare diffuse texture
        sampler2D _myBump;
        half _bumpSlider; //better performance for multiplier with limited precision and range to affect the normals
        half _brightnessSlider;
        
        struct Input {
            float2 uv_myDiffuse; //UV input from diffuse texture
            float2 uv_myBump; //UV input from bump map
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb; //set albedo to diffuse texture's rgb according to the UVs
            
            //can't put bump image straight into the normals
            //run over all the pixel values and convert them to normal vertex values(RGB => XYZ)
            //multiply pixel values by slider value to turn the brightness over the entire model up and down
            
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * _brightnessSlider; 
            
            //multiply normals by a vector(xyz)
            o.Normal *= float3(_bumpSlider,_bumpSlider,1); 
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
  
