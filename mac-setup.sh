#!/usr/bin/env bash
set -euo pipefail

print_status()  { printf "\033[1;34m→ %s\033[0m\n" "$1"; }
print_success() { printf "\033[1;32m✔ %s\033[0m\n" "$1"; }
print_error()   { printf "\033[1;31m✖ %s\033[0m\n" "$1"; }
print_warning() { printf "\033[1;33m⚠ %s\033[0m\n" "$1"; }

brew_formulae=(
    git
    gh  # GitHub CLI
    
    # Node.js and JavaScript tools
    node
    npm
    yarn
    pnpm
    
    # Python
    python@3.11
    python@3.12
    pipx
    displayplacer
    
    # Build tools and utilities
    wget
    curl
    jq
    tree
    htop
    neofetch
    mas  # Mac App Store CLI
    
    # Shell and terminal tools
    zsh
    zsh-completions
    
    # Text editors and IDEs command line tools
    vim
    neovim
    
    # Other useful tools
    ffmpeg
    imagemagick
    
    # Database tools
    sqlite
    
    # Container tools
    docker
    docker-compose
)

brew_casks=(
  balenaetcher       # Etcher
  bambu-studio       # Bambu Studio
  iterm2             # iTerm2
  karabiner-elements # Karabiner-Elements
  protonvpn          # ProtonVPN
  spotify            # Spotify
  istat-menus        # iStat Menus
  utm                # UTM
  crossover          # CrossOver
  visual-studio-code # VS Code
  vesktop            # Vesktop (Discord alternative)
  warp               # Warp terminal
  docker             # Docker Desktop
  whatsapp           # WhatsApp
  steam              # Steam
  zen                # Zen Browser
  coconutbattery     # coconutBattery
  modrinth           # Modrinth Minecraft Launcher
)

# Mac App Store apps (Xcode)
mas_apps=(
  497799835  # Xcode
)

# npm global packages (11ty, Astro, Nunjucks, etc.)
npm_globals=(
  @11ty/eleventy
  astro
  nunjucks-cli
)

vsc_extensions=(
  akamud.vscode-theme-onedark
  amodio.tsl-problem-matcher
  astro-build.astro-vscode
  beardedbear.beardedtheme
  charliermarsh.ruff
  christian-kohler.npm-intellisense
  davidanson.vscode-markdownlint
  dbaeumer.vscode-eslint
  donjayamanne.githistory
  eamodio.gitlens
  .vscode-html-css
  elagil.pre-commit-helper
  esbenp.prettier-vscode
  file-icons.file-icons
  firefox-devtools.vscode-firefox-debug
  george-alisson.html-preview-vscode
  github.copilot
  github.copilot-chat
  github.github-vscode-theme
  github.vscode-pull-request-github
  illixion.vscode-vibrancy-continued
  mechatroner.rainbow-csv
  miguelsolorio.min-theme
  ms-azuretools.vscode-containers
  ms-azuretools.vscode-docker
  ms-dotnettools.csdevkit
  ms-dotnettools.csharp
  ms-dotnettools.vscode-dotnet-runtime
  ms-edgedevtools.vscode-edge-devtools
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-vscode-remote.remote-containers
  ms-vscode.cmake-tools
  ms-vscode.cpptools
  ms-vscode.cpptools-extension-pack
  ms-vscode.cpptools-themes
  ms-vscode.extension-test-runner
  ms-vscode.vscode-typescript-next
  redhat.vscode-yaml
  ronnidc.nunjucks
  tal7aouy.icons
  tomphilbin.gruvbox-themes
  tonybaloney.vscode-pets
  visualstudiotoolsforunity.vstuc
)

if ! command -v brew &>/dev/null; then
  print_status "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  print_success "Homebrew installed"
else
  print_status "Updating Homebrew…"
  brew update
  print_success "Homebrew up to date"
fi

print_status "Installing brew formulae…"
for formula in "${brew_formulae[@]}"; do
  if brew list "$formula" &>/dev/null; then
    print_success "$formula already installed"
  else
    print_status "Installing $formula…"
    brew install "$formula"
    print_success "$formula installed"
  fi
done

# ────────────────────────────────────────────────
# Tap Cask and install Brew casks
# ────────────────────────────────────────────────

brew tap homebrew/cask

print_status "Installing brew casks…"
for cask in "${brew_casks[@]}"; do
  if brew list --cask "$cask" &>/dev/null; then
    print_success "$cask already installed"
  else
    print_status "Installing $cask…"
    brew install --cask "$cask"
    print_success "$cask installed"
  fi
done

# ────────────────────────────────────────────────
# Install Xcode Command Line Tools
# ────────────────────────────────────────────────

if xcode-select -p &>/dev/null; then
  print_success "Xcode Command Line Tools already installed"
else
  print_status "Installing Xcode Command Line Tools…"
  xcode-select --install
  print_success "Xcode Command Line Tools installation triggered"
fi

# ────────────────────────────────────────────────
# Install Xcode via mas
# ────────────────────────────────────────────────

if ! command -v mas &>/dev/null; then
  print_status "Installing mas (Mac App Store CLI)…"
  brew install mas
  print_success "mas installed"
fi

for app_id in "${mas_apps[@]}"; do
  if mas list | grep -q "^$app_id "; then
    print_success "App $app_id already installed"
  else
    print_status "Installing Mac App Store app ID $app_id…"
    mas install "$app_id"
    print_success "App $app_id installed"
  fi
done

# ────────────────────────────────────────────────
# Install Oh My Zsh (but don't switch shell or run Zsh)
# ────────────────────────────────────────────────

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  print_status "Installing Oh My Zsh…"
  export RUNZSH=no
  export CHSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  print_success "Oh My Zsh installed"
else
  print_success "Oh My Zsh already present"
fi

# ────────────────────────────────────────────────
# Install global npm packages
# ────────────────────────────────────────────────

print_status "Installing global npm packages…"
for pkg in "${npm_globals[@]}"; do
  if npm list -g --depth=0 "$pkg" &>/dev/null; then
    print_success "npm $pkg already installed"
  else
    print_status "Installing npm $pkg…"
    npm install -g "$pkg"
    print_success "npm $pkg installed"
  fi
done

# ────────────────────────────────────────────────
# VS Code extensions
# ────────────────────────────────────────────────

print_status "Installing vsc extensions…"
for extension in "${vsc_extensions[@]}"; do
  if code --list-extensions | grep -q "^$extension$"; then
    print_success "VS Code extension $extension already installed"
  else
    print_status "Installing $extension…"
    code --install-extension "$extension"
    print_success "$extension installed"
  fi
done

# ────────────────────────────────────────────────
# Copy dotfiles from cloned repo into your home
# ────────────────────────────────────────────────

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)/dotfiles"  # adjust if needed

if [ -d "$DOTFILES_DIR" ]; then
  print_status "Copying dotfiles…"
  cp -v "$DOTFILES_DIR/.zshrc"     "$HOME"
  cp -v "$DOTFILES_DIR/cookandclean.sh" "$HOME"
  cp -v "$DOTFILES_DIR/sort-files.sh"   "$HOME"
  print_success "Dotfiles copied"
else
  print_warning "Dotfiles dir not found at $DOTFILES_DIR — skipping copy"
fi

# Copy VS Code settings
VSCODE_USER_SETTINGS="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_SETTINGS"
if [ -f "$DOTFILES_DIR/settings.json" ]; then
  print_status "Copying VS Code settings…"
  cp -v "$DOTFILES_DIR/settings.json" "$VSCODE_USER_SETTINGS"
  print_success "VS Code settings copied"
else
  print_warning "VS Code settings.json not found — skipping"
fi

# ────────────────────────────────────────────────
# Open manual-download apps in Safari
# ────────────────────────────────────────────────

print_status "Opening manual downloads in Safari…"
open "https://github.com/pakerwreah/Calendr/releases/download/v1.17.2/Calendr.zip"
open "https://github.com/sindresorhus/menu-bar-spacing-meta/releases/latest/download/Menu.Bar.Spacing.zip"
print_success "Manual download pages opened (please install manually)"

print_status "Applying macOS defaults…"
#!/usr/bin/env sh

# 1. Disable “Show recent apps” in Dock
defaults write com.apple.dock show-recents -bool false
killall Dock

# 2. Wallpaper-click to reveal desktop only in Stage Manager
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
killall WindowManager

# 3. Remove margins from tiled windows
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
killall WindowManager

# 4. Set main display resolution to 1710×1112 (requires displayplacer)
if command -v displayplacer >/dev/null; then
  screen_id=$(displayplacer list | awk '/persistent screen id:/ {print $4; exit}')
  displayplacer "id:${screen_id} res:1710x1112 scaling:on"
fi

# 5. Turn all four hot corners off
for corner in tl tr bl br; do
  defaults write com.apple.dock "wvous-${corner}-corner" -int 0
done
killall Dock

# 6. Disable iCloud Drive (UI scripting)
osascript <<'EOF'
tell application "System Settings" to activate
delay 0.5
tell application "System Events"
  tell process "System Settings"
    click anchor "iCloud" of pane id "com.apple.preferences.icloud"
    delay 0.5
    if (value of checkbox "iCloud Drive" of window 1) is 1 then
      click checkbox "iCloud Drive" of window 1
    end if
  end tell
end tell
EOF

# 7. Ensure menu bar never auto-hides
defaults write NSGlobalDomain _HIHideMenuBar -bool false

# 8. Disable two-finger swipe between pages system-wide
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false

# 9. Disable three-finger “Look up & Data Detectors” tap
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0

killall Dock WindowManager &>/dev/null || true
print_success "macOS defaults applied"

print_success "All done! 🎉 Reboot or log out/in to finalize changes."
