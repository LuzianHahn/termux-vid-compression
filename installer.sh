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

if command -v crontab >/dev/null 2>&1; then 
    echo "crontab found. Attempting installation of different cron files..."
    crontab -l > $SRC_DIR/tmp/cron.bak 2>/dev/null
    for cronjob_bin in ./cron/*;do
        echo "Trying cronfile: $cronjob_bin..."
        cronjob_bin_file=$(basename $cronjob_bin)
        # grep exits with 1 in case of 0 line matches. Especially problematic with empty crontab. Hence " || true"
        cat $SRC_DIR/tmp/cron.bak | grep -v $cronjob_bin_file > $SRC_DIR/tmp/cleaned_cron.bak || true  
        echo "0 5 * * * $ABS_SRC_DIR/cron/$cronjob_bin_file" >> $SRC_DIR/tmp/cleaned_cron.bak
        mv $SRC_DIR/tmp/cleaned_cron.bak $SRC_DIR/tmp/cron.bak
    done
    crontab $SRC_DIR/tmp/cron.bak
    rm $SRC_DIR/tmp/cron.bak
else
    echo "crontab not found. Hence skipping the installation of cronjobs..."
fi
