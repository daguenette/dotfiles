# Dotfiles - opencode Theme

A complete dotfiles setup with opencode theme integration across Ghostty, Neovim, tmux, and zsh.

## Features

- **Ghostty**: Custom opencode-inspired terminal theme
- **Neovim**: LazyVim configuration with opencode colors
- **tmux**: Custom theme matching opencode design
- **zsh**: Oh My Zsh + Powerlevel10k with opencode colors
- **Consistent theming** across all tools

## Quick Setup

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run the setup script
./setup.sh
```

## Manual Setup

### Prerequisites

Install required tools:
```bash
# macOS with Homebrew
brew install stow tmux zsh
brew install --cask ghostty
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Neovim and LazyVim
brew install neovim
```

### Stow Configuration

```bash
cd ~/dotfiles

# Backup existing configs (optional)
mv ~/.zshrc ~/.zshrc.backup
mv ~/.tmux.conf ~/.tmux.conf.backup
mv ~/.p10k.zsh ~/.p10k.zsh.backup

# Create symlinks
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dotfiles/.config ~/.config

# Link Oh My Zsh and tmux directories
mv ~/.oh-my-zsh ~/.oh-my-zsh.backup
mv ~/.tmux ~/.tmux.backup
ln -sf ~/dotfiles/.oh-my-zsh ~/.oh-my-zsh
ln -sf ~/dotfiles/.tmux ~/.tmux
```

### Install tmux plugins

```bash
# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Start tmux and install plugins
tmux
# Press prefix + I (Ctrl-a + I) to install plugins
```

## Theme Colors

The opencode theme uses these primary colors:
- **Primary**: `#fab283` (warm orange)
- **Secondary**: `#9d7cd8` (purple)
- **Background**: `#0a0a0a` (dark)
- **Text**: `#eeeeee` (light gray)

## Customization

### Powerlevel10k
Run `p10k configure` to customize your prompt while keeping the opencode colors.

### Neovim
The LazyVim configuration includes opencode theme integration. Customize in `~/.config/nvim/lua/config/`.

### tmux
Modify `~/.tmux.conf` for additional tmux customizations.

### Ghostty
Edit `~/.config/ghostty/config` for terminal-specific settings.

## Troubleshooting

### Fonts
Install a Nerd Font for proper icon display:
```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### Permissions
If you encounter permission issues:
```bash
chmod +x ~/dotfiles/setup.sh
```

### Shell
Make sure zsh is your default shell:
```bash
chsh -s $(which zsh)
```
