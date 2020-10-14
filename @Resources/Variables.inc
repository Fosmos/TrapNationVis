; IMPORTANT: You have to reload the skin TWICE until your changes are visible!
; Do not change these!!
[Variables]
playerName=Spotify
playerPlugin=Web
playerEXE=%userprofile%\AppData\Roaming\Spotify\Spotify.exe

;--BASIC--
; Bands: Amount of data points that get visualized (CPU intensive!)
; Height: Height/Width of the outer visualization
; Radius: Radius of the inner circle
Bands=150
Height=120
Radius=120
Smoothing=3
Mirror=1
InvertMirror=0
HollowCenter=0
Orientation=Right
BarDir=1
Info=1

; --Image Settings--
; ImageName: The file name of the center image
; ImageScale: The Scale of the image
; ImageAudioReactIntensity: The intensity of the reaction to audio
; ImageAlpha: The transparency of the image (255 = 100%)
; ImageTint: The tint of the image (default: none)
ImageName=spotify.png
ImageXScale=0.50
ImageYScale=0.50
ImageAudioReactIntensity=0.2
ImageAlpha=255
ImageTint=
ImageTint2=[MeasureBackground]
ImageTint3=255,255,255
Chameleon=1

; --Angle Settings--
; Rotate by changing "StartAngle"
; Changing AngularDisplacement will result in some interesting shapes :)
StartAngle=0
EndAngle=360
AngularDisplacement=0

; --FTT Settings--
FFTSize=8192
FFTBufferSize=16384
FFTAttack=0
FFTDecay=0
FreqMin=20
FreqMax=250
Sensitivity=35

; --WORK IN PROGRESS--
; If you want to scale it, please use "Radius" and "Height"
Scale=1

; --DANGEROUS--
; !!! only change "Config" if you renamed the skin file/location !!!
SkinGroup=TrapNationVis
Config=TrapNationVis
Channel=
Port=
ID=

; --Color/Layer Settings--
; Layers: Amount of color layers (recommended 3-5, but there is no limit) (CPU intensive!)
; DelayPerLayer: The Delay per Layer from the previous layer
Layers=0
DelayPerLayer=5
Layer0Color=[MeasureBackground]
Layer1Color=
