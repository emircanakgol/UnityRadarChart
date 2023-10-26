# UnityRadarChart
A radar chart made in Unity Shader Graph and HLSL.

## Requirements
- Universal Render Pipeline
(HDRP not tested)
- Shader Graph

## Installation
Download and copy the files to your project. 
###### If you get errors
[![Drop HLSL](https://s6.gifyu.com/images/S8sz3.gif "Drop HLSL")](https://s6.gifyu.com/images/S8sz3.gif "Drop HLSL")
Open the "RadarChart.shadergraph" and drag the RadarChartFunctions.hlsl to the TWO custom function nodes that give error.

###### If the material is pink
Make sure you set your Universal Render Pipeline correctly. If you need to switch to URP in your project, you can follow this link:
https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@7.1/manual/InstallURPIntoAProject.html

## Usage
1. Create an Image in your Canvas and drag the script "RadarChartController.cs" into it.
2. Right click the "RadarChart.shadergraph" Shader Graph>Create>Material.
3. Drag the material onto the Image's material slot.
4. Edit the values of the script and material to your likings.
	- The "GridCount" variable in the script, "OuterLineThickness, InnerLineThickness, ValueLineThickness, Size, ForegroundColor, BackgroundColor, LineColor" variables in the material are cosmetic values that you can change.
	- MaxValue is important. The values that you give will be divided to MaxValue, so make sure you set it correctly.
5. Pass the values onto the script like this:
```csharp
public RadarChartController radarChartController;
public void ExampleFunction(){
  List<float> values = new(){10f,2f,9f,5f,7f};
  radarChartController.gridCount = 5;
  radarChartController.maxValue = 10f;
  radarChartController.Values = values;
}
```
Everytime you set Values, the Radar Chart will be refreshed.
And the result is;

[![Result](https://s6.gifyu.com/images/S8sL5.png "Result")](https://s6.gifyu.com/images/S8sL5.png "Result")


Copyright (c) 2023, Emir Can Akgöl

All rights reserved.

This source code is licensed under the BSD-style license found in the LICENSE file in the root directory of this source tree. 
