#! /bin/bash 

language=$1
logtype=$2
scriptname=$3
portcheck=$4
numflows=$5
auto=$6

echo "run-pings-no-flows.sh $language $logtype $scriptname $portcheck $numflows $auto"

#
# Start controller
#
bash startController.sh $language $scriptname $portcheck

# Prime network for senders and receivers
for num in {1..8}
do
    ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31035 "arping -q -Ieth$num -c1 10.10.7.1"
done
echo "Network primed"

date +"%s.%3N" >> .tmp/temp

#
# Wait 20 seconds (arbitrary) to allow traffic to occur before sending the pings
#
for num in {20..0}
do
    echo $num
    sleep 1
done
echo "Ping host 8"
date +"%s.%3N" >> .tmp/temp
ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31035 "ping -q -s1442 -c1 10.10.7.1" >> .tmp/temp
ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31035 "ping -q -s1442 -c1 10.10.7.1" >> .tmp/temp
ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31035 "ping -q -s1442 -c1 10.10.7.1" >> .tmp/temp
cat .tmp/temp

#
# Final cleanup
#
echo "Final cleanup"
bash cleanup.sh $language

#
# Pull log information over to local
#
echo "Capture log files? "
if [ "$auto" == "auto" ]
then
    store="y"
else
    read store
fi

if [ $store == "y" ]
then
    echo "Store"
    ssh jivey@pc5.instageni.rnoc.gatech.edu -p31034 "cat /users/jivey/temp" >> logs/ctrl/$language-$logtype-$numflows.log
    cat .tmp/temp >> logs/pings/pings-$language-$logtype-$numflows.log
else
    echo "Discard"
fi
rm .tmp/temp
