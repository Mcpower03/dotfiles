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
- Install Iosevka Font (I like the SS12 varient)

## Included App Configs
- Vim
- Neovim
- Emacs
- Tmux
- Kitty
- Qtile
- Polybar
- Alacritty
- Zsh
- Bash
- Fish
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
Run `git clone https://github.com/hlissner/doom-emacs ~/.emacs.d  ~/.emacs.d/bin/doom install` to install Doom Emacs  
Run `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'` to install vim plug for Neovim
And run `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim` to set up vim plug for regular Vim
Run ``git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`` for tmux plugin manager setup
