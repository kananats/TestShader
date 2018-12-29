Shader "Custom/BasicShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" { }
        _Color("Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }
    
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
        
            CGPROGRAM
            #pragma vertex vert 
            #pragma fragment frag 
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {   
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert(appdata input)
            {
                v2f output; 
                output.vertex = UnityObjectToClipPos(input.vertex);
                output.uv = input.uv;
                return output;
            }
            
            sampler2D _MainTex;
            float4 _Color;
            
            float4 frag(v2f input) : SV_Target 
            {   
                float4 color = tex2D(_MainTex, input.uv);
                return lerp(float4(0,0,0,1), color, _Color);
            }
            
            ENDCG
        }
    }
}
