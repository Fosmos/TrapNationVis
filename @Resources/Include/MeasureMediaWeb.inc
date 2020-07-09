[MeasureState]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State

[MeasureStateButton]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=20

[MeasureTrack]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=20

[MeasureArtist]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
UpdateDivider=20

[MeasureCover]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Cover
CoverPath=#@#images\coverWeb.png
Substitute="":"#@#images\trapnation.png"
UpdateDivider=20

[MeasureProgress]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Progress
UpdateDivider=20

[MeasureAutoHide]
Measure=Plugin
Plugin=WebNowPlaying
IfCondition=(MeasureState = 2 && MeasureProgress > 0)
IfTrueAction=[!HideFade][!DeactivateConfig "TrapNationVis"]
IfFalseAction=[!ShowFade][!ActivateConfig "TrapNationVis"]
