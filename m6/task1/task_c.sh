#!/bin/bash

log_file='./sync.log'

function showManual {
    echo 'Possible arguments:';
    echo -e "\n\033[1m$0 <source folder> <destinationfolder>\033[0m \n\t sync <source folder> with <destinationfolder> and writes log into file $log_file \n"
}

function printMessage() {
    echo -e "\n\033[1m$1\033[0m\n"
}

function noArgumentsProvided {
    printMessage "Error arguments provided . . ."
    showManual
}


if [ $# -le 1 ]
then
   noArgumentsProvided
   exit 1
fi

if [ $# -ge 3 ]
then
   noArgumentsProvided
   exit 1
fi
if [ -d $1 ] 
 then
  if [ -d $2 ]
   then
    src=$1
    dst=$2
    length=${#src}
    last_char=${src:length-1:1}
    [[ $last_char != "/" ]] && src="$src/"; :
    length=${#dst}
    last_char=${dst:length-1:1}
    [[ $last_char != "/" ]] && dst="$dst/"; :    
   
    rsync -cavu --delete -i $src $dst > res.txt

    log=""
    msg=`cat res.txt | grep '^*deleting' | awk '{ printf("%s\n",($2 ~ /.\/$/)?"\033[1m\033[2m  ./"$2"\033[0m":"   ./"$2)}'`
    if [ ${#msg} -gt 0 ]; then
     log="$log\n\033[1m\033[2mDeleted files/directories:\033[0m\n"
     log="$log$msg" 
    fi
    msg=`cat res.txt | grep '^cd' | awk '{ printf("  ./%s\n",$2)}'`

    if [ ${#msg} -gt 0 ]; then
     log="$log\n\033[1m\033[2mCreated new directories:\033[0m\n"
     log="$log$msg" 
    fi    
    msg=`cat res.txt | grep '^>' | awk '{ printf("  ./%s\n",$2) }'`

    if [ ${#msg} -gt 0 ]; then
     log="$log\n\033[1m\033[2mNew/updated copied files to destination:\033[0m\n"
     log="$log$msg" 
    fi   
    if [ ${#log} -gt 0 ] 
    then
     log="\n\033[1m\033[3mDirectory updated on $(date +"%d.%m.%Y %T") \033[0m$log"
     echo -e "$log" >> $log_file
    fi
    
    rm res.txt
   else
    printMessage "Destination folder error!"
    showManual
  fi
 else
  printMessage "Source folder error!"
  showManual
fi

