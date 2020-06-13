#!/bin/bash

bmwverify=$(mount | grep "/sshfs/bmw")

if [[ -z ${bmwverify} ]] ; then
	echo "bmw not mounted"

	echo "stop record"
	/tv/scripts/stoprec.sh

	echo "mounting bmw"
	mv /sshfs/bmw /sshfs/bmw_err
	mkdir /sshfs/bmw
	mount -a

	echo "start record"
	/tv/scripts/setcards.sh
	/tv/scripts/reccards.sh

else
	echo "bmw mounted"
fi


# mv /sshfs/bmw /sshfs/bmw_local
# mkdir /sshfs/bmw
# mount -a
# /tv/scripts/setcards.sh
# /tv/scripts/reccards.sh