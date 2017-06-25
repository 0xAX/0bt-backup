#!/bin/bash

basedir=$(pwd)
toolsdir=$basedir/tools
find $toolsdir -iname *.hpp -o -iname *.cpp | xargs clang-format -i
exit 0
