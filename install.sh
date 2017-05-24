#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # directories directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
directories="vim bash tmux fzf"       # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for directory in $directories; do
	for file in $dir/$directory/*; do
		# echo $file
		echo mv ~/.$(basename $file) $olddir
		echo ln -s $file ~/.$(basename $file)
		###########
		# echo "Moving any existing dotfiles from ~ to $olddir"
		echo "Moving ~/.$(basename $file) to $olddir"
		mv ~/.$(basename $file) $olddir
		echo "Creating symlink to .$file in home directory."
		ln -s $file ~/.$(basename $file)
	done
done
