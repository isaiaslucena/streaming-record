#!/bin/bash

#Set the cards 
v4l2-ctl -d /dev/video0 -i 1
ivtv-tune -d /dev/video1 -c 3

v4l2-ctl -d /dev/video2 -i 1
ivtv-tune -d /dev/video3 -c 3

v4l2-ctl -d /dev/video4 -i 1
ivtv-tune -d /dev/video5 -c 3

v4l2-ctl -d /dev/video6 -i 1
ivtv-tune -d /dev/video7 -c 3
