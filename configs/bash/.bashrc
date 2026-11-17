# Bash settings migrated from ../fish/config.fish.
# Keep this file safe to source more than once and from any directory.

export ZK_NOTEBOOK_DIR="${ZK_NOTEBOOK_DIR:-$HOME/note-taking-system}"
export EDITOR="${EDITOR:-nvim}"
export ANDROID_HOME="${ANDROID_HOME:-$HOME/tools/android/sdk}"
export GOPATH="${GOPATH:-$HOME/.local/src/go}"
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export INKDROP_HOME="${INKDROP_HOME:-$HOME/.inkdrop}"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

case "$(uname -s)" in
  Darwin) export PNPM_HOME="${PNPM_HOME:-$HOME/Library/pnpm}" ;;
  *) export PNPM_HOME="${PNPM_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/pnpm}" ;;
esac

_dotfiles_path_prepend() {
  [[ -d $1 ]] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

for _dotfiles_dir in \
  /opt/homebrew/bin /usr/local/bin \
  "$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.gvm/bin" \
  "$HOME/Library/Python/3.11/bin" \
  "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools" \
  "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin" \
  "$ANDROID_HOME/cmdline-tools/latest/bin" \
  "$HOME/.dbx/bin" "$GOPATH/bin" "$BUN_INSTALL/bin" "$PNPM_HOME" \
  "$HOME/.opencode/bin" "$HOME/.antigravity/antigravity/bin" \
  "$HOME/.antigravity-ide/antigravity-ide/bin" "$HOME/.jenv/shims"; do
  _dotfiles_path_prepend "$_dotfiles_dir"
done
unset _dotfiles_dir
unset -f _dotfiles_path_prepend
export PATH

[[ $- == *i* ]] || return 0

shopt -s checkwinsize histappend
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Kitty, SSH, and tmux set TERM for their own environments.
export X_TERM="${X_TERM:-xterm-256color}"

alias ag='agent-browser'
alias gintaryu='gintary --tui'
alias ginbu='ginb --tui'
alias gindesignu='gindesign --tui'
alias hr='herdr'
alias clawdock='docker compose run --rm openclaw-cli'
alias python='python3.13'
alias dp='docker-compose'
alias dk='docker'
alias y='yarn'
alias n='npm'
alias b='bun'
alias ge='gemini'
alias cc='claude'
alias cl='claude'
alias la='ls -A'
alias glo='git log --oneline'
alias gl='git log'
alias gp='git push'
alias gpull='git pull'
alias lzg='lazygit'
alias g='git'
alias v='nvim'
alias yz='yazi'
alias vtt='nvim1'
command -v nvim >/dev/null 2>&1 && alias vim='nvim'

case "$(uname -s)" in
  Darwin) alias ls='ls -p -G' ;;
  *) alias ls='ls -p --color=auto' ;;
esac

if command -v exa >/dev/null 2>&1; then
  case "$(uname -s)" in
    Linux)
      alias ll='exa -la -g --icons'
      alias llt='exa --tree --level=2'
      ;;
    *)
      alias ll='exa -l -g --icons --git'
      alias llt='exa -l --icons --tree --git-ignore'
      ;;
  esac
else
  alias ll='ls -l'
  alias llt='ls -R'
fi
alias lla='ll -a'

# NVM is a sourced shell function, not an executable on PATH.
if [[ -s $NVM_DIR/nvm.sh ]]; then
  . "$NVM_DIR/nvm.sh" --no-use
  _dotfiles_nvm_auto_use() {
    local version
    [[ -r .nvmrc ]] || { _dotfiles_last_nvmrc=; return 0; }
    IFS= read -r version < .nvmrc || [[ -n $version ]] || return 0
    [[ $PWD:$version == "$_dotfiles_last_nvmrc" ]] && return 0
    if nvm use --silent "$version" >/dev/null 2>&1 || nvm use "$version"; then
      _dotfiles_last_nvmrc="$PWD:$version"
    fi
  }
  case ";${PROMPT_COMMAND:-};" in
    *';_dotfiles_nvm_auto_use;'*) ;;
    *) PROMPT_COMMAND="_dotfiles_nvm_auto_use${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
  esac
  _dotfiles_nvm_auto_use
fi

for _dotfiles_completion in \
  /etc/bash_completion \
  /usr/share/bash-completion/bash_completion \
  /opt/homebrew/etc/profile.d/bash_completion.sh \
  /usr/local/etc/profile.d/bash_completion.sh; do
  if [[ -r $_dotfiles_completion ]]; then
    . "$_dotfiles_completion"
    break
  fi
done
unset _dotfiles_completion

if command -v fzf >/dev/null 2>&1; then
  if _dotfiles_fzf_init=$(fzf --bash 2>/dev/null); then
    eval "$_dotfiles_fzf_init"
  elif [[ -r $HOME/.fzf.bash ]]; then
    . "$HOME/.fzf.bash"
  fi
  unset _dotfiles_fzf_init
fi
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi
if command -v jenv >/dev/null 2>&1; then
  eval "$(jenv init - bash)"
fi
if [[ -r $HOME/.gvm/environments/default ]]; then
  . "$HOME/.gvm/environments/default"
fi

[[ -r $HOME/.bashrc.local ]] && . "$HOME/.bashrc.local"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
