#!/bin/bash

d1days=$(date -d '-25 days 03:00 BRT' '+%Y-%m-%d')
d2days=$(date -d '-35 days 03:00 BRT' '+%Y-%m-%d')
d3days=$(date -d '-31 days 03:00 BRT' '+%Y-%m-%d')

d1midiadir="/applications/record/tv/MIDIA"
d2midiadir="/applications/record/tv/MIDIA"
d3midiadir="/applications/record/tv/MIDIA"
d1thumbdir="/applications/record/tv/THUMB"
d2thumbdir="/applications/record/tv/THUMB"
d3thumbdir="/applications/record/tv/THUMB"

todaydatelog=$(date +'%Y-%m-%d')
nowtimelog=$(date +'%H:%M:%S')
echo $todaydatelog"_"$nowtimelog" - Script Start" >> "/var/log/remove_files.log"

#disco1
for d1month in $(ls -v ${d1midiadir}) ; do
	for d1date in $(ls -v ${d1midiadir}/${d1month}) ; do
		d1currdate=$(date -d "${d1date} 03:00 BRT" +%s)
		d1letdate=$(date -d "${d1days}" +%s)
		if [[ ${d1currdate} -lt ${d1letdate} ]] ; then
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d1midiadir}/${d1month}/${d1date} >> "/var/log/remove_files.log"
			rm -rf ${d1midiadir}/${d1month}/${d1date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Moving" ${d1thumbdir}/${d1month}/${d1date} >> "/var/log/remove_files.log"
			rm -rf ${d1thumbdir}/${d1month}/${d1date}
		fi
	done
done

#disco2
for d2month in $(ls -v ${d2midiadir}) ; do
	for d2date in $(ls -v ${d2midiadir}/${d2month}) ; do
		d2currdate=$(date -d "${d2date} 03:00 BRT" +%s)
		d2letdate=$(date -d "${d2days}" +%s)
		if [[ ${d2currdate} -lt ${d2letdate} ]] ; then
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d2midiadir}/${d2month}/${d2date} >> "/var/log/remove_files.log"
			rm -rf ${d2midiadir}/${d2month}/${d2date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d2thumbdir}/${d2month}/${d2date} >> "/var/log/remove_files.log"
			rm -rf ${d2thumbdir}/${d2month}/${d2date}
		fi
	done
done

#disco3
for d3month in $(ls -v ${d3midiadir}) ; do
	for d3date in $(ls -v ${d3midiadir}/${d3month}) ; do
		d3currdate=$(date -d "${d3date} 03:00 BRT" +%s)
		d3letdate=$(date -d "${d3days}" +%s)
		if [[ ${d3currdate} -lt ${d3letdate} ]] ; then
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d3midiadir}/${d3month}/${d3date} >> "/var/log/remove_files.log"
			rm -rf ${d3midiadir}/${d3month}/${d3date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Moving" ${d3thumbdir}/${d3month}/${d3date} >> "/var/log/remove_files.log"
			rm -rf ${d3thumbdir}/${d3month}/${d3date}
		fi
	done
done

nowtimelog=$(date +'%H:%M:%S')
echo $todaydatelog"_"$nowtimelog" - Script End" >> "/var/log/remove_files.log"
echo >> "/var/log/remove_files.log"
