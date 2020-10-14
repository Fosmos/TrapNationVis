[MeasureGetCoverColor]
Measure=Plugin
Plugin=Chameleon
Type=File
Path=[MeasureCover]

[MeasureAverage]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Average

[MeasureBackground]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background1

[MeasureBackground2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background2

[MeasureForeground]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground1

[MeasureForeground2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground2

[MeasureLight2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Light2

[MeasureDark]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Dark1

[MeasureLuminance]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Luminance
