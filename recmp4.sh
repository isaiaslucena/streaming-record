#!/bin/bash

sourcec="${1}"
aspect="${4}"
segtime="${5}"
destdir="${6}"
destfile="${7}"
destldir="${8}"

n=1
while [[ ${n} -eq 1 ]] ; do
	#FFREPORT=file=${destldir}/${destfile}"_"info.log:level=32 \
	# FFREPORT=file=${destldir}/${destfile}"_"warning.log:level=24 \
	FFREPORT=file=${destldir}/${destfile}"_"error.log:level=16 \
	ffmpeg -loglevel quiet \
	-i "${sourcec}" -c:v copy \
	$([[ "${aspect}" != "null" ]] && echo "-aspect" "${aspect}") \
	-f segment -strftime 1 -segment_time ${segtime} -reset_timestamps 1 -segment_time_metadata 1 \
	${destdir}/%Y-%m-%d"_"%H-%M-%S"_"${destfile}.mp4
done
