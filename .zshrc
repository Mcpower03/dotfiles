# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mikec/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias update-config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add -u
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status
echo "Commit Message: "
read message
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m $message
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /home/mikec/.config/broot/launcher/bash/br
export PATH="${PATH}:$HOME/.scripts:$HOME/.emacs.d/bin"
alias vim='/usr/bin/nvim'
