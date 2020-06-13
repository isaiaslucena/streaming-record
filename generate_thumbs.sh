#!/bin/bash

today=$(date +'%Y-%m-%d')
yesterday=$(date -d '-1 day' +'%Y-%m-%d')
tmonth=$(date '+%m')
tmonthn=$(date '+%B')
now=$(date +'%H:%M:%S')

rootdir="/disks"
midiadir="tv/MIDIA"
thumbdir="tv/THUMB"

for disk in ${rootdir} ; do
	midiadirc=${rootdir}/${disk}/${midiadir}/${tmonth}"-"${tmonthn}/${today}
	for channel in $(ls ${midiadirc}) ; do
		for file in $(ls ${midiadirc}/${channel}) ; do
			filename=$(echo ${file} | sed 's/.mp4//g')
			fileuse=$(lsof ${midiadirc}/${channel}/${file} | tail -n 1 | awk '{print $2}')
			thumbdirc=${rootdir}/${disk}/${thumbdir}/${tmonth}"-"${tmonthn}/${today}
			if [[ -z ${fileuse} ]] ; then
				thumdirfile=${thumbdirc}/${channel}/${filename}
				if [[ ! -d ${thumbdirc}/${channel}/${filename} ]] ; then
					echo "Creating directory" ${thumbdirc}/${channel}/${filename}
					mkdir -p ${thumbdirc}/${channel}/${filename}
					echo "Creating thumbs for file" ${midiadirc}/${channel}/${file}
					ffmpeg -loglevel quiet -threads 1 -i ${midiadirc}/${channel}/${file} -vf fps=1 -s 854x480 ${thumbdirc}/${channel}/${filename}/${filename}"_%03d.jpg"
				fi
			else
				echo "File" ${midiadirc}/${channel}/${file} "is in use!"
			fi
		done
	done
done