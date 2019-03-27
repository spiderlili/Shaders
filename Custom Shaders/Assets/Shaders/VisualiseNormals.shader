Shader "Custom/VisualiseNormals"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
		_NormalX("NormalX", Range(-10,10)) = 1
		_NormalY("NormalY", Range(-10,10)) = 1
		_NormalZ("NormalZ", Range(-10,10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
		half _NormalX;
		half _NormalY;
		half _NormalZ;
		struct Input{
			float2 uv_Diffuse;
		};

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = 1;
            // Metallic and smoothness come from slider variables
            o.Normal = float3(_NormalX, _NormalY, _NormalZ);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
