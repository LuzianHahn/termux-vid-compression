#!/bin/bash

set -e
SRC_DIR=$(dirname "${BASH_SOURCE[0]}")
ABS_SRC_DIR=$(realpath $SRC_DIR)

mkdir -p $HOME/.local/bin
ln -fs $ABS_SRC_DIR/bin/compress_video_files $HOME/.local/bin/
ln -fs $ABS_SRC_DIR/bin/sync_local_dir_w_remote $HOME/.local/bin/
echo "Successfully added executables to your local binaries"

if [ -d $HOME/.shortcuts ];then
    echo "Found potential shortcuts directory. Attempting to register shortcuts..."
    cp $ABS_SRC_DIR/termux-shortcuts/* $HOME/.shortcuts/
    echo "Successfully added termux shortcuts."
fi

if [ ! -f $HOME/bin/termux-file-editor ];then
    echo "Did not find any existing termux-file-editor. Registering WebDav-Sync-Hook then..."
    mkdir -p $HOME/bin
    ln -fs $ABS_SRC_DIR/termux-file-editor/termux-file-editor $HOME/bin
    echo "Successfully registered WebDav-Sync-Hook as termux-file-editor."
else
    echo "Found existing termux-file-editor. Too afraid to overwrite. Do so manually..."
fi
