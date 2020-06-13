#!/bin/bash

d1days=$(date -d '-69 days' '+%Y-%m-%d')
d2days=$(date -d '-42 days' '+%Y-%m-%d')
d3days=$(date -d '-25 days' '+%Y-%m-%d')

d1midiadir="/disks/disco1/tv/MIDIA"
d2midiadir="/disks/disco2/tv/MIDIA"
d3midiadir="/disks/disco3/tv/MIDIA"
d1thumbdir="/disks/disco1/tv/THUMB"
d2thumbdir="/disks/disco2/tv/THUMB"
d3thumbdir="/disks/disco3/tv/THUMB"

todaydatelog=$(date +'%Y-%m-%d')
nowtimelog=$(date +'%H:%M:%S')
echo $todaydatelog"_"$nowtimelog" - Script Start" >> "/var/log/move_files.log"

#store only last 69 days in disco1
for d1month in $(ls -v ${d1midiadir}) ; do
	for d1date in $(ls -v ${d1midiadir}/${d1month}) ; do
		# echo "Verifying" ${d1midiadir}/${d1month}/${d1date}
		d1currdate=$(date -d "${d1date} 03:00 BRT" +%s)
		d1letdate=$(date -d "${d1days} 08:00 BRT" +%s)
		if [[ ${d1currdate} -lt ${d1letdate} ]] ; then
			# echo "Removing" ${d1midiadir}/${d1month}/${d1date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d1midiadir}/${d1month}/${d1date} >> "/var/log/move_files.log"
			rm -rf ${d1midiadir}/${d1month}/${d1date}
			# echo "Removing" ${d1thumbdir}/${d1month}/${d1date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d1thumbdir}/${d1month}/${d1date} >> "/var/log/move_files.log"
			rm -rf ${d1thumbdir}/${d1month}/${d1date}
		fi
	done
done

#store only last 42 days in disco2
for d2month in $(ls -v ${d2midiadir}) ; do
	if [[ ! -d ${d1midiadir}/${d2month} ]] ; then
		mkdir -p ${d1midiadir}/${d2month}
		mkdir -p ${d1thumbdir}/${d2month}
	fi
	for d2date in $(ls -v ${d2midiadir}/${d2month}) ; do
		# echo "Verifying" ${d2midiadir}/${d2month}/${d2date}
		d2currdate=$(date -d "${d2date} 03:00 BRT" +%s)
		d2letdate=$(date -d "${d2days} 08:00 BRT" +%s)
		if [[ ${d2currdate} -lt ${d2letdate} ]] ; then
			# echo "Moving" ${d2midiadir}/${d2month}/${d2date} "to" ${d1midiadir}/${d2month}/${d2date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Moving" ${d2midiadir}/${d2month}/${d2date} "to" ${d1midiadir}/${d2month}/${d2date} >> "/var/log/move_files.log"
			mv ${d2midiadir}/${d2month}/${d2date} ${d1midiadir}/${d2month}/${d2date}
			#echo "Moving" ${d2thumbdir}/${d2month}/${d2date} "to" ${d1thumbdir}/${d2month}/${d2date}
			nowtimelog=$(date +'%H:%M:%S')
			# echo $todaydatelog"_"$nowtimelog" - Moving" ${d2thumbdir}/${d2month}/${d2date} "to" ${d1thumbdir}/${d2month}/${d2date} >> "/var/log/move_files.log"
			# mv ${d2thumbdir}/${d2month}/${d2date} ${d1thumbdir}/${d2month}/${d2date}
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d2thumbdir}/${d2month}/${d2date} >> "/var/log/move_files.log"
			rm -rf ${d2thumbdir}/${d2month}/${d2date}
		fi
	done
done

# store only last 25 days in disco3
for d3month in $(ls -v ${d3midiadir}) ; do
	if [[ ! -d ${d2midiadir}/${d3month} ]] ; then
		mkdir -p ${d2midiadir}/${d3month}
		mkdir -p ${d2thumbdir}/${d3month}
	fi
	for d3date in $(ls -v ${d3midiadir}/${d3month}) ; do
		# echo "Verifying" ${d3midiadir}/${d3month}/${d3date}
		d3currdate=$(date -d "${d3date} 03:00 BRT" +%s)
		d3letdate=$(date -d "${d3days} 08:00 BRT" +%s)
		if [[ ${d3currdate} -lt ${d3letdate} ]] ; then
			# echo "Moving" ${d3midiadir}/${d3month}/${d3date} "to" ${d2midiadir}/${d3month}/${d3date}
			nowtimelog=$(date +'%H:%M:%S')
			echo $todaydatelog"_"$nowtimelog" - Moving" ${d3midiadir}/${d3month}/${d3date} "to" ${d2midiadir}/${d3month}/${d3date} >> "/var/log/move_files.log"
			mv ${d3midiadir}/${d3month}/${d3date} ${d2midiadir}/${d3month}/${d3date}
			#echo "Moving" ${d3thumbdir}/${d3month}/${d3date} "to" ${d2thumbdir}/${d3month}/${d3date}
			nowtimelog=$(date +'%H:%M:%S')
			# echo $todaydatelog"_"$nowtimelog" - Moving" ${d3thumbdir}/${d3month}/${d3date} "to" ${d2thumbdir}/${d3month}/${d3date} >> "/var/log/move_files.log"
			# mv ${d3thumbdir}/${d3month}/${d3date} ${d2thumbdir}/${d3month}/${d3date}
			echo $todaydatelog"_"$nowtimelog" - Removing" ${d3thumbdir}/${d3month}/${d3date} >> "/var/log/move_files.log"
			rm -rf ${d3thumbdir}/${d3month}/${d3date}
		fi
	done
done

nowtimelog=$(date +'%H:%M:%S')
echo $todaydatelog"_"$nowtimelog" - Script End" >> "/var/log/move_files.log"
echo >> "/var/log/move_files.log"