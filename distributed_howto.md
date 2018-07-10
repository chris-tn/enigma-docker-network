Background

Many developers can't enable SGX on their workstation. While a hosted SGX environment is available, actively developing on it can be a handicap. This workflow makes some compromises by hosting Core and Ganache remotely, allowing developers to run and debug Dapp code locally without the SGX drivers. 

Definitions

- R: The remote server with the SGX drivers
- L: The local workstation

Prerequisites

- R: Install the SGX driver and SDK
- R: Clone the Docker Network: `git clone https://github.com/enigmampc/enigma-docker-network` => distributed_dev branch
- R: Whitelist a range of ports reserved for your development. You'll need one port for Ganache an one port per instance of Core. I recommend reserving a range of 10 ports.  
- L: Clone the Engima Contract: `git clone https://github.com/enigmampc/enigma-contract` => truffle-next branch
- L: Clone Surface : `git clone https://github.com/enigmampc/surface` => develop branch

Steps:

1. R: Edit the `docker-compose.yml` file to open ports for Ganache and Core. For core, use a range of ports for the different instances: https://github.com/docker/compose/pull/4649
2. R: Boot the Contract container: `docker-compose up contract`
3. R: Boot the Core container: `docker-compose up --scale core=n core`, where is n is the desired number of Core instances
4. R: Run `docker container ls` and node the public port mapped to each service
6. L: Configure `truffle.js` to set the `ganache_remote` host and port
6. L: Deploy the Enigma contracts from source: `./deploy-ganache.sh ganache_remote`
7. L: Set the remote Ganache URL and port `set GANACHE_URL=host:port`
8. L: Run the Coin Mixer script: `node coin-mixer.js`
9. L: In Surface, edit `src/surface/config.json` to specify the Core host and ports  
10. L: Run `__main.py --dev-account=n`, where n is the account index mapped to the worker (avoid account 9 as it is reserved for the principal node). This will connect to Core, get an Intel report and register the worker
11. L: Check the logs of the `coin-mixer.js` script, you should see a new Register event followed by a new Task dispatched to the worker

