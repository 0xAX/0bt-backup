#!/bin/bash

QEMU=qemu-system-x86_64
SCREEN=0bt

do_setup() {

    tmux new -s $SCREEN \; detach

    echo Starting disk.img in qemu session
    tmux new-window -n qemu "$QEMU \
    -hda disk.img"

    echo Starting disk.img in gdb session
    tmux new-window -n gdb "$QEMU -s -S \
    -hda disk.img"
}

do_teardown() {
    echo "Killing all KVM instances"
    killall qemu-system-x86_64
    echo "Stopping Obt session"
    tmux kill-session -t $SCREEN
}

do_usage() {
    echo "tmux.sh -setup : will setup the 0bt session, And start qemu and gdb windows in the session."
    echo "tmux.sh -teardown : will stop the KVM instances and close tmux session."
}

case $1 in
    -setup)
        do_setup ;;
    -teardown)
        do_teardown ;;
    *)
        do_usage ;;
esac
