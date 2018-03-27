//put in dynamic environmental reflection with the bump map
//take a vector out towards a cube map and then take those points on the cube map and match them back onto the model as the texture
//light will react differently in cracks and smooth surfaces
//use Unity HDMI Pack
//set import normal settings to calculate and smooth angle to 0 => avoid Unity's interpolational smoothing out of the normals around the model

Shader "Custom/BumpedEnvironment" 
{
//input properties
    Properties {
        _mapDiffuse ("Diffuse Texture", 2D) = "white" {}
        _mapBump ("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,10)) = 1
        _myBright ("Brightness", Range(0,10)) = 1
        _myCube ("Cube Map", CUBE) = "white" {}
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _mapDiffuse;
        sampler2D _mapBump;
        half _mySlider;
        half _myBright;
        samplerCUBE _myCube;

//input structure that takes the UV values for the diffuse and the bump using the same set of UV values
        struct Input {
            float2 uv_mapDiffuse;
            float2 uv_mapBump;
            
            //can get worldRefl vector out of data
            //vectors can be mixed together to give a variety of different techniques
            //need 3D data when working with cube maps
            //modify the normals but not affect the world reflection data to prevent errors - they are linked together
            float3 worldRefl; INTERNAL_DATA //use a different data set to separate worldRefl and normal => edit the normals and use the worldRefl data
        };
        
       //surface function to set the albedo and the normals, build the brightness and the slider 
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_mapDiffuse, IN.uv_mapDiffuse).rgb;
            o.Normal = UnpackNormal(tex2D(_mapBump, IN.uv_mapBump)) * _myBright;
            o.Normal *= float3(_mySlider,_mySlider,1);
            //put the cube map onto the object and set emission using the input from the input structure with worldReflection values
            //WorldReflectionVector is an internal function which calculates a vector from the input structure data
            //given the normals of the model itself - use these values with the cube map to set the colour of the emission on the surface
            o.Emission = texCUBE (_myCube, WorldReflectionVector (IN, o.Normal)).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
