#!/bin/bash

#test "$#" -lt 1 &&
#    echo "apply-clang-format.sh: path to tmail root dir should be passed." &&
#    exit 1

basedir=$(pwd)
toolsdir=$basedir/tools
find $toolsdir -iname *.hpp -o -iname *.cpp | xargs clang-format -i

#if [ "$dir" = "tmail" ] || [ "$dir" = "src" ] ;
#then
#    if [ -f "$1/src/tmail.c" ] || [ -f "$1/tmail.c" ] ;
#    then
#	find $1 -iname *.hpp -o -iname *.cpp | xargs clang-format -i
#	exit 0
#    fi
#fi

exit 0

#echo "apply-clang-format.sh: path to tmail root dir should be passed."
#exit 1
