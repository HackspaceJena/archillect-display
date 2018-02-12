#!/bin/bash
#This is a script to show a new picture from archillect.com every 10 minutes.
#in your tmux, you should run ./timer-wrapper.sh, which calls this script every 10 minutes and is an infinite loop.
#made by @CosmoGecko

#enable start of graphical apps
export DISPLAY=:0
#make a working directory and use it
[ -d archillect-resources ] || 
    mkdir archillect-resources || 
    (
        echo 'The folder archillect-resources already exists but is not a directory, please delete or rename.';
        exit 1
    )    
cd archillect-resources
#get a fresh archillect-home.html
[ -e archillect-home.html ] && 
    (
        rm archillect-home.html; echo 'Removed old archillect-home.html' 
    )
wget --output-document='archillect-home.html' archillect.com
#get the picture number of the most recent post by searching for the first six-digit number, and download that image detail site
wget --output-document='archillect-imagedetail.html' archillect.com/`grep -o -P '\d{6}' archillect-home.html | cut -f 1 -d$'\n'`
#grep the image embedded, and download the image. Also write the archillect-image-ID to a file.
wget --output-document='archillect-currentimage' `grep 'id="ii"' archillect-imagedetail.html | grep -o -P 'http.*\.(jpg|png|gif)\ '`
#show the new image and kill the previous instance of the image viewer
#   open a new image viewer and write its pid to new-pid
sxiv -f -b -a -s f archillect-currentimage & echo $! > new-pid
#   checking whether the process with old-pid is really the old image viewer
#       checking whether old-pid is really just a number, exists and is not empty
# disabled: compare the value in old-pid with the running process id for the image viewer, (where both must not be empty at the same time, has been checked already)
#       if the running pid of the old image viewer matches the one saved previously by the script, kill the old image viewer
grep -P '\d*' old-pid && 
#    [[ `pgrep -f "sxiv -f -b -s f archillect-currentimage"` -eq $(<old-pid) ]] && 
        [[ $(<old-pid) -ne 0 ]] &&
        kill -15 $(<old-pid) || echo 'No old image viewer was found, and no process was killed.'

        
mv new-pid old-pid
