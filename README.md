# Shaders
Shader code is executed on a per-pixel or per vertex basis, so write the code as if you're only writing for one pixel. No need to write loops that process all of the pixels that need to appear on screen - the GPU does the rest!

## Best Practices

Use floats for texture coordinates, world positions and calculations<br>
Use half for dynamic colour changes, short vectors and directions<br>
Use fixed for regular colours and simple colour operations<br>
Use int for counters and array indices.<br>

## Useful Resources
PBR Guides by Allegorithmic: https://www.allegorithmic.com/pbr-guide

### Unity
https://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html
https://docs.unity3d.com/Manual/SL-SurfaceShaderExamples.html
Cooking Shaders Book for Unity https://www.packtpub.com/game-development/unity-5x-shaders-and-effects-cookbook

http://www.alanzucconi.com/2015/06/10/a-gentle-introduction-to-shaders-in-unity3d/

Mathematical Formulae for Plasma: https://www.bidouille.org/prog/plasma

http://wiki.unity3d.com/index.php/Shader_Code
http://wiki.unity3d.com/index.php?title=Shaders#Unity_5.x_Shaders
Textures and Normal Maps: http://www.textures.com
Open Source Shader Plugin For Unity - LUX: https://assetstore.unity.com/packages/vfx/shaders/lux-physically-based-shader-framework-16000

RenderDoc: a free MIT licensed stand-alone graphics debugger that allows quick and easy single-frame capture and detailed introspection of any application using Vulkan, D3D11, OpenGL or D3D12 across Windows 7 - 10, Linux.

https://renderdoc.org/

### Unreal Engine

https://docs.unrealengine.com/latest/INT/Engine/Rendering/Materials/PhysicallyBased/

https://docs.unrealengine.com/latest/INT/Resources/Showcases/PhotorealisticCharacter/


