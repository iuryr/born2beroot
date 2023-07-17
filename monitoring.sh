#!/bin/bash
architecture=`uname -a`

phys_cpu=`grep "physical id" /proc/cpuinfo | sort | uniq | wc -l`
virtual_cpu=`lscpu | grep CPU\(s\): | awk '{print $2}'`

free_ram=`free --mega | awk 'FNR == 2 {print $3}'`
total_ram=`free --mega | awk 'FNR == 2 {print $2}'`
pct_ram_usage=`echo "scale=2;$free_ram/$total_ram" | bc`

printf "#Architecture: $architecture\n"
printf "#CPU Physical: $phys_cpu\n"
printf "#vCPU: $virtual_cpu\n"
printf "#Memory Usage: %d/%dMB (%.2f%%)" $free_ram $total_ram $pct_ram_usage
