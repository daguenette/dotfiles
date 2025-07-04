#!/bin/bash

# Dotfiles Setup Script - opencode Theme
# Automated setup for a complete development environment

set -e

echo "🚀 Setting up dotfiles with opencode theme..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This setup script is designed for macOS. Please adapt for your system."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_error "Homebrew is not installed. Please install it first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

print_status "Installing required packages..."

# Install essential packages
brew_packages=(
    "stow"
    "tmux" 
    "zsh"
    "neovim"
    "powerlevel10k"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

for package in "${brew_packages[@]}"; do
    if brew list "$package" &>/dev/null; then
        print_success "$package is already installed"
    else
        print_status "Installing $package..."
        brew install "$package"
    fi
done

# Install Ghostty if not present
if ! brew list --cask ghostty &>/dev/null; then
    print_status "Installing Ghostty..."
    brew install --cask ghostty
else
    print_success "Ghostty is already installed"
fi

# Install Nerd Font
if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
    # Check if font is already installed manually
    if ls ~/Library/Fonts/JetBrainsMono*NerdFont* &>/dev/null || ls /Library/Fonts/JetBrainsMono*NerdFont* &>/dev/null; then
        print_success "JetBrains Mono Nerd Font is already installed (manually)"
    else
        print_status "Installing JetBrains Mono Nerd Font..."
        if ! brew install --cask font-jetbrains-mono-nerd-font; then
            print_warning "Font installation failed, but continuing setup..."
        fi
    fi
else
    print_success "JetBrains Mono Nerd Font is already installed"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh.backup" ] && [ ! -L "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

print_status "Backing up existing configurations..."

# Backup existing configs
backup_files=(
    ".zshrc"
    ".tmux.conf" 
    ".p10k.zsh"
    ".oh-my-zsh"
    ".tmux"
    ".config"
)

for file in "${backup_files[@]}"; do
    if [ -e "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        print_warning "Backing up existing $file to $file.backup"
        mv "$HOME/$file" "$HOME/$file.backup"
    fi
done

print_status "Creating symlinks..."

# Get the absolute path to the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create symlinks for dotfiles
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/.oh-my-zsh" "$HOME/.oh-my-zsh"
ln -sf "$DOTFILES_DIR/.tmux" "$HOME/.tmux"
ln -sf "$DOTFILES_DIR/.config" "$HOME/.config"

print_success "Symlinks created successfully"

# Install TPM (Tmux Plugin Manager) if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    print_status "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    print_success "TPM installed"
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    print_status "Setting zsh as default shell..."
    
    # Add zsh to allowed shells if not already there
    ZSH_PATH="$(which zsh)"
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        print_status "Adding $ZSH_PATH to /etc/shells..."
        echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
    fi
    
    # Change default shell
    if chsh -s "$ZSH_PATH"; then
        print_success "Default shell changed to zsh"
    else
        print_warning "Failed to change default shell. You can do this manually later with: chsh -s $ZSH_PATH"
    fi
fi

print_success "🎉 Dotfiles setup complete!"
echo ""
print_status "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Start tmux and press Ctrl-a + I to install tmux plugins"
echo "  3. Open Neovim to let LazyVim install plugins automatically"
echo "  4. Optional: Run 'p10k configure' to customize your prompt"
echo ""
print_status "Enjoy your opencode-themed development environment! 🚀"