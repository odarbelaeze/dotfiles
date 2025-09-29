eval "$(starship init zsh)"

export VISUAL=nvim
export EDITOR="$VISUAL"
export PYTHONDONTWRITEBYTECODE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/go/bin/:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export ANTIGEN_LOG="$HOME/.cache/antigen.log"
export GPG_TTY=$(tty)

[ -f ~/.tokens.sh ] && source ~/.tokens.sh
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Aliases
alias vim="$EDITOR"
alias ze="$EDITOR ~/.zshrc"
alias zs="source ~/.zshrc"
alias gbsa='git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias gbma='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

# Antigen plugin manager
[ -f ~/.bin/antigen.zsh ] && source ~/.bin/antigen.zsh
[ -f /usr/share/zsh/share/antigen.zsh ] && source /usr/share/zsh/share/antigen.zsh
[ -f /usr/local/share/antigen/antigen.zsh ] && source /usr/local/share/antigen/antigen.zsh
[ -f /opt/homebrew/Cellar/antigen/2.2.3/share/antigen/antigen.zsh ] && source /opt/homebrew/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

# Manage oh-my-zsh
antigen use oh-my-zsh

# Completions
antigen bundle git

# Version manager
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

[ -f ~/.work.sh ] && source ~/.work.sh
