#!/bin/bash

jsonfile="/tv/scripts/CARDs.json"

#kill the rec script
killall recmp4.sh

#kill the ffmpegs
for dvrs in $(jq keys ${jsonfile} | awk -F"[\"\"]" '{print $2}' | grep .) ; do
	# echo ${dvrs}
	arrn=$(($(jq ".${dvrs} | length" ${jsonfile})-1))
	for dvrn in $(seq 0 ${arrn}) ; do
		channel=$(jq --raw-output .${dvrs}[${dvrn}].channel ${jsonfile})
		state=$(jq --raw-output .${dvrs}[${dvrn}].state ${jsonfile})
		name=$(jq --raw-output .${dvrs}[${dvrn}].name ${jsonfile} | sed 's/ /-/g')
		rtsp=$(jq --raw-output .${dvrs}[${dvrn}].rtsp ${jsonfile})
		sourcec=$(jq --raw-output .${dvrs}[${dvrn}].sourcec ${jsonfile})
		aspect=$(jq --raw-output .${dvrs}[${dvrn}].aspect ${jsonfile})
		mtitle=${name}"_"${today}
		destfile=${name}"_"${state}
		# echo "channel:" ${channel}
		# echo "state:" ${state}
		# echo "name:" ${name}
		# echo "rtsp:" ${rtsp}
		# echo "sourcec:" ${sourcec}
		# echo "aspect:" ${aspect}
		ffmpegpid=$(ps aux | grep "ffmpeg" | grep ${destfile} | grep ${sourcec} | awk '{print $2}')
		# echo ${destfile}
		# echo "PID:" ${ffmpegpid}
		if [[ -n ${ffmpegpid} ]]; then
			# echo "kill -INT" ${ffmpegpid}
			kill -2 ${ffmpegpid}
		fi
		# echo
	done
done