# termux-vid-compression

## Issue
Currently my phone records videos in a very high quality resulting into very large files. Those files get currently automatically synced with my OwnCloud. 
I'd rather have them in a compressed version available. This also makes streaming from the cloud more easy.

## Potential solution
* get script for compression running on phone via termux
* use two folders, one for storing the original videos, second for storing the compressed versions
* point owncloud auto sync to the second one
* use cronjobs on the phone to do this regularly
* consider clean up on the phone. Currently not necessary, since I have a lot of storage. I can also buy a large micro SD card to hold them instead.
> could be problematic to use external SD card storage, since termux cannot access it.

## Ideas 
> * Use the share function to call termux and with it an entrypoint doing the compression. Need to see if there is some functionality provided by termux for that.
>
> Not working, since termux does not offer such a thing as it seems
* Remove intermediate compressed files if `ffmpeg` is aborted. Detection of broken mp4 files does not always work, since partially encoded videos apparently count as error free encodings
