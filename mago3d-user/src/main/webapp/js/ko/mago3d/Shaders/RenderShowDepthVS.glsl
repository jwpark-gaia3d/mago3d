attribute vec3 position;

uniform mat4 modelViewMatrixRelToEye; 
uniform mat4 RefTransfMatrix;
uniform mat4 ModelViewProjectionMatrixRelToEye;
uniform vec3 buildingPosHIGH;
uniform vec3 buildingPosLOW;
uniform vec3 encodedCameraPositionMCHigh;
uniform vec3 encodedCameraPositionMCLow;
uniform float near;
uniform float far;
uniform vec3 aditionalPosition;

varying float depth;
  
void main()
{	
    vec4 rotatedPos = RefTransfMatrix * vec4(position.xyz, 1.0) + vec4(aditionalPosition.xyz, 0.0);
    vec3 objPosHigh = buildingPosHIGH;
    vec3 objPosLow = buildingPosLOW.xyz + rotatedPos.xyz;
    vec3 highDifference = objPosHigh.xyz - encodedCameraPositionMCHigh.xyz;
    vec3 lowDifference = objPosLow.xyz - encodedCameraPositionMCLow.xyz;
    vec4 pos4 = vec4(highDifference.xyz + lowDifference.xyz, 1.0);
    
    //linear depth in camera space (0..far)
    depth = (modelViewMatrixRelToEye * pos4).z/far;

    gl_Position = ModelViewProjectionMatrixRelToEye * pos4;
}