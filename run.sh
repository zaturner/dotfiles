#!/bin/bash

sudo apt-get install terminator
sudo apt-get install exuberant-ctags

git submodule init
git submodule update
./install
