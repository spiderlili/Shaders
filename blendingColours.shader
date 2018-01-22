//blending image: fully opaque parts and fully transparent parts

Shader "Custom/blendingColours" {
    Properties {
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0 
    }
    SubShader {
      Tags{"Queue" = "Transparent"}

//add another pass between the tag and the Cg program to make it occur first
      Pass {
      //force it to write depth data about the model into the z buffer
        ZWrite On 
        ColorMask 0  
        
        //visualise whereabouts in the z buffer the depth data is being written for debugging - what's in the z buffer
        //ColorMask RGB 
      }

      //shader being passed through: when the second pass comes there will be z data for it to call on
      CGPROGRAM
      
      #pragma surface surf Lambert alpha:fade //turn the alpha ability on
      struct Input {
          float3 viewDir;
      };

      float4 _RimColor;
      float _RimPower;
      
      void surf (Input IN, inout SurfaceOutput o) {
      
      //reversed - the outside edges have 1 on them
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
          o.Emission = _RimColor.rgb * pow (rim, _RimPower) * 10;
          
          //manipulate the alpha channel using the power and the rim function
          o.Alpha = pow (rim, _RimPower);
      }
      ENDCG
      //end pass
    } 
    Fallback "Diffuse"
  }
