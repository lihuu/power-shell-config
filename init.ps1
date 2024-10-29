#windows 软件平台环境初始化

if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue choco.exe)){
    # 安装choco ，默认软件会安装到 C:/tools 目录中
    Write-Output "Choco not found will install it"
    .\ChocolateyInstallNonAdmin.ps1
}


if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue scoop)){
    # 安装 scoop，软件安装的目录默认的即可
    # https://scoop.sh/
    Write-Output "scoop not found, will instal it"
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    scoop config proxy 127.0.0.1:7890
}

Write-Output "Start to install software using scoop"
# 先添加bucket
scoop bucket add extras
scoop bucket add nirsoft
scoop bucket add dorado https://github.com/h404bi/dorado
scoop bucket add Ash258 'https://github.com/Ash258/Scoop-Ash258.git'
scoop bucket add nerd-fonts
# 对于开发人员，可添加下面的两个
scoop bucket add java
scoop bucket add versions
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
#
scoop install ripgrep
#
scoop install sudo
#
scoop install unzip
#将剪贴板中的图像保存为文件
#https://github.com/huiyadanli/PasteEx.git
scoop install pasteex
#类似于cat，但是提供高亮
#https://github.com/sharkdp/bat.git
scoop install bat
scoop install fd
scoop install runcat
#Windows wsl
scoop install archwsl
#
scoop install cmake

#scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
scoop install neovim
scoop install neovim-qt
scoop install neovide
scoop install vim-nightly

scoop install mobaxterm
scoop install everything
scoop install wox
scoop install listary
scoop install wingetui
scoop install starship
scoop install posh-git
scoop install sourcetree
scoop install gpg4win
scoop install IBMPlexMono-NF
scoop install FiraCode-NF
scoop install JetBrainsMono-NF
scoop install wget
scoop install sed
scoop install totalcommander
scoop install git-credential-manager
scoop install sourcegit
scoop install gitextensions

#Tickeys


# check the exisitence of winget
if($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue winget)){
    # 安装winget
    Write-Output "winget not found, will install it, please install it from windows store!"
}
