#!/bin/bash
architecture=`uname -a`

phys_cpu=`grep "physical id" /proc/cpuinfo | sort | uniq | wc -l`
virtual_cpu=`lscpu | grep CPU\(s\): | awk '{print $2}'`

free_ram=`free --mega | awk 'FNR == 2 {print $3}'`
total_ram=`free --mega | awk 'FNR == 2 {print $2}'`
pct_ram_usage=`echo "scale=2;$free_ram/$total_ram" | bc`

used_disk_MB=`df /dev/sdb --block-size=1MB --output=used | awk 'FNR==2 {print $1}'`
total_disk_GB=`df /dev/sdb --block-size=1GB --output=size | awk 'FNR==2 {print $1}'`
used_disk_pct=`df /dev/sdb --output=pcent | awk 'FNR==2 {print $1}'`

printf "#Architecture: $architecture\n"
printf "#CPU Physical: $phys_cpu\n"
printf "#vCPU: $virtual_cpu\n"
printf "#Memory Usage: %d/%dMB (%.2f%%)\n" $free_ram $total_ram $pct_ram_usage
printf "#Disk Usage: %d/%dGb (%s)\n" $used_disk_MB $total_disk_GB $used_disk_pct
