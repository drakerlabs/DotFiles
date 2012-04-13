#!/bin/bash

# Updates all submodules to most recent version

git submodule init
pwd=$PWD

for submodule in `git submodule | cut -f3 -d ' '`; do
  cd $submodule
  git checkout master
  git pull origin master
  cd $pwd
done
