#!/bin/bash

nowDateTime() {
	date +'%F_%X'
}

daysBeforeIso=$(date -d '-1 days 03:00 BRT' '+%Y-%m-%d')
daysBeforeEpoch=$(date -d "${daysBeforeIso} 03:00 BRT" +%s)

rootDir="/applications/record/files"
midiaDir="/tv/MIDIA"

echo "$(nowDateTime)" "- Script Start" # >> "/var/log/remove_files.log"

for recDeviceDir in $(ls -d ${rootDir}/*) ; do
	# echo "${recDeviceDir}"
	monthsDir=${recDeviceDir}${midiaDir}
	for monthDir in $(ls -d ${monthsDir}/*) ; do
		# echo "${monthDir}"
		for dateDir in $(ls "${monthDir}") ; do
			# echo "Current dayDir" "${dateDir}"
			dateDirEpoch=$(date -d "${dateDir} 03:00 BRT" +%s)
			if [[ ${dateDirEpoch} -le ${daysBeforeEpoch} ]] ; then
				currentMediaDir=${monthDir}/${dateDir}
				currentThumbDir=${currentMediaDir//MIDIA/THUMB}
				#echo ${currentMediaDir}
				#echo ${currentThumbDir}
				# echo "${dateDir}" "is less or equal" "${daysBeforeIso}"
				echo "$(nowDateTime)" "- Copying dir" "${currentMediaDir}" "to remote server..." # >> "/var/log/remove_files.log"
				rsync -e "ssh -p 2134" -Rr --upgrade "${currentMediaDir}" root@serverclip.ddns.net:/
				echo "$(nowDateTime)" "- Copying dir" ${currentThumbDir} "to remote server..." # >> "/var/log/remove_files.log"
				rsync -e "ssh -p 2134" -Rr --upgrade "${currentThumbDir}" root@serverclip.ddns.net:/

				# rm -rf ${midiaDir}/${monthDir}/${dateDir}

				# echo "$(nowDateTime)" "- Removing" ${thumbDir}/${monthDir}/${dateDir} # >> "/var/log/remove_files.log"
				# rm -rf ${thumbDir}/${monthDir}/${dateDir}
			fi
		done
	done
done

echo echo "$(nowDateTime)" "- Script End" # >> "/var/log/remove_files.log"
# echo >> "/var/log/remove_files.log"
