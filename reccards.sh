#!/bin/bash

today=$(date +'%Y-%m-%d')
tmonth=$(date '+%m')
tmonthn=$(date '+%B')
now=$(date +'%H:%M:%S')

segtime="300"
midiadir="/applications/record/files/tv/MIDIA"
logdir="/tv/LOG"
dirpath=${midiadir}/${tmonth}"-"${tmonthn}/${today}
dirlpath=${logdir}/${tmonth}"-"${tmonthn}/${today}
recpath="/applications/record/scripts/recmp4.sh"
jsonfile="/applications/record/scripts/CARDs.json"

for dvrs in $(jq keys ${jsonfile} | awk -F"[\"\"]" '{print $2}' | grep .) ; do
	# echo ${dvrs}
	arrn=$(($(jq ".${dvrs} | length" ${jsonfile})-1))
	for dvrn in $(seq 0 ${arrn}) ; do
		channel=$(jq --raw-output .${dvrs}[${dvrn}].channel ${jsonfile})
		state=$(jq --raw-output .${dvrs}[${dvrn}].state ${jsonfile})
		name=$(jq --raw-output .${dvrs}[${dvrn}].name ${jsonfile} | sed 's/ /-/g')
		feed=$(jq --raw-output .${dvrs}[${dvrn}].feed ${jsonfile})
		sourcec=$(jq --raw-output .${dvrs}[${dvrn}].sourcec ${jsonfile})
		savedisk=$(jq --raw-output .${dvrs}[${dvrn}].savedisk ${jsonfile})
		aspect=$(jq --raw-output .${dvrs}[${dvrn}].aspect ${jsonfile})
		feed=$(jq --raw-output .${dvrs}[${dvrn}].feed ${jsonfile})
		mtitle=${name}"_"${today}
		destfile=${name}"_"${state}
		finaldir=${savedisk}${dirpath}/${destfile}
		finallogdir=${dirlpath}

		echo "channel:" ${channel}
		echo "state:" ${state}
		echo "name:" ${name}
		echo "source:" ${sourcec}
		# echo "feed:" ${feed}
		# echo "aspect:" ${aspect}
		# echo "finaldir:" ${finaldir}
		# echo "finaldirlog:" ${finallogdir}
		# echo

		if [ ! -d ${finaldir} ] ; then
			mkdir -p ${finaldir}
		fi

		if [ ! -d ${finallogdir} ] ; then
			mkdir -p ${finallogdir}
		fi

		# if [[ "${transc}" == 'true' ]] ; then
		# 	if [[ ! -d ${afinaldir} ]] ; then
		# 		mkdir -p ${afinaldir}
		# 	fi

		# 	echo ${name}-${state} "must transcribe!"
		# 	echo "transcribe:" ${transc}
		# 	echo "audio savedisk:" ${asavedisk}
		# fi

		echo

		${recpath} ${sourcec} ${feed} ${mtitle} ${aspect} ${segtime} ${finaldir} ${destfile} ${finallogdir} &
	done
	# echo
done

exit
