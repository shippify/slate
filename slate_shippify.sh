#!/bin/bash

usage() { echo "Usage: $0 [<restart|stop|shell>] [<argument>]" 1>&2; exit 1; }


if [ "$1" == "shell" ]; then
	echo "Loading shell of slate doc shipppify..."

	docker exec -it slate-shippify /bin/bash

elif [ "$1" == "start" ]; then
	
	echo "Removing the slate docker process ..."

	docker rm -f slate-shippify
	
	docker run -p 4567:4567 -v $PWD:/app --name slate-shippify  -d slate-shippify-image
	
	echo "Starting the process again ... check "

elif [ "$1" == "build" ]; then
	
	echo "Building ..."

	docker rm -f slate-shippify
	
	docker build --rm -t slate-shippify-image .

elif [ "$1" == "stop" ]; then
	
	echo "Removing the slate docker process ..."
	docker rm -f slate-shippify
fi



