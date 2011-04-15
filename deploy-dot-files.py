#!/usr/bin/env python
# encoding: utf-8
"""
deploy-dot-files.py

Created by Matthew Rankin on 2009-06-04.
Copyright (c) 2009 Cumulusware, LLC. All rights reserved.
"""


import sys
import os
import shutil


# Tuple containing files in dot-files project
dot_files_to_deploy = (
    '.bash_profile',
    '.bash_aliases',
    '.bashrc',
    '.gitconfig',
    '.gitignore',
    '.git-completion.bash',
	'.hgrc',
    '.vimrc.local',
    '.gvimrc.local',
)

def is_already_linked(link_to_check, check_against_file):
    '''
    Determine if 'file' is actually a link to the dot-files directory
    '''
    if os.path.islink(link_to_check):
        if os.path.realpath(link_to_check) == check_against_file:
            return True
    return False
    
def main():
    '''
    Check to see if the .bash and .git files are already symbolic links. If
    they are then don't make a backup, delete the link, and create a new one.
    If they are not symbolic links, then make a backup and create the links.
    '''
    user_home_dir = os.path.expanduser('~')
    dot_files_dir = os.getcwd()
    print 'user_home_dir = ' + user_home_dir
    print 'dot_files_dir = ' + dot_files_dir
    
    for dot_file in dot_files_to_deploy:
        dot_file_with_home_path = os.path.join(user_home_dir, dot_file)
        # print 'dot_file_with_home_path = ' + dot_file_with_home_path
        dot_file_with_dot_file_path = os.path.join(dot_files_dir, dot_file)

        if os.path.isfile(dot_file_with_dot_file_path):
            # This particular dot file does exist in the dot file directory
            # So let's delete the already existing symlink, copy an existing
            # dot-file to .bak, and create a new symlink as needed
            if os.path.islink(dot_file_with_home_path):
                # dot_file is a link in the home directory, so delete the link
                os.remove(dot_file_with_home_path)
            else:
                if os.path.isfile(dot_file_with_home_path):
                    # Home directory dot-file is not a link, but is a file;
                    # therefore, let's backup this file before we delete it
                    print 'Backing up' + dot_file_with_home_path
                    shutil.move(dot_file_with_home_path,
                        dot_file_with_home_path + '.bak')
            print 'Creating link to ' + dot_file_with_dot_file_path
            os.symlink(dot_file_with_dot_file_path, dot_file_with_home_path)
        else:
            print 'Skipping ' + dot_file_with_dot_file_path

if __name__ == '__main__':
	main()

