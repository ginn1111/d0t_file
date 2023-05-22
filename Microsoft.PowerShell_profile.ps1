Set-Alias g git
Set-Alias v nvim
Set-Alias ll ls

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -EditMode Emacs

Invoke-Expression (&starship init powershell)
