#!/bin/bash
#Usage: $0 tgt

if (( $# != 1 )); then
    echo Usage: $0 tgt
    exit 1
fi
cd $(dirname $0)
tgt="$1"
gnuplot -e "set terminal svg;
set output 'ping-${tgt}.svg';
set xdata time;
set timefmt '%m/%d/%y %H:%M:%S';
set xtics out rotate by -90 format '%d %H:%M';
set logscale y;
plot 'ping-${tgt}-dat.csv' using 1:4"
