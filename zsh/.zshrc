eval "$(starship init zsh)"

export VISUAL=nvim
export EDITOR="$VISUAL"

alias vim="nvim"

# Config aliases
alias ze="nvim ~/.zshrc"
alias zs="source ~/.zshrc"

export ZSH="/home/oscar/.oh-my-zsh"

# Antigen plugin manager
source /usr/share/zsh/share/antigen.zsh

# Manage oh-my-zsh
antigen use oh-my-zsh

# Completions
antigen bundle git

# Version manager
antigen bundle pyenv
antigen bundle lukechilds/zsh-nvm

# Quality of life
antigen bundle z
antigen bundle colored-man-pages

# Fish like
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

antigen apply
