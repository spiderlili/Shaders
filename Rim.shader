//lighting around the edges of the model respective to the view location
 Shader "Custom/Rim" {
    Properties {
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0) //teal blue
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0  //slider to adjust how much rim there is
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float3 viewDir; //tell where the model's edges are 
      };

      float4 _RimColor;
      float _RimPower;
      void surf (Input IN, inout SurfaceOutput o) {
      
      //dot product value using the normalised(-1 to 1) view direction and normalised normal
      //reverse it with 1.0 -: rather than having the brightest part to be on viewDir, put the colour effect on the edges 
      //any value facing directly towards the viewer will be 1-1=0 => black
      //saturate reduce dot product to a value between 0 and 1 as having a -1 isn't doing anything
      
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));  
          
          //put rim(strength of colour) into the emission channel after multiplying it by the rim colour
          //add power function on to the dot product to push out the rim colour to the edge
          o.Emission = _RimColor.rgb * pow (rim, _RimPower);
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }
