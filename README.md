# Shaders
Shader code is executed on a per-pixel or per vertex basis, so write the code as if you're only writing for one pixel. No need to write loops that process all of the pixels that need to appear on screen(the GPU does the rest).

There are some visible differences between shader code and normal code: float(the highest precision is 32 bits), half, fixed and int. They have been designed to be more efficient.

## Best Practices

Use floats for texture coordinates, world positions and calculations<br>
Use half for dynamic colour changes, short vectors and directions<br>
Use fixed for regular colours and simple colour operations<br>
Use int for counters and array indices.<br>

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


