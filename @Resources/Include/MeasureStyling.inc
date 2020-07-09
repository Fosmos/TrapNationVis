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

[MeasureCoverColorBackground1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background1

[MeasureCoverColorBackground2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background2

[MeasureCoverColorForeground1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground1

[MeasureCoverColorForeground2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground2

[MeasureCoverColor1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Light2

[MeasureCoverLigth]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Light2

[MeasureCoverDark]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Dark1

[MeasureCoverColor2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground1

[MeasureLuminance]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Luminance

; [MeasureColor]
; Measure=Plugin
; Plugin=Chameleon
; Format=Dec
; IfCondition=MeasureLuminance < 0.5
; IfTrueAction=[!WriteKeyValue Variables ImageTint3 204,204,204 "#@#Variables.inc"]
; IfFalseAction=[!WriteKeyValue Variables ImageTint3 30,30,30 "#@#Variables.inc"]

