# archillect-display
A screen we set up as art in our Hackerspace that displays a new image from <https://archillect.com> every 10 minutes.

Archillect is a bot-driven project that finds images that evoke emotion, often times with an ambient and dark tone. This physical exhibition should bring this ambience to our hackerspace. 

On a system with X, the script "timer-wrapper.sh" should be executed. This will cause a new image to be displayed at every full 10 minutes of the time. It runs forever and checks every 60 seconds whether to run "archillect.sh", which actually gets and displays the image.

The "archillect.sh" is well commented for every step in the algorithm.
