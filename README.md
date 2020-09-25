# Dotfiles

## Pre Reqs
- Curl
- Bash
- NodeJS
- Picom
- zsh-syntax-highlighting
- zsh-autosuggestions
- Git
- Ripgrep
- GNU Find
- Fd

## Included App Configs
- Vim
- Emacs
- Tmux
- Kitty
- Qtile
- Polybar
- Alacritty
- Zsh
- Xresources
- Bspwm
- Sxhkd
- Feh
- Dunst
- Rofi

## Instructions
Type `git clone --bare https://github.com/Mcpower03/Dotfiles.git ~/.dotfiles`  
Add following to alias Bash/Zsh/Etc config `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`  
Run `dotfiles checkout`  
Fix any existing file errors and run again if needed  
Run `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k` to setup powerlevel zsh prompt  
Run `git clone https://github.com/hlissner/doom-emacs ~/.emacs.d  
~/.emacs.d/bin/doom install` to install Doom Emacs
