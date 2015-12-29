# README #

## Included Configuration Files ##

These are the configuration files (dot files) that I use for my MacBook
and Ubuntu servers/slices. Files have been included for:

- [Bash][] and the [Readline library][readline]
- [ChkTeX][]
- [Git][]
- [Mercurial][]
- [npm][]
- [RVM][]
- [Tmux][]
- [Vim][] using [Janus][]

## Initial Setup ##

To start using this repository, run:

1. Clone the repositoiry using `git clone
   https://github.com/matthewrankin/dotfiles.git`
2. Deploy the dot-files by running `./deploy_dot_files.py`

## Update from Github ##

Whenever you want to pull the latest updates from [GitHub][] use:

```bash
$ git pull
```

## What does `deploy_dot_files.py` actually do? ##

This script does the following:

- Expects to be run from the directory containing the dot-files that
  have been cloned from github (e.g., `/Users/me/dev/dot-files/`)
- On a per file basis, checks to see if symlinks from the user's home
  directory to the `dot-files` directory already exist and checks to
  make sure that the file in the `dot-files` directory does exist.
- If a symlink does not exist but the file does exist in the `dot-files`
  directory, then the current file in the user's home directory will be
  backed up and a symlink will be created
- By using symlinks instead of copying files, the `deploy_dot_files.py`
  script only needs to be run one time. To update simply clone the
  github repository using `git pull`.

[bash]: https://www.gnu.org/software/bash/bash.html
[chktex]: http://www.nongnu.org/chktex/
[git]: https://git-scm.com
[github]: https://github.com
[janus]: https://github.com/carlhuda/janus
[mercurial]: https://www.mercurial-scm.org
[npm]: https://docs.npmjs.com
[readline]: https://cnswww.cns.cwru.edu/php/chet/readline/readline.html
[rvm]: http://rvm.io
[tmux]: https://tmux.github.io
[vim]: http://www.vim.org
