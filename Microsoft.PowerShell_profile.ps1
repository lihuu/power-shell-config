#chcp 65001

#Import-Module oh-my-posh
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module -Name PSFzf
function Get-PSVersion{
    $PSVersionTable.PSVersion
}

function Get-LPSVersion{
    $PSVersionTable.PSVersion
}
function Get-ModulePath{
    $env.PSModulePath
}

function Get-ChildItemFormatedWide {
    param (
        [string]$Path = ""
    )

    $Expression = "Get-ChildItem -Path `"$Path`" $Args | Format-Wide -AutoSize"
    $Items = Invoke-Expression $Expression
    ForEach ($Item in $Items) {
        $Item
    }
}

function Get-ChildItemFormatedTable {
    param (
        [string]$Path = ""
    )

    $Expression = "Get-ChildItem -Path `"$Path`" $Args | Format-Table -AutoSize"
    $Items = Invoke-Expression $Expression
    ForEach ($Item in $Items) {
        $Item
    }
}

If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor
    Set-Alias ll Get-ChildItemFormatedTable -option AllScope
    #Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
    Set-Alias ls Get-ChildItemFormatedWide -option AllScope
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

oh-my-posh init pwsh | Invoke-Expression

Write-Host ''
