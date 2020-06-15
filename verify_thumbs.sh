#!/bin/bash

checkr=$(pidof -x generate_thumbs.sh)
# echo ${checkr}
if [[ -z ${checkr} ]] ; then
	/applications/record/scripts/generate_thumbs.sh
else
	echo "Already running!"
fi