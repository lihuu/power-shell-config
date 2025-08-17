#chcp 65001

#Import-Module oh-my-posh
#Import-Module posh-git
#Add-PoshGitToProfile
Import-Module -Name Terminal-Icons
#Import-Module -Name PSFzf
function Get-PSVersion {
  $PSVersionTable.PSVersion
}

function Get-LPSVersion {
  $PSVersionTable.PSVersion
}
function Get-ModulePath {
  $env.PSModulePath
}

function Get-ProfileDir {
  $PROFILE | Split-Path
}

$env:PROFILE_DIR = $(Get-ProfileDir)


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


function Test-CommandExist {
  param (
    [string] $path = ""
  )
  return !($null -eq (Get-Command -CommandType Application -ErrorAction SilentlyContinue $path))
}

function Edit-Profile {
  if (Test-CommandExist("code")) {
    code $PROFILE
  }
  elseif (Test-CommandExist("gvim")) {
    gvim $PROFILE
  }
  elseif (Test-CommandExist vim) {
    vim $PROFILE
  }
  elseif (Test-CommandExist nvim) {
    nvim $PROFILE
  }
  else {
    notepad.exe $PROFILE
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

If (-Not (Test-Path Variable:PSise)) {
  # Only run this in the console and not in the ISE
  Import-Module Get-ChildItemColor
  Set-Alias ll Get-ChildItemFormatedTable -option AllScope
  #Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
  Set-Alias ls Get-ChildItemFormatedWide -option AllScope
}

if (-Not (Test-CommandExist("winget"))) {
  # 安装winget
  Write-Output "winget not found, will install it, please install it from windows store!"
}
else {
  Set-Alias apt winget
  function Get-Upgradable {
    apt list --upgrade-available
  }
  function Update-All {
    apt upgrade --all
  }

  function Get-WinGetInstalled {
    apt list
  }

  function Invoke-WinGetUpgrade {
    [CmdletBinding()]
    param (
      [Parameter(Mandatory = $true)]
      [string]$content
    )


    begin {
      Write-Output "Start upgraded $content"
    }

    process {
      $appName = $content.Replace("^", "")
      apt upgrade $appName
    }

    end {
      Write-Output "Upgrade $content successfully"
    }
  }

  function Get-WingetUpgradable {
    # Install-Package Microsoft.WinGet.Client
    #Get-Upgradable | Select-String -Pattern "winget" | ForEach-Object { $_.Line } | fzf --bind 'enter:become(pwsh -c "Invoke-WingetUpgrade {}")' 
    Get-WinGetPackage | Where-Object IsUpdateAvailable | ForEach-Object { $_.Id } |  fzf --bind 'enter:become(pwsh -c "Invoke-WinGetUpgrade {}")' 
  }
}

Set-Alias pwd Get-Location -option AllScope
Set-Alias version Get-LPSVersion -option AllScope

#Set-Theme Paradox
#Set-Theme Honukai
# https://ohmyposh.dev/docs/themes
#Set-PoshPrompt Honukai
#Set-PoshPrompt slim
#Set-PoshPrompt material

#Set-PoshPrompt -Theme marcduiker

#pip install thefuck
#Invoke-Expression "$(thefuck --alias)"

#oh-my-posh init pwsh | Invoke-Expression

Invoke-Expression (&starship init powershell)
# 检查powershell启动时间
#Measure-Command { PowerShell.exe -NoProfile -Command { } }
#Write-Host ''

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58


Set-Alias open explorer.exe

function Add-GitIgnore {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$FilePath
  )
  
  # Normalize the file path
  $FilePath = $FilePath.Replace('\', '/').Trim()
  
  # Find the git root directory
  $gitRoot = git rev-parse --show-toplevel 2>$null
  if (-not $?) {
    Write-Error "Not in a git repository"
    return
  }
  
  $gitignorePath = Join-Path $gitRoot '.gitignore'
  
  # Create .gitignore if it doesn't exist
  if (-not (Test-Path $gitignorePath)) {
    New-Item -Path $gitignorePath -ItemType File | Out-Null
    Write-Output "Created new .gitignore file"
  }
  
  # Check if file path is already in .gitignore
  $content = Get-Content $gitignorePath -ErrorAction SilentlyContinue
  if ($content -contains $FilePath) {
    Write-Output "'$FilePath' is already in .gitignore"
    return
  }
  
  # Add the file to .gitignore
  Add-Content -Path $gitignorePath -Value "`n$FilePath"
  Write-Output "Added '$FilePath' to .gitignore"
}

function Get-GitIgnore {
  $gitRoot = git rev-parse --show-toplevel 2>$null
  if (-not $?) {
    Write-Error "Not in a git repository"
    return
  }
  
  $gitignorePath = Join-Path $gitRoot '.gitignore'
  
  if (-not (Test-Path $gitignorePath)) {
    Write-Output "No .gitignore file found"
    return
  }
  
  Get-Content $gitignorePath
}


# write set proxy
function Set-Proxy {
  param (
    [string]$Server = "127.0.0.1",
    [string]$Port = "7890"
  )
  
  $env:http_proxy = "http://${Server}:${Port}"
  $env:https_proxy = "http://${Server}:${Port}"
  
  Write-Output "Proxy set to: $env:http_proxy"
}

function Remove-Proxy {
  $env:http_proxy = ""
  $env:https_proxy = ""
  
  Write-Output "Proxy settings removed"
}

function Get-Proxy {
  Write-Output "Current proxy settings:"
  Write-Output "HTTP Proxy: $env:http_proxy"
  Write-Output "HTTPS Proxy: $env:https_proxy"
}

set-proxy

