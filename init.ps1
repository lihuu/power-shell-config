


if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue choco.exe)){
    # 安装choco
    Write-Output "Choce not found will install it"
    .\ChocolateyInstallNonAdmin.ps1
}


if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue scoop)){
    # 安装 scoop
    Write-Output "scoop not found, will instal it"
}

