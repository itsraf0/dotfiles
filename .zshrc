#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Install missing plugins if needed
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install powerlevel10k theme if using Oh My Zsh
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing powerlevel10k theme for Oh My Zsh..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

plugins=(
  git
  macos
  brew
  vscode
  npm
  yarn
  node
  python
  pip
  zsh-syntax-highlighting
  zsh-autosuggestions
  colored-man-pages
  colorize
  command-not-found
  history-substring-search
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_AU.UTF-8
export EDITOR='nvim'
export VISUAL='code'

# History configuration
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt extended_glob

# Lazy load NVM for faster shell startup
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}

node() {
  unset -f node
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  node "$@"
}

npm() {
  unset -f npm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  npm "$@"
}

# Python pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Golang path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Add Homebrew to PATH
export PATH=/opt/homebrew/bin:$PATH

# Ruby related
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi


# System aliases
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"
alias brewup="brew update && brew upgrade"
alias i="brew update && brew upgrade && brew cleanup && ping -c 4 1.1.1.1 && ls -a && neofetch"
alias ls="ls -la"
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"
alias cl="clear"
alias p='ping -c 4 1.1.1.1 && ping -c 4 8.8.8.8'
alias nolock='defaults write com.apple.loginwindow DisableScreenLockImmediate -bool yes'
alias sort="~/sort-files.sh"
alias rafsort="~/sort-files.sh"
alias neo="neofetch"
alias cnc="~/cookandclean.sh"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias glog="git log --oneline --decorate --graph"
alias gd="git diff"

# Docker aliases
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dex="docker exec -it"
alias dcp="docker-compose"
alias dcup="docker-compose up -d"
alias dcdown="docker-compose down"
alias dclog="docker-compose logs -f"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# Python aliases
alias py="python"
alias py3="python3"
alias pyvenv="python -m venv venv"
alias activate="source venv/bin/activate"
alias pip-upgrade="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"

# npm aliases
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nup="npm update"
alias nug="npm upgrade -g"
alias nr="npm run"
alias nstart="npm start"
alias ndev="npm run dev"
alias nbuild="npm run build"
alias ntest="npm test"

# Yarn aliases
alias yi="yarn install"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yag="yarn global add"
alias yup="yarn upgrade"
alias ydev="yarn dev"
alias ybuild="yarn build"
alias ystart="yarn start"
alias ytest="yarn test"


# Quick shortcuts
alias c="code ."
alias h="history | grep"
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias myip="curl -s https://api.ipify.org && echo"
alias localip="ipconfig getifaddr en0"
alias weather="curl -s wttr.in"
alias cpu="top -l 1 | grep -E '^CPU'"
alias mem="top -l 1 | grep PhysMem"

# macOS specific aliases
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias emptytrash="rm -rf ~/.Trash/*"

# Disk usage
alias diskspace="df -h"
alias foldersize="du -sh"
alias bigfolders="du -k ~ | sort -nr | head -20"

gitlog() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

cd() {
  builtin cd "$@" && ls -la
}

docker-clean() {
  echo "Removing all stopped containers..."
  docker container prune -f
  
  echo "Removing all dangling images..."
  docker image prune -f
  
  echo "Removing all unused networks..."
  docker network prune -f
  
  echo "Removing all unused volumes..."
  docker volume prune -f
}

backup() {
  cp -r "$1" "$1.bak-$(date +%Y%m%d-%H%M%S)"
  echo "Backed up $1"
}

# Auto fix SSH auth socket in tmux
function fixssh {
  eval $(tmux show-env -s | grep ^SSH_)
}

# Create a new directory and enter it
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Open a file with the appropriate application
open_with() {
  open -a "$1" "$2"
}

# Extract most know archives with one command
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create a data URL from a file
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# HTTP server from current directory
server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/"
  python -m http.server "$port"
}

# Git add, commit, and push in one command
gacp() {
  git add .
  git commit -m "$1"
  git push
}

# Find process using a port
findport() {
  lsof -i :"$1"
}

# Kill process using a port
killport() {
  kill -9 $(lsof -t -i:"$1")
}

# Search command history
hs() {
  history | grep "$1"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use brew installed powerlevel10k if not using Oh My Zsh theme
if [[ "$ZSH_THEME" != "powerlevel10k/powerlevel10k" ]]; then
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Source syntax highlighting if it's installed via Homebrew
if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Source autosuggestions if it's installed via Homebrew
if [[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
