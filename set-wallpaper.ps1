# Define the path to the image file for the wallpaper
$wallpaperPath = "C:\Windows\Customization\Background.png"

# Function to set the wallpaper
Function Set-Wallpaper {
    Param (
        [string]$WallpaperPath
    )

    # Load required assemblies
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    # Set the wallpaper
    $SystemParametersInfo = @"
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
"@
    $SPI_SETDESKWALLPAPER = 20
    $UpdateIniFile = 0x01
    $SendChange = 0x02

    $result = Add-Type -MemberDefinition $SystemParametersInfo -Name Win32Utils -Namespace SystemUtils -PassThru

    $result::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $WallpaperPath, $UpdateIniFile -bor $SendChange)
}
# Set the path to the background image
$backgroundImagePath = "C:\Windows\customization\Background.png"

# Set the registry key
$regKey = "HKCU:\Control Panel\Desktop"
$regValueName = "WallPaper"
$regValueType = "String"

# Set the background image as the wallpaper
Set-ItemProperty -Path $regKey -Name $regValueName -Value $backgroundImagePath -Type $regValueType

# Refresh the desktop to apply changes
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
# Set the wallpaper
Set-Wallpaper -WallpaperPath $wallpaperPath