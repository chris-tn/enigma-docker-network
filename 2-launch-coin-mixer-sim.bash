#!/usr/bin/env bash

ARGF=""
SRFD=""

echo "Starting coin-mixer app..."
docker-compose $ARGF exec contract bash -c \"cd enigma-contract && node integration/coin-mixer.js --url=http://enigma_contract_1:8545\"
