[MeasureState]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=State

[MeasureStateButton]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=20

[MeasureCover]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Cover
CoverPath=#@#images\coverGPMDP.png
Substitute="":"#@#images\gpmdp.png"

[MeasureArtist]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Artist
RegExpSubstitute=1
;; Removes anything followed by a '-' or '&' (except for 'country' and 'free') or 'feat.' or 'and' or ':' or '/'
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| and| :| \/).+)+$":"\1"
UpdateDivider=100

[MeasureArtistFull]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Artist
UpdateDivider=200

[MeasureAlbum]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Album
UpdateDivider=100

[MeasureTrack]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Title
RegExpSubstitute=1
;; Removes anything following a: '-' or anything in between () or [] with 'mix','with','feat','ft','from','version','track','live','unplugged','acoustic','bootleg','demo','cover','theme','remaster','as heard','w\'
; Substitute="^(?siU)^(.+) (-.+|((\(|\[).*(mix|with|feat|ft|from|version|track|live|unplugged|acoustic|bootleg|demo|cover|theme|remaster|as heard|w\/).+))+$":"\1"
;; Removes anything with () or [] 
Substitute="^(?siU)^(.+) ((-|\/|(\(|\[).*()).+)+$":"\1"
UpdateDivider=100

[MeasureTrackFull]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Title
UpdateDivider=200

[MeasureProgress]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Progress

[MeasureAutoHide]
Measure=calc
IfCondition=(MeasureState = 2 && MeasureProgress > 0)
IfTrueAction=!HideFade
IfFalseAction=!ShowFade

; [MeasureAutoHideGPMDP]
; Measure=Plugin
; Plugin=GPMDPPlugin
; PlayerInfo=Status
; IfEqualValue=0
; IfEqualAction=[!HideFade][!DeactivateConfig "TrapNationVis"]
; IfAboveValue=0
; IfAboveAction=[!ShowFade][!ActivateConfig "TrapNationVis"]
; UpdateDivider=100