eval "$(starship init zsh)"

export VISUAL=nvim
export EDITOR="$VISUAL"
export PYTHONDONTWRITEBYTECODE=1
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.bin:$HOME/.yarn/bin:$PATH"
export ANTIGEN_LOG="$HOME/.cache/antigen.log"

[ -f ~/.tokens.sh ] && source ~/.tokens.sh

# Aliases
alias vim="nvim"
alias ze="nvim ~/.zshrc"
alias zs="source ~/.zshrc"

# Antigen plugin manager
[ -f /usr/share/zsh/share/antigen.zsh ] && source /usr/share/zsh/share/antigen.zsh
[ -f /usr/local/share/antigen/antigen.zsh ] && source /usr/local/share/antigen/antigen.zsh

# Manage oh-my-zsh
antigen use oh-my-zsh

# Completions
antigen bundle git

# Version manager
antigen bundle rbenv
antigen bundle pyenv
antigen bundle lukechilds/zsh-nvm
antigen bundle cowboyd/zsh-rust@v1

# Quality of life
antigen bundle z
antigen bundle colored-man-pages
antigen bundle ssh-agent

# Fish like
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

antigen apply
