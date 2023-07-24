#!/bin/bash
architecture=`uname -a`

phys_cpu=`grep "physical id" /proc/cpuinfo | sort | uniq | wc -l`
virtual_cpu=`lscpu | grep  ^CPU\(s\): | awk '{print $2}'`

free_ram=`free --mega | awk 'FNR == 2 {print $3}'`
total_ram=`free --mega | awk 'FNR == 2 {print $2}'`
pct_ram_usage=`echo "scale=2; $free_ram / $total_ram" | bc`

used_disk=`df -BMB --output=source,used | grep ^/dev/ | awk '{used+=$2} END {print used}'`
total_disk=`df -BMB --output=source,size | grep ^/dev/ | awk '{size+=$2} END {print size}'`
pct_disk_usage=`df -BMB --output=source,used,size | grep ^/dev/ | awk '{used+=$2 size+=$3} END {print used / size}' `

idle_cput=`mpstat 1 1 | awk 'FNR==4 {print $13}'`
used_cpu=`echo "scale=2; 100- $idle_cpu" | bc`

last_boot=`uptime --since`

logical_volumes=$(lsblk | grep lvm | wc -l)
lv_use=$(if [ $logical_volumes -eq 0 ]; then echo no; else echo yes; fi)

tcp_connections=`netstat --tcp | grep ESTABLISHED | wc -l`

nbr_users=`users | wc -w`

ip=`hostname -I`
mac=`ip link | awk '$1 == "link/ether" {print $2}'`

nbr_sudo=`grep COMMAND= /var/log/sudo/sudo.log | wc -l`

printf "#Architecture: $architecture\n"
printf "#CPU Physical: $phys_cpu\n"
printf "#vCPU: $virtual_cpu\n"
printf "#Memory Usage: %d/%dMB (%.2f%%)\n" $free_ram $total_ram $pct_ram_usage
printf "#Disk Usage: %d/%dGb (%s)\n" $used_disk $total_disk $pct_disk_usage
printf "#CPU load: %.2f%%\n" $used_cpu
printf "#Last boot: $last_boot\n"
printf "LVM use: $lv_use\n"
printf "#Connections TCP: $tcp_connections ESTABLISHED\n"
printf "#User log: $nbr_users\n"
printf "#Network: IP %ip ($mac)\n"
printf "#Sudo: $nbr_sudo\n"

