#!/bin/bash

# Tags file
files_path=./tag_files;

# Find the files to run ctags and cscope on.
touch $files_path
rm $files_path;
touch $files_path
find . -name "*\.c" -o -name "*\.cpp" -o -name "*\.h" >> $files_path;

# Run Ctags
ctags -L $files_path
