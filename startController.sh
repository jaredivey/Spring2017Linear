#! /bin/bash

language=$1
scriptname=$2
portcheck=$3

if [ "$language" == "python" ]
then
    echo "Starting Ryu"
    ssh -f jivey@pc5.instageni.rnoc.gatech.edu -p31034 "cd /local/geni-install-files/ryu ; PYTHONPATH=. ./bin/ryu-manager ryu/app/$scriptname.py &> /users/jivey/temp"
    sleep 5

    # Make sure all 8 switches have contacted the controller
    if [ "$portcheck" == "y" ]
    then
        echo "0" > .tmp/portdescs
        while [ $(cat .tmp/portdescs) -lt 8 ]
        do
            ssh jivey@pc5.instageni.rnoc.gatech.edu -p31034 "tr ' ' '\n' < /users/jivey/temp | grep PORTDESC | wc -l" > .tmp/portdescs
            sleep 1
        done
        rm .tmp/portdescs
    fi
    echo "Ryu ready!"
else
    if [ "$scriptname" == "nix" ]
    then
        echo "Starting Floodlight Nix"
        ssh -f jivey@pc5.instageni.rnoc.gatech.edu -p31034 "cd /local/geni-install-files/floodlight-nix ; java -jar target/floodlight.jar &> /users/jivey/temp"
    else
        echo "Starting Floodlight"
        ssh -f jivey@pc5.instageni.rnoc.gatech.edu -p31034 "cd /local/geni-install-files/floodlight ; java -jar target/floodlight.jar &> /users/jivey/temp"
    fi
    sleep 5

    echo "0" > .tmp/DebugServer
    while [ $(cat .tmp/DebugServer) -lt 1 ]
    do
        ssh jivey@pc5.instageni.rnoc.gatech.edu -p31034 "tr ' ' '\n' < /users/jivey/temp | grep JythonServer | wc -l" > .tmp/DebugServer
        sleep 1
    done
    rm .tmp/DebugServer
    echo "Floodlight ready!"
fi
