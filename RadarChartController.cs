using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.IO;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
public class RadarChartController : MonoBehaviour
{
    
    [Header("Chart Settings")]
    public int gridCount;

    [Header("Value Settings")]
    public float maxValue;
    private List<float> _values = new();
    public List<float> Values {
        get => _values;
        set{
            if(_values == value)
                return;
            _values = value;
            RefreshValues();
        }
    }

    private Material radarChartMaterial;

    void Start(){
        radarChartMaterial = GetComponent<Image>().material;
        List<float> values = new(){10f,2f,9f,5f,7f};
        maxValue = 10f;
        Values = values;
    }

    public void RefreshValues(){
        if(Values.Count < 3){
            Debug.LogError("Value count cannot be less than 3");
            return;
        }

        if(Values.Count > 100){
            Debug.LogError("Value count cannot be more than 100");
            return;
        }

        radarChartMaterial.SetFloat("_Sides", Values.Count);
        radarChartMaterial.SetFloat("_LineCount", gridCount);
        radarChartMaterial.SetTexture("_Values", CreateValueTexture());
    }

    Texture2D CreateValueTexture(){
        Texture2D valueTexture = new(Values.Count, 1, TextureFormat.RFloat, false){
            filterMode = FilterMode.Point,
            wrapMode = TextureWrapMode.Clamp
        };
        for (int i = 0; i < Values.Count; i++){
            Color color = new(Values[i]/maxValue,0,0,1);
            valueTexture.SetPixel(i, 0, color);
        }
        
        valueTexture.Apply();
        return valueTexture;
    }
}
