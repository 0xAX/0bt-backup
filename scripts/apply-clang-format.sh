#!/bin/bash

# where the script is runned from
base_dir=$(pwd)
# basename of the current directory where the script is runned from
bootloader_root_dir=$(basename $base_dir)

#
# we should be runned from 0bt root dir
#
if [[ $"bootloader_root_dir" != "0bt" ]];
then
    echo -e "\033[31mError: \e[0mapply-clang-format.sh should be runned from root 0bt directory."
    exit 1
fi

#
# directories with c++ code
#
tools_dir=$base_dir/tools
x86_64_src=$base_dir/src/x86_64

#
# apply clang script for this directories
#
find $tool_sdir -iname *.hpp -o -iname *.cpp | xargs clang-format -i
find $x86_64_src -iname *.hpp -o -iname *.cpp | xargs clang-format -i

exit 0
