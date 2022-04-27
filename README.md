# dotfiles

Getting a handle on this guys.

This config is managed using [GNU Stow](https://www.gnu.org/software/stow/).

## Installing

### `zsh` module

First make sure you have the required software:

```bash
brew install stow antigen starship pyenv pyenv-virtualenv nvm neovim
```

Then edit the `./zsh/.zshrc` file and make sure that this block points to where your `antigen` ended up being installed:

```bash
# Antigen plugin manager
[ -f /usr/share/zsh/share/antigen.zsh ] && source /usr/share/zsh/share/antigen.zsh
[ -f /usr/local/share/antigen/antigen.zsh ] && source /usr/local/share/antigen/antigen.zsh
[ -f /opt/homebrew/Cellar/antigen/2.2.3/share/antigen/antigen.zsh ] && source /opt/homebrew/Cellar/antigen/2.2.3/share/antigen/antigen.zsh
```

After that you can go ahead and install the module by:

```bash
stow zsh
```

### Other modules

TBD 😅
