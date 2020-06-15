#!/bin/bash

d1days=$(date -d '-1 days 03:00 BRT' '+%Y-%m-%d')

d1midiadir="/applications/record/tv/MIDIA"
d1thumbdir="/applications/record/tv/THUMB"

todaydatelog=$(date +'%Y-%m-%d')
nowtimelog=$(date +'%H:%M:%S')
echo $todaydatelog"_"$nowtimelog" - Script Start" #>> "/var/log/remove_files.log"

for d1month in $(ls -v ${d1midiadir}) ; do
	for d1date in $(ls -v ${d1midiadir}/${d1month}) ; do
		d1currdate=$(date -d "${d1date} 03:00 BRT" +%s)
		d1letdate=$(date -d "${d1days}" +%s)
		if [[ ${d1currdate} -lt ${d1letdate} ]] ; then
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d1midiadir}/${d1month}/${d1date} #>> "/var/log/remove_files.log"
			#rm -rf ${d1midiadir}/${d1month}/${d1date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Moving" ${d1thumbdir}/${d1month}/${d1date} #>> "/var/log/remove_files.log"
			#rm -rf ${d1thumbdir}/${d1month}/${d1date}
		fi
	done
done

nowtimelog=$(date +'%H:%M:%S')
echo $todaydatelog"_"$nowtimelog" - Script End" #>> "/var/log/remove_files.log"
#echo >> "/var/log/remove_files.log"
