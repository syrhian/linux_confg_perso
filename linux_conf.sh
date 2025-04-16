#!/bin/bash

set -e

# ---------- CONFIG ----------
THEME_NAME="custom.omp.json"
THEME_DIR="$HOME/.poshthemes"
ZSHRC="$HOME/.zshrc"
# ----------------------------

echo "📦 Mise à jour des paquets..."
sudo apt update && sudo apt install -y zsh wget curl git neovim netplan.io

echo "🔧 Installation de Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "⚡ Installation de Oh My Posh..."
sudo wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
sudo oh-my-posh font install meslo

echo "🎨 Téléchargement du thème $THEME_NAME..."
mkdir -p "$THEME_DIR"
mv "$THEME_NAME" "$THEME_DIR/$THEME_NAME"
chmod u+rw "$THEME_DIR/$THEME_NAME"

echo "🧠 Configuration du .zshrc..."
  echo "eval "$(oh-my-posh init zsh --config $THEME_DIR/$THEME_NAME)"" >> "$ZSHRC"

echo "🐚 Passage à Zsh comme shell par défaut..."
chsh -s "$(which zsh)"

echo "✅ Installation terminée. Redémarre le terminal ou tape 'zsh' pour lancer le shell."

