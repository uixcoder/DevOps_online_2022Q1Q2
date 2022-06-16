#!/bin/bash

function ipPrefixByNetmask () {
   c=0 x=0$( printf '%o' ${1//./ } )
   while [ $x -gt 0 ]; do
       let c+=$((x%2)) 'x>>=1'
   done
   echo /$c ; }

function ipConfigToNetaddr () {
   line=`ifconfig -a $net_i | grep netmask | tr -s " "`
   ip=`echo $line | cut -f 2 -d " "`
   mask=`echo $line | cut -f 4 -d " "`

   IFS=. read -r io1 io2 io3 io4 <<< $ip
   IFS=. read -r mo1 mo2 mo3 mo4 <<< $mask
   NET_ADDR="$((io1 & mo1)).$(($io2 & mo2)).$((io3 & mo3)).$((io4 & mo4))"

   echo $NET_ADDR`ipPrefixByNetmask $mask` ; 
}

function printAllActiveNetworks () {
   netInterfaces="/sys/class/net"
   for net_f in "$netInterfaces"/*
   do
    net_i=$(basename $net_f)
    found=`ifconfig -a $net_i 2> /dev/null | grep "UP"`
    if [ $? -eq 0 ]; then
         ipConfigToNetaddr $net_i
    fi
   done
   echo ""
}

function showManual {
    echo 'Possible arguments:';
    echo -e "\n   \033[1m--all <subnet>\033[0m \n\t displays the IP addresses and symbolic names of all hosts in the current <subnet> in CIDR notation"
    echo -e "\n   \033[1m--target <targetIP>\033[0m \n\t displays a list of open system TCP ports on <targetIP>"
    echo -e "\n   \033[1m--net\033[0m \n\t displays a list of active networks\n"
}

function printMessage() {
    echo -e "\n\033[1m$1\033[0m\n"
}

function noArgumentsProvided {
    printMessage "No arguments provided . . ."
    showManual
}

function errorArguments {
    printMessage "Error arguments provided . . ."
    showManual
}

function getHostsInSubnet () {
    printMessage "IP addresses and symbolic names of all hosts in the selected subnet $1"
    nmap -sn $1 | egrep "scan report" | awk '{gsub(/\(|\)/,"");printf("%s\t%s\n",($5 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/)?$5:$6, ($5 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/)?$6:$5) }'
}

function getOpenPortsOnTarget () {
    printMessage "List of open system TCP ports on $1"
    nmap -sT -p- $1 | grep --color=never -e "PORT" -e "tcp" 
}

if [ $# -eq 0 ]; then
   noArgumentsProvided
   exit 1
fi
if [ $1 = "--all" ]; then
   if [ $# -eq 1 ]; then
     printMessage "Enter <network> in CIDR notation format as second argument\n\nAll active networks:"
     printAllActiveNetworks
     showManual
     exit 1 
   fi
   getHostsInSubnet $2
   exit 0
fi
if [ $1 = "--target" ]; then
   if [ $# -eq 1 ]; then
     printMessage "Enter <targetIP>"
     showManual
     exit 1 
   fi
   getOpenPortsOnTarget $2
   exit 0
fi
if [ $1 = "--net" ]; then
     printMessage "All active networks:"
     printAllActiveNetworks
     exit 0
fi

errorArguments
