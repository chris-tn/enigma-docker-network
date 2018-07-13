#!/bin/bash

echo "Starting coin-mixer app..."
docker-compose exec contract bash -c \"cd enigma-contract && node integration/coin-mixer.js --url http://enigma_contract_1:8545; bash\" &
# echo "Starting Surface..."
# docker-compose exec surface bash -c \"./wait_launch.bash\" &
