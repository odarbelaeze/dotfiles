eval "$(starship init zsh)"

# export VISUAL=vim
export VISUAL=nvim
export EDITOR="$VISUAL"
export PYTHONDONTWRITEBYTECODE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.bin:$HOME/.yarn/bin:$PATH:$HOME/go/bin"
export ANTIGEN_LOG="$HOME/.cache/antigen.log"
export GPG_TTY=$(tty)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

[ -f ~/.tokens.sh ] && source ~/.tokens.sh

# Aliases
alias vim="$EDITOR"
alias ze="$EDITOR ~/.zshrc"
alias zs="source ~/.zshrc"
alias gbsa='git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

# Antigen plugin manager
[ -f /usr/share/zsh/share/antigen.zsh ] && source /usr/share/zsh/share/antigen.zsh
[ -f /usr/local/share/antigen/antigen.zsh ] && source /usr/local/share/antigen/antigen.zsh
[ -f /opt/homebrew/Cellar/antigen/2.2.3/share/antigen/antigen.zsh ] && source /opt/homebrew/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

# Manage oh-my-zsh
antigen use oh-my-zsh

# Completions
antigen bundle git

# Version manager
antigen bundle rbenv
antigen bundle pyenv
antigen bundle golang
antigen bundle direnv
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
