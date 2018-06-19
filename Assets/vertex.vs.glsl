#version 410

layout(location = 0) in vec3 iv3vertex;
layout(location = 1) in vec2 iv2tex_coord;
layout(location = 2) in vec3 iv3normal;

uniform mat4 um4mv;
uniform mat4 um4p;
uniform vec3 Light_direction = vec3(10.0,10.0,10.0);

uniform float x_add;
uniform float y_add;
uniform float z_add;
uniform int isCar;
out VertexData
{
    vec3 N; // eye space normal
    vec3 L; // eye space light vector
    vec3 V;
    vec3 H; // eye space halfway vector
    vec2 texcoord;
} vertexData;

void main()
{
    vec4 P = um4mv * vec4(iv3vertex,1.0);
    if(isCar==1)
	{
	    gl_Position = um4p * um4mv * vec4(iv3vertex[0]+x_add,iv3vertex[1]+y_add,iv3vertex[2]+z_add, 1.0);
	}
	else
	{
	    gl_Position = um4p * um4mv * vec4(iv3vertex,1.0);
	}
    vertexData.texcoord = iv2tex_coord;
    
    vertexData.V = normalize(-P.xyz);
    vertexData.N = normalize(mat3(um4mv) * iv3normal);
    vertexData.L = normalize(Light_direction - P.xyz);
    vertexData.H = normalize(vertexData.V + vertexData.L);
	
}
