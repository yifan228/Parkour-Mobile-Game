Shader "Hidden/wave"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _A("Arange",float) =0
        _Omega("Omega",float) = 0
        _k("k",float) = 0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
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
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float _A;
            float _k;
            float _Omega;
            v2f vert (appdata v)
            {
                float timer = _Time.y;
                v.vertex.y = _A*sin(_k*v.vertex.x+timer*_Omega);

                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
               
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
