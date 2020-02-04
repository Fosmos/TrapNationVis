# TrapNationVis
A modified verion of SnGmng's visualizer which can be found here: https://www.deviantart.com/sngmng/art/TrapNation-Visualizer-v1-1-1-792869094

![](https://i.ibb.co/4pqRfgc/vis.png)

## What's different?
* Added Media player support
  - Spotify (Sadly no album cover support ... yet)
  - Google Play Music Desktop Player (Full Support)
  - iTunes (Full support)
  - Windows Media Player (aka WMP) (Full Suport)
  - Web Now Playing (Full Support but untested on Firefox)
    - Requires the rainmeter extension (Chrome, Firefox or Edge [Chromium Version])
  - AIMP (Untested but theoretically should work)
    - If you use this one, let me know if it works or not
  - foobar2000 (Untested but should work)
    - See AIMP
  - J.River Media Center and Media JukeBox (Unteste but should work)
    - See AIMP
  - MediaMonkey (Untested but should work)
    - See AIMP
  - Winamp (Untested but should work)
    - See AIMP
* You can now
  - Next/Previous buttons on the visualizer
    - Show up when you hover over it
  - An option for the album cover to show on the visualizer
    - Right-Click it then select Media Player
      - If your media player is listed above, but is not listed in the popup window then click the "Now Playing"
 button
  - An option to color the visualizer to the colors of the album cover
    - Right-Click the visualizer and select Media Player, then "Chameleon"
  - Play/Pause functionality
    - Works the same as the previous/next buttons
  - Skin for displaying the current song information (Artist, Track)
    - In Rainmeter select you're prefered style (left.ini, center.ini, right.ini)
      - In TrapNation\Song Info
      

## Installation
Install Rainmeter, which can be found at: https://www.rainmeter.net/
* To be safe, maybe download the final instead of the beta

Download the .rmskin file in the release tab
* https://github.com/Fosmos/TrapNationVis/releases

Once downloaded, double-click to run it
* This should add the necessary files and plugins to your system that rainmeter will run

Next open Rainmeter
* It should be one of the tray icons if it's running already

In Rainmeter locate the TrapNation folder
* Hopefully that's easy enough to do 😅

Then Double click the .ini file
The Visualizer should show up on your desktop

## Editing the Visualizer
If you right click the visualizer you'll notice an "Options"
Opening that will allow you to customize the way the visualizer responds to sound
* Credit goes to SnGmng for this one, though I did make some minor changes
I suggest not touching the color section of this window or changing of the icon (including it's scale), for now
So just to quickly run through each setting (starting from the top left of the window)
* Radius => how large do you want the vis to be?
* Height => how far can the waves reach out from the vis?
* Start angle => where is the position for the high frequency 
  - If mirror on/off is on the high sounds will be a the bottom (when set to 0) and the low sounds will be at the top
  - With Invert Mirror the the high sounds will be at the top and the bottom and the lows will be to the sides
  - If you're still unsure as to what this does, mess around with the values to see what happens
* End Angle => Like the start angle but you can tell it where it should stop
  - Best way to really know what it does is to mess with it
* Angle Displacement => Some cool whacky stuff happens when you change values here 
  - I suggest trying 90, 180 and 270
* Circle Measures => how many individual lines will it be drawing
  - Try lowering this to 10 then to a high number to see what I mean
  - *Note* The higher this is the more it will chew through your system's resources
* Hollow center => gets rid of the color layer in the center
* Mirror => Mirrors the waves to the other half
  - Looks boring if this is off
* Invert Mirror => Takes Mirroring to a whole new level
* Smoothing => If you set this to 0 it will show a lot of detail but it doesn't look that great
* FFTSize => This is a little confusing to explain but it's basically how detailed rainmeter breaks apart the sound coming out of your system. The Higher the more detailed
  - You'll have to mess with this value to get a good result
* FFTBufferSize => This goes hand in hand with the FFTSize. It's essentially stores a chunk of the sound data before actually breaking it down into it's frequencies. The higher the higher accuracy
  - You'll have to work this with the previous one, but generally this should be set higher then the FFTSize
* Attack => A delay for the waves coming out
* Decay => Delay for the waves coming back
* Sensitivity => How loud does the sound, in decibels, have to be for it to pick it up
  - 35 seems to be the golden number
* Frequency => Which frequency range do you you want?
  - Lower values == bass
  - Higher values == treble
* Delay per layer => how delayed each layer is
  - The higher it is the more noticeable the layer is
* Image Audio React Intensity => How much the image expands when reacting to sounds from a kick drum
  - Just try putting this 1 and see what happens the kick comes in 😂
  - Essentially this activates when a really low frequency is played (like a kick drum)
    - If you set your lowest frequency to something high like 150, you'll see it a lot more and if you set it to something like 10 you'll probably never see it happen
