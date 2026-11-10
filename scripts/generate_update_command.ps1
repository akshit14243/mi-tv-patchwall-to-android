<#
.SYNOPSIS
    Generates Xiaomi Mi TV recovery command trigger files (xiaomi_update and xiaomi_update-magnolia).

.DESCRIPTION
    Creates clean, extensionless recovery instruction files for FAT32 USB drives used in
    upgrading Xiaomi Mi TV (PatchWall to Android TV).

.PARAMETER UsbDrive
    Drive letter of your USB flash drive (e.g. "E:" or "E:\"). If omitted, files are created in the current directory.

.PARAMETER ZipFileName
    Name of the firmware update zip file. Defaults to "update-magnolia_p_rel_190830r2854-3698-user.zip".

.PARAMETER WipeData
    Switch to append --wipe_data to perform a full factory reset alongside installation (recommended for major version jumps).

.EXAMPLE
    .\generate_update_command.ps1 -UsbDrive "E:"
    .\generate_update_command.ps1 -UsbDrive "E:" -WipeData
#>

[CmdletBinding()]
param(
    [string]$UsbDrive = ".",
    [string]$ZipFileName = "update-magnolia_p_rel_190830r2854-3698-user.zip",
    [switch]$WipeData
)

$targetDir = Resolve-Path $UsbDrive
$commandContent = "--update_package=/udisk/$ZipFileName"
if ($WipeData) {
    $commandContent += "`n--wipe_data"
}

$filesToCreate = @(
    "xiaomi_update-magnolia"
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Xiaomi Mi TV Recovery Command Generator" -ForegroundColor Yellow
Write-Host " Developed by Akshit Saini (@akshit14243)" -ForegroundColor DarkGray
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Target Directory : $targetDir"
Write-Host " Firmware Target  : /udisk/$ZipFileName"
Write-Host " Wipe Data Option : $WipeData"
Write-Host ""

foreach ($fileName in $filesToCreate) {
    $outPath = Join-Path $targetDir $fileName
    [System.IO.File]::WriteAllText($outPath, $commandContent + "`n")
    Write-Host " [+] Created: $outPath" -ForegroundColor Green
}

Write-Host ""
Write-Host " Done! Copy your firmware zip and these files to the root of your FAT32 USB drive." -ForegroundColor Cyan
