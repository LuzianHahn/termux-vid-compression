# termux-vid-compression

## Issue
Currently my phone records videos in a very high quality resulting into very large files. Those files get currently automatically synced with my OwnCloud. 
I'd rather have them in a compressed version available. This also makes streaming from the cloud more easy.

## Supported Features
* Script to convert all videos in a folder into compressed versions in another folder
* webdav sync to transfer all files in own folder into a webdav location.
  Only files with changes file sizes are transmitted. 
  No nested transmission.

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

