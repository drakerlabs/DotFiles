#!/bin/bash

# Symlink all files in conf to ~/.home

pwd=`pwd`

git submodule init

for file in `ls $pwd/conf`; do
  target="$pwd/conf/$file"
  destination="$HOME/.$file"
  backup=false
  delete=false
  skip=false
  if [ -e $destination ]; then
    echo
    echo "$destination exists, you may (s)kip this file, (b)ackup the existing file, or (d)elete the existing file"
    read -n 1 option
    echo
    if [ "$option" == "s" ]; then
      skip=true
    fi
    if [ "$option" == "b" ]; then
      backup=true
    fi
    if [ "$option" == "d" ]; then
      delete=true
    fi
  fi

  if [ $backup == true ]; then
    back="$destination.back"
    echo "Backing up $destination to $back"
    `mv $destination $back`
  fi

  if [ $delete == true ]; then
    echo "Deleting $destination"
    `rm $destination`
  fi

  if [ ! $skip == true ]; then
    echo "Symlinking $target to $destination"
    `ln -s $target $destination`
  fi
done
