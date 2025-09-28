# dotfiles

Getting a handle on this guys.

This config is managed using [GNU Stow](https://www.gnu.org/software/stow/).

## Installing

The first thing you need to install is `stow` itself. You can get it from your
package manager. For example, on macOS you can install it using [brew][brew]:

```bash
brew install stow
```

Once that's installed, you can start installing the various modules. Each module
is a directory in this repo. You can install a module by running `stow <module>`
from the root of this repo. For example, to install the `zsh` module, run:

```bash
stow zsh
```

Let me describe each of the modules below.

### `zsh` module

This module configures your zsh shell. It includes:

- [antigen][antigen] for managing zsh plugins.
- [starship][starship] for a fancy prompt.
- [neovim][neovim] as the default editor.

```bash
brew install stow antigen starship pyenv pyenv-virtualenv nvm neovim
```

Then edit the `./zsh/.zshrc` file and make sure that this block points to where
your `antigen` ended up being installed:

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

For the best experience, make sure you get a nice terminal emulator like
[iterm2][iterm2], [alacritty][alacritty] or [ghostty][ghostty]. Then, grab
yourself a [nerd font][nerdfonts] no make the glyphs show correctly.

### `git` module

This module configures git. It includes a `.gitconfig` file with some sensible
defaults and aliases.

```bash
stow git
```

This module may not be for you.

### `nvim` module

This module configures [neovim][neovim].

```bash
stow nvim
```

Leader is set to `,` (comma) in neovim. This is old school, I know.

### `tmux` module

This module configures [tmux][tmux]. It uses [tpm][tpm] to manage plugins.

```bash
stow tmux
```

You probably need to delve into the `./tmux/.tmux.conf` file to tweak re-run
the plugin installation command.

### `alacritty` module

This module configures [alacritty][alacritty].

```bash
stow alacritty
```

It requries the `ttf-jetbrains-mono-nerd` font to be installed.

### `aerospace` module

[aerospace][aerospace] is a tiling window manager for macOS. This module
configures it.

```bash
stow aerospace
```

### `awesome` module

[awesome][awesome] is an awesome tiling window manager for Linux. This module
configures it.

```bash
stow awesome
```

### `hypr` module

This module configures [hyprland][hyprland], a tiling window manager
for Linux.

```bash
stow hypr
```

### `idea` module

This module configures JetBrains IDEs like IntelliJ IDEA, PyCharm, WebStorm,
etc. It includes a `.ideavimrc` file that remaps some keys to be more
consistent across different IDEs.

```bash
stow idea
```

## `walker` module

This module configures [walker][walker], a simple application launcher for Linux.

```bash
stow walker
```

### `waybar` module

This module configures [waybar][waybar], a status bar for Wayland.

```bash
stow waybar
```

### `zed` module

This module configures [Zed][zed], a modern text editor.

```bash
stow zed
```

[brew]: https://brew.sh/
[antigen]: https://github.com/zsh-users/antigen
[starship]: https://starship.rs/
[neovim]: https://neovim.io/
[iterm2]: https://iterm2.com/
[alacritty]: https://alacritty.org/
[ghostty]: https://ghostty.org/
[nerdfonts]: https://www.nerdfonts.com/#home
[tmux]: https://github.com/tmux/tmux
[tpm]: https://github.com/tmux-plugins/tpm
[aerospace]: https://github.com/nikitabobko/AeroSpace
[awesome]: https://awesomewm.org/
[hyprland]: https://hyprland.org/
[walker]: https://github.com/abenz1267/walker
[waybar]: https://github.com/Alexays/Waybar
[zed]: https://zed.dev/
