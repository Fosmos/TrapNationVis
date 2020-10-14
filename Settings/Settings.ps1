Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$v = @{}
$variablesPath = Resolve-Path "..\@Resources\Variables.inc"
$raw = Get-Content -Path $variablesPath
foreach ($line in $raw)
{
    if ($line -match "^(\w+)\s??=\s??(.*?);?\n?$")
    {
        Write-Host $matches[1]:  $matches[2]
        $v[$matches[1]] = $matches[2]
    }
}

if ($v["ImageAlpha"] -eq "") { $v["ImageAlpha"]=255 }
if ($v["playerName"] -eq "") { $v["playerName"]='Spotify'}
if ($v["playerName"] -eq "Spotify" -AND $v["playerPlugin"] -eq "NowPlaying") { $v["playerName"]="Spotify (Now Playing)" }
$rmPath = (Get-Process "Rainmeter").Path

$assemblies=(
    "System", 
    "System.Runtime.InteropServices",
    "System.Windows.Forms"
)

$psforms = @'
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace PSForms
{
    public class ListViewX : ListView
    {
        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
        public extern static int SetWindowTheme(IntPtr hWnd, string pszSubAppName, string pszSubIdList);

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(this.Handle, "explorer", null);
        }
    }

    // [WIP]
    public class NumericUpDownX : NumericUpDown
    {
        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
        public extern static int SetWindowTheme(IntPtr hWnd, string pszSubAppName, string pszSubIdList);

        public NumericUpDownX()
        {
            this.Paint += NumericUpDownX_Paint;
            this.GotFocus += NumericUpDownX_GotFocus;
            this.LostFocus += NumericUpDownX_LostFocus;
        }

        public string Unit { get; set; }

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(this.Handle, "explorer", null);
        }

        private void NumericUpDownX_Paint(object sender, PaintEventArgs e)
        {
            //this.Text = this.Value + Unit;
        }

        private void NumericUpDownX_GotFocus(object sender, EventArgs e)
        {
            //this.Text = this.Value.ToString();
        }

        private void NumericUpDownX_LostFocus(object sender, EventArgs e)
        {
            //this.Text = this.Value + Unit;
        }

        /*
        protected override void UpdateEditText()
        {
            // Append the units to the end of the numeric value
            //this.Text = this.Value + Unit;
        }*/
    }
}
'@

$wppsdef = @'
[DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool WritePrivateProfileString(string lpAppName,
    string lpKeyName,
    string lpString,
    string lpFileName);
'@

$wpps = Add-Type -MemberDefinition $wppsdef -Name WinWritePrivateProfileString -Namespace Win32Utils -PassThru
Add-Type -ReferencedAssemblies $assemblies -TypeDefinition $psforms -Language CSharp

# Window Settings
$form                               = New-Object system.Windows.Forms.Form
$form.ClientSize                    = '795,440'
$form.text                          = $v["Config"]
$form.TopMost                       = $false
$form.Icon                          = [Drawing.Icon]::ExtractAssociatedIcon($rmPath)
$form.AutoSize                      = $false
$form.FormBorderStyle               = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.ShowInTaskbar                 = $false
$form.MinimizeBox                   = $false
$form.MaximizeBox                   = $false
$form.Font                          = 'Arial,9'

### <General> ###
    $gbGeneral                       = New-Object system.Windows.Forms.Groupbox
    $gbGeneral.height                = 170
    $gbGeneral.width                 = 250
    $gbGeneral.text                  = "General"
    $gbGeneral.location              = New-Object System.Drawing.Point(10,10)

    # Radius
    $lblRadius                       = New-Object system.Windows.Forms.Label
    $lblRadius.text                  = "Radius"
    $lblRadius.AutoSize              = $true
    $lblRadius.width                 = 25
    $lblRadius.height                = 10
    $lblRadius.location              = New-Object System.Drawing.Point(10,20)

    $numRadius                       = New-Object PSForms.NumericUpDownX
    $numRadius.width                 = 100
    $numRadius.height                = 20
    $numRadius.location              = New-Object System.Drawing.Point(140,15)
    $numRadius.Font                  = 'Microsoft Sans Serif,8'
    $numRadius.Minimum               = 0
    $numRadius.Maximum               = 1000
    $numRadius.Value                 = $v["Radius"]
    $numRadius.Unit                  = " px"

    # Height
    $lblHeight                       = New-Object system.Windows.Forms.Label
    $lblHeight.text                  = "Height"
    $lblHeight.AutoSize              = $true
    $lblHeight.width                 = 25
    $lblHeight.height                = 10
    $lblHeight.location              = New-Object System.Drawing.Point(10,50)

    $numHeight                       = New-Object PSForms.NumericUpDownX
    $numHeight.width                 = 100
    $numHeight.height                = 20
    $numHeight.location              = New-Object System.Drawing.Point(140,45)
    $numHeight.Font                  = 'Microsoft Sans Serif,8'
    $numHeight.Minimum               = 0
    $numHeight.Maximum               = 360
    $numHeight.Value                 = $v["Height"]
    $numHeight.Unit                  = " px"    

    # Start Angle
    $lblStartAngle                   = New-Object system.Windows.Forms.Label
    $lblStartAngle.text              = "Start Angle"
    $lblStartAngle.AutoSize          = $true
    $lblStartAngle.width             = 25
    $lblStartAngle.height            = 10
    $lblStartAngle.location          = New-Object System.Drawing.Point(10,80)

    $numStartAngle                   = New-Object PSForms.NumericUpDownX
    $numStartAngle.width             = 100
    $numStartAngle.height            = 20
    $numStartAngle.location          = New-Object System.Drawing.Point(140,75)
    $numStartAngle.Font              = 'Microsoft Sans Serif,8'
    $numStartAngle.Minimum           = 0
    $numStartAngle.Maximum           = 360
    $numStartAngle.Value             = $v["StartAngle"]
    $numStartAngle.Unit              = " deg"
    
    # End Angle
    $lblEndAngle                     = New-Object system.Windows.Forms.Label
    $lblEndAngle.text                = "End Angle"
    $lblEndAngle.AutoSize            = $true
    $lblEndAngle.width               = 25
    $lblEndAngle.height              = 10
    $lblEndAngle.location            = New-Object System.Drawing.Point(10,110)

    $numEndAngle                     = New-Object PSForms.NumericUpDownX
    $numEndAngle.width               = 100
    $numEndAngle.height              = 20
    $numEndAngle.location            = New-Object System.Drawing.Point(140,105)
    $numEndAngle.Font                = 'Microsoft Sans Serif,8'
    $numEndAngle.Minimum             = 0
    $numEndAngle.Maximum             = 360
    $numEndAngle.Value               = $v["EndAngle"]
    $numEndAngle.Unit                = " deg"

    # Angle Displacement
    $lblAngularDisplacement          = New-Object system.Windows.Forms.Label
    $lblAngularDisplacement.text     = "Angle Displacement"
    $lblAngularDisplacement.AutoSize = $true
    $lblAngularDisplacement.width    = 25
    $lblAngularDisplacement.height   = 10
    $lblAngularDisplacement.location = New-Object System.Drawing.Point(10,140)

    $numAngularDisplacement          = New-Object PSForms.NumericUpDownX
    $numAngularDisplacement.width    = 100
    $numAngularDisplacement.height   = 20
    $numAngularDisplacement.location  = New-Object System.Drawing.Point(140,135)
    $numAngularDisplacement.Font     = 'Microsoft Sans Serif,8'
    $numAngularDisplacement.Minimum  = 0
    $numAngularDisplacement.Maximum  = 360
    $numAngularDisplacement.Value    = $v["AngularDisplacement"]
    $numAngularDisplacement.Unit     = '°'
### <General/> ###

### <Circle> ###
    $gbBar                           = New-Object system.Windows.Forms.Groupbox
    $gbBar.height                    = 80
    $gbBar.width                     = 250
    $gbBar.text                      = "Circle"
    $gbBar.location                  = New-Object System.Drawing.Point(10,190)

    # Bands
    $lblBarAmount                    = New-Object system.Windows.Forms.Label
    $lblBarAmount.text               = "Circle Measures"
    $lblBarAmount.AutoSize           = $true
    $lblBarAmount.width              = 25
    $lblBarAmount.height             = 10
    $lblBarAmount.location           = New-Object System.Drawing.Point(10,20)

    $numBars                         = New-Object PSForms.NumericUpDownX
    $numBars.width                   = 100
    $numBars.height                  = 20
    $numBars.location                = New-Object System.Drawing.Point(140,15)
    $numBars.Font                    = 'Microsoft Sans Serif,8'
    $numBars.Minimum                 = 0
    $numBars.Maximum                 = 2000
    $numBars.Value                   = $v["Bands"]

    # Hollow Center
    $cbHollowCenter                  = New-Object system.Windows.Forms.CheckBox
    $cbHollowCenter.text             = "Hollow Center"
    $cbHollowCenter.AutoSize         = $true
    $cbHollowCenter.width            = 95
    $cbHollowCenter.height           = 20
    $cbHollowCenter.location         = New-Object System.Drawing.Point(10,45)
    $cbHollowCenter.Checked          = [int]$v["HollowCenter"]
### <Circle/>

### <Visualizer> ###
    $gbVisualizer                    = New-Object system.Windows.Forms.Groupbox
    $gbVisualizer.height             = 120
    $gbVisualizer.width              = 250
    $gbVisualizer.text               = "Visualizer"
    $gbVisualizer.location           = New-Object System.Drawing.Point(10,275)

    # Mirror
    $cbMirror                        = New-Object system.Windows.Forms.CheckBox
    $cbMirror.text                   = "Mirror"
    $cbMirror.AutoSize               = $false
    $cbMirror.width                  = 100
    $cbMirror.height                 = 20
    $cbMirror.location               = New-Object System.Drawing.Point(10,20)
    $cbMirror.Checked                = [int]$v["Mirror"]

    # Invert
    $cbInvertMirror                  = New-Object system.Windows.Forms.CheckBox
    $cbInvertMirror.text             = "Invert Mirror"
    $cbInvertMirror.AutoSize         = $false
    $cbInvertMirror.width            = 100
    $cbInvertMirror.height           = 20
    $cbInvertMirror.location         = New-Object System.Drawing.Point(140,20)
    $cbInvertMirror.Checked          = [int]$v["InvertMirror"]
    $cbInvertMirror.Enabled          = [int]$v["Mirror"]

    # Smoothing
    $lblSmoothing                    = New-Object system.Windows.Forms.Label
    $lblSmoothing.text               = "Smoothing"
    $lblSmoothing.AutoSize           = $true
    $lblSmoothing.width              = 50
    $lblSmoothing.height             = 10
    $lblSmoothing.location           = New-Object System.Drawing.Point(10,50)

    $numSmoothing                    = New-Object PSForms.NumericUpDownX
    $numSmoothing.width              = 100
    $numSmoothing.height             = 20
    $numSmoothing.location           = New-Object System.Drawing.Point(140,49)
    $numSmoothing.Font               = 'Microsoft Sans Serif,8'
    $numSmoothing.Minimum            = 0
    $numSmoothing.Maximum            = 10
    $numSmoothing.Value              = $v["Smoothing"]

    # Delay
    $lblLayers                      = New-Object system.Windows.Forms.Label
    $lblLayers.text                 = "Delay Per Layer"
    $lblLayers.AutoSize             = $true
    $lblLayers.width                = 50
    $lblLayers.height               = 10
    $lblLayers.location             = New-Object System.Drawing.Point(10,80)

    $numLayers                      = New-Object PSForms.NumericUpDownX
    $numLayers.width                = 100
    $numLayers.height               = 20
    $numLayers.location             = New-Object System.Drawing.Point(140,79)
    $numLayers.Minimum              = 0
    $numLayers.Maximum              = 20
    $numLayers.Value                = $v["DelayPerLayer"] 
### <Visualizer/> ###

### <Visualization> ###
    $gbVisualization                 = New-Object system.Windows.Forms.Groupbox
    $gbVisualization.height          = 170
    $gbVisualization.width           = 250
    $gbVisualization.text            = "Visualization"
    $gbVisualization.location        = New-Object System.Drawing.Point(270,10)

    # Size
    $lblFFTSize                      = New-Object system.Windows.Forms.Label
    $lblFFTSize.text                 = "FFTSize"
    $lblFFTSize.AutoSize             = $true
    $lblFFTSize.width                = 25
    $lblFFTSize.height               = 10
    $lblFFTSize.location             = New-Object System.Drawing.Point(10,20)

    $cbFFTSize                       = New-Object System.Windows.Forms.ComboBox
    $cbFFTSize.width                 = 100
    $cbFFTSize.height                = 20
    $cbFFTSize.location              = New-Object System.Drawing.Point(140,15)
    $cbFFTSize.Font                  = 'Microsoft Sans Serif,8'
    $cbFFTSize.DropDownStyle         = 'DropDownList'
    $cbFFTSize.Items.AddRange(@(512,1024,2048,4096,8192,16384,32768,65536))
    $cbFFTSize.SelectedIndex         = [Math]::Round([Math]::Log($v["FFTSize"], 2)-9)

    # Buffer Size
    $lblFFTBufferSize                = New-Object system.Windows.Forms.Label
    $lblFFTBufferSize.text           = "FFTBufferSize"
    $lblFFTBufferSize.AutoSize       = $true
    $lblFFTBufferSize.width          = 25
    $lblFFTBufferSize.height         = 10
    $lblFFTBufferSize.location       = New-Object System.Drawing.Point(10,50)

    $cbFFTBufferSize                 = New-Object System.Windows.Forms.ComboBox
    $cbFFTBufferSize.width           = 100
    $cbFFTBufferSize.height          = 20
    $cbFFTBufferSize.location        = New-Object System.Drawing.Point(140,45)
    $cbFFTBufferSize.Font            = 'Microsoft Sans Serif,8'
    $cbFFTBufferSize.DropDownStyle   = 'DropDownList'
    $cbFFTBufferSize.Items.AddRange(@(4096,8192,16384,32768,65536))
    $cbFFTBufferSize.SelectedIndex   = [Math]::Round([Math]::Log($v["FFTBufferSize"], 2)-12)    

    # Attack
    $lblFFTAttack                    = New-Object system.Windows.Forms.Label
    $lblFFTAttack.text               = "Attack"
    $lblFFTAttack.AutoSize           = $true
    $lblFFTAttack.width              = 25
    $lblFFTAttack.height             = 10
    $lblFFTAttack.location           = New-Object System.Drawing.Point(10,80)

    $numFFTAttack                    = New-Object PSForms.NumericUpDownX
    $numFFTAttack.width              = 100
    $numFFTAttack.height             = 20
    $numFFTAttack.location           = New-Object System.Drawing.Point(140,75)
    $numFFTAttack.Font               = 'Microsoft Sans Serif,8'
    $numFFTAttack.Minimum            = 0
    $numFFTAttack.Maximum            = 1000
    $numFFTAttack.Value              = $v["FFTAttack"]    

    # Decay
    $lblFFTDecay                     = New-Object system.Windows.Forms.Label
    $lblFFTDecay.text                = "Decay"
    $lblFFTDecay.AutoSize            = $true
    $lblFFTDecay.width               = 25
    $lblFFTDecay.height              = 10
    $lblFFTDecay.location            = New-Object System.Drawing.Point(10,110)
    
    $numFFTDecay                     = New-Object PSForms.NumericUpDownX
    $numFFTDecay.width               = 100
    $numFFTDecay.height              = 20
    $numFFTDecay.location            = New-Object System.Drawing.Point(140,105)
    $numFFTDecay.Font                = 'Microsoft Sans Serif,8'
    $numFFTDecay.Minimum             = 0
    $numFFTDecay.Maximum             = 1000
    $numFFTDecay.Value               = $v["FFTDecay"]
    
    # Sensitivity
    $lblSensitivity                  = New-Object system.Windows.Forms.Label
    $lblSensitivity.text             = "Sensitivity"
    $lblSensitivity.AutoSize         = $true
    $lblSensitivity.width            = 25
    $lblSensitivity.height           = 10
    $lblSensitivity.location         = New-Object System.Drawing.Point(10,140)

    $numSensitivity                  = New-Object PSForms.NumericUpDownX
    $numSensitivity.width            = 100
    $numSensitivity.height           = 20
    $numSensitivity.location         = New-Object System.Drawing.Point(140,135)
    $numSensitivity.Font             = 'Microsoft Sans Serif,8'
    $numSensitivity.Minimum          = 0
    $numSensitivity.Maximum          = 100
    $numSensitivity.Value            = $v["Sensitivity"]
    $numSensitivity.Unit             = " dB"
### <Visualization/> ###

### <Frequency> ###
    $gbFrequency                     = New-Object system.Windows.Forms.Groupbox
    $gbFrequency.height              = 110
    $gbFrequency.width               = 250
    $gbFrequency.text                = "Frequency"
    $gbFrequency.location            = New-Object System.Drawing.Point(270,180)

    # Presets
    $lblPresets                      = New-Object system.Windows.Forms.Label
    $lblPresets.text                 = "Presets"
    $lblPresets.AutoSize             = $true
    $lblPresets.width                = 25
    $lblPresets.height               = 10
    $lblPresets.location             = New-Object System.Drawing.Point(10,20)

    $btnLows                         = New-Object system.Windows.Forms.Button
    $btnLows.text                    = "Lows"
    $btnLows.width                   = 50
    $btnLows.height                  = 20
    $btnLows.location                = New-Object System.Drawing.Point(70,16)

    $btnMids                         = New-Object system.Windows.Forms.Button
    $btnMids.text                    = "Mids"
    $btnMids.width                   = 50
    $btnMids.height                  = 20
    $btnMids.location                = New-Object System.Drawing.Point(130,16)

    $btnAll                          = New-Object system.Windows.Forms.Button
    $btnAll.text                     = "All"
    $btnAll.width                    = 50
    $btnAll.height                   = 20
    $btnAll.location                 = New-Object System.Drawing.Point(190,16)

    # Min
    $lblStartFreqency                = New-Object system.Windows.Forms.Label
    $lblStartFreqency.text           = "Start Frequency"
    $lblStartFreqency.AutoSize       = $true
    $lblStartFreqency.width          = 25
    $lblStartFreqency.height         = 10
    $lblStartFreqency.location       = New-Object System.Drawing.Point(10,50)

    $numFreqMin                      = New-Object PSForms.NumericUpDownX
    $numFreqMin.width                = 100
    $numFreqMin.height               = 20
    $numFreqMin.location             = New-Object System.Drawing.Point(140,45)
    $numFreqMin.Font                 = 'Microsoft Sans Serif,8'
    $numFreqMin.Minimum              = 15
    $numFreqMin.Maximum              = 20000
    $numFreqMin.Value                = $v["FreqMin"]
    $numFreqMin.Unit                 = " hz"

    # Max
    $lblEndFreqency                  = New-Object system.Windows.Forms.Label
    $lblEndFreqency.text             = "End Frequency"
    $lblEndFreqency.AutoSize         = $true
    $lblEndFreqency.width            = 25
    $lblEndFreqency.height           = 10
    $lblEndFreqency.location         = New-Object System.Drawing.Point(10,80)

    $numFreqMax                      = New-Object PSForms.NumericUpDownX
    $numFreqMax.width                = 100
    $numFreqMax.height               = 20
    $numFreqMax.location             = New-Object System.Drawing.Point(140,75)
    $numFreqMax.Font                 = 'Microsoft Sans Serif,8'
    $numFreqMax.Minimum              = 15
    $numFreqMax.Maximum              = 20000
    $numFreqMax.Value                = $v["FreqMax"]
    $numFreqMax.Unit                 = " hz"
### <Frequency/>

### <Cover> ###
    # Cover Box
    $gbCover                        = New-Object system.Windows.Forms.Groupbox
    $gbCover.height                 = 105
    $gbCover.width                  = 250
    $gbCover.text                   = "Cover"
    $gbCover.location               = New-Object System.Drawing.Point(270,290)

    # Opacity
    $lblImageAlpha                  = New-Object system.Windows.Forms.Label
    $lblImageAlpha.text             = "Image Opacity"
    $lblImageAlpha.AutoSize         = $true
    $lblImageAlpha.width            = 25
    $lblImageAlpha.height           = 10
    $lblImageAlpha.location         = New-Object System.Drawing.Point(10,25)
    
    $numImageAlpha                  = New-Object PSForms.NumericUpDownX
    $numImageAlpha.AutoSize         = $true
    $numImageAlpha.width            = 90
    $numImageAlpha.height           = 10
    $numImageAlpha.location         = New-Object System.Drawing.Point(150,24)
    $numImageAlpha.Font             = 'Microsoft Sans Serif,8'
    $numImageAlpha.Minimum          = 0
    $numImageAlpha.Maximum          = 255
    $numImageAlpha.Value            = $v["ImageAlpha"]

    # Scale
    $lblImageSize                  = New-Object system.Windows.Forms.Label
    $lblImageSize.text             = "Image Scale"
    $lblImageSize.AutoSize         = $true
    $lblImageSize.width            = 25
    $lblImageSize.height           = 10
    $lblImageSize.location         = New-Object System.Drawing.Point(10,50)

    $numImageSize                  = New-Object PSForms.NumericUpDownX
    $numImageSize.AutoSize         = $true
    $numImageSize.width            = 90
    $numImageSize.height           = 10
    $numImageSize.location         = New-Object System.Drawing.Point(150,49)
    $numImageSize.Font             = 'Microsoft Sans Serif,8'
    $numImageSize.DecimalPlaces    = 2
    $numImageSize.Minimum          = 0
    $numImageSize.Maximum          = 10
    $numImageSize.Value            = $v["ImageXScale"]

    # React Intensity
    $lblImageARI                    = New-Object system.Windows.Forms.Label
    $lblImageARI.text               = "Image React Intensity"
    $lblImageARI.AutoSize           = $true
    $lblImageARI.width              = 25
    $lblImageARI.height             = 10
    $lblImageARI.location           = New-Object System.Drawing.Point(10,75)

    $numImageARI                    = New-Object PSForms.NumericUpDownX
    $numImageARI.AutoSize           = $true
    $numImageARI.width              = 90
    $numImageARI.height             = 10
    $numImageARI.location           = New-Object System.Drawing.Point(150,74)
    $numImageARI.Font               = 'Microsoft Sans Serif,8'
    $numImageARI.DecimalPlaces      = 1
    $numImageARI.Minimum            = 0
    $numImageARI.Maximum            = 1
    $numImageARI.Value              = $v["ImageAudioReactIntensity"]
### <Cover/> ###

### <MediaPlayer> ###
    $gbMediaPlayer                  = New-Object system.Windows.Forms.Groupbox
    $gbMediaPlayer.height           = 150
    $gbMediaPlayer.width            = 250
    $gbMediaPlayer.text             = "MediaPlayer"
    $gbMediaPlayer.location         = New-Object System.Drawing.Point(530,10)

    # MediaPlayer
    $lblPlayer                      = New-Object system.Windows.Forms.Label
    $lblPlayer.text                 = "Media Player"
    $lblPlayer.AutoSize             = $true
    $lblPlayer.width                = 25
    $lblPlayer.height               = 10
    $lblPlayer.location             = New-Object System.Drawing.Point(10,20)

    $cbPlayer                       = New-Object System.Windows.Forms.ComboBox
    $cbPlayer.width                 = 100
    $cbPlayer.height                = 20
    $cbPlayer.location              = New-Object System.Drawing.Point(140,18)
    $cbPlayer.Font                  = 'Microsoft Sans Serif,8'
    $cbPlayer.DropDownStyle         = 'DropDownList'
    $cbPlayer.Items.AddRange(@('Spotify','Spotify (Now Playing)','GPMDP','Web','WMP','iTunes'))
    $cbPlayer.SelectedItem          = $v["playerName"]

    # Chameleon Colors
    $cbChameleon                    = New-Object system.Windows.Forms.CheckBox
    $cbChameleon.text               = "Chameleon Colors"
    $cbChameleon.AutoSize           = $true
    $cbChameleon.width              = 100
    $cbChameleon.height             = 20
    $cbChameleon.location           = New-Object System.Drawing.Point(10,50)
    $cbChameleon.Checked            = [int]$v["Chameleon"]

    # Single Layer
    $cbSingle                       = New-Object system.Windows.Forms.CheckBox
    $cbSingle.text                  = "Single Layer"
    $cbSingle.AutoSize              = $true
    $cbSingle.width                 = 100
    $cbSingle.height                = 20
    $cbSingle.location              = New-Object System.Drawing.Point(10,75)
    $cbSingle.Checked               = -NOT([int]$v["Layers"])
    #$cbSingle.Enabled               = $cbChameleon.Checked

    # Song Info
    $cbInfo                        = New-Object system.Windows.Forms.CheckBox
    $cbInfo.text                   = "Song Info"
    $cbInfo.AutoSize               = $true
    $cbInfo.width                  = 100
    $cbInfo.height                 = 20
    $cbInfo.location               = New-Object System.Drawing.Point(10,100)
    $cbInfo.Checked                = [int]$v["Info"]

    # Info Orientation
    $lblOri                         = New-Object system.Windows.Forms.Label
    $lblOri.text                    = "Orientation"
    $lblOri.AutoSize                = $true
    $lblOri.width                   = 25
    $lblOri.height                  = 10
    $lblOri.location                = New-Object System.Drawing.Point(10,125)
    $lblOri.Enabled                 = $cbInfo.Checked

    $cbOri                          = New-Object System.Windows.Forms.ComboBox
    $cbOri.width                    = 100
    $cbOri.height                   = 20
    $cbOri.location                 = New-Object System.Drawing.Point(140,123)
    $cbOri.Font                     = 'Microsoft Sans Serif,8'
    $cbOri.DropDownStyle            = 'DropDownList'
    $cbOri.Items.AddRange(@('Left','Right','Center'))
    $cbOri.SelectedItem             = $v["Orientation"]
    $cbOri.Enabled                  = $cbInfo.Checked
### <MediaPlayer/>

# Apply Button
$btnApply                           = New-Object system.Windows.Forms.Button
$btnApply.text                      = "Apply"
$btnApply.width                     = 775
$btnApply.height                    = 30
$btnApply.location                  = New-Object System.Drawing.Point(10,400)

# Wire the buttons
$btnApply.Add_Click({ applyClick })
$btnLows.Add_Click({ btnLowsClick })
$btnMids.Add_Click({ btnMidsClick })
$btnAll.Add_Click({ btnAllClick })

# Enable/Disable checkboxes
$cbMirror.Add_CheckedChanged({ $cbInvertMirror.Enabled = $cbMirror.Checked })
$cbInfo.Add_CheckedChanged({ $cbOri.Enabled = $cbInfo.Checked; $lblOri.Enabled = $cbInfo.Checked })

### <Helper Functions> ###
    function WriteKeyValue([string] $key, [string] $value)
    {
        $wpps::WritePrivateProfileString("Variables", $key, $value, $variablesPath)
    }

    function CommandMeasure([string] $measure, [string] $arguments, [string] $config)
    {
        & $rmPath !CommandMeasure "$measure" "$arguments" "$config"
    }

    function btnLowsClick 
    {
        $numFreqMin.Value = 18;
        $numFreqMax.Value = 250;
    }

    function btnMidsClick 
    {
        $numFreqMin.Value = 20;
        $numFreqMax.Value = 2000;
    }

    function btnAllClick
    {
        $numFreqMin.Value = 20;
        $numFreqMax.Value = 15000;
    }

    function MediaPlayer
    {
        WriteKeyValue ImageTint2 '255,255,255'
        WriteKeyValue Layer0Color '255,255,255'
        WriteKeyValue Layer1Color ''
        WriteKeyValue Layers 0

        if($cbPlayer.SelectedItem.equals("Spotify"))
        {
            WriteKeyValue playerName 'Spotify'
            WriteKeyValue playerPlugin 'Web'
            WriteKeyValue ImageTint2 '0,0,0'
            WriteKeyValue Layer0Color '0,0,0'
            WriteKeyValue Layer1Color '30,215,96'
            WriteKeyValue Layers 1
            WriteKeyValue playerEXE '%userprofile%\AppData\Roaming\Spotify\Spotify.exe'
            WriteKeyValue ImageName 'spotify.png'    
        } elseif ($cbPlayer.SelectedItem.equals("Spotify (Now Playing)"))
        {
            WriteKeyValue playerName 'Spotify'
            WriteKeyValue playerPlugin 'NowPlaying'
            WriteKeyValue ImageTint2 '0,0,0'
            WriteKeyValue Layer0Color '0,0,0'
            WriteKeyValue Layer1Color '30,215,96'  
            WriteKeyValue Layers 1
            WriteKeyValue playerEXE '%userprofile%\AppData\Roaming\Spotify\Spotify.exe'
            WriteKeyValue ImageName 'spotify.png'    
        } elseif ($cbPlayer.SelectedItem.equals("GPMDP"))
        {
            WriteKeyValue playerName 'GPMDP'
            WriteKeyValue playerPlugin 'GPMDP'
            WriteKeyValue playerEXE '%userprofile%\AppData\Local\GPMDP_3\app-4.7.1\Google Play Music Desktop Player.exe'
            WriteKeyValue ImageName 'gpmdp.png'
        } elseif ($cbPlayer.SelectedItem.equals("Web"))
        {
            WriteKeyValue playerName 'Web'
            WriteKeyValue playerPlugin 'Web'
            WriteKeyValue playerEXE ''
            WriteKeyValue ImageName 'trapnation.png'
        } elseif ($cbPlayer.SelectedItem.equals("WMP"))
        {
            WriteKeyValue playerName 'WMP'
            WriteKeyValue playerPlugin 'NowPlaying'
            WriteKeyValue playerEXE 'wmplayer.exe'
            WriteKeyValue ImageName 'trapnation.png'
        } elseif ($cbPlayer.SelectedItem.equals("iTunes"))
        {
            WriteKeyValue playerName 'iTunes'
            WriteKeyValue playerPlugin 'NowPlaying'
            WriteKeyValue playerEXE 'iTunes.exe'
            WriteKeyValue ImageName 'itunes.png'
        }
    }

    function applyClick 
    {
        $doMirror = [int]$cbMirror.Checked
        $doInvertMirror = [int]$cbInvertMirror.Checked
        $doHollowCenter = [int]$cbHollowCenter.Checked
        $fftSize = [Math]::Pow(2, 9 + $cbFFTSize.SelectedIndex)
        $fftBufferSize = [Math]::Pow(2, 12 + $cbFFTBufferSize.SelectedIndex)
        $doChameleon = [int]$cbChameleon.Checked
        $ShowInfo   = [int]$cbInfo.Checked

        if ($fftBufferSize -lt $fftSize)
        {
            $fftBufferSize = $fftSize
            $cbFFTBufferSize.SelectedIndex = [Math]::Round([Math]::Log($fftSize, 2)-12)
        }

        # Set the media player data
        MediaPlayer

        # Set the chameleon colors
        if ([int]$cbChameleon.Checked -eq 1)
        {
            WriteKeyValue ImageTint2 '[MeasureBackground]'
            WriteKeyValue Layer0Color '[MeasureBackground]'
            WriteKeyValue Layer1Color '[MeasureForeground2]' 
        }

        if ([int]$cbSingle.Checked -eq 1) 
        { 
            WriteKeyValue Layer1Color ''
            WriteKeyValue Layers 0
        }

        if ([int]$cbInfo.Checked -eq 1)
        {
            WriteKeyValue Orientation $cbOri.SelectedItem
            if ($cbOri.SelectedItem.equals("Left")) 
            {
                WriteKeyValue BarDir -1 
                & $rmPath !ActivateConfig "TrapNationVis\Assets" "Info.ini"
            }
            elseif ($cbOri.SelectedItem.equals("Right")) { 
                WriteKeyValue BarDir 1 
                & $rmPath !ActivateConfig "TrapNationVis\Assets" "Info.ini"
            }
            else
            {
                WriteKeyValue BarDir 0
                & $rmPath !ActivateConfig "TrapNationVis\Assets" "Center.ini"
            }
        } 
        else 
        {
            & $rmPath !DeactivateConfig "TrapNationVis\Assets"
        }

        WriteKeyValue Chameleon $doChameleon
        WriteKeyValue Info $ShowInfo
        WriteKeyValue DelayPerLayer $numLayers.Value
        WriteKeyValue Bands $numBars.Value
        WriteKeyValue Height $numHeight.Value
        WriteKeyValue Radius $numRadius.Value
        WriteKeyValue StartAngle $numStartAngle.Value
        WriteKeyValue EndAngle $numEndAngle.Value
        WriteKeyValue AngularDisplacement $numAngularDisplacement.Value
        WriteKeyValue Smoothing $numSmoothing.Value

        WriteKeyValue Mirror $doMirror
        WriteKeyValue InvertMirror $doInvertMirror
        WriteKeyValue HollowCenter $doHollowCenter

        WriteKeyValue FFTSize $fftSize
        WriteKeyValue FFTBufferSize $fftBufferSize
        WriteKeyValue FFTAttack $numFFTAttack.Value
        WriteKeyValue FFTDecay $numFFTDecay.Value
        WriteKeyValue FreqMin $numFreqMin.Value
        WriteKeyValue FreqMax $numFreqMax.Value
        WriteKeyValue Sensitivity $numSensitivity.Value

        WriteKeyValue ImageXScale $numImageSize.Value
        WriteKeyValue ImageYScale $numImageSize.Value
        WriteKeyValue ImageAlpha $numImageAlpha.Value
        WriteKeyValue ImageAudioReactIntensity $numImageARI.Value

        CommandMeasure "InitScript" "GenerateTNVis()" $v["Config"]
        & $rmPath !RefreshGroup "SongInfo"
    }
### <HelperFunctions/> ###

$form.controls.AddRange(@($gbGeneral,$gbBar,$gbVisualizer,$gbVisualization,$gbVisualizer,$gbFrequency,$gbMediaPlayer,$gbCover,$btnApply))
$gbGeneral.controls.AddRange(@($numRadius,$lblRadius, $lblHeight, $numHeight,$lblStartAngle,$lblEndAngle,$lblAngularDisplacement,$numStartAngle,$numEndAngle,$numAngularDisplacement))
$gbBar.controls.AddRange(@($lblBarAmount,$cbHollowCenter,$numBars))
$gbVisualization.controls.AddRange(@($lblFFTSize,$lblFFTBufferSize,$lblFFTAttack,$lblFFTDecay,$lblSensitivity,$numFFTAttack,$numFFTDecay,$cbFFTBufferSize,$cbFFTSize,$numSensitivity))
$gbVisualizer.controls.AddRange(@($cbMirror,$cbInvertMirror,$lblSmoothing,$numSmoothing,$lblLayers,$numLayers))
$gbFrequency.controls.AddRange(@($lblStartFreqency,$lblEndFreqency,$lblPresets,$numFreqMin,$numFreqMax,$btnLows,$btnMids,$btnAll))
$gbMediaPlayer.Controls.AddRange(@($lblPlayer,$cbPlayer,$cbChameleon,$cbSingle,$lblOri,$cbOri,$cbInfo))
$gbCover.Controls.AddRange(@($lblImageAlpha,$lblImageSize,$lblImageARI,$numImageAlpha,$numImageSize,$numImageARI))

$form.ResumeLayout()

[Windows.Forms.Application]::Run($form)