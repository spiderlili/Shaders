Shader "Custom/Plasma" {
    Properties {
      _Tint("Colour Tint", Color) = (1,1,1,1) 
      
      //change the flow rate
      _Speed("Speed", Range(1,100)) = 10
      
      //4 scale values each used for different part of the calculation
      _Scale1("Scale 1", Range(0.1,10)) = 2
      _Scale2("Scale 2", Range(0.1,10)) = 2
      _Scale3("Scale 3", Range(0.1,10)) = 2
      _Scale4("Scale 4", Range(0.1,10)) = 2
    }
    SubShader {
      
      CGPROGRAM
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_MainTex;
          float3 worldPos;
      };
      
      //Associated variable for each property
      float4 _Tint;
      float _Speed;
      float _Scale1;
      float _Scale2;
      float _Scale3;
      float _Scale4;
      
      //add different sinewaves and calculations to it to get different effects

      void surf (Input IN, inout SurfaceOutput o) {
      //PI for circular effect 
          const float PI = 3.14159265;
          //time value - unity defined time which is changing over time and its x value 
          float t = _Time.x * _Speed;
          
          //calculate vertical movement - c to hold colour
          //calculate the colour based on the sine wave for the world position x * scale1 + time
          float c = sin(IN.worldPos.x * _Scale1 + t);

          //calculate horizontal sine waves across the surface
          c += sin(IN.worldPos.z * _Scale2 + t);

          //calculate diagonal sine waves across the surface: update c value by adding another sin calculation
          c += sin(_Scale3*(IN.worldPos.x*sin(t/2.0) + IN.worldPos.z*cos(t/3))+t);

          //calculate circular movement
          float c1 = pow(IN.worldPos.x + 0.5 * sin(t/5),2);
          float c2 = pow(IN.worldPos.z + 0.5 * cos(t/3),2);
          c += sin(sqrt(_Scale4*(c1 + c2)+1+t));

          //push the calculated values back through the sin function
          //modify different albedo channels
          o.Albedo.r = sin(c/4.0*PI);
          o.Albedo.g = sin(c/4.0*PI + 2*PI/4);
          o.Albedo.b = sin(c/4.0*PI + 4*PI/4);
          o.Albedo *= _Tint;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }
