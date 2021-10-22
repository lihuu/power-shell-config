#windows 软件平台环境初始化

if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue choco.exe)){
    # 安装choco ，默认软件会安装到 C:/tools 目录中
    Write-Output "Choce not found will install it"
    .\ChocolateyInstallNonAdmin.ps1
}

#安装一些必备的软件，chocolatey这个上面的软件要比scoop上面的稍微新一些
choco install neovim -y


if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue scoop)){
    # 安装 scoop，软件安装的目录默认的即可
    # https://scoop.sh/
    Write-Output "scoop not found, will instal it"
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    scoop config proxy http://localhost:7891
}
#使用scoop 安装一些软件
scoop install 7zip
scoop install ack
scoop install fzf
scoop install graphviz
scoop install hugo
scoop install maven
scoop install mkcert
scoop install pandoc
scoop install perl
scoop install ripgrep
scoop install sudo
scoop install unzip

