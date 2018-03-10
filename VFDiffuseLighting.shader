//add simple lighting calculations into fragmet vertex shader

Shader "Custom/VFDiffuseLighting"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        { 
	//set up for forward rendering so lights are calculated on a per model basis rather than at the end(as in deferred lighting)
            Tags {"LightMode"="ForwardBase"}
        
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc" 
	    
	    //include definitions for the lighting system - needed when using properties from the lights 
            #include "UnityLightingCommon.cginc" 

			struct appdata {
			    float4 vertex : POSITION;
			    
			    //normal is the most important part in this lighting model
			    float3 normal : NORMAL;
			    
			    //texture coordinates / UVs
			    float4 texcoord : TEXCOORD0;
			};

            struct v2f
            {
                float2 uv : TEXCOORD0;
		
		//include diffuse values - the colour produced for the lighting in calculation
                fixed4 diff : COLOR0; 
                float4 vertex : SV_POSITION;
            };

//convert vertices, grab hold of the UVs 
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
		
		//calculate world normals with the vertex normal
		//convert unity object local normals on the mesh to world normal coordinates 
		//make sure they are in the same coordinate space to compare the normal against the world position of the light
		
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
		
		//work out the dot product between the world normal on the mesh and the world space light position
		//the world space light position comes from the lighting common file - holds onto the light position in the scene
		//convert the number from between -1 and 1 to between 0 and 1

                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
		
		//take a calculated normal and multiply by the light colour - in the include file at the top which holds the light colour in the scene
		//calculate the diffuse colour to use on the surface of an object, return it in structure with all other values which goes to the frag
                o.diff = nl * _LightColor0;
                return o;
            }
            
            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
	    //getting colour from the texture
                fixed4 col = tex2D(_MainTex, i.uv);
		//before displaying the colour, multiply it by the diffuse colour of the light
		//render that pixel out considering the colour from the texture and the colour from the light
                col *= i.diff;
                return col;
            }
            ENDCG
        }
    }
}
