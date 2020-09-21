#!/bin/bash

jsonfile="RADIOS.json"

#kill the rec script
killall rec_mp3.sh

#kill the ffmpegs
killall -INT ffmpeg
killall -INT ffmpeg
killall -INT ffmpeg

sleep 3
# for dvrs in $(jq keys ${jsonfile} | awk -F"[\"\"]" '{print $2}' | grep .) ; do
# 	# echo ${dvrs}
# 	arrn=$(($(jq ".${dvrs} | length" ${jsonfile})-1))
# 	for dvrn in $(seq 0 ${arrn}) ; do
# 		state=$(jq --raw-output .${dvrs}[${dvrn}].state ${jsonfile})
# 		name=$(jq --raw-output .${dvrs}[${dvrn}].name ${jsonfile} | sed 's/ /-/g')
# 		stream=$(jq --raw-output .${dvrs}[${dvrn}].stream ${jsonfile})
# 		kbps=$(jq --raw-output .${dvrs}[${dvrn}].kbps ${jsonfile})
# 		mono_channel=$(jq --raw-output .${dvrs}[${dvrn}].mono_channel ${jsonfile})
# 		disk=$(jq --raw-output .${dvrs}[${dvrn}].disk ${jsonfile})
# 		mtitle=${name}"_"${today}
# 		destfile=${name}"_"${state}
# 		echo "state:" ${state}
# 		echo "name:" ${name}
# 		# echo "stream:" ${stream}
# 		# echo "kbps:" ${kbps}
# 		echo
# 		ffmpegpid=$(ps aux | grep "ffmpeg" | grep ${destfile} | grep ${sourcec} | awk '{print $2}')
# 		# echo ${destfile}
# 		# echo "PID:" ${ffmpegpid}
# 		if [[ -n ${ffmpegpid} ]]; then
# 			# echo "kill -INT" ${ffmpegpid}
# 			kill -2 ${ffmpegpid}
# 		fi
# 		# echo
# 	done
# done