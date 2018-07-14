#!/bin/bash

if [[ "$DEVELOP" -eq 1 ]]; then
    echo "Launching Docker Enigma Network in development mode..."
    ARGF="-f docker-compose.develop.yml"
    SRFD="~/wrapper-develop.bash &&"
else
    ARGF=""
    SRFD=""
fi

if [ "$1" != "" ]; then
    NUM_WORKERS=$1
    docker-compose $ARGF up --scale surface=$NUM_WORKERS surface &
    sleep 1
    docker-compose $ARGF up --scale core=$NUM_WORKERS core &
    sleep 1

    if [ $NUM_WORKERS -gt 1 ]; then
    	for i in $(seq 2 $NUM_WORKERS); do
            docker-compose exec --index=$i surface bash -c "$SRFD ./wait_launch.bash; bash" &

    	done
    fi

else
	echo "Specify the number of workers with:"
    echo "./spawn_workers N"
    echo "where is N is a number greater than 1"
fi
