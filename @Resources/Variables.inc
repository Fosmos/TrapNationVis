; IMPORTANT: You have to reload the skin TWICE until your changes are visible!
[Variables]
playerName=GPDMP
playerPlugin=GPMDP
playerVal=4
playerEXE=C:\Users\erme2\AppData\Local\GPMDP_3\app-4.7.1\Google Play Music Desktop Player.exe

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

; --Image Settings--
; ImageName: The file name of the center image
; ImageScale: The Scale of the image
; ImageAudioReactIntensity: The intensity of the reaction to audio
; ImageAlpha: The transparency of the image (255 = 100%)
; ImageTint: The tint of the image (default: none)
ImageName=gpmdp.png
ImageXScale=0.6
ImageYScale=0.6
ImageAudioReactIntensity=0.2
ImageAlpha=255
ImageTint=
ImageTint2=[MeasureCoverColorBackground1]
ImageTint3=255,255,255

; --Angle Settings--
; Rotate by changing "StartAngle"
; Changing AngularDisplacement will result in some interesting shapes :)
StartAngle=0
EndAngle=360
AngularDisplacement=0

; --FTT Settings--
FFTSize=8192
FFTBufferSize=8192
FFTAttack=0
FFTDecay=0
FreqMin=15
FreqMax=250
Sensitivity=28

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
Layer0Color=[MeasureCoverColorBackground1]
Layer1Color=30,215,96
