#Alias
Set-Alias v nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Invoke-Expression (&starship init powershell)

# Terminal-Icons
Import-Module -Name Terminal-Icons
