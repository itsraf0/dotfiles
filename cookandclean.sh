#!/bin/bash

set -euo pipefail

RUN_SORT=false

for arg in "$@"; do
  case "$arg" in
    -s|--sort)
      RUN_SORT=true
      shift
      ;;
    *)
      # ignore other args
      ;;
  esac
done

echo "🍲 cooking..."

brew update

echo "-> upgrading installed brews..."
brew upgrade

echo "-> upgrading global npm packages..."
npm upgrade -g

echo "🧼 cleaning..."

echo "-> cleaning up Homebrew cache..."
brew cleanup

if command -v docker-clean >/dev/null 2>&1; then
  echo "-> running docker-clean..."
  docker-clean
else
  echo "⚠️  docker-clean not found; skipping Docker cleanup"
fi

echo "-> flushing DNS cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

echo "✅ system cleaned!"

ping -c 4 1.1.1.1

neofetch

echo -n "🌐 public ip: "
curl -s https://api.ipify.org
echo
echo -n "🏠 local ip: "
ipconfig getifaddr en0
echo

if $RUN_SORT; then
  echo "🚀 [--sort flag detected] running ~/sort-files.sh immediately..."
  ~/sort-files.sh
  exit 0
fi

# Prompt with 10s timeout; default to 'yes' on timeout
read -t 10 -rp "do you want to run rafsort now? [y/n] " answer \
  || answer="y"

if [[ "$answer" =~ ^[Yy] ]]; then
  echo "🚀 running ~/sort-files.sh..."
  ~/sort-files.sh
else
  echo "👍 noted. skipping sort-files for now."
fi
