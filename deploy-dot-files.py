#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright (c) 2009-2022 Matthew Rankin. All rights reserved.
# Project site: https://github.com/matthewrankin/dotfiles
# Use of this source code is governed by a MIT-style license that
# can be found in the LICENSE.txt file for the project.
"""Deploy dot-files
"""

import fileinput
import os
import shutil
import subprocess
import sys

from pathlib import Path


# TODO(mdr): Should create a folder with the dot-files to deploy that way I
# don't need to update a tuple. I could just scan the deploy folder and deploy
# any dot-file found.

# Tuple containing files in dot-files project
dot_files_to_deploy = (
    '.bash_aliases',
    '.bash_profile',
    '.bashrc',
    '.chktexrc',
    '.eslintrc.json',
    '.git-completion.bash',
    '.gitconfig',
    '.gitconfig.local',
    '.gvimrc.after',
    '.gvimrc.before',
    '.hgrc',
    '.inputrc',
    '.npmrc',
    '.tmux.conf',
    '.tmux.mac.conf',
    '.vimrc.after',
    '.vimrc.before',
    '.zshrc',
    '.zsh_aliases',
)


def is_already_linked(link_to_check, check_against_file):
    '''
    Determine if 'file' is actually a link to the dot-files directory
    '''
    if os.path.islink(link_to_check):
        if os.path.realpath(link_to_check) == check_against_file:
            return True
    return False


def compare_versions(v1, v2):
    def normalize_version(v):
        parts = [int(x) for x in v.split(".")]
        while parts[-1] == 0:
            parts.pop()
        return parts
    return cmp(normalize_version(v1), normalize_version(v2))


def knows_push_simple(git_version):
    return True if compare_versions(git_version, '1.7.11') >= 0 else False


def add_git_default_push():
    """Add the default push to Git based on version.

    If Git >= v1.7.11, then use the simple push.
    If Git < v1.7.11, then use the current push.
    """
    raw_git_version = subprocess.check_output(['git', '--version'])
    git_version = raw_git_version.replace("git version", "").strip().split()[0]

    # Determine which version of push to use as default
    if knows_push_simple(git_version):
        desired_push_default = "simple"
    else:
        desired_push_default = "current"

    found_push_section = False
    for line in fileinput.input(".gitconfig", inplace=True):
        if line.startswith('[push]'):
            found_push_section = True
        elif found_push_section and line.startswith('  default ='):
            line = '  default = {}\n'.format(desired_push_default)
            found_push_section = False
        elif found_push_section and line.startswith('['):
            found_push_section = False
        sys.stdout.write(line)


def main():
    '''
    Check to see if the .bash and .git files are already symbolic links. If
    they are then don't make a backup, delete the link, and create a new one.
    If they are not symbolic links, then make a backup and create the links.
    '''
    user_home_dir = Path.home()
    cwd = os.getcwd()
    dot_files_dir = Path(cwd, 'dotfiles')
    print(f'user_home_dir = {user_home_dir}')
    print(f'dot_files_dir = {dot_files_dir}')

    for path, subdirs, files in os.walk('dotfiles'):
        for dot_file in files:
            subpath = Path(path).relative_to(Path("dotfiles"))
            dest = Path(user_home_dir, subpath, dot_file)
            src = Path(cwd, path, dot_file)
            print(f'dest = {dest}')
            print(f'src = {src}')

            if os.path.isfile(src):
                # This particular dot file does exist in the dotfile directory,
                # so let's delete the already existing symlink, copy an
                # existing dot-file to .bak, and create a new symlink as needed
                if os.path.islink(dest):
                    # dot_file is a link in the home directory, so delete the link
                    os.remove(dest)
                else:
                    if os.path.isfile(dest):
                        # Home directory dot-file is not a link, but is a file;
                        # therefore, let's backup this file before we delete it
                        print(f'Backing up {dest}')
                        shutil.move(dest, dest.with_suffix('.bak'))
                print(f'Creating link to {src}')
                os.symlink(src, dest)
            else:
                print('Skipping ' + src)


if __name__ == '__main__':
    main()
