#!/bin/bash
function rmAllContainers() {
    docker stop $(docker ps -a -q)
    docker rm -f $(docker ps -a -q)
}

function rmImages() {
    if [ "$#" -lt 1 ]
    then
	    echo 'No docker image name key word specified, please provide one';
	    exit
    fi
    keyword=$1;
    echo "The key word specified is $keyword, will delete docker images whose name contain the key word provided"
    docker rmi -f $(docker images|grep $keyword|awk '{print $3}')
}

echo "deleting all docker containers..."
rmAllContainers
# remove all docker images that built for chaincodes
echo "removing all docker images whose name contains dev"
rmImages dev
GOPATH=$GOPATH
: ${GOPATH:="/opt/gopath"}
echo '$GOPATH is set to:' $GOPATH
cd $GOPATH/src/github.com/hyperledger/fabric/examples/fabric-docker-compose-svt

echo "begin to remove all existing crypto-config"
rm -rf ./crypto-config/*
# start the network
cd $GOPATH/src/github.com/hyperledger/fabric/examples/fabric-docker-compose-svt/
./network_setup.sh -s -n mychannel -f docker-compose-e2e.yaml up
rm -rf ~/.hfc*
# remove hfc directory in tmp
#if test -d "$TMPDIR"; then
#   :
#elif test -d "$TMP"; then
#    TMPDIR=$TMP
#elif test -d /var/tmp; then
#    TMPDIR=/var/tmp
#else
TMPDIR=/tmp
#fi
echo "temp directory for the OS is:" $TMPDIR
echo "deleting hfc directory: "$TMPDIR/"hfc"
rm -rf $TMPDIR/hfc
cd $GOPATH/src/github.com/hyperledger/fabric-sdk-node/test/fixtures/channel
rm -rf *
echo "begin to copy the crypto stuffs"
cp $GOPATH/src/github.com/hyperledger/fabric/examples/fabric-docker-compose-svt/channel-artifacts/* .
cp -r $GOPATH/src/github.com/hyperledger/fabric/examples/fabric-docker-compose-svt/crypto-config .
echo "all things set"
