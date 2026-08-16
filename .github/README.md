# dotfiles

Personal configuration files managed with a bare Git repository. The Git directory lives at `~/.dotfiles`, while `$HOME` is used as the work tree. This keeps tracked files in their normal locations without copying them or creating symlinks.

## How it works

The `dotfiles` shell alias runs Git against the bare repository:

```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Only files explicitly added to Git are tracked. Untracked files under `$HOME` are hidden from status output with `status.showUntrackedFiles=no`.

## Updating dotfiles

After changing a tracked file in your home directory:

```sh
dotfiles status
dotfiles diff
dotfiles add ~/.zshrc
dotfiles commit -m "Update shell configuration"
dotfiles push
```

To start tracking another file, add it explicitly:

```sh
dotfiles add ~/.config/example/config.toml
dotfiles commit -m "Track example configuration"
dotfiles push
```

To update this machine from the remote repository:

```sh
dotfiles pull --ff-only
```

Run `cd ~ && dotfiles ls-files` to list every tracked file.

## Set up a new machine

Clone the repository without creating a conventional working directory:

```sh
git clone --bare https://github.com/nextonesfaster/dotfiles.git "$HOME/.dotfiles"
```

Define the alias for the initial checkout and hide unrelated home-directory files from status output:

```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

If checkout reports that existing files would be overwritten, move those files to a backup location and run `dotfiles checkout` again. The tracked shell configuration contains the permanent alias for subsequent sessions.
