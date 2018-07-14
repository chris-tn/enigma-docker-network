#!/bin/bash

if [[ "$DEVELOP" -eq 1 ]]; then
    echo "Spawning workers in development mode..."
    ARGF="-f docker-compose.develop.yml"
    SRFD="~/wrapper-develop.bash &&"
else
    ARGF=""
    SRFD=""
fi

docker-compose $ARGF up core surface &

sleep 5
docker-compose exec surface bash -c "$SRFD ./wait_launch.bash" &


