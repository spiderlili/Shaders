//colour stripe effect surface shader: when moving the stripes will remain in the same world position

 Shader "Custom/StripesSurface" {
    Properties {
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
      _RimScale("Rim Scale", Range(10, 50)) = 10
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float3 viewDir;
          float3 worldPos;
      };

      float4 _RimColor;
      float _RimPower;
      float _RimScale;

//fake lighting effect: colour vertex differently depending on world position y
//colour all objects of a certain height in the world

      void surf (Input IN, inout SurfaceOutput o) {
          half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
          
          //if true: green, if false: red
          //divide the world position by 2: with the odd and even set of numbers, alternate the pattern on the 3D model
          //remainder set to 0.4(not 0.5) to prevent floating value inaccuracies
          //multiply worldPos by _RimScale to make the value bigger: otherwise won't see the effect if obj is in a small space
          
          o.Emission = frac(IN.worldPos.y*_RimScale * 0.5) > 0.4 ? 
                          float3(0,1,0)*rim: float3(1,0,0)*rim;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }
