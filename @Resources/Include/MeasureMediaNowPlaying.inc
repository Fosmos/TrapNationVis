[MeasurePlayer]
Measure=NowPlaying
PlayerName=#playerName#
PlayerType=TITLE

[MeasureState]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=State
UpdateDivider=100

[MeasureStateButton]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=100

[MeasureCover]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=Cover
Substitute="":"#@#images\#ImageName#"
UpdateDivider=100

[MeasureTrack]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=Title
UpdateDivider=100

[MeasureArtist]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=Artist
UpdateDivider=100

[MeasureAlbum]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=Album
UpdateDivider=100

[MeasureProgress]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
PlayerType=Progress
UpdateDivider=100

[MeasureAutoHide]
Measure=NowPlaying
PlayerName=[MeasurePlayer]
IfCondition=(MeasureState = 2)
IfTrueAction=[!HideFadeGroup "SongInfo"][!DeactivateConfig "TrapNationVis"]
IfFalseAction=[!ShowFadeGroup "SongInfo"][!ActivateConfig "TrapNationVis"]
UpdateDivider=20