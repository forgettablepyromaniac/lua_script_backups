#pragma header // written by forgettablePyromaniac

vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;

// Uniforms for brightness, effects, and RGB amounts
uniform float uBrightness;         //  brightness (-1 to 1, negative for darkness)
uniform float uBW;                 // b&w effect (0 to 1)
uniform float uSepia;              // sepia effect (0 to 1)
uniform float uR;                  // red tint (0 to 1)
uniform float uG;                  // green tint (0 to 1)
uniform float uB;                  // blue tint (0 to 1)

#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

vec4 adjustBrightness(vec4 color, float brightness) {
    // Keep alpha channel
    float alpha = color.a;

    // Adjust brightness only if alpha is greater than 0
    if (alpha > 0.5) {
        color.rgb += brightness;
        color.rgb = clamp(color.rgb, 0.0, 1.0);
    }
    color.a = alpha;

    return color;
}

vec4 toBlackAndWhite(vec4 color, float amount) {
    float avg = (color.r + color.g + color.b) / 3.0;
    return mix(color, vec4(avg, avg, avg, color.a), amount);
}

vec4 toSepia(vec4 color, float amount) {
    float r = (color.r * 0.393) + (color.g * 0.769) + (color.b * 0.189);
    float g = (color.r * 0.349) + (color.g * 0.686) + (color.b * 0.168);
    float b = (color.r * 0.272) + (color.g * 0.534) + (color.b * 0.131);
    vec4 sepiaColor = vec4(r, g, b, color.a);
    return mix(color, sepiaColor, amount);
}

vec4 applyRGBTint(vec4 color, float redAmount, float greenAmount, float blueAmount) {
    // Blend original color with RGB tint based on the specified amounts
    return vec4(
        mix(color.r, color.r * redAmount, redAmount),
        mix(color.g, color.g * greenAmount, greenAmount),
        mix(color.b, color.b * blueAmount, blueAmount),
        color.a  // Preserve alpha channel
    );
}

void mainImage() {
    vec4 color = texture(iChannel0, uv);
    color = adjustBrightness(color, uBrightness);
    color = toBlackAndWhite(color, uBW);
    color = toSepia(color, uSepia);
    color = applyRGBTint(color, uR, uG, uB);
    fragColor = color;
}
