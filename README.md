# Shaders
Shader code is executed on a per-pixel or per vertex basis, so write the code as if you're only writing for one pixel. No need to write loops that process all of the pixels that need to appear on screen(the GPU does the rest).

There are some visible differences between shader code and normal code: float(the highest precision is 32 bits), half, fixed and int. They have been designed to be more efficient.

## Best Practices

Use floats for texture coordinates, world positions and calculations<br>
Use half for dynamic colour changes, short vectors and directions<br>
Use fixed for regular colours and simple colour operations<br>
Use int for counters and array indices.<br>

## Texture Data types

Each of these has a high and low precision version for low end image processing and high end image manilulation.<br>

Sampler2D: regular images<br>
SamplerCUBE: cube maps<br>
Packed arrays: any of these data types can be made into special arrays(RGBA or XYZW)<br>

## PBR Pipeline focuses on 7 areas:

1. Reflection: Accomplished by drawing rays from the viewer to the reflective surface and calculating where it bounces off = a reverse calculation to lighting.<br>
2. Diffusion: examines how light and colour are distributed across the surface by considering what light is absorbed and what light is reflected and how.<br>
3. Translucency & transparency: Examines how light can move through objects and render them fully or partly see through.<br>
4. Conservation of energy: A concept that ensures objects never reflect more light than they receive. unless an object is a perfect mirror finish, it will absorb light depending on the surface. however some lights will always be reflected and available to light other objects.<br>
5. Metallicity: Considers the interaction of light on shiny surfaces, highlight and colours that are reflected. metals tend to be highly reflective with very little in the way of diffused light.<br>
6. Fresnel reflectivity: Examines how reflections on a curved surface becomes stronger towards the edges and fading towards the centre. normal reflection reflects the environment as it is, fresnel reflection is how real world reflection works on a curved surface. this varies as reflective surface change. however you will never get the perfect straight line of the horizon in a curved surface as you do with normal reflection.<br>
7. Microsurface scattering: Similar to bump mapping - suggests that most surfaces are going to contain grooves and cracks which will reflect the light at different angles other than those dictated by a regular surface.<br>

## Vertex vs Pixel Lighting

Vertex lit = Gouraud shading in reverse, the incoming light is caluclated at each vertex and average across the surface.<br>

Pixel lit = Phong-like: a light for each pixel is calculated.<br>

Pixel will pick up far more details and specular highlights than vertex, as light is calculated for every point. it provides far more detailed shading but requires more processing. Vertex lit is the way to go for older graphics card and mobile devices(or when you have a lot of things to render but the quality doesn't matter so much).<br>

Write your own lighting model if all these lighting models doesn't suit your needs.<br>

## Useful Resources
PBR Guides by Allegorithmic: https://www.allegorithmic.com/pbr-guide<br>

### Unity
https://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html<br>
https://docs.unity3d.com/Manual/SL-SurfaceShaderExamples.html<br>
Cooking Shaders Book for Unity https://www.packtpub.com/game-development/unity-5x-shaders-and-effects-cookbook<br>

http://www.alanzucconi.com/2015/06/10/a-gentle-introduction-to-shaders-in-unity3d/<br>

Mathematical Formulae for Plasma: https://www.bidouille.org/prog/plasma<br>

http://wiki.unity3d.com/index.php/Shader_Code<br>
http://wiki.unity3d.com/index.php?title=Shaders#Unity_5.x_Shaders<br>
Textures and Normal Maps: http://www.textures.com<br>
Open Source Shader Plugin For Unity - LUX: https://assetstore.unity.com/packages/vfx/shaders/lux-physically-based-shader-framework-16000<br>

RenderDoc: a free MIT licensed stand-alone graphics debugger that allows quick and easy single-frame capture and detailed introspection of any application using Vulkan, D3D11, OpenGL or D3D12 across Windows 7 - 10, Linux.<br>

https://renderdoc.org/<br>

### Unreal Engine

https://docs.unrealengine.com/latest/INT/Engine/Rendering/Materials/PhysicallyBased/<br>

https://docs.unrealengine.com/latest/INT/Resources/Showcases/PhotorealisticCharacter/<br>


