#!/bin/bash

function check_dependency() {
    program=$(whereis "$1" | awk '{print $2}')
    if [[ -z $program ]];
    then
        echo -e "\e[39m$1 is not found \033[31m[NOT OK]\e[0m"
        exit 1
    else
        echo -e "\e[39m$1 OK \e[32m[OK]\e[0m"
    fi
}

check_dependency ld
check_dependency gcc
check_dependency g++
check_dependency fdisk
check_dependency mkfs.vfat
check_dependency mkfs.ext2
check_dependency as
check_dependency sed
check_dependency dd
check_dependency find
check_dependency bc
check_dependency hexdump
check_dependency mount
check_dependency getopt
check_dependency tar
