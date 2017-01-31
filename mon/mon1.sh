#!/bin/bash
#Usage: cd anything; $0 tgt

if (( $# != 1 )); then
    echo Usage: $0 tgt
    exit 1
fi
cd $(dirname $0)
tgt="$1"
#tgt=24.105.29.75
RANDOM=$$
touch ping-${tgt}-dat.csv
touch ping-${tgt}-log.txt
touch  mtr-${tgt}-log.txt
while true; do
    echo >> ping-${tgt}-log.txt
    date >> ping-${tgt}-log.txt
    foo=$(ping -n -c 3 $tgt | tee -a ping-${tgt}-log.txt | grep rtt) || foo="a b c 5000/5000/5000/0"
    echo "$(date +'%D %T') $(echo $foo | awk '{ print $4 }' | tr / ' ')" >> ping-${tgt}-dat.csv
    if [ "$tgt" != "localhost" ]; then
	echo >> mtr-${tgt}-log.txt
	mtr -w -b -r -c 25 ${tgt} >> mtr-${tgt}-log.txt
    fi
    let rs=45+${RANDOM}%50
    sleep $rs
done
