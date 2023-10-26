
float calculatePolygon(float2 UV, float Sides, float Size)
{
    float pi = 3.14159265359;
    float aSize = Size * cos(pi / Sides);
    float2 uv = (UV * 2 - 1) / float2(aSize, aSize);
    uv.y *= -1;
    float pCoord = atan2(uv.x, uv.y);
    float r = 2 * pi / Sides;
    float distance = cos(floor(0.5 + pCoord / r) * r - pCoord) * length(uv);

    #if defined(SHADER_STAGE_RAY_TRACING)
        return saturate((1.0 - distance) * 1e7);
    #else
        return saturate((1 - distance) / fwidth(distance));
    #endif
}

float segment(float2 p, float2 a, float2 b, float t) {
    float2 ab = b - a, ap = p - a;
    //Out = A < B ? 1 : 0;
    float ln = length(ap - ab * clamp(dot(ab, ap) / dot(ab, ab), 0.0, 1.0)) > t ? 1 : 0;
    return 1 - ln;
}

float polygonLine(float2 UV, float Sides, float Size, float Thickness){
    float polygonExpand = calculatePolygon(UV, Sides, Size + Thickness / 2);
    float polygonDilate = calculatePolygon(UV, Sides, Size - Thickness / 2);
    return polygonExpand - polygonDilate;
}

void calculate_Polygon_float(float2 UV, float Sides, float Size, float OuterThickness, float InnerThickness, float Count, float4 LineColor, float4 BackgroundColor, out float4 Out)
{
    float result = 0;
    float sizeStep = Size/Count;
    
    for(int i = 1; i <= Count; i++){
        float polygon = polygonLine(UV, Sides, i * sizeStep, InnerThickness);
        result += polygon;
    }
    float outerPolygon = polygonLine(UV, Sides, Size, OuterThickness);
    result = saturate(result + outerPolygon);
    float neglectedArea = calculatePolygon(UV, Sides, Size);
    float invertedResult = 1 - saturate(result);
    float4 background = BackgroundColor * invertedResult * neglectedArea;
    
    float4 foreground = result * LineColor;
    Out = background + foreground;
}
void draw_Custom_Polygon_float(float2 UV, float Sides, float Size, float Count, float Thickness, UnityTexture2D Values, UnitySamplerState SS, out float4 Out)
{   
    float pi = 3.14159265359;
    float result = 0;
    float2 uv = (UV * 2 - 1) / float2(Size, Size);
    
    float values[100];
    values[0] = SAMPLE_TEXTURE2D(Values, SS, float2(0,0.5)).x;
    for(int i = 1; i < Sides; i++){
        if(i < 100){
            values[i] = SAMPLE_TEXTURE2D(Values, SS, float2((i + 0.5)/Sides,0.5)).x;
        }      
    }

    float angleIncrement = (2.0 * pi) / Sides;
    float angleOffset = (Sides - 2) * pi/Sides / 2;
    float firstXPos = values[0] * cos(-angleOffset);
    float firstYPos = values[0] * sin(-angleOffset);
    float2 firstPosition = float2(firstXPos,firstYPos);
    float2 previousPosition = float2(firstXPos,firstYPos);
    for(int j = 1; j < Sides; j++){
        float xPos = values[j] * cos(j * angleIncrement - angleOffset);
        float yPos = values[j] * sin(j * angleIncrement - angleOffset);
        result += segment(uv, float2(xPos, yPos), previousPosition, Thickness);
        previousPosition = float2(xPos, yPos);
        if(j == Sides - 1){
            result += segment(uv, float2(xPos, yPos), firstPosition, Thickness);
        }
    }
    
    Out = saturate(result);
}
