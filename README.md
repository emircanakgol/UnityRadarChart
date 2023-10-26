# UnityRadarChart
A radar chart made in Unity Shader Graph and HLSL.

## Requirements
- Universal Render Pipeline
(HDRP not tested)
- Shader Graph

## Installation
Download the files and copy the files to your project. 
###### If you get errors
[![Drop HLSL](https://s6.gifyu.com/images/S8sz3.gif "Drop HLSL")](https://s6.gifyu.com/images/S8sz3.gif "Drop HLSL")
Open the "RadarChart.shadergraph" and drag the RadarChart.hlsl to the custom function nodes that give error.

## Usage
1. Create an Image in your Canvas and drag the script "RadarChartController.cs" into it.
2. Drag the RadarChartMat material onto the Image's material slot.
3. Edit the values of the script and material to your likings.
	- The "GridCount" variable in the script, "OuterLineThickness, InnerLineThickness, ValueLineThickness, Size, ForegroundColor, BackgroundColor, LineColor" variables in the material are cosmetic values that you can change.
	- MaxValue is important. The values that you give will be divided to MaxValue, so make sure you set it correctly.
4. Pass the values onto the script like this:
```csharp
public RadarChartController radarChartController;
public void ExampleFunction(){
  List<float> values = new(){10f,2f,9f,5f,7f};
  radarChartController.gridCount = 5;
  radarChartController.maxValue = 10f;
  radarChartController.Values = values;
}
```
And the result is;

[![Result](https://s6.gifyu.com/images/S8sL5.png "Result")](https://s6.gifyu.com/images/S8sL5.png "Result")


Copyright (c) 2023, Emir Can Akgöl

All rights reserved.

This source code is licensed under the BSD-style license found in the LICENSE file in the root directory of this source tree. 
