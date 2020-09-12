# Dotfiles

## Pre Reqs
- Curl
- Bash
- NodeJS

## Included App Configs
- Vim
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

## Instructions
Type `git clone --bare https://github.com/Mcpower03/Dotfiles.git ~/.dotfiles`  
Add following to alias Bash/Zsh/Etc config `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`  
Run `dotfiles checkout`  
Fix any existing file errors and run again if needed
