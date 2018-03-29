Shader "Custom/RedSilhouetteVF"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
    Pass {
    CGPROGRAM
    #pragma vertex vert
    #pragma fragment frag

    struct vertInput{
      float4 pos : POSITION;
    };

    struct vertOutput{
      float4 pos : SV_POSITION;
    };

//The vert function converts the vertices from their native 3D space to their final 2D position on the screen.
//UNITY_MATRIX_MVP hides the maths behind it.

  vertOutput vert(vertInput input){
    vertOutput o;
    o.pos = mul(UNITY_MATRIX_MVP, input.pos);
    return o;
  }

//the return of the frag function gives a red colour to every pixel.
  half4 frag(vertOutput output) : COLOR{
    return half4(1.0, 0.0, 0.0, 1.0);
  }
  ENDCG
  }
}
}
}
