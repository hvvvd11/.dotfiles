#!/bin/bash

# Ensure the .config directory exists
mkdir -p $HOME/.config

# Function to handle copying and symlinking
setup_config() {
    local source_path="$1"
    local target_path="$2"
    local target_dir=$(dirname "$target_path")

    # Ensure target directory exists
    mkdir -p "$target_dir"

    # Copy files if they don't exist at the target
    if [ ! -e "$target_path" ]; then
        cp -r "$source_path" "$target_path"
        echo "Copied $source_path to $target_path"
    else
        echo "$target_path already exists. Skipping copy..."
    fi

    # Create symlink from source to target
    if [ ! -L "$source_path" ]; then
        ln -sfn "$target_path" "$source_path"
        echo "Created symlink from $source_path to $target_path"
    else
        echo "Symlink $source_path already exists. Skipping symlink..."
    fi
}

# Configurations
setup_config "kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
setup_config "nvim" "$HOME/.config/nvim"
setup_config "rustfmt/config.toml" "$HOME/.config/rustfmt/config.toml"
setup_config "tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
setup_config "xmonad/xmonad.hs" "$HOME/.config/xmonad/xmonad.hs"

# Xresources, handle if it's a broken symlink
[ -L $HOME/.Xresources ] && [ ! -e $HOME/.Xresources ] && rm $HOME/.Xresources
setup_config "Xresources" "$HOME/.Xresources"

echo "Configuration setup complete."
