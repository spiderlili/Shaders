//modify the vertices of a mesh in one direction to create a moving wave pattern mathematically using a sine function 
// y = sin(x) returns the amplitude height y of a wave of time x

Shader "Custom/Waves" {
    Properties {
      _MainTex("Diffuse", 2D) = "white" {} //texture
      _Tint("Colour Tint", Color) = (1,1,1,1) //tint the waves
      _Freq("Frequency", Range(0,5)) = 3 //how close the waves peak together
      _Speed("Speed",Range(0,100)) = 10 //how fast the waves are going across the plane surface
      _Amp("Amplitude",Range(0,1)) = 0.5 //wave height
    }
    SubShader {
      CGPROGRAM
      //surface shader with a vertex shader inside
      #pragma surface surf Lambert vertex:vert 
      
      struct Input {
          float2 uv_MainTex; //uv textures for main texture
          float3 vertColor; //add tint based on vertices
      };
      
      float4 _Tint;
      float _Freq;
      float _Speed;
      float _Amp;

      struct appdata {
          float4 vertex: POSITION;
          float3 normal: NORMAL;
          float4 texcoord: TEXCOORD0;
          float4 texcoord1: TEXCOORD1;
          float4 texcoord2: TEXCOORD2;
      };
      
      void vert (inout appdata v, out Input o) {
          UNITY_INITIALIZE_OUTPUT(Input,o);
          
          //time is used across the time function to work out the height as the program runs
          //speed up time by multiplying time with speed
          float t = _Time * _Speed;
          
          //as time changes, the sin function gives back data going up and down
          //the height value to be given to the vertex to lift it up/push it down
          //the height is based on the sin function called on time + the vertex's x value => wave across the x direction
          //multiplied by the frequency: squish the waves up or spread the map before pushing the vertex values through into sin
          //multiplied by the amplitude to lift the whole thing up or down
      
          float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp +
                        sin(t*2 + v.vertex.x * _Freq*2) * _Amp;
                        
       //set the vertex's y value to the current y value + the waveHieght
       //use waveHieght as an offset from the existing position of the mesh
          v.vertex.y = v.vertex.y + waveHeight;
          
       //update the normals to reflect the changes made in the vertex to prevent weird shadows and projections   
          v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
          
       //set the vertex colour for output structure: have vertex colours based on the wave height, then use these values to help colour the waves
       //give changes in gradient of colouring over the wave 
       o.vertColor = waveHeight + 2;

      }

      sampler2D _MainTex;
      
      //the surface function is getting its main colour from the texture
      void surf (Input IN, inout SurfaceOutput o) {
          float4 c = tex2D(_MainTex, IN.uv_MainTex);
          
      //the albedo is being set as that texture colour multiplied by the vertex colour that's coming in - calculated in vertex shader     
          o.Albedo = c * IN.vertColor.rgb;
      }
      ENDCG

    } 
    Fallback "Diffuse"
  }
