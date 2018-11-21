# Copyright (c) 2018 The nanoFramework project contributors
# See LICENSE file in the project root for full license information.

[System.Net.WebClient]$webClient = New-Object System.Net.WebClient
$webClient.UseDefaultCredentials = $true

function DownloadVsixFile($fileUrl, $downloadFileName)
{
    # Write-Debug "Download VSIX file from $fileUrl to $downloadFileName"
    # Write-Host "Download VSIX file..."
    $webClient.DownloadFile($fileUrl,$downloadFileName)
}

# download VS extension
$vsixPath = Join-Path  $($env:temp) "nanoFramework.Tools.VS2017.Extension.zip"
# this was the original download URL that provides the last version, but the marketplace is blocking access to it
# "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vs-publisher-1470366/vsextensions/nanoFrameworkVS2017Extension/0/vspackage
DownloadVsixFile "https://www.myget.org/F/nanoframework-dev/vsix/47973986-ed3c-4b64-ba40-a9da73b44ef7-1.0.1.0.vsix" $vsixPath

# unzip extension
# Write-Debug "Unzip extension content"
# Write-Host "Unzip extension content"
Invoke-Expression "$env:SEVENZIP_PATH\7z.exe x $vsixPath -bd -o$env:temp\nf-extension" > $null

# copy build files to msbuild location
# Write-Debug "Copy build files to msbuild location"
# Write-Host "Copy build files to msbuild location"
$msbuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild"
Copy-Item -Path "$env:temp\nf-extension\`$MSBuild\nanoFramework" -Destination $msbuildPath -Recurse
