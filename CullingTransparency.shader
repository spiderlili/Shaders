//useful for leaves, trees and particles when back face culling is not needed

Shader "Custom/CullingTransparency"{
  Properties{
    _MainTex ("Texture", 2D) = "black" {}
  }
  SubShader{
    Tags{"Queue" = "Transparent" }
    Blend ScrAlpha OneMinusSrcAlpha  // Traditional transparency: source alpha & 1 - source alpha
    Cull Off //turn culling off completely so the back face of the leave quad is visible
    Pass{
      SetTexture [_MainTex] {combine texture}
    }
  }
}
