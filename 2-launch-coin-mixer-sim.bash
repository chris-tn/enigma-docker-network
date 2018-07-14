#!/usr/bin/env bash

if [[ "$DEVELOP" -eq 1 ]]; then
    echo "Launching the coin-mixer script in development mode..."
    ARGF="-f docker-compose.develop.yml"
    SRFD="~/wrapper-develop.bash &&"
else
    ARGF=""
    SRFD=""
fi

echo "Starting coin-mixer app..."
docker-compose $ARGF exec contract bash -c "cd enigma-contract && node integration/coin-mixer.js --url=http://enigma_contract_1:8545"
