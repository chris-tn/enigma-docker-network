#!/usr/bin/env bash

ARGF=""
SRFD=""

docker-compose up contract

echo "Deploying contracts on testnet..."
docker-compose exec contract bash -c "rm -rf ~/enigma-contract/build/contracts/*"
docker-compose exec contract bash -c "cd enigma-contract && ~/darq-truffle migrate --reset --network ganache"
docker-compose exec contract bash -c "~/darq-truffle test"
