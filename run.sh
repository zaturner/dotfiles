#!/bin/bash

sudo apt-get install vim
sudo apt-get install terminator
sudo apt-get install exuberant-ctags
sudo apt-get install cscope

git submodule init
git submodule update
./install
