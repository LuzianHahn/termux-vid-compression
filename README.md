# termux-vid-compression

## Issue
Currently my phone records videos in a very high quality resulting into very large files. Those files get currently automatically synced with my OwnCloud. 
I'd rather have them in a compressed version available. This also makes streaming from the cloud more easy.

## Supported Features
* Script to convert all videos in a folder into compressed versions in another folder
* webdav sync to transfer all files in own folder into a webdav location.
  Only files with changes file sizes are transmitted. 
  No nested transmission.

## Installation
* ```bash
  mkdir -p $HOME/.local/lib 
  git clone https://github.com/LuzianHahn/termux-vid-compression.git $HOME/.local/lib/termux-vid-compression
  bash $HOME/.local/lib/termux-vid-compression/installer.sh
  ```
* You need the following packages: `cadaver`, `ffmpeg`
* In order to use the shortcuts, configure a local `.env` file in this repository with:
  ```bash
  $VIDEO_SRC        # used as source directory for large videos, you want to compress
  $VIDEO_TRG        # used as target directory to store the compressed videos from $VIDEO_SRC
  $VIDEO_LOCAL_SRC  # used as local source directory to sync videos from
  $VIDEO_REMOTE_TRG # used as remote target directory on a webdav server to sync your videos to
  $WEBDAV_URL       # url for your webdav service, to which the videos are synced to 
  ```
  > Regarding infos on shortcuts, checkout https://github.com/termux/termux-widget
* Configure a `$HOME/.netrc` file to authenticate yourself against your webdav service.
  See also https://man.archlinux.org/man/cadaver.1.en#THE_.netrc_FILE

## Potential solution
- [x] get script for compression running on phone via termux
- [x] use two folders, one for storing the original videos, second for storing the compressed versions
- [x] use `cadaver` to sync with webdav owncloud
- [ ] use cronjobs on the phone to do this regularly

## Ideas 
* use `find` instead of for loop, in case of no content raising in error (`$SRC_DIR/*` is then interpreted as file)
* consider clean up on the phone. Currently not necessary, since I have a lot of storage. I can also buy a large micro SD card to hold them instead. However since termux cannot access the SD-Card, this would require a more complicated solution
* use different compression approaches to even further compress videos
* add compression for images

## Development

The test are done via python, although the utilities don't use it.
In order to run the tests, you need to install `pytest` and run
```bash
pytest
```

