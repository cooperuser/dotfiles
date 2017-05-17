#!/bin/bash

pythonPath=$(python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")
dir=~/dotfiles
olddir=~/.dotfiles_old

mkdir $pythonPath

mv $pythonPath/powerline/config_files $olddir/powerline/
ln -s $dir/powerline/config_files $pythonPath/powerline/config_files
