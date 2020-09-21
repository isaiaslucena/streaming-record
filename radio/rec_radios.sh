#!/bin/bash

IFS="
"

today=$(date +'%Y-%m-%d')
tmonth=$(date '+%m')
tmonthn=$(LC_TIME=pt_BR.UTF-8 date '+%B')
now=$(date +'%H:%M:%S')

segtime="600"
midiadir="/applications/record/files/REC01/radio"
logdir="/LOG"
dirpath=${tmonth}"-"${tmonthn}/${today}
dirlpath=${logdir}/${tmonth}"-"${tmonthn}/${today}
recpath="/applications/record/scripts/radio/rec_mp3.sh"
jsonfile="/applications/record/scripts/radio/RADIOS.json"
for dvrs in $(jq keys ${jsonfile} | awk -F"[\"\"]" '{print $2}' | grep .) ; do
	echo ${dvrs}
	arrn=$(($(jq ".${dvrs} | length" ${jsonfile})-1))
	for dvrn in $(seq 0 ${arrn}) ; do
		# channel=$(jq --raw-output .${dvrs}[${dvrn}].channel ${jsonfile})
		state=$(jq --raw-output .${dvrs}[${dvrn}].state ${jsonfile})
		name=$(jq --raw-output .${dvrs}[${dvrn}].name ${jsonfile} | sed 's/ /-/g')
		stream=$(jq --raw-output .${dvrs}[${dvrn}].stream ${jsonfile})
		kbps=$(jq --raw-output .${dvrs}[${dvrn}].kbps ${jsonfile})
		mono_channel=$(jq --raw-output .${dvrs}[${dvrn}].mono_channel ${jsonfile})
		# disk=$(jq --raw-output .${dvrs}[${dvrn}].disk ${jsonfile})
		mtitle=${name}"_"${today}
		destfile=${name}"_"${state}
		# finaldir=${disk}${midiadir}/${dirpath}/${destfile}
		finaldir=${midiadir}/${dirpath}/${destfile}
		finallogdir=${dirlpath}
		# echo "channel:" ${channel}
		# echo "state:" ${state}
		# echo "name:" ${name}
		# echo ${name} - ${state}
		# echo "stream:" ${stream}
		# echo "kbps:" ${kbps}
		# echo

		if [ ! -d ${finaldir} ] ; then
			mkdir -p ${finaldir}
		fi

		if [ ! -d ${finallogdir} ] ; then
			mkdir -p ${finallogdir}
		fi

		${recpath} ${stream} ${mtitle} ${kbps} ${segtime} ${finaldir} ${destfile} ${finallogdir} ${mono_channel} &
	done
	# echo
done
