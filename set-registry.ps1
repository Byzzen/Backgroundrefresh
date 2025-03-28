# Define the folder paths
$sourceFolder = $PSScriptRoot # Current folder where the script resides
$destinationFolder = "C:\Windows\customization"

# Check if the destination folder exists, if not, create it
if (-not (Test-Path -Path $destinationFolder -PathType Container)) {
    New-Item -Path $destinationFolder -ItemType Directory -Force
}

# Copy PNG files from the current folder to the destination folder
Get-ChildItem -Path $sourceFolder -Filter *.png | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $destinationFolder -Force
}

# Copy all PS1 files from the current folder to the destination folder
Get-ChildItem -Path $sourceFolder -Filter set-wallpaper.ps1 | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $destinationFolder -Force
}

# Define registry key path
$Wallpaperkeypath = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{DesktopBranding}"

# Add registry values
New-Item -Path $Wallpaperkeypath -Force | Out-Null
New-ItemProperty -Path $Wallpaperkeypath -Name "(Default)" -Value "DesktopBranding" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $Wallpaperkeypath -Name "Version" -Value "1.1" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $Wallpaperkeypath -Name "StubPath" -Value 'powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Windows\customization\set-wallpaper.ps1"' -PropertyType String -Force | Out-Null

# Define the registry key path
$keyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
New-Item -Path $keyPath -Force | Out-Null
# Set LockScreenImage value
Set-ItemProperty -Path $keyPath -Name "LockScreenImage" -Value "c:\windows\customization\LockScreen.png"

# Set LockScreenOverlaysDisabled value
Set-ItemProperty -Path $keyPath -Name "LockScreenOverlaysDisabled" -Value 1 -Type DWord

# Set NoChangingLockScreen value
Set-ItemProperty -Path $keyPath -Name "NoChangingLockScreen" -Value 1 -Type DWord