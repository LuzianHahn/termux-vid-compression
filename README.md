# termux-vid-compression

## Issue
Currently my phone records videos in a very high quality resulting into very large files. Those files get currently automatically synced with my OwnCloud. 
I'd rather have them in a compressed version available. This also makes streaming from the cloud more easy.

## Potential solution
- [x] get script for compression running on phone via termux
- [x] use two folders, one for storing the original videos, second for storing the compressed versions
- [ ] point owncloud auto sync to the second one
> Apparently the owncloud client somehow reacts on
- [ ] use `cadaver` to sync with webdav owncloud
> is an interactive tool. It is possible to send stuff here, but an efficient sync is not possible, like it would be done with `rsync`
- [ ] fork EasySync Fdroid app. It uses static folder paths to sync. Might be easy to change and use an own fork of it.
- [ ] use cronjobs on the phone to do this regularly

## Ideas 
* use `find` instead of for loop, in case of no content raising in error (`$SRC_DIR/*` is then interpreted as file)
* consider clean up on the phone. Currently not necessary, since I have a lot of storage. I can also buy a large micro SD card to hold them instead. However since termux cannot access the SD-Card, this would require a more complicated solution


## Issues:
* cadaver's `ls` splits its overview with spaces but does not escape spaces in files listed.
  This might require a more complex parsing of the received table structure.
