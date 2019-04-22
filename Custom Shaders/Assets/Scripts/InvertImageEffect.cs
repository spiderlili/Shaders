using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InvertImageEffect : MonoBehaviour
{
    //automatically looks for the shader it needs to use
    //depth effect is the depth texture of the scene.e.g.for a post effect that does dof
    public Shader curShader;
    private Material curMaterial;
    public bool InvertEffect;
    public bool DepthEffect;

    Material material
    {
        get
        {
            if (curMaterial == null)
            {
                curMaterial = new Material(curShader);
                //The GameObject is not shown in the Hierarchy, not saved to to Scenes, not unloaded by Resources.UnloadUnusedAssets.
                //used for GameObjects which are created by a script and are purely under the script's control.
                curMaterial.hideFlags = HideFlags.HideAndDontSave;
            }
            return curMaterial;
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        curShader = Shader.Find("Hidden/InvertDepth");
        GetComponent<Camera>().allowHDR = true;
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            Debug.Log("not supported");
            return;
        }
        if (!curShader && !curShader.isSupported)
        {
            enabled = false;
            Debug.Log("not supported");
        }
        GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
    }

    private void OnRenderImage(RenderTexture sourceTex, RenderTexture destinationTex)
    {
        if (curShader != null)
        {
            //use different passes in the same shader
            if (InvertEffect)
            {
                Graphics.Blit(sourceTex, destinationTex, material, 0);
            }
            else if (DepthEffect)
            {
                Graphics.Blit(sourceTex, destinationTex, material, 1);
            }
            else
            {
                Graphics.Blit(sourceTex, destinationTex);
            }
        }
    }
}
