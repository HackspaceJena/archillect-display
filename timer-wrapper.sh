#!/bin/bash
#this calls the archillect-image-get-and-display script every 10 minutes.
while true
do
    [[ $((10#`date +%M`%10)) == 1 ]] && ./archillect.sh
    sleep 59
done
