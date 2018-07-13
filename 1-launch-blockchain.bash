#!/usr/bin/env bash

ARGF=""
SRFD=""

echo "Launching the contract service"
docker-compose up contract &

CONTRACT_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' enigma_contract_1)
while :
do
	nc -z $CONTRACT_IP 8545
	result=$?
	if [[ $result -eq 0 ]]; then
        break
    fi
    sleep 5
done

echo "Deploying contracts on testnet..."
docker-compose exec contract bash -c "rm -rf ~/enigma-contract/build/contracts/*"
docker-compose exec contract bash -c "cd enigma-contract && ~/darq-truffle migrate --reset --network ganache"
docker-compose exec contract bash -c "~/darq-truffle test"
