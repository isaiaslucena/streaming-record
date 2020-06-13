#!/bin/bash

checkr=$(pidof -x generate_thumbs.sh)
# echo ${checkr}
if [[ -z ${checkr} ]] ; then
	/tv/scripts/generate_thumbs.sh
else
	echo "Already running!"
fi