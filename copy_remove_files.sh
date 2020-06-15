#!/bin/bash

nowDateTime() {
	date +'%F_%X'
}

daysBeforeIso=$(date -d '-1 days 03:00 BRT' '+%Y-%m-%d')
daysBeforeEpoch=$(date -d "${daysBeforeIso}" +%s)

rootDir="/applications/record/files/"
midiaDir="/tv/MIDIA"
thumbDir="/tv/THUMB"

echo "$(nowDateTime)" "- Script Start" #>> "/var/log/remove_files.log"

for recDevice in ${rootDir} ; do
	monthsMediaDir=${rootDir}${recDevice}${midiaDir}
	for monthDir in ${monthsMediaDir} ; do
	datesDir=${monthsMediaDir}${monthDir}
		for dateDir in ${datesDir} ; do
			d1currdate=$(date -d "${dateDir} 03:00 BRT" +%s)
			if [[ ${d1currdate} -lt ${daysBeforeEpoch} ]] ; then
				echo "$(nowDateTime)" "- Removing" ${midiaDir}/${monthDir}/${dateDir} # >> "/var/log/remove_files.log"
				# rm -rf ${midiaDir}/${monthDir}/${dateDir}

				echo "$(nowDateTime)" "- Removing" ${thumbDir}/${monthDir}/${dateDir} # >> "/var/log/remove_files.log"
				# rm -rf ${thumbDir}/${monthDir}/${dateDir}
			fi
		done
	done
done

echo echo "$(nowDateTime)" "- Script End" # >> "/var/log/remove_files.log"
# echo >> "/var/log/remove_files.log"
