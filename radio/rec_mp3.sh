#!/bin/bash

stream=$1
mtitle=$2
kbps=$3
segtime=$4
destdir=$5
# destdir="/tv/MIDIA"
destfile=$6
destldir=$7
mono_channel=$8

n=1
while [[ ${n} -eq 1 ]] ; do
	# FFREPORT=file=${destldir}/${destfile}"_"info.log:level=32 \
	# FFREPORT=file=${destldir}/${destfile}"_"warning.log:level=24 \
	FFREPORT=file=${destldir}/${destfile}"_"error.log:level=16 \
	ffmpeg -loglevel quiet \
	-threads 1 -i "${stream}" \
	-b:a ${kbps}k -ar 48000 ${mono_channel} \
	-f segment -strftime 1 -segment_time ${segtime} \
	${destdir}/%Y-%m-%d"_"%H-%M-%S"_"${destfile}.mp3
done
