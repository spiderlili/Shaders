Shader "Custom/AlwaysGreenTexture"
//takes a texture to use as the albedo colour, but no matter what always turns up the green channel to full. 
{
    Properties
    {
        _Color ("Color", Color) = (0,1,0,0)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
		_ColorMultiplier ("ColorMultiplier", Range(0,1)) = 0.5
		_Cubemap ("Cubemap", CUBE) = ""{}
		_SkyboxIntensity("SkyboxIntensity", Range(0,1)) = 0.5
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

        sampler2D _MainTex;
		samplerCUBE _Cubemap;
        struct Input
        {
            float2 uv_MainTex;
			float3 worldRefl;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
		half _ColorMultiplier;
		half _SkyboxIntensity;
		
        // Add instancing support for this shader. need to check 'Enable Instancing' on materials that use the shader.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = (tex2D(_MainTex, IN.uv_MainTex)*_ColorMultiplier) * _Color;
            o.Albedo = c.rgb;
			o.Albedo.g = 1; //always turns the green channel to full
			o.Emission = (texCUBE(_Cubemap, IN.worldRefl)*_SkyboxIntensity).rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
