/*void main(void) {
    
    vec2 uv = v_tex_coord;
    
    uv.y += (cos((uv.y + (u_time * 0.04)) * 45.0) * 0.0019) +
    (cos((uv.y + (u_time * 0.1)) * 10.0) * 0.002);
    
    uv.x += (sin((uv.y + (u_time * 0.07)) * 15.0) * 0.0029) +
    (sin((uv.y + (u_time * 0.1)) * 15.0) * 0.002);
    
    gl_FragColor = texture2D(u_texture, uv);
}*/

void main(void)
{
    float time = (u_time+29.) * 60.0;
    
    float s = 0.0, v = 0.0;
    vec2 uv = (gl_FragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    float t = time*0.005;
    uv.x = (uv.x * iResolution.x / iResolution.y) + sin(t) * 0.5;
    float si = sin(t + 2.17); // ...Squiffy rotation matrix!
    float co = cos(t);
    uv *= mat2(co, si, -si, co);
    vec3 col = vec3(0.0);
    vec3 init = vec3(0.25, 0.25 + sin(time * 0.001) * 0.4, floor(time) * 0.0008);
    for (int r = 0; r < 100; r++)
    {
        vec3 p = init + s * vec3(uv, 0.143);
        p.z = mod(p.z, 2.0);
        for (int i=0; i < 10; i++)    p = abs(p * 2.04) / dot(p, p) - 0.75;
        v += length(p * p) * smoothstep(0.0, 0.5, 0.9 - s) * .002;
        // Get a purple and cyan effect by biasing the RGB in different ways...
        col +=  vec3(v * 0.8, 1.1 - s * 0.5, .7 + v * 0.5) * v * 0.013;
        s += .01;
    }
    gl_FragColor = vec4(col, 1.0);
}
