[MeasureGetCoverColor]
Measure=Plugin
Plugin=Chameleon
Type=File
Path=[MeasureCover]

[MeasureCoverColorAverage]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Average
UpdateDivider=1

[MeasureCoverColorBackground1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background1
UpdateDivider=1

[MeasureCoverColorBackground2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background2
UpdateDivider=1

[MeasureCoverColorForeground1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground1
UpdateDivider=1

[MeasureCoverColorForeground2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground2
UpdateDivider=1

[MeasureCoverColor1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Light1
UpdateDivider=1

[MeasureCoverColor2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Light3
UpdateDivider=1