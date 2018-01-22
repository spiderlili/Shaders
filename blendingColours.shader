//blending image: fully opaque parts and fully transparent parts

Shader "Custom/blendingColours" {
    Properties {
    //black = fully transparent, white = fully opaque
      _MainTex ("Texture", 2D) = "black" {}
    }
    SubShader {
      Tags{"Queue" = "Transparent"}
      //multiplies one colour at full strength by the incoming colour full strength - a lot brighter than normal transparency
      //then it multiplies what's already in the framebuffer by the incoming colour and add them together
      //Blend One One
      
      //traditional blend: multiply the incoming value by the source image alpha
      //the colour already in the frame buffer will be multiplied by 1 - its current alpha => switching alphas around
      Blend ScrAlpha OneMinusScrAlpha
      
      //soft additive blend: multiply the incoming colour by the destination colour in the frame buffer
      //the framebuffer colour will be multiplied by 0 
      //the current colour is being discarded because multiplied with incoming colour
      //Blend DstColor Zero
//add another pass between the tag and the Cg program to make it occur first

      Pass {
      //property coming in - a texture initially set to black 
      //replacing the pixels in the frame buffer with content in texture
            SetTexture [_MainTex] { combine texture }
      }
    }
 }
