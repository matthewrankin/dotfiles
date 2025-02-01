# README

## Included Configuration Files

These are the configuration files (dotfiles) that I use for my MacBook
and Ubuntu servers/slices. Some of the configuration files include:

- [bash][]
- [chktex][]
- [git][]
- [neovim][]
- [npm][]
- [tmux][]
- [zsh][]

In October 2023, I converted my old Vim configuration using mainly Vim script
to Neovim using Lua.

## Dependencies

- [GNU Stow][stow]
- [Just][], while not required, provides a simple way to deploy the various
  dotfiles.

## Initial Setup

To start using this repository, run:

1. Clone the repositoiry using `git clone
https://github.com/matthewrankin/dotfiles.git`
2. Run `just`, which will list the available commands to deploy the dotfiles.

## Update from Github

Whenever you want to pull the latest updates from [GitHub][] use:

```bash
$ git pull
```

## License

[dotfiles][] is released under the MIT license. Please see the
[LICENSE.txt][] file for more information.

[bash]: https://www.gnu.org/software/bash/bash.html
[chktex]: https://www.nongnu.org/chktex/
[dotfiles]: https://github.com/matthewrankin/dotfiles
[eslint]: https://eslint.org/
[git]: https://git-scm.com
[github]: https://github.com
[just]: https://just.systems/
[LICENSE.txt]: https://github.com/matthewrankin/dotfiles/blob/master/LICENSE.txt
[neovim]: https://neovim.io/
[npm]: https://docs.npmjs.com
[stow]: https://www.gnu.org/software/stow/
[tmux]: https://tmux.github.io
[zsh]: https://zsh.sourceforge.io/
