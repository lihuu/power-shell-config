Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
Install-Module -Name PSFzf -Repository PSGallery -Scope CurrentUser

Install-Module posh-git -Force -AllowPrerelease -Scope CurrentUser

Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser
