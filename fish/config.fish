set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias glo "git log --oneline"
alias gl "git log"
alias gp "git push"
alias gpull "git pull"
alias lzg lazygit
alias g git
alias v nvim

command -qv nvim && alias vim nvim

set -gx EDITOR nvim
set -gx ANDROID_HOME /mnt/DATA/Dev/android
set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64


set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

set -gx PATH $JAVA_HOME/bin $PATH

set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
    status --is-command-substitution; and return

    if test -f .nvmrc; and test -r .nvmrc
        nvm use
    else
    end
end

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
