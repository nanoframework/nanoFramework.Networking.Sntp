# Copyright (c) 2018 The nanoFramework project contributors
# See LICENSE file in the project root for full license information.


# choco install wixtoolset -y --force

# #Installing VS extension 'Wix Toolset Visual Studio 2017 Extension'
# Install-VsixExtension -Url 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vs-publisher-1470366/vsextensions/nanoFrameworkVS2017Extension/0/vspackage' -Name 'nanoFramework.Tools.VS2017.Extension.vsix'


# # install VSSetup PS module (https://github.com/Microsoft/vssetup.powershell)
# 'Installing VSSetup module ...' | Write-Host -ForegroundColor White
# Install-Module VSSetup -Scope CurrentUser -AcceptLicense -Force

# # get Visual Studio install path
# $vsInstallPath = Get-VSSetupInstance `
# | Select-VSSetupInstance `
# | Select-Object -ExpandProperty InstallationPath

# extension path
$vsixPath = Join-Path $env:Agent_TempDirectory "nanoFramework.Tools.VS2017.Extension.vsix"
# installer path
$INSTALLER_PATH = Join-Path $env:Agent_TempDirectory "install-vsix.cmd"
Write-Host ("##vso[task.setvariable variable=INSTALLER_PATH;]$INSTALLER_PATH")

# "Downloading extension from marketplace..." | Write-Host -ForegroundColor White

# # # download extension from marketplace
# $FileUrl = 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vs-publisher-1470366/vsextensions/nanoFrameworkVS2017Extension/0/vspackage'
# # (New-Object Net.WebClient).DownloadFile('https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vs-publisher-1470366/vsextensions/nanoFrameworkVS2017Extension/0/vspackage', $vsixPath)

# $start_time = Get-Date
# Invoke-WebRequest -Uri "$FileUrl" -OutFile $vsixPath -UseDefaultCredentials -UseBasicParsing
# Write-Host "Time taken to download: $((Get-Date).Subtract($start_time).Seconds) second(s)"

# # $installScript = Join-Path $env:Agent_TempDirectory "install-vsix.cmd"

$Url = "https://vs-publisher-1470366.gallerycdn.vsassets.io/extensions/vs-publisher-1470366/nanoframeworkvs2017extension/1.0.0.0/1539707795657/nanoFramework.Tools.VS2017.Extension.vsix"
$Name = "nanoFramework.Tools.VS2017.Extension.vsix"

Write-Host "Downloading $Name..."
$FilePath = "${env:Temp}\$Name"

Invoke-WebRequest -Uri $Url -OutFile $FilePath

# $ArgumentList = ('/quiet /a', $FilePath)

# install on normal process 
Write-Host "Starting Install $Name..."
Start-Process -FilePath 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\VSIXInstaller.exe' -ArgumentList " /skuName:Enterprise /skuVersion:15.0 /quiet /a $FilePath" -Wait -PassThru

# # install on process with timeout
# Write-Host "Starting Install $Name..."

# $proc = Start-Process -FilePath 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\VSIXInstaller.exe' -ArgumentList "/q /a $FilePath" -Wait -PassThru

# # keep track of timeout event
# $timeouted = $null # reset any previously set timeout

# # wait up to 4 minutes (4 * 60 = 240 seconds) for normal termination
# Wait-Process -Name "VSIXInstaller" -Timeout 240 -ErrorAction SilentlyContinue -ErrorVariable $timeouted
# # $proc | Wait-Process -Timeout 240 -ErrorAction SilentlyContinue -ErrorVariable timeouted

# if ($timeouted)
# {
#     # terminate the process
#     $proc | kill

#     # update internal error counter
# }
# elseif ($proc.ExitCode -ne 0)
# {
#     # update internal error counter
# }



# ("`"$vsInstallPath\Common7\IDE\VSIXInstaller.exe`" /q $vsixPath" | Out-File $installScript -Encoding ASCII)

# # "`"$vsInstallPath\Common7\IDE\VSIXInstaller.exe`" /q /a $vsixPath" | out-file ".\install-vsix.cmd" -Encoding ASCII
# "`"C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\VSIXInstaller.exe`" /skuName:Enterprise /skuVersion:15.0 /q /a `"$vsixPath`"" | out-file $INSTALLER_PATH -Encoding ASCII
"`"$vsInstallPath\Common7\IDE\VSIXInstaller.exe`" /skuName:Enterprise /skuVersion:15.0 /q `"$vsixPath`"" | out-file $INSTALLER_PATH -Encoding ASCII

# Start-Process -FilePath "$vsInstallPath\Common7\IDE\VSIXInstaller.exe" -ArgumentList "/q $extension" -Wait -PassThru

# 'Installing nanoFramework VS extension ...' | Write-Host -ForegroundColor White -NoNewline
# Invoke-Expression "& '$env:ComSpec' '$installScript'"
# Invoke-Expression "& '$installScript'"

# 'OK' | Write-Host -ForegroundColor Green
