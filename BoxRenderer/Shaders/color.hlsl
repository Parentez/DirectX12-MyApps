
cbuffer cbPerObject : register(b0)
{
	float4x4 gWorldViewProj; 
    float4 gTime;
};

struct VertexIn
{
	float3 PosL  : POSITION;
    float4 Color : COLOR;
};

struct VertexOut
{
	float4 PosH  : SV_POSITION;
    float4 Color : COLOR;
};

float EaseInOutSine(float t)
{
    return 0.5f * (1.0f - cos(4.14159f * t));
}



VertexOut VS(VertexIn vin)
{
	VertexOut vout;
	
	// Transform to homogeneous clip space.
	vout.PosH = mul(float4(vin.PosL, 1.0f), gWorldViewProj);
	
	// Just pass vertex color into the pixel shader.
    vout.Color = vin.Color;
    
    return vout;
}

float4 PS(VertexOut pin) : SV_Target
{
    float t = EaseInOutSine(gTime * 0.5f);
    
    float4 targetColor = float4(1, 1, 1, 1);
    
    return lerp(pin.Color, targetColor, t);
}