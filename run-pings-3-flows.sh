#! /bin/bash 

language=$1
logtype=$2
scriptname=$3
portcheck=$4
numflows=$5
auto=$6

echo "run-pings-3-flows.sh $language $logtype $scriptname $portcheck $numflows $auto"
#
# Start controller
#
bash startController.sh $language $scriptname $portcheck

# Prime network for senders and receivers
for num in {1..8}
do
    ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31035 "arping -q -Ieth$num -c1 10.10.7.1"
done
for num in {1..8}
do
    for ipnum in {1..4}
    do
        ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31034 "arping -q -Ieth$num -c1 10.10.6.$ipnum"
        ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31035 "arping -q -Ieth$num -c1 10.10.5.$ipnum"
        ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31034 "arping -q -Ieth$num -c1 10.10.4.$ipnum"
    done
done
echo "Network primed"

#
# Start UDP servers (Host 5)
#
for port in 45000
do
    for num in {1..4}
    do
        ssh -f jivey@pc5.instageni.rnoc.gatech.edu -p 31036 "iperf -u -l1400 -s -p$port -B10.10.4.$num > /users/jivey/temp-$num-$port.log &"
        ssh -f jivey@pc5.instageni.rnoc.gatech.edu -p 31036 "sudo tcpdump -i any udp and src 10.10.3.$num and dst 10.10.4.$num &> /users/jivey/tcpdump-$num-$port.log &"
        sleep 1
    done
done

# Make sure all servers have started
echo "0" > .tmp/iperfs
while [ $(cat .tmp/iperfs) -lt 4 ]
do
    ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31036 "pgrep iperf | sed '/^\s*$/d' | wc -l" > .tmp/iperfs
    sleep 1
done
rm .tmp/iperfs

#
# Start UDP servers (Host 6)
#
for port in 45000
do
    for num in {1..4}
    do
        ssh -f jivey@pc2.instageni.rnoc.gatech.edu -p 31035 "iperf -u -l1400 -s -p$port -B10.10.5.$num > /users/jivey/temp-$num-$port.log &"
        ssh -f jivey@pc2.instageni.rnoc.gatech.edu -p 31035 "sudo tcpdump -i any udp and src 10.10.2.$num and dst 10.10.5.$num &> /users/jivey/tcpdump-$num-$port.log &"
        sleep 1
    done
done

# Make sure all servers have started
echo "0" > .tmp/iperfs
while [ $(cat .tmp/iperfs) -lt 4 ]
do
    ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31035 "pgrep iperf | sed '/^\s*$/d' | wc -l" > .tmp/iperfs
    sleep 1
done
rm .tmp/iperfs

#
# Start UDP servers (Host 7)
#
for port in 45000
do
    for num in {1..4}
    do
        ssh -f jivey@pc1.instageni.rnoc.gatech.edu -p 31036 "iperf -u -l1400 -s -p$port -B10.10.6.$num > /users/jivey/temp-$num-$port.log &"
        ssh -f jivey@pc1.instageni.rnoc.gatech.edu -p 31036 "sudo tcpdump -i any udp and src 10.10.1.$num and dst 10.10.6.$num &> /users/jivey/tcpdump-$num-$port.log &"
        sleep 1
    done
done

# Make sure all servers have started
echo "0" > .tmp/iperfs
while [ $(cat .tmp/iperfs) -lt 4 ]
do
    ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31036 "pgrep iperf | sed '/^\s*$/d' | wc -l" > .tmp/iperfs
    sleep 1
done
rm .tmp/iperfs

sleep 5
echo "Servers up"

#
# Start UDP clients (Hosts 2, 3 and 4)
#
date +"%s.%3N" > .tmp/temp
for port in 45000
do
    for num in {1..4}
    do
        ssh -f jivey@pc1.instageni.rnoc.gatech.edu -p 31034 "iperf -u -l1400 -c 10.10.6.$num -p$port -B10.10.1.$num -b 100K -t180 > /users/jivey/temp-$num-$port.log &"
        ssh -f jivey@pc1.instageni.rnoc.gatech.edu -p 31035 "iperf -u -l1400 -c 10.10.5.$num -p$port -B10.10.2.$num -b 100K -t180 > /users/jivey/temp-$num-$port.log &"
        ssh -f jivey@pc2.instageni.rnoc.gatech.edu -p 31034 "iperf -u -l1400 -c 10.10.4.$num -p$port -B10.10.3.$num -b 100K -t180 > /users/jivey/temp-$num-$port.log &"
        ssh -f jivey@pc1.instageni.rnoc.gatech.edu -p 31034 "sudo tcpdump -i any udp and src 10.10.1.$num and dst 10.10.6.$num > /users/jivey/tcpdump-$num-$port.log &"
        ssh -f jivey@pc1.instageni.rnoc.gatech.edu -p 31035 "sudo tcpdump -i any udp and src 10.10.2.$num and dst 10.10.5.$num > /users/jivey/tcpdump-$num-$port.log &"
        ssh -f jivey@pc2.instageni.rnoc.gatech.edu -p 31034 "sudo tcpdump -i any udp and src 10.10.3.$num and dst 10.10.4.$num > /users/jivey/tcpdump-$num-$port.log &"
    done
done
echo "Clients transmitting"

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
    for port in 45000
    do
        for num in {1..4}
        do
            ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31036 "cat /users/jivey/temp-$num-$port.log" >> logs/iperfs/iperfs-$language-$logtype-$numflows-$num-$port-0.log
            ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31035 "cat /users/jivey/temp-$num-$port.log" >> logs/iperfs/iperfs-$language-$logtype-$numflows-$num-$port-1.log
            ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31036 "cat /users/jivey/temp-$num-$port.log" >> logs/iperfs/iperfs-$language-$logtype-$numflows-$num-$port-2.log

            ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31036 "sudo cat /users/jivey/tcpdump-$num-$port.log" >> logs/tcpdumps/tcpdumps-$language-$logtype-$numflows-$num-$port-0.log
            ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31035 "sudo cat /users/jivey/tcpdump-$num-$port.log" >> logs/tcpdumps/tcpdumps-$language-$logtype-$numflows-$num-$port-1.log
            ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31036 "sudo cat /users/jivey/tcpdump-$num-$port.log" >> logs/tcpdumps/tcpdumps-$language-$logtype-$numflows-$num-$port-2.log
        done

        for num in {1..4}
        do
            ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31034 "cat /users/jivey/temp-$num-$port.log" >> logs/iperfc/iperfc-$language-$logtype-$numflows-$num-$port-0.log
            ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31035 "cat /users/jivey/temp-$num-$port.log" >> logs/iperfc/iperfc-$language-$logtype-$numflows-$num-$port-1.log
            ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31034 "cat /users/jivey/temp-$num-$port.log" >> logs/iperfc/iperfc-$language-$logtype-$numflows-$num-$port-2.log

            ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31034 "sudo cat /users/jivey/tcpdump-$num-$port.log" >> logs/tcpdumpc/tcpdumpc-$language-$logtype-$numflows-$num-$port-0.log
            ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31035 "sudo cat /users/jivey/tcpdump-$num-$port.log" >> logs/tcpdumpc/tcpdumpc-$language-$logtype-$numflows-$num-$port-1.log
            ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31034 "sudo cat /users/jivey/tcpdump-$num-$port.log" >> logs/tcpdumpc/tcpdumpc-$language-$logtype-$numflows-$num-$port-2.log
        done
    done
    cat .tmp/temp >> logs/pings/pings-$language-$logtype-$numflows.log
else
    echo "Discard"
fi
rm .tmp/temp
