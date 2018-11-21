# Copyright (c) 2018 The nanoFramework project contributors
# See LICENSE file in the project root for full license information.

# This PS download and installs 7zip executable

$env:SEVENZIP_PATH = "C:\7zip"

md $($env:SEVENZIP_PATH) > $null

Write-Host "Downloading 7zip..."

$url = "https://bintray.com/nfbot/internal-build-tools/download_file?file_path=7za.exe"

$output = "$env:SEVENZIP_PATH\7z.exe"

# download executable with utility
(New-Object Net.WebClient).DownloadFile($url, $output)

