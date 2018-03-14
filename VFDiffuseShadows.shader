//include shadows with shadow casting and shadow receiving with the vertex fragment diffuse shader

 Shader "Custom/VFDiffuseShadows"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
    //build in a shadow pass to accept shadows
    //do another draw call to create a shadow after the first pass
        Pass
        {
    //cast a shadow onto the objects that are around it based on where the light is projecting that shadow
            Tags {"LightMode"="ForwardBase"}
        
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            //tell the compiler to accept shadows, don't include lightmaps to take over the shadow processing
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            #include "UnityCG.cginc" 
            #include "UnityLightingCommon.cginc"
            
            //include essential shadow functions
            #include "Lighting.cginc" 
            #include "AutoLight.cginc"

            
            struct appdata {
            //need the position and the normals to cast a shadow output
            //data is being transformed into the shadow cast via vertex shader code
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                fixed4 diff : COLOR0; 
                
                //vertex => pos for TRANSFER SHADOW
                float4 pos : SV_POSITION;
                
                //calculate the coords for the shadows on object
                SHADOW_COORDS(1)
            };

            v2f vert (appdata v)
            {
                v2f o; //normal output version of v2f
                //vertex coming from data
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = nl * _LightColor0;
                
                //pass in that structure for unity to fill it up with the details of what the shadow is going to look like
                //create the shadow data
                //takes the v2f structure and look for pos
                //transfer shaders from world space into that structure the fragment can then use
                 TRANSFER_SHADOW(o)

                return o;
            }
            
            sampler2D _MainTex;
            
            //spitting out the shadow data as far as the pixel colour is concerned(i)
            //calculate the shadow pixels which are going to be dark spots
            //use the shadow and multiply that by adding diffuse light to put it into the colour
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                 //casting the fragment for this shadow in the pass
                 //shadow is calculated with SHADOW_ATTENUATION given the v2f structure passed in
                fixed shadow = SHADOW_ATTENUATION(i);
                
                //multiply the diff value and multiply that with the rgb from the texture
                //if the shadow is around 0 => a very dark patch on the object
                col.rgb *= i.diff * shadow;
                return col;
            }
            ENDCG
        }
        Pass
        {
        //only the second pass draws the shadow
            Tags {"LightMode"="ShadowCaster"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"
            
            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f { 
                V2F_SHADOW_CASTER;
            };

            v2f vert(appdata v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }

        
    }
}
