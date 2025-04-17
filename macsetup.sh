/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/raf/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/raf/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update && brew upgrade

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Core utilities
brew install mas
xcode-select --install
mas install 'Xcode', id: 497799835

printf 'continue? (y/n)? '
read answer

if [[ $answer == "y" || $answer == "Y" ]]; then
    echo -e "\033[1;32mmoving on...\033[0m"
else
    exit 0
fi

brew install neofetch
brew install git
brew install gh
brew install wget
brew install curl
brew install jq
brew install tldr
brew install htop
brew install tree

brew install node
brew install nvm
brew install deno
brew install typescript
brew install http-server
brew install --cask docker
brew install colima

# Python ecosystem
brew install python
brew install pyenv
brew install pipenv
brew install poetry

# Swift-related tools
brew install swiftlint
brew install swift-format

# PHP and related tools
brew install php
brew install composer
brew install wp-cli

# Shell development
brew install shellcheck
brew install shfmt
brew install bash
brew install zsh
brew install fzf

# Text editors/IDEs
brew install --cask visual-studio-code
brew install neovim
brew install --cask cursor
brew install --cask warp
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# tools
brew install bat fd ripgrep lazygit zoxide tmux watch aria2
defaults write com.apple.finder AppleShowAllFiles -bool true

brew install jordanbaird-ice
brew install postman
brew install --cask raycast
brew install --cask karabiner-elements
brew install --cask bettertouchtool
brew install --cask keyboard-maestro
brew install --cask moom
brew install --cask paste

brew install --cask istat-menus        # Advanced system monitoring in menu bar
brew install --cask stats              # Free, simple system monitor
brew install --cask app-cleaner        # Thorough app uninstallation

brew install --cask totalfinder       # Adds tabs and features to Finder
brew install --cask hazel

brew install --cask coconutbattery
brew install --cask alt-tab
brew install --cask cheatsheet
brew install --cask grandperspective
brew install --cask transmission
brew install --cask utm

printf 'install non-dev programs? (y/n)? '
read answer

if [[ $answer == "y" || $answer == "Y" ]]; then
    brew install --cask balenaetcher
    brew install --cask bambu-studio
    brew install --cask arc
    brew install --cask obs
    brew install --cask steam
    brew install tailscale
    brew install --cask whatsapp
    brew install --cask claude
    brew install --cask discord
    open https://github.com/pakerwreah/Calendr/releases/download/v1.16.2/Calendr.zip
    echo -e "\033[1;32mfinished. moving on...\033[0m"
else
    echo -e "\033[1;32mmoving on...\033[0m"
    
fi

printf 'install claude code? (y/n)? '
read answer

if [[ $answer == "y" || $answer == "Y" ]]; then
    npm install -g @anthropic-ai/claude-code
    echo -e "\033[1;32mfinished. moving on...\033[0m"
else
    echo -e "\033[1;32mmoving on...\033[0m"
    
fi

printf 'setup git? (y/n)? '
read answer

if [[ $answer == "y" || $answer == "Y" ]]; then
    echo -e "\033[1;32menter git username\033[0m"
    read git_username
    git config --global user.name "$git_username"

    echo -e "\033[1;32menter git email\033[0m"
    read git_email
    git config --global user.email "$git_email"

    echo -e "\033[1;32mfinished. moving on...\033[0m"
else
    echo -e "\033[1;32mmoving on...\033[0m"
    
fi

printf 'mkdir recommended folder structure? (y/n)?
recommended folder stucture:
~/Projects/
├── Dev/
│   ├── Web/
│   │   ├── React/
│   │   ├── Vue/
│   │   ├── Static/
│   │   └── WordPress/
│   ├── Mobile/
│   │   ├── iOS/
│   │   ├── Android/
│   │   └── React-Native/
│   ├── Desktop/
│   │   ├── Swift/
│   │   ├── Electron/
│   │   └── Python/
│   ├── Scripts/
│   │   ├── Bash/
│   │   ├── Python/
│   │   └── Node/
│   ├── API/
│   │   ├── REST/
│   │   ├── GraphQL/
│   │   └── Microservices/
│   └── Learning/
│       ├── Tutorials/
│       └── Experiments/
├── Creative/
│   ├── Photography/
│   │   ├── Raw/
│   │   ├── Edited/
│   │   ├── Portfolio/
│   │   └── Projects/
│   ├── 3D/
│   │   ├── Models/
│   │   ├── Prints/
│   │   ├── STL-Files/
│   │   └── Sliced/
│   └── Design/
│       ├── UI/
│       ├── Logos/
│       └── Assets/
├── Personal/
│   ├── Documents/
│   ├── Finance/
│   └── Notes (for rafnotes)/
└── Archive/
    ├── OldProjects/
    ├── References/
    └── Backups/'
read answer

if [[ $answer == "y" || $answer == "Y" ]]; then
mkdir -p ~/Dev/{Web/{React,Vue,Static,WordPress},Mobile/{iOS,Android,React-Native},Desktop/{Swift,Electron,Python},Scripts/{Bash,Python,Node},API/{REST,GraphQL,Microservices},Learning/{Tutorials,Experiments}} ~/Creative/{Photography/{Raw,Edited,Portfolio,Projects},3D/{Models,Prints,STL-Files,Sliced},Design/{UI,Logos,Assets}} ~/Personal/{Documents,Finance,Notes} ~/Archive/{OldProjects,References,Backups}
    echo -e "\033[1;32mfinished. moving on...\033[0m"
else
    echo -e "\033[1;32mmoving on...\033[0m"
    
fi

# Function to reload shell config
reload_shell_config() {
  case "$SHELL" in
    */zsh)
      source ~/.zshrc && echo "Reloaded ~/.zshrc"
      ;;
    */bash)
      if [ -f ~/.bash_profile ]; then
        source ~/.bash_profile && echo "Reloaded ~/.bash_profile"
      else
        source ~/.bashrc && echo "Reloaded ~/.bashrc"
      fi
      ;;
    *)
      echo "Unknown shell. Please reload your terminal manually to activate the alias."
      ;;
  esac
}

neofetch
chsh -s $(which zsh)

echo 'done.'




