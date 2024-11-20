#pragma header // written by forgettablePyromaniac

vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;

uniform float time;
uniform float amplitude = 0.005;   // intensity
uniform float frequency = 10.0;    // speed

#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

void mainImage() {
    // Apply squiggle effect using sine functions
    float wiggleX = sin(uv.y * frequency + time) * amplitude;
    float wiggleY = cos(uv.x * frequency + time) * amplitude;

    // Offset UV coordinates to achieve the squiggle effect
    vec2 animatedUV = uv + vec2(wiggleX, wiggleY);

    // Sample texture with modified UV coordinates
    vec4 color = texture(iChannel0, animatedUV);

    fragColor = color;
}