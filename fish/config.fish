set fish_greeting ""
export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin

#set -gx TERM xterm-256color
set -gx TERM xterm-kitty

set -gx MSSQL_SCRIPTER_CONNECTION_STRING "sqlserver://localhost:1433;database=quan_ly_du_an;integratedSecurity=true;username=sa;password=Thu@n12312;trustServerCertificate=true;"
set -gx MSSQL_SCRIPTER_PASSWORD Thu@n12312
# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias python "python3.13"
alias dp docker-compose
alias dk docker
alias y yarn
alias n npm
alias pnpm p
alias b bun
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
alias ll "exa -l -g --icons --git"
alias llt "exa -l --icons --tree --git-ignore"
alias yz yazi
alias vtt nvim1
alias cl claude

command -qv nvim && alias vim nvim

set -gx ZK_NOTEBOOK_DIR ~/note-taking-system
set -gx EDITOR nvim
set -gx ANDROID_HOME ~/tools/android/sdk
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home
set -gx GOPATH ~/.local/src/go

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.gvm/bin $PATH

# set -gx PATH $JAVA_HOME/bin $PATH

set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH

set -gx PATH $MSSQL_SCRIPTER_CONNECTION_STRING $PATH
set -gx PATH $MSSQL_SCRIPTER_PASSWORD $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME /Users/gin/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

starship init fish | source
