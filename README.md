# README #

## Included Configuration Files ##

These are the configuration files (dot files) that I use for my MacBook and Ubuntu servers/slices. Files include:

* .bash\_profile
* .bash\_alias
* `.bashrc`
* .gitconfig
* .gitignore

## Initial Setup ##

Only need to run the following commands the first time:

1. Clone the github repository using `git clone git://github.com/mdr22github/dot-files.git`
2. Deploy the dot-files by running `deploy_dot_files.py`

## Update from Github ##

Whenever you want to pull the latest updates from github use:

1. Execute the command `git pull`

## What does `deploy_dot_files.py` actually do? ##

This script does the following:

* Expects to be run from the directory containing the dot-files that have been cloned from github (e.g., `/Users/matthew/dev/dot-files/`)
* On a per file basis, checks to see if symlinks from the user's home directory to the `dot-files` directory already exist and checks to make sure that the file in the `dot-files` directory does exist.
* If a symlink does not exist but the file does exist in the `dot-files` directory, then the current file in the user's home directory will be backed up and a symlink will be created
* By using symlinks instead of copying files, the `deploy_dot_files.py` script only needs to be run one time. To update simply clone the github repository using `git pull`.