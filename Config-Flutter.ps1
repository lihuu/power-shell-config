
# cd to flutter dir
currentDirectory = Get-Location   
newPath = "$currentDirectory\bin;$env:PATH"
[System.Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
[System.Environment]::SetEnvironmentVariable('PUB_HOSTED_URL', 'https://pub.flutter-io.cn', 'User')
[System.Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL', 'https://storage.flutter-io.cn', 'User')

Write-Host ". $PROFILE"
