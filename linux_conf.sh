#!/bin/bash

set -e

# ---------- CONFIG ----------
THEME_NAME="custom.omp.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"
# ----------------------------

echo "📦 Mise à jour des paquets..."
sudo apt update && sudo apt install -y zsh wget curl git neovim netplan.io pipx
pipx install thefuck

echo "🔧 Installation de Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "⚡ Installation de Oh My Posh..."
sudo wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
sudo oh-my-posh font install meslo

echo "🎨 Téléchargement du thème $THEME_NAME..."
mkdir -p "$SCRIPT_DIR/.poshthemes"
mv "$THEME_NAME" "$SCRIPT_DIR/.poshthemes/$THEME_NAME"
chmod u+rw "$SCRIPT_DIR/.poshthemes/$THEME_NAME"



echo "🧠 Configuration du .zshrc..."
  mv ".zshrc" $SCRIPT_DIR/.zshrc

echo "🐚 Passage à Zsh comme shell par défaut..."
chsh -s "$(which zsh)"

echo "✅ Installation terminée. Redémarre le terminal ou tape 'zsh' pour lancer le shell."

zsh