[MeasureState]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
UpdateDivider=2

[MeasureStateButton]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=2

[MeasureTrack]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=100

[MeasureArtist]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
UpdateDivider=100

[MeasureCover]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Cover
DefaultPath=#@#images\nocover.png
CoverPath=#@#images\coverWeb.png
Substitute="":"#@#images\trapnation.png"
UpdateDivider=100

[MeasurePosition]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Position
UpdateDivider=20

[MeasureDuration]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Duration
UpdateDivider=20

[MeasureProgress]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Progress
UpdateDivider=20