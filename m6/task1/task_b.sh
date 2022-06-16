#!/bin/bash

tmpFile="file"

function showManual {
    echo 'Possible arguments:';
    echo -e "\n\033[1m$0 <apache log file> \033[0m \n\t analyses <apache log file> \n"
}

function printMessage() {
    echo -e "\n\033[1m$1\033[0m\n"
}

function noArgumentsProvided {
    printMessage "Error arguments provided . . ."
    showManual
}

function getIpsMostRequests () {
  cat $1 | awk '{printf("%s\n"),$1}' | sort | uniq -c | sort -n -r  > $tmpFile
  max=`cat $tmpFile | head -n 1| awk '{ printf("%s",$1)}'`
  grep "$max " $tmpFile | awk '{ printf("%s\n",$2)}'
  echo -e "\033[2mRequests:\033[0m \033[1m$max\033[0m"
  rm $tmpFile
}

function getPageMostRequests () {
  cat $1 | awk '{printf("%s\n"),$7}' | sort | uniq -c | sort -r > $tmpFile
  max=`cat $tmpFile | head -n 1| awk '{ printf("%s",$1)}'`
  grep "$max " $tmpFile | awk '{ printf("%s\n",$2)}'
  echo -e "\033[2mRequests:\033[0m \033[1m$max\033[0m"  
  rm $tmpFile
}

function getRequestsCountFromEachIp () {
  printf "%s              %s\n" "IP" "Count"  
  cat $1 | awk '{printf("%s\n"),$1}' | sort | uniq -c | sort -n -r | awk '{ printf("%s\t%s\n",$2,$1)}'
}

function getNonExistPages () {
  cat $1 | awk '{printf("%s %s \n"),$7,$9}' | sort | uniq -c | sort -n -r | grep " 404 "| awk '{ printf("%s\t%s\n",$1,$2)}'
}

function getTimeRequests () { 
  cat $1 | awk '{printf("%s\n"),($4 ~ /^\[.*/)?substr($4,2):$4}' | awk -F'[:]' '{printf("%s:%s\n"),$1,$2}'| sort | uniq -c | sort -r -n | awk '{printf("%s\n"),$2}' | awk -F'[:]' '{printf("%s at %s:00 - %s:00\n"),$1,$2,($2==12)?"01":$2+1}' | head -n 1 
}

function getBotsList () {
  grep -i "bot" $1 | awk  -F'["]' '{printf("%s %s\n",$1,$6)}'| sed -e 's/\[[^][]*\]//g' | sed -e 's/ - - / /g'| sort | uniq -c | sort -n -r 
}

if [ $# -eq 0 ]
then
   noArgumentsProvided
   exit 1
fi

if [ $# -ge 2 ]
then
   noArgumentsProvided 
   exit 1
fi

if [ -r $1 ]
then 
  printMessage "From such ips were the most requests:"
  getIpsMostRequests $1
  printMessage "The most requested pages:"
  getPageMostRequests $1
  printMessage "Requests count from each ip:"
  getRequestsCountFromEachIp $1
  printMessage "Non-existent pages:"
  getNonExistPages $1
  printMessage "Time period site get the most requests:"
  getTimeRequests $1
  printMessage "Bots that have accessed the site:"
  getBotsList $1

else
  printMessage "Can't find log file!"
  showManual
fi

#grep -E '[0-9]{0,3}\.[0-9]{0,3}\.[0-9]{0,3}\.[0-9]{0,3}' apache_logs.txt | awk '{printf("%s\n"),$1}' | uniq -c | sort -n -r -k1,1 | awk 'NR==1{print $2}'