varying vec2 v_vTexcoord;

uniform vec2 u_center;
uniform float u_radius;
uniform float u_fade_radius;

void main() {
    vec2 pos = gl_FragCoord.xy;
    float dist = distance(pos, u_center);
    
    float alpha = 1.0;
    
    if (dist < u_radius) {
        alpha = 0.0;
    } else if (dist < u_fade_radius) {
        float t = (dist - u_radius) / (u_fade_radius - u_radius);
        alpha = t * t * (3.0 - 2.0 * t);
    }
    
    gl_FragColor = vec4(0.0, 0.0, 0.0, alpha);
}