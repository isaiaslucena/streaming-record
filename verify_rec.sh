#!/bin/bash

#botapi="${APIKEY}"
#chatid="${CHATID}"

recscript=$(pidof -x "recmp4.sh")
audioscript=$(pidof -x "rec_mp3.sh")

if [[ -z ${recscript} ]] ; then
	echo "Script TV not running!"
	echo "Starting..."
#	curl -s -o /dev/null -X POST 'http://192.168.0.13:5000/send' -H 'content-type: application/json' -d '{"idGrupo": 8, "msgAssunto": "Script de gravação", "msgTitulo": "ktm", "msgLink": "O script de gravação recmp4.sh não estava iniciado."}'
	/applications/record/scripts/stoprec.sh
	# /applications/record/scripts/setcards.sh
	/applications/record/scripts/reccards.sh
else
	echo "Script running!"
fi


if [[ -z ${audioscript} ]] ; then
	echo "Script Radio not running!"
	echo "Starting..."
#	curl -s -o /dev/null -X POST 'http://192.168.0.13:5000/send' -H 'content-type: application/json' -d '{"idGrupo": 8, "msgAssunto": "Script de gravação", "msgTitulo": "ktm", "msgLink": "O script de gravação recmp4.sh não estava iniciado."}'
	/applications/record/scripts/radio/rec_radios.sh
else
	echo "Script running!"
fi
