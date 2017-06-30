#!/bin/bash

QEMU=qemu-system-x86_64
SCREEN=0bt
QEMU_OPTS="-nographic"
IMG=disk.img

do_setup() {
    if [[ -n "$1" ]];
    then
        IMG=$1
    elif [[ ! -f "$IMG" ]];
    then
        echo "$IMG file not exist"
        exit 1
    fi

    tmux new -s $SCREEN \; detach

    echo "Starting $IMG in qemu session"
    tmux new-window -n qemu "$QEMU $QEMU_OPTS \
    -hda $IMG"

    echo "Starting $IMG in gdb session"
    tmux new-window -n gdb "$QEMU $QEMU_OPTS -s -S \
    -hda $IMG"
}

do_teardown() {
    echo "Killing all KVM instances"
    killall qemu-system-x86_64
    echo "Stopping Obt session"
    tmux kill-session -t $SCREEN
}

do_usage() {
    echo "Usage:"
    echo "    tmux.sh -setup <image file>: Will setup the 0bt session, And start qemu and gdb windows in the session."
    echo "    tmux.sh -teardown: Will stop the KVM instances and close tmux session."
}

case $1 in
    -setup)
        do_setup $2;;
    -teardown)
        do_teardown ;;
    *)
        do_usage ;;
esac

exit 0
