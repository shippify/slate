usage() { echo "Usage: $0 [<restart|stop|shell>] [<argument>]" 1>&2; exit 1; }


if [ "$1" == "shell" ]; then
	echo "Loading shell of slate doc shipppify..."

	docker exec -it slate-shippify /bin/bash

elif [ "$1" == "restart" ]; then
	
	echo "Removing the slate docker process ..."

	docker rm -f slate-shippify

	echo "Starting the process again ... "
	docker run -d -p 4567:4567 -v $PWD:/app --name slate-shippify slate

elif [ "$1" == "stop" ]; then
	
	echo "Removing the slate docker process ..."
	docker rm -f slate-shippify
fi



