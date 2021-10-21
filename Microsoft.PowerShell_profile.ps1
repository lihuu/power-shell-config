chcp 65001
Import-Module posh-git
Import-Module oh-my-posh
function Get-PSVersion{
    $PSVersionTable.PSVersion
}

function Get-LPSVersion{
    $PSVersionTable.PSVersion
}
function Get-ModulePath{
    $env.PSModulePath
}

If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor
    Set-Alias ll Get-ChildItem -option AllScope
    Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
}

Set-Alias pwd Get-Location -option AllScope
Set-Alias version Get-LPSVersion -option AllScope

#Set-Theme Paradox
#Set-Theme Honukai
# https://ohmyposh.dev/docs/themes
#Set-PoshPrompt Honukai
#Set-PoshPrompt slim
#Set-PoshPrompt material

Set-PoshPrompt -Theme marcduiker

#pip install thefuck
Invoke-Expression "$(thefuck --alias)"
