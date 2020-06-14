#!/bin/bash

botapi="${APIKEY}"
chatid="${CHATID}"

recscript=$(pidof -x "recmp4.sh")

if [[ -z ${recscript} ]] ; then
	echo "Script not running!"
	echo "Starting..."
	curl -s -o /dev/null -X POST 'http://192.168.0.13:5000/send' -H 'content-type: application/json' -d '{"idGrupo": 8, "msgAssunto": "Script de gravação", "msgTitulo": "ktm", "msgLink": "O script de gravação recmp4.sh não estava iniciado."}'
	/tv/scripts/stoprec.sh
	/tv/scripts/setcards.sh
	/tv/scripts/reccards.sh
else
	echo "Script running!"
fi