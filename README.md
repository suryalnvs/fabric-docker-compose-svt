# fabric-docker-compose-svt
## Cloning the repository:
Clone the repository under fabric/examples using git clone https://github.com/suryalnvs/fabric-docker-compose-svt

## Usage:
```
	./network_setup.sh -n [channel-name] -s -c -t [cli timer] -f [compose yaml] <up|down|retstart>"
	./network_setup.sh -n "mychannel" -c -s -t 10  restart"
	    -n       channel name
			-c       enable couchdb
			-f       Docker compose file for the network
			-s       Enable TLS
			-t       CLI container timeout
			up       Launch the network and start the test
  		down     teardown the network and the test
	  	restart  Restart the network and start the test
```

The repository contains multiple docker-compose files
1) docker-compose-e2e.yaml is used to launch the network with two orderers, three kafka brokers, three zookeepers, two organizations with two peers in each, one ca per each organization.
2) docker-compose-cli.yaml is used to launch a cli container that runs end-to-end script and the same network as docker-compose-e2e.yaml 
