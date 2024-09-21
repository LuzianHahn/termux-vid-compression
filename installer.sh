#!/bin/bash

set -e
SRC_DIR=$(dirname "${BASH_SOURCE[0]}")
ABS_SRC_DIR=$(realpath $SRC_DIR)

mkdir -p $HOME/.local/bin
ln -fs $ABS_SRC_DIR/compress_video_files $HOME/.local/bin/
ln -fs $ABS_SRC_DIR/sync_local_dir_w_remote $HOME/.local/bin/

echo "Successfully added executables to your local binaries"
