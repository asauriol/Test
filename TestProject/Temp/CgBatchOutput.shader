Shader "Reflective/River Water" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
	_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
	_ChromaticDispersion ("_ChromaticDispersion", Range(0.0,4.0)) = 0.1
	_Refraction ("Refraction", Range (0.00, 100.0)) = 1.0
	_ReflToRefrExponent ("_ReflToRefrExponent", Range(0.00,4.00)) = 1.0
	_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
	_BumpReflectionStr ("_BumpReflectionStr", Range(0.00,1.00)) = 0.5
	_MainTex ("Base (RGB) RefStrGloss (A)", 2D) = "white" {}
	_ReflectionTex ("_ReflectionTex", CUBE) = "white" {}
	_BumpMap ("Normalmap", 2D) = "bump" {}
	//_Up ("_Up", Vector) = (0,1,0,1)
}

SubShader 
{	
	
	Tags { "RenderType"="Transparent" }
	LOD 400
	
	GrabPass 
	{ 
		
	}
	
	//Pass {

	Alphatest Greater 0 ZWrite Off ColorMask RGB
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
// Vertex combos: 3
//   opengl - ALU: 40 to 95
//   d3d9 - ALU: 41 to 98
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 64 ALU
PARAM c[25] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
MOV R0.y, R2.w;
DP3 R0.z, R1, c[7];
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[19];
DP4 R2.y, R0, c[18];
DP4 R2.x, R0, c[17];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[22];
DP4 R3.x, R1, c[20];
DP4 R3.y, R1, c[21];
MOV R1.xyz, vertex.attrib[14];
MAD R0.w, R0.x, R0.x, -R0.y;
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.w, c[23];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[7].xyz, R2, R3;
MUL R2.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[15];
MOV R0.w, c[0].y;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
MAD R4.xyz, R1, c[14].w, -vertex.position;
MOV R1, c[16];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
DP3 R1.y, R2, c[5];
DP3 result.texcoord[5].y, R2, R4;
DP3 result.texcoord[6].y, R2, R0;
DP4 R2.w, vertex.position, c[4];
DP3 R1.w, -R4, c[5];
DP3 R1.x, vertex.attrib[14], c[5];
DP3 R1.z, vertex.normal, c[5];
MUL result.texcoord[2], R1, c[14].w;
DP3 R1.y, R2, c[6];
DP3 R1.w, -R4, c[6];
DP3 R1.x, vertex.attrib[14], c[6];
DP3 R1.z, vertex.normal, c[6];
MUL result.texcoord[3], R1, c[14].w;
DP3 R1.y, R2, c[7];
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MUL R3.xyz, R2.xyww, c[0].x;
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R4, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[14].w;
MUL R1.y, R3, c[13].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[5].z, vertex.normal, R4;
DP3 result.texcoord[5].x, vertex.attrib[14], R4;
DP3 result.texcoord[6].z, vertex.normal, R0;
DP3 result.texcoord[6].x, vertex.attrib[14], R0;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 64 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 67 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c25, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
dp4 r2.z, r0, c19
dp4 r2.y, r0, c18
dp4 r2.x, r0, c17
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c22
dp4 r3.y, r1, c21
dp4 r3.x, r1, c20
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c23
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
add o8.xyz, r2, r3
mul r2.xyz, v1.w, r0
mov r0.w, c25.y
mov r0.xyz, c15
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r3.xyz, r1, c14.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
dp3 r0.y, r2, c4
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c14.w
dp3 r0.y, r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
dp3 r0.x, v1, c6
dp3 o6.y, r2, r3
dp3 o7.y, r2, r4
mul r2.xyz, r1.xyww, c25.x
dp3 r0.w, -r3, c6
dp3 r0.z, v2, c6
mul o5, r0, c14.w
mul r0.y, r2, c12.x
mov r0.x, r2
mad o2.xy, r2.z, c13.zwzw, r0
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp3 o7.z, v2, r4
dp3 o7.x, v1, r4
mov o0, r1
mov o2.zw, r1
mad o1.xy, v3, c24, c24.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_79;
  tmpvar_79 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_83;
  tmpvar_83.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_83.w = 1.0;
  mat3 tmpvar_91;
  tmpvar_91[0] = _Object2World[0].xyz;
  tmpvar_91[1] = _Object2World[1].xyz;
  tmpvar_91[2] = _Object2World[2].xyz;
  vec3 tmpvar_95;
  tmpvar_95 = (tmpvar_91 * -((((_World2Object * tmpvar_83).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_97;
  tmpvar_97 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_98;
  tmpvar_98[0].x = tmpvar_3.x;
  tmpvar_98[0].y = tmpvar_97.x;
  tmpvar_98[0].z = tmpvar_5.x;
  tmpvar_98[1].x = tmpvar_3.y;
  tmpvar_98[1].y = tmpvar_97.y;
  tmpvar_98[1].z = tmpvar_5.y;
  tmpvar_98[2].x = tmpvar_3.z;
  tmpvar_98[2].y = tmpvar_97.z;
  tmpvar_98[2].z = tmpvar_5.z;
  vec4 tmpvar_109;
  tmpvar_109.xyz = (tmpvar_98 * _Object2World[0].xyz).xyz;
  tmpvar_109.w = tmpvar_95.x;
  vec4 tmpvar_111;
  tmpvar_111.xyz = (tmpvar_98 * _Object2World[1].xyz).xyz;
  tmpvar_111.w = tmpvar_95.y;
  vec4 tmpvar_113;
  tmpvar_113.xyz = (tmpvar_98 * _Object2World[2].xyz).xyz;
  tmpvar_113.w = tmpvar_95.z;
  vec4 o_i0;
  vec4 tmpvar_117;
  tmpvar_117 = (tmpvar_79 * 0.5);
  o_i0 = tmpvar_117;
  vec2 tmpvar_118;
  tmpvar_118.x = tmpvar_117.x;
  tmpvar_118.y = (vec2((tmpvar_117.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_118 + tmpvar_117.w);
  o_i0.zw = tmpvar_79.zw;
  mat3 tmpvar_127;
  tmpvar_127[0] = _Object2World[0].xyz;
  tmpvar_127[1] = _Object2World[1].xyz;
  tmpvar_127[2] = _Object2World[2].xyz;
  vec4 tmpvar_138;
  tmpvar_138.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_138.w = 1.0;
  vec4 tmpvar_141;
  tmpvar_141.xyz = (tmpvar_127 * (tmpvar_5 * unity_Scale.w)).xyz;
  tmpvar_141.w = 1.0;
  vec3 x2;
  vec3 x1;
  x1.x = dot (unity_SHAr, tmpvar_141);
  x1.y = (vec2(dot (unity_SHAg, tmpvar_141))).y;
  x1.z = (vec3(dot (unity_SHAb, tmpvar_141))).z;
  vec4 tmpvar_150;
  tmpvar_150 = (tmpvar_141.xyzz * tmpvar_141.yzzx);
  x2.x = dot (unity_SHBr, tmpvar_150);
  x2.y = (vec2(dot (unity_SHBg, tmpvar_150))).y;
  x2.z = (vec3(dot (unity_SHBb, tmpvar_150))).z;
  gl_Position = tmpvar_79.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_109 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_111 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_113 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_98 * (((_World2Object * tmpvar_138).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_98 * (_World2Object * _WorldSpaceLightPos0).xyz).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
  vec4 tmpvar_31;
  tmpvar_31.xyz = ((x1 + x2) + (unity_SHC.xyz * ((tmpvar_141.x * tmpvar_141.x) - (tmpvar_141.y * tmpvar_141.y)))).xyz;
  tmpvar_31.w = 0.0;
  gl_TexCoord[7] = tmpvar_31;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec3 tmpvar_14;
  tmpvar_14 = gl_TexCoord[6].xyz;
  vec4 c;
  vec2 tmpvar_118;
  tmpvar_118 = gl_TexCoord[0].xy;
  vec3 tmpvar_119;
  tmpvar_119.x = tmpvar_6.w;
  tmpvar_119.y = tmpvar_8.w;
  tmpvar_119.z = tmpvar_10.w;
  vec4 tmpvar_252;
  tmpvar_252 = tmpvar_4;
  float tmpvar_140;
  tmpvar_140 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_118).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_118 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_162;
  tmpvar_162 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_252.xy = (((((tmpvar_162 * _Refraction) * tmpvar_140).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_166;
  tmpvar_166.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_166.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_166.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_168;
  tmpvar_168.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_168.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_168.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_170;
  tmpvar_170.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_170.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_170.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_172;
  tmpvar_172.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_162 * tmpvar_166)))).x;
  tmpvar_172.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_162 * tmpvar_168)))).y;
  tmpvar_172.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_162 * tmpvar_170)))).z;
  vec3 tmpvar_173;
  tmpvar_173 = reflect (tmpvar_119, tmpvar_172);
  float tmpvar_184;
  tmpvar_184 = clamp (tmpvar_140, 0.0, 1.0);
  vec3 tmpvar_195;
  tmpvar_195 = (_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_173).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_252).xyz, vec3(clamp (pow (abs (dot (tmpvar_162, normalize (tmpvar_173))), _ReflToRefrExponent), 0.1, 0.9))));
  vec4 c_i0_i1;
  float tmpvar_211;
  tmpvar_211 = pow (max (0.0, dot (tmpvar_162, normalize ((tmpvar_14 + normalize (gl_TexCoord[5].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = ((((tmpvar_195 * _LightColor0.xyz) * max (0.0, dot (tmpvar_162, tmpvar_14))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_211)) * 2.0).xyz;
  c_i0_i1.w = (vec4((tmpvar_184 + ((_LightColor0.w * _SpecColor.w) * tmpvar_211)))).w;
  c = c_i0_i1;
  c.xyz = (c_i0_i1.xyz + (tmpvar_195 * gl_TexCoord[7].xyz)).xyz;
  c.xyz = (c.xyz + (tmpvar_195 * 0.5)).xyz;
  c.w = (vec4(tmpvar_184)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_LightmapST]
Vector 17 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 40 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.w, c[0].y;
MOV R1.xyz, c[15];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[14].w, -vertex.position;
MUL R1.xyz, vertex.attrib[14].w, R0;
DP3 R0.y, R1, c[5];
DP3 result.texcoord[5].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[14].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[14].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[14].w;
MUL R1.y, R3, c[13].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[6].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 40 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 16 [unity_LightmapST]
Vector 17 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.w, c18.y
mov r1.xyz, c15
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
mul r1.xyz, v1.w, r0
dp3 r0.y, r1, c4
dp3 o6.y, r1, r2
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c14.w
dp3 r0.y, r1, c5
dp3 r1.y, r1, c6
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c14.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r3.xyz, r0.xyww, c18.x
dp3 r1.x, v1, c6
dp3 r1.w, -r2, c6
dp3 r1.z, v2, c6
mul o5, r1, c14.w
mul r1.y, r3, c12.x
mov r1.x, r3
mad o2.xy, r3.z, c13.zwzw, r1
dp3 o6.z, v2, r2
dp3 o6.x, v1, r2
mov o0, r0
mov o2.zw, r0
mad o1.xy, v3, c17, c17.zwzw
mad o7.xy, v4, c16, c16.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 unity_LightmapST;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_59;
  tmpvar_59 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_63;
  tmpvar_63.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_63.w = 1.0;
  mat3 tmpvar_71;
  tmpvar_71[0] = _Object2World[0].xyz;
  tmpvar_71[1] = _Object2World[1].xyz;
  tmpvar_71[2] = _Object2World[2].xyz;
  vec3 tmpvar_75;
  tmpvar_75 = (tmpvar_71 * -((((_World2Object * tmpvar_63).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_77;
  tmpvar_77 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_78;
  tmpvar_78[0].x = tmpvar_3.x;
  tmpvar_78[0].y = tmpvar_77.x;
  tmpvar_78[0].z = tmpvar_5.x;
  tmpvar_78[1].x = tmpvar_3.y;
  tmpvar_78[1].y = tmpvar_77.y;
  tmpvar_78[1].z = tmpvar_5.y;
  tmpvar_78[2].x = tmpvar_3.z;
  tmpvar_78[2].y = tmpvar_77.z;
  tmpvar_78[2].z = tmpvar_5.z;
  vec4 tmpvar_89;
  tmpvar_89.xyz = (tmpvar_78 * _Object2World[0].xyz).xyz;
  tmpvar_89.w = tmpvar_75.x;
  vec4 tmpvar_91;
  tmpvar_91.xyz = (tmpvar_78 * _Object2World[1].xyz).xyz;
  tmpvar_91.w = tmpvar_75.y;
  vec4 tmpvar_93;
  tmpvar_93.xyz = (tmpvar_78 * _Object2World[2].xyz).xyz;
  tmpvar_93.w = tmpvar_75.z;
  vec4 o_i0;
  vec4 tmpvar_97;
  tmpvar_97 = (tmpvar_59 * 0.5);
  o_i0 = tmpvar_97;
  vec2 tmpvar_98;
  tmpvar_98.x = tmpvar_97.x;
  tmpvar_98.y = (vec2((tmpvar_97.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_98 + tmpvar_97.w);
  o_i0.zw = tmpvar_59.zw;
  vec4 tmpvar_115;
  tmpvar_115.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_115.w = 1.0;
  gl_Position = tmpvar_59.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_89 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_91 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_93 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_78 * (((_World2Object * tmpvar_115).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xy = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw).xy;
  tmpvar_29.z = 0.0;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec4 c;
  vec2 tmpvar_104;
  tmpvar_104 = gl_TexCoord[0].xy;
  vec3 tmpvar_105;
  tmpvar_105.x = tmpvar_6.w;
  tmpvar_105.y = tmpvar_8.w;
  tmpvar_105.z = tmpvar_10.w;
  vec4 tmpvar_224;
  tmpvar_224 = tmpvar_4;
  float tmpvar_126;
  tmpvar_126 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_104).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_104 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_148;
  tmpvar_148 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_224.xy = (((((tmpvar_148 * _Refraction) * tmpvar_126).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_152;
  tmpvar_152.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_152.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_152.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_154;
  tmpvar_154.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_154.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_154.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_156;
  tmpvar_156.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_156.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_156.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_158;
  tmpvar_158.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_148 * tmpvar_152)))).x;
  tmpvar_158.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_148 * tmpvar_154)))).y;
  tmpvar_158.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_148 * tmpvar_156)))).z;
  vec3 tmpvar_159;
  tmpvar_159 = reflect (tmpvar_105, tmpvar_158);
  float tmpvar_170;
  tmpvar_170 = clamp (tmpvar_126, 0.0, 1.0);
  vec3 tmpvar_181;
  tmpvar_181 = (_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_159).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_224).xyz, vec3(clamp (pow (abs (dot (tmpvar_148, normalize (tmpvar_159))), _ReflToRefrExponent), 0.1, 0.9))));
  c.xyz = (tmpvar_181 * (2.0 * texture2D (unity_Lightmap, gl_TexCoord[6].xy).xyz)).xyz;
  c.w = (vec4(tmpvar_170)).w;
  c.xyz = (c.xyz + (tmpvar_181 * 0.5)).xyz;
  c.w = (vec4(tmpvar_170)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 95 ALU
PARAM c[33] = { { 0.5, 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[14].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[18];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[17];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].y;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[19];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[20];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].y;
DP4 R2.z, R4, c[27];
DP4 R2.y, R4, c[26];
DP4 R2.x, R4, c[25];
DP4 R2.w, vertex.position, c[4];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[22];
MAD R1.xyz, R0.x, c[21], R1;
MAD R0.xyz, R0.z, c[23], R1;
MUL R1, R4.xyzz, R4.yzzx;
MAD R0.xyz, R0.w, c[24], R0;
MUL R0.w, R3, R3;
MAD R0.w, R4.x, R4.x, -R0;
MUL R4.xyz, R0.w, c[31];
DP4 R3.z, R1, c[30];
DP4 R3.y, R1, c[29];
DP4 R3.x, R1, c[28];
ADD R1.xyz, R2, R3;
ADD R1.xyz, R1, R4;
ADD result.texcoord[7].xyz, R1, R0;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MUL R2.xyz, vertex.attrib[14].w, R2;
MOV R0.xyz, c[15];
MOV R0.w, c[0].y;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
MAD R4.xyz, R1, c[14].w, -vertex.position;
MOV R1, c[16];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
DP3 R1.y, R2, c[5];
DP3 result.texcoord[5].y, R2, R4;
DP3 result.texcoord[6].y, R2, R0;
DP3 R1.w, -R4, c[5];
DP3 R1.x, vertex.attrib[14], c[5];
DP3 R1.z, vertex.normal, c[5];
MUL result.texcoord[2], R1, c[14].w;
DP3 R1.y, R2, c[6];
DP3 R1.w, -R4, c[6];
DP3 R1.x, vertex.attrib[14], c[6];
DP3 R1.z, vertex.normal, c[6];
MUL result.texcoord[3], R1, c[14].w;
DP3 R1.y, R2, c[7];
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MUL R3.xyz, R2.xyww, c[0].x;
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R4, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[14].w;
MUL R1.y, R3, c[13].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[5].z, vertex.normal, R4;
DP3 result.texcoord[5].x, vertex.attrib[14], R4;
DP3 result.texcoord[6].z, vertex.normal, R0;
DP3 result.texcoord[6].x, vertex.attrib[14], R0;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 95 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [_BumpMap_ST]
"vs_3_0
; 98 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c33, 0.50000000, 1.00000000, 0.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c14.w
dp4 r0.x, v0, c5
add r1, -r0.x, c18
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c17
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c33.y
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c19
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c20
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c33.y
dp4 r2.z, r4, c27
dp4 r2.y, r4, c26
dp4 r2.x, r4, c25
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c33.z
mul r0, r0, r1
mul r1.xyz, r0.y, c22
mad r1.xyz, r0.x, c21, r1
mad r0.xyz, r0.z, c23, r1
mad r1.xyz, r0.w, c24, r0
mul r0, r4.xyzz, r4.yzzx
dp4 r3.z, r0, c30
dp4 r3.y, r0, c29
dp4 r3.x, r0, c28
mul r1.w, r3, r3
mad r0.x, r4, r4, -r1.w
add r2.xyz, r2, r3
mul r3.xyz, r0.x, c31
add r3.xyz, r2, r3
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r2
mul r2.xyz, v1.w, r0
add o8.xyz, r3, r1
mov r0.w, c33.y
mov r0.xyz, c15
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r3.xyz, r1, c14.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
dp3 r0.y, r2, c4
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c14.w
dp3 r0.y, r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
dp3 r0.x, v1, c6
dp3 o6.y, r2, r3
dp3 o7.y, r2, r4
mul r2.xyz, r1.xyww, c33.x
dp3 r0.w, -r3, c6
dp3 r0.z, v2, c6
mul o5, r0, c14.w
mul r0.y, r2, c12.x
mov r0.x, r2
mad o2.xy, r2.z, c13.zwzw, r0
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp3 o7.z, v2, r4
dp3 o7.x, v1, r4
mov o0, r1
mov o2.zw, r1
mad o1.xy, v3, c32, c32.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec3 unity_LightColor3;
uniform vec3 unity_LightColor2;
uniform vec3 unity_LightColor1;
uniform vec3 unity_LightColor0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightAtten0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_102;
  tmpvar_102 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_106;
  tmpvar_106.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_106.w = 1.0;
  mat3 tmpvar_114;
  tmpvar_114[0] = _Object2World[0].xyz;
  tmpvar_114[1] = _Object2World[1].xyz;
  tmpvar_114[2] = _Object2World[2].xyz;
  vec3 tmpvar_118;
  tmpvar_118 = (tmpvar_114 * -((((_World2Object * tmpvar_106).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_120;
  tmpvar_120 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_121;
  tmpvar_121[0].x = tmpvar_3.x;
  tmpvar_121[0].y = tmpvar_120.x;
  tmpvar_121[0].z = tmpvar_5.x;
  tmpvar_121[1].x = tmpvar_3.y;
  tmpvar_121[1].y = tmpvar_120.y;
  tmpvar_121[1].z = tmpvar_5.y;
  tmpvar_121[2].x = tmpvar_3.z;
  tmpvar_121[2].y = tmpvar_120.z;
  tmpvar_121[2].z = tmpvar_5.z;
  vec4 tmpvar_132;
  tmpvar_132.xyz = (tmpvar_121 * _Object2World[0].xyz).xyz;
  tmpvar_132.w = tmpvar_118.x;
  vec4 tmpvar_134;
  tmpvar_134.xyz = (tmpvar_121 * _Object2World[1].xyz).xyz;
  tmpvar_134.w = tmpvar_118.y;
  vec4 tmpvar_136;
  tmpvar_136.xyz = (tmpvar_121 * _Object2World[2].xyz).xyz;
  tmpvar_136.w = tmpvar_118.z;
  vec4 o_i0;
  vec4 tmpvar_140;
  tmpvar_140 = (tmpvar_102 * 0.5);
  o_i0 = tmpvar_140;
  vec2 tmpvar_141;
  tmpvar_141.x = tmpvar_140.x;
  tmpvar_141.y = (vec2((tmpvar_140.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_141 + tmpvar_140.w);
  o_i0.zw = tmpvar_102.zw;
  mat3 tmpvar_150;
  tmpvar_150[0] = _Object2World[0].xyz;
  tmpvar_150[1] = _Object2World[1].xyz;
  tmpvar_150[2] = _Object2World[2].xyz;
  vec3 tmpvar_154;
  tmpvar_154 = (tmpvar_150 * (tmpvar_5 * unity_Scale.w));
  vec4 tmpvar_161;
  tmpvar_161.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_161.w = 1.0;
  vec4 tmpvar_164;
  tmpvar_164.xyz = tmpvar_154.xyz;
  tmpvar_164.w = 1.0;
  vec3 x2;
  vec3 x1;
  x1.x = dot (unity_SHAr, tmpvar_164);
  x1.y = (vec2(dot (unity_SHAg, tmpvar_164))).y;
  x1.z = (vec3(dot (unity_SHAb, tmpvar_164))).z;
  vec4 tmpvar_173;
  tmpvar_173 = (tmpvar_164.xyzz * tmpvar_164.yzzx);
  x2.x = dot (unity_SHBr, tmpvar_173);
  x2.y = (vec2(dot (unity_SHBg, tmpvar_173))).y;
  x2.z = (vec3(dot (unity_SHBb, tmpvar_173))).z;
  vec3 tmpvar_184;
  tmpvar_184 = (_Object2World * tmpvar_1).xyz;
  vec4 tmpvar_187;
  tmpvar_187 = (unity_4LightPosX0 - tmpvar_184.x);
  vec4 tmpvar_188;
  tmpvar_188 = (unity_4LightPosY0 - tmpvar_184.y);
  vec4 tmpvar_189;
  tmpvar_189 = (unity_4LightPosZ0 - tmpvar_184.z);
  vec4 tmpvar_193;
  tmpvar_193 = (((tmpvar_187 * tmpvar_187) + (tmpvar_188 * tmpvar_188)) + (tmpvar_189 * tmpvar_189));
  vec4 tmpvar_203;
  tmpvar_203 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_187 * tmpvar_154.x) + (tmpvar_188 * tmpvar_154.y)) + (tmpvar_189 * tmpvar_154.z)) * inversesqrt (tmpvar_193))) * 1.0/((1.0 + (tmpvar_193 * unity_4LightAtten0))));
  gl_Position = tmpvar_102.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_132 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_134 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_136 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_121 * (((_World2Object * tmpvar_161).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_121 * (_World2Object * _WorldSpaceLightPos0).xyz).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
  vec4 tmpvar_31;
  tmpvar_31.xyz = (((x1 + x2) + (unity_SHC.xyz * ((tmpvar_164.x * tmpvar_164.x) - (tmpvar_164.y * tmpvar_164.y)))) + ((((unity_LightColor0 * tmpvar_203.x) + (unity_LightColor1 * tmpvar_203.y)) + (unity_LightColor2 * tmpvar_203.z)) + (unity_LightColor3 * tmpvar_203.w))).xyz;
  tmpvar_31.w = 0.0;
  gl_TexCoord[7] = tmpvar_31;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec3 tmpvar_14;
  tmpvar_14 = gl_TexCoord[6].xyz;
  vec4 c;
  vec2 tmpvar_118;
  tmpvar_118 = gl_TexCoord[0].xy;
  vec3 tmpvar_119;
  tmpvar_119.x = tmpvar_6.w;
  tmpvar_119.y = tmpvar_8.w;
  tmpvar_119.z = tmpvar_10.w;
  vec4 tmpvar_252;
  tmpvar_252 = tmpvar_4;
  float tmpvar_140;
  tmpvar_140 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_118).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_118 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_162;
  tmpvar_162 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_252.xy = (((((tmpvar_162 * _Refraction) * tmpvar_140).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_166;
  tmpvar_166.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_166.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_166.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_168;
  tmpvar_168.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_168.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_168.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_170;
  tmpvar_170.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_170.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_170.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_172;
  tmpvar_172.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_162 * tmpvar_166)))).x;
  tmpvar_172.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_162 * tmpvar_168)))).y;
  tmpvar_172.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_162 * tmpvar_170)))).z;
  vec3 tmpvar_173;
  tmpvar_173 = reflect (tmpvar_119, tmpvar_172);
  float tmpvar_184;
  tmpvar_184 = clamp (tmpvar_140, 0.0, 1.0);
  vec3 tmpvar_195;
  tmpvar_195 = (_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_173).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_252).xyz, vec3(clamp (pow (abs (dot (tmpvar_162, normalize (tmpvar_173))), _ReflToRefrExponent), 0.1, 0.9))));
  vec4 c_i0_i1;
  float tmpvar_211;
  tmpvar_211 = pow (max (0.0, dot (tmpvar_162, normalize ((tmpvar_14 + normalize (gl_TexCoord[5].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = ((((tmpvar_195 * _LightColor0.xyz) * max (0.0, dot (tmpvar_162, tmpvar_14))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_211)) * 2.0).xyz;
  c_i0_i1.w = (vec4((tmpvar_184 + ((_LightColor0.w * _SpecColor.w) * tmpvar_211)))).w;
  c = c_i0_i1;
  c.xyz = (c_i0_i1.xyz + (tmpvar_195 * gl_TexCoord[7].xyz)).xyz;
  c.xyz = (c.xyz + (tmpvar_195 * 0.5)).xyz;
  c.w = (vec4(tmpvar_184)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

}
Program "fp" {
// Fragment combos: 2
//   opengl - ALU: 60 to 78, TEX: 5 to 6
//   d3d9 - ALU: 57 to 78, TEX: 5 to 6
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 78 ALU, 5 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[14] = { program.local[0..10],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xy, c[10];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[11].y, -c[11].z;
MAD R1.xy, R1.wyzw, c[11].y, -c[11].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[11].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[11];
RSQ R0.z, R0.z;
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R0.xyz, R0, c[12].x;
MUL R1.xyz, R0, c[8].x;
DP3 R2.x, fragment.texcoord[2], R1;
DP3 R2.y, R1, fragment.texcoord[3];
DP3 R2.z, R1, fragment.texcoord[4];
MOV R1.x, fragment.texcoord[2].w;
MOV R1.z, fragment.texcoord[4].w;
MOV R1.y, fragment.texcoord[3].w;
DP3 R0.w, R2, R1;
MUL R2.xyz, R2, R0.w;
MAD R2.xyz, -R2, c[11].y, R1;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R2;
DP3 R1.x, R0, R1;
TXP R3.x, fragment.texcoord[1], texture[1], SHADOW2D;
MAD R0.w, R3.x, c[1].z, c[1];
ABS R1.x, R1;
POW R1.x, R1.x, c[9].x;
MIN R1.z, R1.x, c[12].y;
MAX R2.w, R1.z, c[12].z;
RCP R0.w, R0.w;
ADD R0.w, fragment.texcoord[1].z, -R0;
ABS R0.w, R0;
MUL_SAT R0.w, R0, c[11].x;
MUL R1.xy, R0, c[7].x;
MUL R1.xy, R0.w, R1;
MUL R1.xy, R1, c[10];
MOV R1.zw, fragment.texcoord[1];
MAD R1.xy, fragment.texcoord[1].z, R1, fragment.texcoord[1];
TXP R1.xyz, R1, texture[0], SHADOW2D;
TEX R2.xyz, R2, texture[3], CUBE;
MAD R1.xyz, -R2, c[5], R1;
MUL R2.xyz, R2, c[5];
MAD R1.xyz, R2.w, R1, R2;
MUL R1.xyz, R1, c[4];
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R1.w, R1.w;
MOV R3.xyz, fragment.texcoord[6];
MAD R3.xyz, R1.w, fragment.texcoord[5], R3;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
DP3 R2.w, R0, R3;
MOV R1.w, c[13].x;
MUL R3.x, R1.w, c[6];
MAX R1.w, R2, c[12];
POW R2.w, R1.w, R3.x;
DP3 R1.w, R0, fragment.texcoord[6];
MOV R3.xyz, c[3];
MUL R0.xyz, R3, c[2];
MUL R2.xyz, R1, c[2];
MUL R0.xyz, R0, R2.w;
MAX R1.w, R1, c[12];
MAD R0.xyz, R2, R1.w, R0;
MUL R2.xyz, R1, fragment.texcoord[7];
MUL R0.xyz, R0, c[11].y;
ADD R0.xyz, R0, R2;
MAD result.color.xyz, R1, c[12].x, R0;
MOV result.color.w, R0;
END
# 78 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
"ps_3_0
; 78 ALU, 5 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
def c11, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c12, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c13, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7.xyz
mov r0.x, c0.y
mul r0.xy, c10, r0.x
mad r0.xy, -r0, c12.x, v0
texld r1.yw, r0, s2
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c11.y, c11.z
mad_pp r1.xy, r1.wyzw, c11.y, c11.z
mul_pp r0.w, r1.y, r1.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.w, -r1.x, r1.x, -r0
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.w, r0, c11
rsq_pp r0.w, r0.w
add_pp r0.z, r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r1.z, r0.w
rcp_pp r0.z, r0.z
add_pp r0.xyz, r0, r1
mul_pp r2.xyz, r0, c12.y
mul_pp r0.xyz, r2, c8.x
dp3_pp r1.x, v2, r0
dp3_pp r1.y, r0, v3
dp3_pp r1.z, r0, v4
mov r0.x, v2.w
mov r0.z, v4.w
mov r0.y, v3.w
dp3 r0.w, r1, r0
mul r1.xyz, r1, r0.w
mad r0.xyz, -r1, c11.y, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3_pp r0.w, r2, r1
abs_pp r0.w, r0
pow r1, r0.w, c9.x
texldp r3.x, v1, s1
mad r0.w, r3.x, c1.z, c1
min r1.x, r1, c12.z
max r2.w, r1.x, c12
rcp r0.w, r0.w
add r0.w, v1.z, -r0
abs r0.w, r0
mul_sat r0.w, r0, c11.x
mul r1.xy, r2, c7.x
mul r1.xy, r0.w, r1
mul r1.xy, r1, c10
texld r0.xyz, r0, s3
mov r1.zw, v1
mad r1.xy, v1.z, r1, v1
texldp r1.xyz, r1, s0
mad r1.xyz, -r0, c5, r1
dp3_pp r1.w, v5, v5
mul r0.xyz, r0, c5
mad r0.xyz, r2.w, r1, r0
mul r0.xyz, r0, c4
rsq_pp r1.w, r1.w
mov_pp r3.xyz, v6
mad_pp r3.xyz, r1.w, v5, r3
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r1.xyz, r1.w, r3
dp3_pp r1.x, r2, r1
mov_pp r1.w, c6.x
mul_pp r3.x, c13.y, r1.w
max_pp r2.w, r1.x, c13.x
pow r1, r2.w, r3.x
dp3_pp r1.w, r2, v6
mov r2.w, r1.x
mov r1.xyz, c2
mul r1.xyz, c3, r1
mul r3.xyz, r0, c2
mul r1.xyz, r1, r2.w
max_pp r1.w, r1, c13.x
mad r1.xyz, r3, r1.w, r1
mul r2.xyz, r0, v7
mul r1.xyz, r1, c11.y
add_pp r1.xyz, r1, r2
mad_pp oC0.xyz, r0, c12.y, r1
mov_pp oC0.w, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Vector 3 [_ReflectColor]
Float 4 [_Refraction]
Float 5 [_BumpReflectionStr]
Float 6 [_ReflToRefrExponent]
Vector 7 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 60 ALU, 6 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[10] = { program.local[0..7],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xy, c[7];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[8].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[8].y, -c[8].z;
MAD R1.xy, R1.wyzw, c[8].y, -c[8].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[8].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[8];
RSQ R0.z, R0.z;
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R0, c[9].x;
MUL R0.xyz, R2, c[5].x;
DP3 R1.x, fragment.texcoord[2], R0;
DP3 R1.y, R0, fragment.texcoord[3];
DP3 R1.z, R0, fragment.texcoord[4];
MOV R0.x, fragment.texcoord[2].w;
MOV R0.z, fragment.texcoord[4].w;
MOV R0.y, fragment.texcoord[3].w;
DP3 R0.w, R1, R0;
MUL R1.xyz, R1, R0.w;
MAD R0.xyz, -R1, c[8].y, R0;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
DP3 R0.w, R2, R1;
ABS R1.y, R0.w;
TXP R1.x, fragment.texcoord[1], texture[1], SHADOW2D;
MAD R0.w, R1.x, c[1].z, c[1];
POW R1.x, R1.y, c[6].x;
MIN R1.x, R1, c[9].y;
MAX R2.w, R1.x, c[9].z;
RCP R0.w, R0.w;
ADD R0.w, fragment.texcoord[1].z, -R0;
ABS R0.w, R0;
MUL_SAT R0.w, R0, c[8].x;
MUL R1.xy, R2, c[4].x;
TEX R0.xyz, R0, texture[3], CUBE;
MUL R1.xy, R0.w, R1;
MUL R1.xy, R1, c[7];
MUL R2.xyz, R0, c[3];
MOV R1.zw, fragment.texcoord[1];
MAD R1.xy, fragment.texcoord[1].z, R1, fragment.texcoord[1];
TXP R1.xyz, R1, texture[0], SHADOW2D;
MAD R0.xyz, -R0, c[3], R1;
MAD R0.xyz, R2.w, R0, R2;
MUL R1.xyz, R0, c[2];
TEX R2, fragment.texcoord[6], texture[4], 2D;
MUL R0.xyz, R2.w, R2;
MUL R2.xyz, R1, c[9].x;
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[9].w, R2;
MOV result.color.w, R0;
END
# 60 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Vector 3 [_ReflectColor]
Float 4 [_Refraction]
Float 5 [_BumpReflectionStr]
Float 6 [_ReflToRefrExponent]
Vector 7 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [unity_Lightmap] 2D
"ps_3_0
; 57 ALU, 6 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
dcl_2d s4
def c8, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c9, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c10, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord6 v5.xy
texld r1.yw, v0, s2
mad_pp r1.xy, r1.wyzw, c8.y, c8.z
mul_pp r0.z, r1.y, r1.y
mad_pp r0.z, -r1.x, r1.x, -r0
mov r0.x, c0.y
mul r0.xy, c7, r0.x
mad r0.xy, -r0, c9.x, v0
texld r0.yw, r0, s2
mad_pp r0.xy, r0.wyzw, c8.y, c8.z
mul_pp r0.w, r0.y, r0.y
mad_pp r0.w, -r0.x, r0.x, -r0
add_pp r0.w, r0, c8
rsq_pp r1.z, r0.w
add_pp r0.z, r0, c8.w
rsq_pp r0.w, r0.z
rcp_pp r0.z, r1.z
rcp_pp r1.z, r0.w
add_pp r0.xyz, r1, r0
mul_pp r2.xyz, r0.zxyw, c9.y
mul_pp r1.xyz, r2.yzxw, c5.x
dp3_pp r0.x, v2, r1
dp3_pp r0.y, r1, v3
dp3_pp r0.z, r1, v4
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r0.w, r0, r1
mul r0.xyz, r0, r0.w
mad r1.xyz, -r0, c8.y, r1
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r0.xyz, r0.x, r1
dp3_pp r0.x, r2.yzxw, r0
abs_pp r1.w, r0.x
pow r0, r1.w, c6.x
texldp r2.x, v1, s1
mad r0.y, r2.x, c1.z, c1.w
mov r0.z, r0.x
rcp r0.x, r0.y
min r0.y, r0.z, c9.z
add r0.x, v1.z, -r0
abs r0.z, r0.x
mul_sat r1.w, r0.z, c8.x
max r2.w, r0.y, c9
mul r0.xy, r2.yzzw, c4.x
texld r1.xyz, r1, s3
mul r0.xy, r1.w, r0
mul r0.xy, r0, c7
mul r2.xyz, r1, c3
mov r0.zw, v1
mad r0.xy, v1.z, r0, v1
texldp r0.xyz, r0, s0
mad r0.xyz, -r1, c3, r0
mad r1.xyz, r2.w, r0, r2
mul r1.xyz, r1, c2
texld r0, v5, s4
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1, c9.y
mul_pp r0.xyz, r0, r1
mad_pp oC0.xyz, r0, c10.x, r2
mov_pp oC0.w, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"!!GLES"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
		Blend SrcAlpha One
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 46 to 55
//   d3d9 - ALU: 49 to 58
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 54 ALU
PARAM c[22] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.w, c[0].y;
MOV R1.xyz, c[19];
DP4 R0.z, R1, c[11];
DP4 R0.y, R1, c[10];
DP4 R0.x, R1, c[9];
MAD R2.xyz, R0, c[18].w, -vertex.position;
MOV R1.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R3;
MOV R0, c[20];
MUL R1.xyz, vertex.attrib[14].w, R1;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R4.xyz, R3, c[18].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 result.texcoord[5].y, R1, R4;
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[18].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[18].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[18].w;
MUL R1.y, R3, c[17].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[5].z, vertex.normal, R4;
DP3 result.texcoord[5].x, vertex.attrib[14], R4;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
DP4 result.texcoord[7].z, R0, c[15];
DP4 result.texcoord[7].y, R0, c[14];
DP4 result.texcoord[7].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 54 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 57 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c22, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c22.y
mov r1.xyz, c19
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r2.xyz, v1.w, r2
mov r1, c8
dp4 r4.x, c20, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o6.y, r2, r0
dp3 r1.y, r2, c4
dp3 o7.y, r2, r3
dp4 r2.w, v0, c3
dp3 o6.z, v2, r0
dp3 o6.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o3, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o4, r1, c18.w
dp3 r1.y, r2, c6
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mul r4.xyz, r2.xyww, c22.x
dp3 r1.x, v1, c6
dp3 r1.w, -r3, c6
dp3 r1.z, v2, c6
mul o5, r1, c18.w
mul r1.y, r4, c16.x
mov r1.x, r4
mad o2.xy, r4.z, c17.zwzw, r1
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o0, r2
mov o2.zw, r2
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
mad o1.xy, v3, c21, c21.zwzw
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_55;
  tmpvar_55 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_59;
  tmpvar_59.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_59.w = 1.0;
  mat3 tmpvar_67;
  tmpvar_67[0] = _Object2World[0].xyz;
  tmpvar_67[1] = _Object2World[1].xyz;
  tmpvar_67[2] = _Object2World[2].xyz;
  vec3 tmpvar_71;
  tmpvar_71 = (tmpvar_67 * -((((_World2Object * tmpvar_59).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_73;
  tmpvar_73 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_74;
  tmpvar_74[0].x = tmpvar_3.x;
  tmpvar_74[0].y = tmpvar_73.x;
  tmpvar_74[0].z = tmpvar_5.x;
  tmpvar_74[1].x = tmpvar_3.y;
  tmpvar_74[1].y = tmpvar_73.y;
  tmpvar_74[1].z = tmpvar_5.y;
  tmpvar_74[2].x = tmpvar_3.z;
  tmpvar_74[2].y = tmpvar_73.z;
  tmpvar_74[2].z = tmpvar_5.z;
  vec4 tmpvar_85;
  tmpvar_85.xyz = (tmpvar_74 * _Object2World[0].xyz).xyz;
  tmpvar_85.w = tmpvar_71.x;
  vec4 tmpvar_87;
  tmpvar_87.xyz = (tmpvar_74 * _Object2World[1].xyz).xyz;
  tmpvar_87.w = tmpvar_71.y;
  vec4 tmpvar_89;
  tmpvar_89.xyz = (tmpvar_74 * _Object2World[2].xyz).xyz;
  tmpvar_89.w = tmpvar_71.z;
  vec4 o_i0;
  vec4 tmpvar_93;
  tmpvar_93 = (tmpvar_55 * 0.5);
  o_i0 = tmpvar_93;
  vec2 tmpvar_94;
  tmpvar_94.x = tmpvar_93.x;
  tmpvar_94.y = (vec2((tmpvar_93.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_94 + tmpvar_93.w);
  o_i0.zw = tmpvar_55.zw;
  vec4 tmpvar_104;
  tmpvar_104.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_104.w = 1.0;
  gl_Position = tmpvar_55.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_85 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_87 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_89 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_74 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_74 * (((_World2Object * tmpvar_104).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
  vec4 tmpvar_31;
  tmpvar_31.xyz = (_LightMatrix0 * (_Object2World * tmpvar_1)).xyz;
  tmpvar_31.w = 0.0;
  gl_TexCoord[7] = tmpvar_31;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec3 tmpvar_16;
  tmpvar_16 = gl_TexCoord[7].xyz;
  vec4 c;
  vec2 tmpvar_117;
  tmpvar_117 = gl_TexCoord[0].xy;
  vec3 tmpvar_118;
  tmpvar_118.x = tmpvar_6.w;
  tmpvar_118.y = tmpvar_8.w;
  tmpvar_118.z = tmpvar_10.w;
  vec4 tmpvar_256;
  tmpvar_256 = tmpvar_4;
  float tmpvar_139;
  tmpvar_139 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_117).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_117 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_161;
  tmpvar_161 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_256.xy = (((((tmpvar_161 * _Refraction) * tmpvar_139).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_165;
  tmpvar_165.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_165.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_165.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_167;
  tmpvar_167.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_167.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_167.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_169;
  tmpvar_169.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_169.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_169.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_171;
  tmpvar_171.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_161 * tmpvar_165)))).x;
  tmpvar_171.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_161 * tmpvar_167)))).y;
  tmpvar_171.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_161 * tmpvar_169)))).z;
  vec3 tmpvar_172;
  tmpvar_172 = reflect (tmpvar_118, tmpvar_171);
  float tmpvar_183;
  tmpvar_183 = clamp (tmpvar_139, 0.0, 1.0);
  vec3 tmpvar_198;
  tmpvar_198 = normalize (gl_TexCoord[5].xyz);
  float atten;
  atten = texture2D (_LightTexture0, vec2(dot (tmpvar_16, tmpvar_16))).w;
  vec4 c_i0_i1;
  float tmpvar_217;
  tmpvar_217 = pow (max (0.0, dot (tmpvar_161, normalize ((tmpvar_198 + normalize (gl_TexCoord[6].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = (((((_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_172).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_256).xyz, vec3(clamp (pow (abs (dot (tmpvar_161, normalize (tmpvar_172))), _ReflToRefrExponent), 0.1, 0.9)))) * _LightColor0.xyz) * max (0.0, dot (tmpvar_161, tmpvar_198))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_217)) * (atten * 2.0)).xyz;
  c_i0_i1.w = (vec4((tmpvar_183 + (((_LightColor0.w * _SpecColor.w) * tmpvar_217) * atten)))).w;
  c = c_i0_i1;
  c.w = (vec4(tmpvar_183)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 17 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 46 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.w, c[0].y;
MOV R1.xyz, c[15];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[14].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[16];
MUL R1.xyz, vertex.attrib[14].w, R1;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
DP3 R0.y, R1, c[5];
DP3 result.texcoord[5].y, R1, R3;
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[14].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[14].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R4.xyz, R0.xyww, c[0].x;
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[14].w;
MUL R1.y, R4, c[13].x;
MOV R1.x, R4;
ADD result.texcoord[1].xy, R1, R4.z;
DP3 result.texcoord[5].z, vertex.normal, R3;
DP3 result.texcoord[5].x, vertex.attrib[14], R3;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
END
# 46 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [_BumpMap_ST]
"vs_3_0
; 49 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c18.y
mov r0.xyz, c15
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r1, c8
dp4 r4.x, c16, r1
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
dp3 r0.y, r2, c4
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c14.w
dp3 r0.y, r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
dp3 r0.x, v1, c6
dp3 o6.y, r2, r4
dp3 o7.y, r2, r3
mul r2.xyz, r1.xyww, c18.x
dp3 r0.w, -r3, c6
dp3 r0.z, v2, c6
mul o5, r0, c14.w
mul r0.y, r2, c12.x
mov r0.x, r2
mad o2.xy, r2.z, c13.zwzw, r0
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o0, r1
mov o2.zw, r1
mad o1.xy, v3, c17, c17.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_53;
  tmpvar_53 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_57;
  tmpvar_57.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_57.w = 1.0;
  mat3 tmpvar_65;
  tmpvar_65[0] = _Object2World[0].xyz;
  tmpvar_65[1] = _Object2World[1].xyz;
  tmpvar_65[2] = _Object2World[2].xyz;
  vec3 tmpvar_69;
  tmpvar_69 = (tmpvar_65 * -((((_World2Object * tmpvar_57).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_71;
  tmpvar_71 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_72;
  tmpvar_72[0].x = tmpvar_3.x;
  tmpvar_72[0].y = tmpvar_71.x;
  tmpvar_72[0].z = tmpvar_5.x;
  tmpvar_72[1].x = tmpvar_3.y;
  tmpvar_72[1].y = tmpvar_71.y;
  tmpvar_72[1].z = tmpvar_5.y;
  tmpvar_72[2].x = tmpvar_3.z;
  tmpvar_72[2].y = tmpvar_71.z;
  tmpvar_72[2].z = tmpvar_5.z;
  vec4 tmpvar_83;
  tmpvar_83.xyz = (tmpvar_72 * _Object2World[0].xyz).xyz;
  tmpvar_83.w = tmpvar_69.x;
  vec4 tmpvar_85;
  tmpvar_85.xyz = (tmpvar_72 * _Object2World[1].xyz).xyz;
  tmpvar_85.w = tmpvar_69.y;
  vec4 tmpvar_87;
  tmpvar_87.xyz = (tmpvar_72 * _Object2World[2].xyz).xyz;
  tmpvar_87.w = tmpvar_69.z;
  vec4 o_i0;
  vec4 tmpvar_91;
  tmpvar_91 = (tmpvar_53 * 0.5);
  o_i0 = tmpvar_91;
  vec2 tmpvar_92;
  tmpvar_92.x = tmpvar_91.x;
  tmpvar_92.y = (vec2((tmpvar_91.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_92 + tmpvar_91.w);
  o_i0.zw = tmpvar_53.zw;
  vec4 tmpvar_102;
  tmpvar_102.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_102.w = 1.0;
  gl_Position = tmpvar_53.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_83 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_85 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_87 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_72 * (_World2Object * _WorldSpaceLightPos0).xyz).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_72 * (((_World2Object * tmpvar_102).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec3 tmpvar_12;
  tmpvar_12 = gl_TexCoord[5].xyz;
  vec4 c;
  vec2 tmpvar_115;
  tmpvar_115 = gl_TexCoord[0].xy;
  vec3 tmpvar_116;
  tmpvar_116.x = tmpvar_6.w;
  tmpvar_116.y = tmpvar_8.w;
  tmpvar_116.z = tmpvar_10.w;
  vec4 tmpvar_246;
  tmpvar_246 = tmpvar_4;
  float tmpvar_137;
  tmpvar_137 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_115).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_115 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_159;
  tmpvar_159 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_246.xy = (((((tmpvar_159 * _Refraction) * tmpvar_137).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_163;
  tmpvar_163.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_163.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_163.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_165;
  tmpvar_165.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_165.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_165.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_167;
  tmpvar_167.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_167.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_167.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_169;
  tmpvar_169.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_159 * tmpvar_163)))).x;
  tmpvar_169.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_159 * tmpvar_165)))).y;
  tmpvar_169.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_159 * tmpvar_167)))).z;
  vec3 tmpvar_170;
  tmpvar_170 = reflect (tmpvar_116, tmpvar_169);
  float tmpvar_181;
  tmpvar_181 = clamp (tmpvar_137, 0.0, 1.0);
  vec4 c_i0_i1;
  float tmpvar_209;
  tmpvar_209 = pow (max (0.0, dot (tmpvar_159, normalize ((tmpvar_12 + normalize (gl_TexCoord[6].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = (((((_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_170).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_246).xyz, vec3(clamp (pow (abs (dot (tmpvar_159, normalize (tmpvar_170))), _ReflToRefrExponent), 0.1, 0.9)))) * _LightColor0.xyz) * max (0.0, dot (tmpvar_159, tmpvar_12))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_209)) * 2.0).xyz;
  c_i0_i1.w = (vec4((tmpvar_181 + ((_LightColor0.w * _SpecColor.w) * tmpvar_209)))).w;
  c = c_i0_i1;
  c.w = (vec4(tmpvar_181)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 55 ALU
PARAM c[22] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.w, c[0].y;
MOV R1.xyz, c[19];
DP4 R0.z, R1, c[11];
DP4 R0.y, R1, c[10];
DP4 R0.x, R1, c[9];
MAD R2.xyz, R0, c[18].w, -vertex.position;
MOV R1.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R3;
MOV R0, c[20];
MUL R1.xyz, vertex.attrib[14].w, R1;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R4.xyz, R3, c[18].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 result.texcoord[5].y, R1, R4;
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[18].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[18].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[18].w;
MUL R1.y, R3, c[17].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[5].z, vertex.normal, R4;
DP3 result.texcoord[5].x, vertex.attrib[14], R4;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
DP4 result.texcoord[7].w, R0, c[16];
DP4 result.texcoord[7].z, R0, c[15];
DP4 result.texcoord[7].y, R0, c[14];
DP4 result.texcoord[7].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 55 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 58 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c22, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c22.y
mov r1.xyz, c19
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r2.xyz, v1.w, r2
mov r1, c8
dp4 r4.x, c20, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o6.y, r2, r0
dp3 r1.y, r2, c4
dp4 r0.w, v0, c7
dp3 o7.y, r2, r3
dp4 r2.w, v0, c3
dp3 o6.z, v2, r0
dp3 o6.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o3, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o4, r1, c18.w
dp3 r1.y, r2, c6
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mul r4.xyz, r2.xyww, c22.x
dp3 r1.x, v1, c6
dp3 r1.w, -r3, c6
dp3 r1.z, v2, c6
mul o5, r1, c18.w
mul r1.y, r4, c16.x
mov r1.x, r4
mad o2.xy, r4.z, c17.zwzw, r1
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o0, r2
mov o2.zw, r2
dp4 o8.w, r0, c15
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
mad o1.xy, v3, c21, c21.zwzw
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_55;
  tmpvar_55 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_59;
  tmpvar_59.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_59.w = 1.0;
  mat3 tmpvar_67;
  tmpvar_67[0] = _Object2World[0].xyz;
  tmpvar_67[1] = _Object2World[1].xyz;
  tmpvar_67[2] = _Object2World[2].xyz;
  vec3 tmpvar_71;
  tmpvar_71 = (tmpvar_67 * -((((_World2Object * tmpvar_59).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_73;
  tmpvar_73 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_74;
  tmpvar_74[0].x = tmpvar_3.x;
  tmpvar_74[0].y = tmpvar_73.x;
  tmpvar_74[0].z = tmpvar_5.x;
  tmpvar_74[1].x = tmpvar_3.y;
  tmpvar_74[1].y = tmpvar_73.y;
  tmpvar_74[1].z = tmpvar_5.y;
  tmpvar_74[2].x = tmpvar_3.z;
  tmpvar_74[2].y = tmpvar_73.z;
  tmpvar_74[2].z = tmpvar_5.z;
  vec4 tmpvar_85;
  tmpvar_85.xyz = (tmpvar_74 * _Object2World[0].xyz).xyz;
  tmpvar_85.w = tmpvar_71.x;
  vec4 tmpvar_87;
  tmpvar_87.xyz = (tmpvar_74 * _Object2World[1].xyz).xyz;
  tmpvar_87.w = tmpvar_71.y;
  vec4 tmpvar_89;
  tmpvar_89.xyz = (tmpvar_74 * _Object2World[2].xyz).xyz;
  tmpvar_89.w = tmpvar_71.z;
  vec4 o_i0;
  vec4 tmpvar_93;
  tmpvar_93 = (tmpvar_55 * 0.5);
  o_i0 = tmpvar_93;
  vec2 tmpvar_94;
  tmpvar_94.x = tmpvar_93.x;
  tmpvar_94.y = (vec2((tmpvar_93.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_94 + tmpvar_93.w);
  o_i0.zw = tmpvar_55.zw;
  vec4 tmpvar_104;
  tmpvar_104.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_104.w = 1.0;
  gl_Position = tmpvar_55.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_85 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_87 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_89 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_74 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_74 * (((_World2Object * tmpvar_104).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
  gl_TexCoord[7] = (_LightMatrix0 * (_Object2World * tmpvar_1)).xyzw;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec4 tmpvar_16;
  tmpvar_16 = gl_TexCoord[7].xyzw;
  vec4 c;
  vec2 tmpvar_124;
  tmpvar_124 = gl_TexCoord[0].xy;
  vec3 tmpvar_125;
  tmpvar_125.x = tmpvar_6.w;
  tmpvar_125.y = tmpvar_8.w;
  tmpvar_125.z = tmpvar_10.w;
  vec4 tmpvar_268;
  tmpvar_268 = tmpvar_4;
  float tmpvar_146;
  tmpvar_146 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_124).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_124 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_168;
  tmpvar_168 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_268.xy = (((((tmpvar_168 * _Refraction) * tmpvar_146).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_172;
  tmpvar_172.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_172.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_172.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_174;
  tmpvar_174.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_174.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_174.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_176;
  tmpvar_176.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_176.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_176.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_178;
  tmpvar_178.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_168 * tmpvar_172)))).x;
  tmpvar_178.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_168 * tmpvar_174)))).y;
  tmpvar_178.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_168 * tmpvar_176)))).z;
  vec3 tmpvar_179;
  tmpvar_179 = reflect (tmpvar_125, tmpvar_178);
  float tmpvar_190;
  tmpvar_190 = clamp (tmpvar_146, 0.0, 1.0);
  vec3 tmpvar_205;
  tmpvar_205 = normalize (gl_TexCoord[5].xyz);
  vec3 LightCoord_i0;
  LightCoord_i0 = tmpvar_16.xyz;
  float atten;
  atten = ((float((tmpvar_16.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_16.xy / tmpvar_16.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (LightCoord_i0, LightCoord_i0))).w);
  vec4 c_i0_i1;
  float tmpvar_229;
  tmpvar_229 = pow (max (0.0, dot (tmpvar_168, normalize ((tmpvar_205 + normalize (gl_TexCoord[6].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = (((((_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_179).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_268).xyz, vec3(clamp (pow (abs (dot (tmpvar_168, normalize (tmpvar_179))), _ReflToRefrExponent), 0.1, 0.9)))) * _LightColor0.xyz) * max (0.0, dot (tmpvar_168, tmpvar_205))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_229)) * (atten * 2.0)).xyz;
  c_i0_i1.w = (vec4((tmpvar_190 + (((_LightColor0.w * _SpecColor.w) * tmpvar_229) * atten)))).w;
  c = c_i0_i1;
  c.w = (vec4(tmpvar_190)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 54 ALU
PARAM c[22] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.w, c[0].y;
MOV R1.xyz, c[19];
DP4 R0.z, R1, c[11];
DP4 R0.y, R1, c[10];
DP4 R0.x, R1, c[9];
MAD R2.xyz, R0, c[18].w, -vertex.position;
MOV R1.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R3;
MOV R0, c[20];
MUL R1.xyz, vertex.attrib[14].w, R1;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R4.xyz, R3, c[18].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 result.texcoord[5].y, R1, R4;
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[18].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[18].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[18].w;
MUL R1.y, R3, c[17].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[5].z, vertex.normal, R4;
DP3 result.texcoord[5].x, vertex.attrib[14], R4;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
DP4 result.texcoord[7].z, R0, c[15];
DP4 result.texcoord[7].y, R0, c[14];
DP4 result.texcoord[7].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 54 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 57 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c22, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c22.y
mov r1.xyz, c19
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r2.xyz, v1.w, r2
mov r1, c8
dp4 r4.x, c20, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o6.y, r2, r0
dp3 r1.y, r2, c4
dp3 o7.y, r2, r3
dp4 r2.w, v0, c3
dp3 o6.z, v2, r0
dp3 o6.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o3, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o4, r1, c18.w
dp3 r1.y, r2, c6
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mul r4.xyz, r2.xyww, c22.x
dp3 r1.x, v1, c6
dp3 r1.w, -r3, c6
dp3 r1.z, v2, c6
mul o5, r1, c18.w
mul r1.y, r4, c16.x
mov r1.x, r4
mad o2.xy, r4.z, c17.zwzw, r1
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o0, r2
mov o2.zw, r2
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
mad o1.xy, v3, c21, c21.zwzw
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_55;
  tmpvar_55 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_59;
  tmpvar_59.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_59.w = 1.0;
  mat3 tmpvar_67;
  tmpvar_67[0] = _Object2World[0].xyz;
  tmpvar_67[1] = _Object2World[1].xyz;
  tmpvar_67[2] = _Object2World[2].xyz;
  vec3 tmpvar_71;
  tmpvar_71 = (tmpvar_67 * -((((_World2Object * tmpvar_59).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_73;
  tmpvar_73 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_74;
  tmpvar_74[0].x = tmpvar_3.x;
  tmpvar_74[0].y = tmpvar_73.x;
  tmpvar_74[0].z = tmpvar_5.x;
  tmpvar_74[1].x = tmpvar_3.y;
  tmpvar_74[1].y = tmpvar_73.y;
  tmpvar_74[1].z = tmpvar_5.y;
  tmpvar_74[2].x = tmpvar_3.z;
  tmpvar_74[2].y = tmpvar_73.z;
  tmpvar_74[2].z = tmpvar_5.z;
  vec4 tmpvar_85;
  tmpvar_85.xyz = (tmpvar_74 * _Object2World[0].xyz).xyz;
  tmpvar_85.w = tmpvar_71.x;
  vec4 tmpvar_87;
  tmpvar_87.xyz = (tmpvar_74 * _Object2World[1].xyz).xyz;
  tmpvar_87.w = tmpvar_71.y;
  vec4 tmpvar_89;
  tmpvar_89.xyz = (tmpvar_74 * _Object2World[2].xyz).xyz;
  tmpvar_89.w = tmpvar_71.z;
  vec4 o_i0;
  vec4 tmpvar_93;
  tmpvar_93 = (tmpvar_55 * 0.5);
  o_i0 = tmpvar_93;
  vec2 tmpvar_94;
  tmpvar_94.x = tmpvar_93.x;
  tmpvar_94.y = (vec2((tmpvar_93.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_94 + tmpvar_93.w);
  o_i0.zw = tmpvar_55.zw;
  vec4 tmpvar_104;
  tmpvar_104.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_104.w = 1.0;
  gl_Position = tmpvar_55.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_85 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_87 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_89 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_74 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_74 * (((_World2Object * tmpvar_104).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
  vec4 tmpvar_31;
  tmpvar_31.xyz = (_LightMatrix0 * (_Object2World * tmpvar_1)).xyz;
  tmpvar_31.w = 0.0;
  gl_TexCoord[7] = tmpvar_31;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec3 tmpvar_16;
  tmpvar_16 = gl_TexCoord[7].xyz;
  vec4 c;
  vec2 tmpvar_117;
  tmpvar_117 = gl_TexCoord[0].xy;
  vec3 tmpvar_118;
  tmpvar_118.x = tmpvar_6.w;
  tmpvar_118.y = tmpvar_8.w;
  tmpvar_118.z = tmpvar_10.w;
  vec4 tmpvar_257;
  tmpvar_257 = tmpvar_4;
  float tmpvar_139;
  tmpvar_139 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_117).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_117 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_161;
  tmpvar_161 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_257.xy = (((((tmpvar_161 * _Refraction) * tmpvar_139).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_165;
  tmpvar_165.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_165.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_165.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_167;
  tmpvar_167.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_167.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_167.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_169;
  tmpvar_169.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_169.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_169.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_171;
  tmpvar_171.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_161 * tmpvar_165)))).x;
  tmpvar_171.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_161 * tmpvar_167)))).y;
  tmpvar_171.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_161 * tmpvar_169)))).z;
  vec3 tmpvar_172;
  tmpvar_172 = reflect (tmpvar_118, tmpvar_171);
  float tmpvar_183;
  tmpvar_183 = clamp (tmpvar_139, 0.0, 1.0);
  vec3 tmpvar_198;
  tmpvar_198 = normalize (gl_TexCoord[5].xyz);
  float atten;
  atten = (texture2D (_LightTextureB0, vec2(dot (tmpvar_16, tmpvar_16))).w * textureCube (_LightTexture0, tmpvar_16).w);
  vec4 c_i0_i1;
  float tmpvar_218;
  tmpvar_218 = pow (max (0.0, dot (tmpvar_161, normalize ((tmpvar_198 + normalize (gl_TexCoord[6].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = (((((_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_172).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_257).xyz, vec3(clamp (pow (abs (dot (tmpvar_161, normalize (tmpvar_172))), _ReflToRefrExponent), 0.1, 0.9)))) * _LightColor0.xyz) * max (0.0, dot (tmpvar_161, tmpvar_198))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_218)) * (atten * 2.0)).xyz;
  c_i0_i1.w = (vec4((tmpvar_183 + (((_LightColor0.w * _SpecColor.w) * tmpvar_218) * atten)))).w;
  c = c_i0_i1;
  c.w = (vec4(tmpvar_183)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 52 ALU
PARAM c[22] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.w, c[0].y;
MOV R1.xyz, c[19];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[18].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[20];
MUL R1.xyz, vertex.attrib[14].w, R1;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
DP3 R0.y, R1, c[5];
DP3 result.texcoord[5].y, R1, R3;
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[18].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[18].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R4.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 R1.x, vertex.attrib[14], c[7];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[18].w;
MUL R1.y, R4, c[17].x;
MOV R1.x, R4;
ADD result.texcoord[1].xy, R1, R4.z;
DP3 result.texcoord[5].z, vertex.normal, R3;
DP3 result.texcoord[5].x, vertex.attrib[14], R3;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
DP4 result.texcoord[7].y, R0, c[14];
DP4 result.texcoord[7].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 52 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 55 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c22, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.y
mov r0.xyz, c19
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r1, c8
dp4 r4.x, c20, r1
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
dp3 r0.y, r2, c4
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c18.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c18.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c18.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp3 o6.y, r2, r4
dp3 o7.y, r2, r3
mul r2.xyz, r1.xyww, c22.x
mul r0.y, r2, c16.x
mov r0.x, r2
mad o2.xy, r2.z, c17.zwzw, r0
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o0, r1
mov o2.zw, r1
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
mad o1.xy, v3, c21, c21.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES

#ifdef VERTEX
attribute vec4 TANGENT;
uniform vec4 unity_Scale;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
uniform mat4 _World2Object;
uniform vec4 _ProjectionParams;
uniform mat4 _Object2World;
uniform mat4 _LightMatrix0;
uniform vec4 _BumpMap_ST;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyzw;
  vec4 tmpvar_3;
  tmpvar_3 = TANGENT.xyzw;
  vec3 tmpvar_5;
  tmpvar_5 = gl_Normal.xyz;
  vec4 tmpvar_55;
  tmpvar_55 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 tmpvar_59;
  tmpvar_59.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_59.w = 1.0;
  mat3 tmpvar_67;
  tmpvar_67[0] = _Object2World[0].xyz;
  tmpvar_67[1] = _Object2World[1].xyz;
  tmpvar_67[2] = _Object2World[2].xyz;
  vec3 tmpvar_71;
  tmpvar_71 = (tmpvar_67 * -((((_World2Object * tmpvar_59).xyz * unity_Scale.w) - tmpvar_1.xyz)));
  vec3 tmpvar_73;
  tmpvar_73 = (cross (tmpvar_5, tmpvar_3.xyz) * tmpvar_3.w);
  mat3 tmpvar_74;
  tmpvar_74[0].x = tmpvar_3.x;
  tmpvar_74[0].y = tmpvar_73.x;
  tmpvar_74[0].z = tmpvar_5.x;
  tmpvar_74[1].x = tmpvar_3.y;
  tmpvar_74[1].y = tmpvar_73.y;
  tmpvar_74[1].z = tmpvar_5.y;
  tmpvar_74[2].x = tmpvar_3.z;
  tmpvar_74[2].y = tmpvar_73.z;
  tmpvar_74[2].z = tmpvar_5.z;
  vec4 tmpvar_85;
  tmpvar_85.xyz = (tmpvar_74 * _Object2World[0].xyz).xyz;
  tmpvar_85.w = tmpvar_71.x;
  vec4 tmpvar_87;
  tmpvar_87.xyz = (tmpvar_74 * _Object2World[1].xyz).xyz;
  tmpvar_87.w = tmpvar_71.y;
  vec4 tmpvar_89;
  tmpvar_89.xyz = (tmpvar_74 * _Object2World[2].xyz).xyz;
  tmpvar_89.w = tmpvar_71.z;
  vec4 o_i0;
  vec4 tmpvar_93;
  tmpvar_93 = (tmpvar_55 * 0.5);
  o_i0 = tmpvar_93;
  vec2 tmpvar_94;
  tmpvar_94.x = tmpvar_93.x;
  tmpvar_94.y = (vec2((tmpvar_93.y * _ProjectionParams.x))).y;
  o_i0.xy = (tmpvar_94 + tmpvar_93.w);
  o_i0.zw = tmpvar_55.zw;
  vec4 tmpvar_104;
  tmpvar_104.xyz = _WorldSpaceCameraPos.xyz;
  tmpvar_104.w = 1.0;
  gl_Position = tmpvar_55.xyzw;
  vec4 tmpvar_17;
  tmpvar_17.xy = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw).xy;
  tmpvar_17.z = 0.0;
  tmpvar_17.w = 0.0;
  gl_TexCoord[0] = tmpvar_17;
  gl_TexCoord[1] = o_i0.xyzw;
  gl_TexCoord[2] = (tmpvar_85 * unity_Scale.w).xyzw;
  gl_TexCoord[3] = (tmpvar_87 * unity_Scale.w).xyzw;
  gl_TexCoord[4] = (tmpvar_89 * unity_Scale.w).xyzw;
  vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_74 * (_World2Object * _WorldSpaceLightPos0).xyz).xyz;
  tmpvar_27.w = 0.0;
  gl_TexCoord[5] = tmpvar_27;
  vec4 tmpvar_29;
  tmpvar_29.xyz = (tmpvar_74 * (((_World2Object * tmpvar_104).xyz * unity_Scale.w) - tmpvar_1.xyz)).xyz;
  tmpvar_29.w = 0.0;
  gl_TexCoord[6] = tmpvar_29;
  vec4 tmpvar_31;
  tmpvar_31.xy = (_LightMatrix0 * (_Object2World * tmpvar_1)).xy;
  tmpvar_31.z = 0.0;
  tmpvar_31.w = 0.0;
  gl_TexCoord[7] = tmpvar_31;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 _Time;
uniform vec4 _SpecColor;
uniform float _Shininess;
uniform float _Refraction;
uniform samplerCube _ReflectionTex;
uniform vec4 _ReflectColor;
uniform float _ReflToRefrExponent;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform vec4 _GrabTexture_TexelSize;
uniform sampler2D _GrabTexture;
uniform vec4 _Color;
uniform sampler2D _CameraDepthTexture;
uniform float _BumpReflectionStr;
uniform sampler2D _BumpMap;
void main ()
{
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[1].xyzw;
  vec4 tmpvar_6;
  tmpvar_6 = gl_TexCoord[2].xyzw;
  vec4 tmpvar_8;
  tmpvar_8 = gl_TexCoord[3].xyzw;
  vec4 tmpvar_10;
  tmpvar_10 = gl_TexCoord[4].xyzw;
  vec3 tmpvar_12;
  tmpvar_12 = gl_TexCoord[5].xyz;
  vec4 c;
  vec2 tmpvar_117;
  tmpvar_117 = gl_TexCoord[0].xy;
  vec3 tmpvar_118;
  tmpvar_118.x = tmpvar_6.w;
  tmpvar_118.y = tmpvar_8.w;
  tmpvar_118.z = tmpvar_10.w;
  vec4 tmpvar_251;
  tmpvar_251 = tmpvar_4;
  float tmpvar_139;
  tmpvar_139 = clamp ((0.125 * abs ((tmpvar_4.z - 1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_4).x) + _ZBufferParams.w))))), 0.0, 1.0);
  vec4 normal;
  normal.xy = ((texture2D (_BumpMap, tmpvar_117).wy * 2.0) - 1.0);
  normal.z = (vec3(sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y))))).z;
  vec4 normal_i0;
  normal_i0.xy = ((texture2D (_BumpMap, (tmpvar_117 - ((5.0 * _Time.y) * _GrabTexture_TexelSize.xy))).wy * 2.0) - 1.0);
  normal_i0.z = (vec3(sqrt (((1.0 - (normal_i0.x * normal_i0.x)) - (normal_i0.y * normal_i0.y))))).z;
  vec3 tmpvar_161;
  tmpvar_161 = ((normal.xyz + normal_i0.xyz) * 0.5);
  tmpvar_251.xy = (((((tmpvar_161 * _Refraction) * tmpvar_139).xy * _GrabTexture_TexelSize.xy) * tmpvar_4.z) + tmpvar_4.xy);
  vec3 tmpvar_165;
  tmpvar_165.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_165.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_165.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_167;
  tmpvar_167.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_167.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_167.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_169;
  tmpvar_169.x = (vec3(_BumpReflectionStr)).x;
  tmpvar_169.y = (vec3(_BumpReflectionStr)).y;
  tmpvar_169.z = (vec3(_BumpReflectionStr)).z;
  vec3 tmpvar_171;
  tmpvar_171.x = (vec3(dot (tmpvar_6.xyz, (tmpvar_161 * tmpvar_165)))).x;
  tmpvar_171.y = (vec3(dot (tmpvar_8.xyz, (tmpvar_161 * tmpvar_167)))).y;
  tmpvar_171.z = (vec3(dot (tmpvar_10.xyz, (tmpvar_161 * tmpvar_169)))).z;
  vec3 tmpvar_172;
  tmpvar_172 = reflect (tmpvar_118, tmpvar_171);
  float tmpvar_183;
  tmpvar_183 = clamp (tmpvar_139, 0.0, 1.0);
  float atten;
  atten = texture2D (_LightTexture0, gl_TexCoord[7].xy).w;
  vec4 c_i0_i1;
  float tmpvar_212;
  tmpvar_212 = pow (max (0.0, dot (tmpvar_161, normalize ((tmpvar_12 + normalize (gl_TexCoord[6].xyz))))), (_Shininess * 128.0));
  c_i0_i1.xyz = (((((_Color.xyz * mix ((textureCube (_ReflectionTex, tmpvar_172).xyz * _ReflectColor.xyz), texture2DProj (_GrabTexture, tmpvar_251).xyz, vec3(clamp (pow (abs (dot (tmpvar_161, normalize (tmpvar_172))), _ReflToRefrExponent), 0.1, 0.9)))) * _LightColor0.xyz) * max (0.0, dot (tmpvar_161, tmpvar_12))) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_212)) * (atten * 2.0)).xyz;
  c_i0_i1.w = (vec4((tmpvar_183 + (((_LightColor0.w * _SpecColor.w) * tmpvar_212) * atten)))).w;
  c = c_i0_i1;
  c.w = (vec4(tmpvar_183)).w;
  gl_FragData[0] = c.xyzw;
}


#endif
"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 75 to 86, TEX: 5 to 7
//   d3d9 - ALU: 75 to 85, TEX: 5 to 7
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 80 ALU, 6 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[14] = { program.local[0..10],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.xy, c[10];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[11].y, -c[11].z;
MAD R1.xy, R1.wyzw, c[11].y, -c[11].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[11].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[11];
RSQ R0.z, R0.z;
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R0, c[12].x;
MUL R2.xyz, R1, c[8].x;
DP3 R0.x, fragment.texcoord[2], R2;
DP3 R0.y, R2, fragment.texcoord[3];
DP3 R0.z, R2, fragment.texcoord[4];
MOV R2.x, fragment.texcoord[2].w;
MOV R2.z, fragment.texcoord[4].w;
MOV R2.y, fragment.texcoord[3].w;
DP3 R0.w, R0, R2;
MUL R0.xyz, R0, R0.w;
MAD R2.xyz, -R0, c[11].y, R2;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R2;
DP3 R0.y, R1, R0;
TXP R0.x, fragment.texcoord[1], texture[1], SHADOW2D;
ABS R0.y, R0;
MAD R0.x, R0, c[1].z, c[1].w;
POW R0.y, R0.y, c[9].x;
MIN R0.y, R0, c[12];
RCP R0.x, R0.x;
ADD R0.x, fragment.texcoord[1].z, -R0;
ABS R0.x, R0;
MUL_SAT R1.w, R0.x, c[11].x;
MAX R0.w, R0.y, c[12].z;
TEX R0.xyz, R2, texture[3], CUBE;
MUL R3.xy, R1, c[7].x;
MUL R3.xy, R1.w, R3;
MUL R2.xy, R3, c[10];
MOV R2.zw, fragment.texcoord[1];
MAD R2.xy, fragment.texcoord[1].z, R2, fragment.texcoord[1];
TXP R2.xyz, R2, texture[0], SHADOW2D;
MAD R2.xyz, -R0, c[5], R2;
DP3 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R2.w, R2.w;
MUL R0.xyz, R0, c[5];
MAD R0.xyz, R0.w, R2, R0;
MUL R0.xyz, R0, c[4];
MUL R3.xyz, R2.w, fragment.texcoord[5];
DP3 R3.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R2.w, R3.w;
MAD R4.xyz, R2.w, fragment.texcoord[6], R3;
DP3 R2.w, R4, R4;
RSQ R0.w, R2.w;
MUL R2.xyz, R0.w, R4;
DP3 R2.x, R1, R2;
MAX R2.w, R2.x, c[12];
MOV R0.w, c[13].x;
MUL R0.w, R0, c[6].x;
MOV R2.xyz, c[3];
DP3 R1.x, R1, R3;
POW R0.w, R2.w, R0.w;
MUL R2.xyz, R2, c[2];
MUL R2.xyz, R2, R0.w;
DP3 R0.w, fragment.texcoord[7], fragment.texcoord[7];
TEX R0.w, R0.w, texture[4], 2D;
MUL R0.xyz, R0, c[2];
MAX R1.x, R1, c[12].w;
MUL R0.w, R0, c[11].y;
MAD R0.xyz, R0, R1.x, R2;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, R1;
END
# 80 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 80 ALU, 6 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
dcl_2d s4
def c11, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c12, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c13, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7.xyz
mov r0.x, c0.y
mul r0.xy, c10, r0.x
mad r0.xy, -r0, c12.x, v0
texld r1.yw, r0, s2
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c11.y, c11.z
mad_pp r1.xy, r1.wyzw, c11.y, c11.z
mul_pp r0.w, r1.y, r1.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.w, -r1.x, r1.x, -r0
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.w, r0, c11
rsq_pp r0.w, r0.w
add_pp r0.z, r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r1.z, r0.w
rcp_pp r0.z, r0.z
add_pp r0.xyz, r0, r1
mul_pp r1.xyz, r0, c12.y
mul_pp r2.xyz, r1, c8.x
dp3_pp r0.x, v2, r2
dp3_pp r0.y, r2, v3
dp3_pp r0.z, r2, v4
mov r2.x, v2.w
mov r2.z, v4.w
mov r2.y, v3.w
dp3 r0.w, r0, r2
mul r0.xyz, r0, r0.w
mad r2.xyz, -r0, c11.y, r2
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul r0.xyz, r0.x, r2
dp3_pp r0.x, r1, r0
abs_pp r1.w, r0.x
pow r0, r1.w, c9.x
texldp r3.x, v1, s1
mad r0.y, r3.x, c1.z, c1.w
mov r0.z, r0.x
rcp r0.x, r0.y
min r0.y, r0.z, c12.z
add r0.x, v1.z, -r0
abs r0.x, r0
mul_sat r1.w, r0.x, c11.x
max r2.w, r0.y, c12
mul r0.zw, r1.xyxy, c7.x
mul r0.xy, r1.w, r0.zwzw
mul r0.xy, r0, c10
texld r3.xyz, r2, s3
mov r0.zw, v1
mad r0.xy, v1.z, r0, v1
texldp r0.xyz, r0, s0
mad r4.xyz, -r3, c5, r0
dp3_pp r0.w, v5, v5
rsq_pp r0.x, r0.w
mul r3.xyz, r3, c5
mad r3.xyz, r2.w, r4, r3
mul r3.xyz, r3, c4
mul_pp r2.xyz, r0.x, v5
dp3_pp r0.y, v6, v6
rsq_pp r0.x, r0.y
mad_pp r0.xyz, r0.x, v6, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c6.x
dp3_pp r0.x, r1, r0
mov r4.xyz, c2
mul_pp r3.w, c13.y, r0
max_pp r2.w, r0.x, c13.x
pow r0, r2.w, r3.w
mov r0.w, r0.x
mul r0.xyz, c3, r4
mul r4.xyz, r0, r0.w
dp3 r0.x, v7, v7
texld r0.x, r0.x, s4
dp3_pp r0.y, r1, r2
mul_pp r0.w, r0.x, c11.y
mul r3.xyz, r3, c2
max_pp r0.y, r0, c13.x
mad r0.xyz, r3, r0.y, r4
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r1
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 75 ALU, 5 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[14] = { program.local[0..10],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xy, c[10];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[11].y, -c[11].z;
MAD R1.xy, R1.wyzw, c[11].y, -c[11].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[11].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[11];
RSQ R0.z, R0.z;
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R0.xyz, R0, c[12].x;
MUL R1.xyz, R0, c[8].x;
DP3 R2.x, fragment.texcoord[2], R1;
DP3 R2.y, R1, fragment.texcoord[3];
DP3 R2.z, R1, fragment.texcoord[4];
MOV R1.x, fragment.texcoord[2].w;
MOV R1.z, fragment.texcoord[4].w;
MOV R1.y, fragment.texcoord[3].w;
DP3 R0.w, R2, R1;
MUL R2.xyz, R2, R0.w;
MAD R2.xyz, -R2, c[11].y, R1;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R2;
DP3 R1.x, R0, R1;
TXP R3.x, fragment.texcoord[1], texture[1], SHADOW2D;
MAD R0.w, R3.x, c[1].z, c[1];
ABS R1.x, R1;
POW R1.x, R1.x, c[9].x;
MIN R1.z, R1.x, c[12].y;
MAX R2.w, R1.z, c[12].z;
RCP R0.w, R0.w;
ADD R0.w, fragment.texcoord[1].z, -R0;
ABS R0.w, R0;
MUL_SAT R0.w, R0, c[11].x;
MUL R1.xy, R0, c[7].x;
MUL R1.xy, R0.w, R1;
MUL R1.xy, R1, c[10];
MOV R1.zw, fragment.texcoord[1];
MAD R1.xy, fragment.texcoord[1].z, R1, fragment.texcoord[1];
TXP R1.xyz, R1, texture[0], SHADOW2D;
TEX R2.xyz, R2, texture[3], CUBE;
MAD R1.xyz, -R2, c[5], R1;
MUL R2.xyz, R2, c[5];
MAD R1.xyz, R2.w, R1, R2;
DP3 R1.w, fragment.texcoord[6], fragment.texcoord[6];
MUL R1.xyz, R1, c[4];
RSQ R1.w, R1.w;
MOV R3.xyz, fragment.texcoord[5];
MAD R3.xyz, R1.w, fragment.texcoord[6], R3;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R3;
DP3 R2.x, R0, R2;
MOV R1.w, c[13].x;
MUL R2.y, R1.w, c[6].x;
MAX R1.w, R2.x, c[12];
POW R2.w, R1.w, R2.y;
DP3 R1.w, R0, fragment.texcoord[5];
MOV R2.xyz, c[3];
MUL R0.xyz, R2, c[2];
MUL R1.xyz, R1, c[2];
MUL R0.xyz, R0, R2.w;
MAX R1.w, R1, c[12];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, c[11].y;
MOV result.color.w, R0;
END
# 75 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
"ps_3_0
; 75 ALU, 5 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
def c11, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c12, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c13, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
mov r0.x, c0.y
mul r0.xy, c10, r0.x
mad r0.xy, -r0, c12.x, v0
texld r1.yw, r0, s2
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c11.y, c11.z
mad_pp r1.xy, r1.wyzw, c11.y, c11.z
mul_pp r0.w, r1.y, r1.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.w, -r1.x, r1.x, -r0
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.w, r0, c11
rsq_pp r0.w, r0.w
add_pp r0.z, r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r1.z, r0.w
rcp_pp r0.z, r0.z
add_pp r0.xyz, r0, r1
mul_pp r2.xyz, r0, c12.y
mul_pp r0.xyz, r2, c8.x
dp3_pp r1.x, v2, r0
dp3_pp r1.y, r0, v3
dp3_pp r1.z, r0, v4
mov r0.x, v2.w
mov r0.z, v4.w
mov r0.y, v3.w
dp3 r0.w, r1, r0
mul r1.xyz, r1, r0.w
mad r0.xyz, -r1, c11.y, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3_pp r0.w, r2, r1
abs_pp r0.w, r0
pow r1, r0.w, c9.x
texldp r3.x, v1, s1
mad r0.w, r3.x, c1.z, c1
min r1.x, r1, c12.z
max r2.w, r1.x, c12
rcp r0.w, r0.w
add r0.w, v1.z, -r0
abs r0.w, r0
mul_sat r0.w, r0, c11.x
mul r1.xy, r2, c7.x
mul r1.xy, r0.w, r1
mul r1.xy, r1, c10
texld r0.xyz, r0, s3
mov r1.zw, v1
mad r1.xy, v1.z, r1, v1
texldp r1.xyz, r1, s0
mad r1.xyz, -r0, c5, r1
dp3_pp r1.w, v6, v6
mul r0.xyz, r0, c5
mad r0.xyz, r2.w, r1, r0
mul r0.xyz, r0, c4
rsq_pp r1.w, r1.w
mov_pp r3.xyz, v5
mad_pp r3.xyz, r1.w, v6, r3
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r1.xyz, r1.w, r3
mov_pp r1.w, c6.x
dp3_pp r1.x, r2, r1
max_pp r2.w, r1.x, c13.x
mul_pp r3.x, c13.y, r1.w
pow r1, r2.w, r3.x
mov r2.w, r1.x
mov r1.xyz, c2
dp3_pp r1.w, r2, v5
mul r1.xyz, c3, r1
mul r0.xyz, r0, c2
mul r1.xyz, r1, r2.w
max_pp r1.w, r1, c13.x
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, c11.y
mov_pp oC0.w, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 86 ALU, 7 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[14] = { program.local[0..10],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.xy, c[10];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
MAD R1.xy, R1.wyzw, c[11].y, -c[11].z;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[11].y, -c[11].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[11].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[11];
RSQ R0.z, R0.z;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R0, c[12].x;
MUL R2.xyz, R1, c[8].x;
DP3 R0.x, fragment.texcoord[2], R2;
DP3 R0.y, R2, fragment.texcoord[3];
DP3 R0.z, R2, fragment.texcoord[4];
MUL R3.xy, R1, c[7].x;
MOV R3.zw, fragment.texcoord[1];
MOV R2.x, fragment.texcoord[2].w;
MOV R2.z, fragment.texcoord[4].w;
MOV R2.y, fragment.texcoord[3].w;
DP3 R0.w, R0, R2;
MUL R0.xyz, R0, R0.w;
MAD R2.xyz, -R0, c[11].y, R2;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R2;
DP3 R0.y, R1, R0;
TXP R0.x, fragment.texcoord[1], texture[1], SHADOW2D;
ABS R0.y, R0;
MAD R0.x, R0, c[1].z, c[1].w;
POW R0.y, R0.y, c[9].x;
MIN R0.y, R0, c[12];
RCP R0.x, R0.x;
ADD R0.x, fragment.texcoord[1].z, -R0;
ABS R0.x, R0;
MUL_SAT R2.w, R0.x, c[11].x;
MAX R0.w, R0.y, c[12].z;
TEX R0.xyz, R2, texture[3], CUBE;
MUL R3.xy, R2.w, R3;
MUL R2.xy, R3, c[10];
MAD R3.xy, fragment.texcoord[1].z, R2, fragment.texcoord[1];
TXP R2.xyz, R3, texture[0], SHADOW2D;
MAD R2.xyz, -R0, c[5], R2;
RSQ R1.w, R1.w;
MUL R0.xyz, R0, c[5];
MAD R0.xyz, R0.w, R2, R0;
MUL R0.xyz, R0, c[4];
MUL R3.xyz, R1.w, fragment.texcoord[5];
DP3 R3.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R1.w, R3.w;
MAD R4.xyz, R1.w, fragment.texcoord[6], R3;
DP3 R1.w, R4, R4;
RSQ R0.w, R1.w;
MUL R2.xyz, R0.w, R4;
DP3 R1.w, R1, R2;
DP3 R1.x, R1, R3;
MOV R0.w, c[13].x;
MOV R2.xyz, c[3];
MAX R1.w, R1, c[12];
MUL R0.w, R0, c[6].x;
POW R0.w, R1.w, R0.w;
MUL R2.xyz, R2, c[2];
MUL R2.xyz, R2, R0.w;
RCP R0.w, fragment.texcoord[7].w;
MAD R1.zw, fragment.texcoord[7].xyxy, R0.w, c[12].x;
DP3 R1.y, fragment.texcoord[7], fragment.texcoord[7];
TEX R0.w, R1.zwzw, texture[4], 2D;
TEX R1.w, R1.y, texture[5], 2D;
SLT R1.y, c[12].w, fragment.texcoord[7].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[12];
MUL R0.xyz, R0, c[2];
MUL R1.x, R1.y, c[11].y;
MAD R0.xyz, R0, R0.w, R2;
MUL result.color.xyz, R0, R1.x;
MOV result.color.w, R2;
END
# 86 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"ps_3_0
; 85 ALU, 7 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
dcl_2d s4
dcl_2d s5
def c11, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c12, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c13, 0.00000000, 128.00000000, 1.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7
mov r0.x, c0.y
mul r0.xy, c10, r0.x
mad r0.xy, -r0, c12.x, v0
texld r1.yw, r0, s2
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c11.y, c11.z
mad_pp r1.xy, r1.wyzw, c11.y, c11.z
mul_pp r0.w, r1.y, r1.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.w, -r1.x, r1.x, -r0
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.w, r0, c11
rsq_pp r0.w, r0.w
add_pp r0.z, r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r1.z, r0.w
rcp_pp r0.z, r0.z
add_pp r0.xyz, r0, r1
mul_pp r1.xyz, r0, c12.y
mul_pp r2.xyz, r1, c8.x
dp3_pp r0.x, v2, r2
dp3_pp r0.y, r2, v3
dp3_pp r0.z, r2, v4
mov r2.x, v2.w
mov r2.z, v4.w
mov r2.y, v3.w
dp3 r0.w, r0, r2
mul r0.xyz, r0, r0.w
mad r2.xyz, -r0, c11.y, r2
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul r0.xyz, r0.x, r2
dp3_pp r0.x, r1, r0
abs_pp r1.w, r0.x
pow r0, r1.w, c9.x
texldp r3.x, v1, s1
mad r0.y, r3.x, c1.z, c1.w
mov r0.z, r0.x
rcp r0.x, r0.y
min r0.y, r0.z, c12.z
add r0.x, v1.z, -r0
abs r0.x, r0
mul_sat r1.w, r0.x, c11.x
max r2.w, r0.y, c12
mul r0.zw, r1.xyxy, c7.x
mul r0.xy, r1.w, r0.zwzw
mul r0.xy, r0, c10
texld r2.xyz, r2, s3
mov r0.zw, v1
mad r0.xy, v1.z, r0, v1
texldp r0.xyz, r0, s0
mad r4.xyz, -r2, c5, r0
dp3_pp r0.w, v5, v5
rsq_pp r0.x, r0.w
mul r2.xyz, r2, c5
mad r2.xyz, r2.w, r4, r2
mul r2.xyz, r2, c4
mul_pp r3.xyz, r0.x, v5
dp3_pp r0.y, v6, v6
rsq_pp r0.x, r0.y
mad_pp r0.xyz, r0.x, v6, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.x, r1, r0
mov_pp r0.w, c6.x
mov r4.xyz, c2
mul_pp r3.w, c13.y, r0
max_pp r2.w, r0.x, c13.x
pow r0, r2.w, r3.w
mov r0.w, r0.x
mul r0.xyz, c3, r4
mul r4.xyz, r0, r0.w
dp3_pp r0.y, r1, r3
rcp r0.x, v7.w
mad r1.xy, v7, r0.x, c12.y
dp3 r0.x, v7, v7
texld r0.w, r1, s4
cmp r0.z, -v7, c13.x, c13
mul r0.z, r0, r0.w
texld r0.x, r0.x, s5
mul r0.z, r0, r0.x
mul_pp r0.w, r0.z, c11.y
mul r2.xyz, r2, c2
max_pp r0.x, r0.y, c13
mad r0.xyz, r2, r0.x, r4
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r1
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 82 ALU, 7 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[14] = { program.local[0..10],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.xy, c[10];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
MAD R1.xy, R1.wyzw, c[11].y, -c[11].z;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[11].y, -c[11].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[11].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[11];
RSQ R0.z, R0.z;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R0, c[12].x;
MUL R2.xyz, R1, c[8].x;
DP3 R0.x, fragment.texcoord[2], R2;
DP3 R0.y, R2, fragment.texcoord[3];
DP3 R0.z, R2, fragment.texcoord[4];
MUL R3.xy, R1, c[7].x;
MOV R3.zw, fragment.texcoord[1];
MOV R2.x, fragment.texcoord[2].w;
MOV R2.z, fragment.texcoord[4].w;
MOV R2.y, fragment.texcoord[3].w;
DP3 R0.w, R0, R2;
MUL R0.xyz, R0, R0.w;
MAD R2.xyz, -R0, c[11].y, R2;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R2;
DP3 R0.y, R1, R0;
TXP R0.x, fragment.texcoord[1], texture[1], SHADOW2D;
ABS R0.y, R0;
MAD R0.x, R0, c[1].z, c[1].w;
POW R0.y, R0.y, c[9].x;
MIN R0.y, R0, c[12];
RCP R0.x, R0.x;
ADD R0.x, fragment.texcoord[1].z, -R0;
ABS R0.x, R0;
MUL_SAT R2.w, R0.x, c[11].x;
MAX R0.w, R0.y, c[12].z;
TEX R0.xyz, R2, texture[3], CUBE;
MUL R3.xy, R2.w, R3;
MUL R2.xy, R3, c[10];
MAD R3.xy, fragment.texcoord[1].z, R2, fragment.texcoord[1];
TXP R2.xyz, R3, texture[0], SHADOW2D;
MAD R2.xyz, -R0, c[5], R2;
RSQ R1.w, R1.w;
MUL R0.xyz, R0, c[5];
MAD R0.xyz, R0.w, R2, R0;
MUL R0.xyz, R0, c[4];
MUL R3.xyz, R1.w, fragment.texcoord[5];
DP3 R3.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R1.w, R3.w;
MAD R4.xyz, R1.w, fragment.texcoord[6], R3;
DP3 R1.w, R4, R4;
RSQ R0.w, R1.w;
MUL R2.xyz, R0.w, R4;
DP3 R1.w, R1, R2;
DP3 R1.x, R1, R3;
MOV R0.w, c[13].x;
MOV R2.xyz, c[3];
MAX R1.w, R1, c[12];
MUL R0.w, R0, c[6].x;
POW R0.w, R1.w, R0.w;
DP3 R1.y, fragment.texcoord[7], fragment.texcoord[7];
MUL R2.xyz, R2, c[2];
MUL R2.xyz, R2, R0.w;
TEX R0.w, fragment.texcoord[7], texture[5], CUBE;
TEX R1.w, R1.y, texture[4], 2D;
MUL R1.y, R1.w, R0.w;
MAX R0.w, R1.x, c[12];
MUL R0.xyz, R0, c[2];
MUL R1.x, R1.y, c[11].y;
MAD R0.xyz, R0, R0.w, R2;
MUL result.color.xyz, R0, R1.x;
MOV result.color.w, R2;
END
# 82 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 81 ALU, 7 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
dcl_2d s4
dcl_cube s5
def c11, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c12, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c13, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7.xyz
mov r0.x, c0.y
mul r0.xy, c10, r0.x
mad r0.xy, -r0, c12.x, v0
texld r1.yw, r0, s2
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c11.y, c11.z
mad_pp r1.xy, r1.wyzw, c11.y, c11.z
mul_pp r0.w, r1.y, r1.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.w, -r1.x, r1.x, -r0
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.w, r0, c11
rsq_pp r0.w, r0.w
add_pp r0.z, r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r1.z, r0.w
rcp_pp r0.z, r0.z
add_pp r0.xyz, r0, r1
mul_pp r1.xyz, r0, c12.y
mul_pp r2.xyz, r1, c8.x
dp3_pp r0.x, v2, r2
dp3_pp r0.y, r2, v3
dp3_pp r0.z, r2, v4
mov r2.x, v2.w
mov r2.z, v4.w
mov r2.y, v3.w
dp3 r0.w, r0, r2
mul r0.xyz, r0, r0.w
mad r2.xyz, -r0, c11.y, r2
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul r0.xyz, r0.x, r2
dp3_pp r0.x, r1, r0
abs_pp r1.w, r0.x
pow r0, r1.w, c9.x
texldp r3.x, v1, s1
mad r0.y, r3.x, c1.z, c1.w
mov r0.z, r0.x
rcp r0.x, r0.y
min r0.y, r0.z, c12.z
add r0.x, v1.z, -r0
abs r0.x, r0
mul_sat r1.w, r0.x, c11.x
max r2.w, r0.y, c12
mul r0.zw, r1.xyxy, c7.x
mul r0.xy, r1.w, r0.zwzw
mul r0.xy, r0, c10
texld r2.xyz, r2, s3
mov r0.zw, v1
mad r0.xy, v1.z, r0, v1
texldp r0.xyz, r0, s0
mad r4.xyz, -r2, c5, r0
dp3_pp r0.w, v5, v5
rsq_pp r0.x, r0.w
mul r2.xyz, r2, c5
mad r2.xyz, r2.w, r4, r2
mul r2.xyz, r2, c4
mul_pp r3.xyz, r0.x, v5
dp3_pp r0.y, v6, v6
rsq_pp r0.x, r0.y
mad_pp r0.xyz, r0.x, v6, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c6.x
dp3_pp r0.x, r1, r0
mov r4.xyz, c2
mul_pp r3.w, c13.y, r0
max_pp r2.w, r0.x, c13.x
pow r0, r2.w, r3.w
mov r0.w, r0.x
mul r0.xyz, c3, r4
mul r4.xyz, r0, r0.w
dp3 r0.x, v7, v7
dp3_pp r0.y, r1, r3
texld r0.w, v7, s5
texld r0.x, r0.x, s4
mul r0.z, r0.x, r0.w
mul_pp r0.w, r0.z, c11.y
mul r2.xyz, r2, c2
max_pp r0.x, r0.y, c13
mad r0.xyz, r2, r0.x, r4
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r1
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 77 ALU, 6 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[14] = { program.local[0..10],
		{ 0.125, 2, 1, 5 },
		{ 0.5, 0.89999998, 0.1, 0 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xy, c[10];
MUL R0.xy, R0, c[0].y;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R1.yw, R0, texture[2], 2D;
TEX R0.yw, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[11].y, -c[11].z;
MAD R1.xy, R1.wyzw, c[11].y, -c[11].z;
MUL R0.w, R1.y, R1.y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.w, R0, c[11].z;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[11];
RSQ R0.z, R0.z;
RCP R1.z, R0.w;
RCP R0.z, R0.z;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R0, c[12].x;
MUL R0.xyz, R1, c[8].x;
DP3 R2.x, fragment.texcoord[2], R0;
DP3 R2.y, R0, fragment.texcoord[3];
DP3 R2.z, R0, fragment.texcoord[4];
MOV R0.x, fragment.texcoord[2].w;
MOV R0.z, fragment.texcoord[4].w;
MOV R0.y, fragment.texcoord[3].w;
DP3 R0.w, R2, R0;
MUL R2.xyz, R2, R0.w;
MAD R3.xyz, -R2, c[11].y, R0;
DP3 R0.x, R3, R3;
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, R3;
DP3 R0.y, R1, R2;
TXP R0.x, fragment.texcoord[1], texture[1], SHADOW2D;
MAD R0.x, R0, c[1].z, c[1].w;
ABS R0.y, R0;
POW R0.y, R0.y, c[9].x;
MIN R0.w, R0.y, c[12].y;
RCP R0.x, R0.x;
ADD R0.x, fragment.texcoord[1].z, -R0;
ABS R0.z, R0.x;
MUL_SAT R1.w, R0.z, c[11].x;
MAX R2.w, R0, c[12].z;
MUL R0.xy, R1, c[7].x;
MUL R0.xy, R1.w, R0;
MUL R0.xy, R0, c[10];
MOV R0.zw, fragment.texcoord[1];
MAD R0.xy, fragment.texcoord[1].z, R0, fragment.texcoord[1];
TXP R2.xyz, R0, texture[0], SHADOW2D;
TEX R0.xyz, R3, texture[3], CUBE;
MAD R2.xyz, -R0, c[5], R2;
DP3 R0.w, fragment.texcoord[6], fragment.texcoord[6];
MUL R0.xyz, R0, c[5];
MAD R0.xyz, R2.w, R2, R0;
MUL R0.xyz, R0, c[4];
RSQ R0.w, R0.w;
MOV R3.xyz, fragment.texcoord[5];
MAD R3.xyz, R0.w, fragment.texcoord[6], R3;
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R3;
DP3 R2.x, R1, R2;
MAX R2.w, R2.x, c[12];
MOV R0.w, c[13].x;
MUL R0.w, R0, c[6].x;
MOV R2.xyz, c[3];
DP3 R1.x, R1, fragment.texcoord[5];
POW R0.w, R2.w, R0.w;
MUL R2.xyz, R2, c[2];
MUL R2.xyz, R2, R0.w;
TEX R0.w, fragment.texcoord[7], texture[4], 2D;
MUL R0.xyz, R0, c[2];
MAX R1.x, R1, c[12].w;
MUL R0.w, R0, c[11].y;
MAD R0.xyz, R0, R1.x, R2;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, R1;
END
# 77 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_ZBufferParams]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Shininess]
Float 7 [_Refraction]
Float 8 [_BumpReflectionStr]
Float 9 [_ReflToRefrExponent]
Vector 10 [_GrabTexture_TexelSize]
SetTexture 0 [_GrabTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ReflectionTex] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 77 ALU, 6 TEX
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s0
dcl_2d s4
def c11, 0.12500000, 2.00000000, -1.00000000, 1.00000000
def c12, 5.00000000, 0.50000000, 0.89999998, 0.10000000
def c13, 0.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7.xy
mov r0.x, c0.y
mul r0.xy, c10, r0.x
mad r0.xy, -r0, c12.x, v0
texld r1.yw, r0, s2
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c11.y, c11.z
mad_pp r1.xy, r1.wyzw, c11.y, c11.z
mul_pp r0.w, r1.y, r1.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.w, -r1.x, r1.x, -r0
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.w, r0, c11
rsq_pp r0.w, r0.w
add_pp r0.z, r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r1.z, r0.w
rcp_pp r0.z, r0.z
add_pp r0.xyz, r0, r1
mul_pp r3.xyz, r0, c12.y
mul_pp r0.xyz, r3, c8.x
dp3_pp r1.x, v2, r0
dp3_pp r1.y, r0, v3
dp3_pp r1.z, r0, v4
mov r0.x, v2.w
mov r0.z, v4.w
mov r0.y, v3.w
dp3 r0.w, r1, r0
mul r1.xyz, r1, r0.w
mad r2.xyz, -r1, c11.y, r0
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul r0.xyz, r0.x, r2
dp3_pp r0.x, r3, r0
abs_pp r0.y, r0.x
pow r1, r0.y, c9.x
mov r0.y, r1.x
min r0.w, r0.y, c12.z
texldp r0.x, v1, s1
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
add r0.x, v1.z, -r0
abs r0.z, r0.x
mul_sat r1.w, r0.z, c11.x
max r2.w, r0, c12
mul r0.xy, r3, c7.x
mul r0.xy, r1.w, r0
mul r0.xy, r0, c10
texld r1.xyz, r2, s3
mov r0.zw, v1
mad r0.xy, v1.z, r0, v1
texldp r0.xyz, r0, s0
mad r2.xyz, -r1, c5, r0
dp3_pp r0.w, v6, v6
mul r1.xyz, r1, c5
mad r1.xyz, r2.w, r2, r1
mul r1.xyz, r1, c4
rsq_pp r0.w, r0.w
mov_pp r0.xyz, v5
mad_pp r0.xyz, r0.w, v6, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c6.x
dp3_pp r0.x, r3, r0
mul_pp r2.y, c13, r0.w
max_pp r2.x, r0, c13
pow r0, r2.x, r2.y
mov r0.w, r0.x
mov r2.xyz, c2
mul r0.xyz, c3, r2
mul r0.xyz, r0, r0.w
dp3_pp r2.x, r3, v5
texld r0.w, v7, s4
mul r1.xyz, r1, c2
max_pp r2.x, r2, c13
mul_pp r0.w, r0, c11.y
mad r0.xyz, r1, r2.x, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

}
	}

#LINE 104

//}
}

	
FallBack "Reflective/Bumped Diffuse"
}
