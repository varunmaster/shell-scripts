#!/bin/bash
#this script will find all the log files in dir /Scripts/ that are more than 100MB and then compress them

pathToSearch="/Scripts/Sandbox"
largeFiles=( $(find $pathToSearch -type f -size +40k) ) #K,M,G for other file size - wrapping in outter prens to store in arr

#echo "${largeFiles[1]}"
#echo $pathToSearch

#for i in "${largeFiles[@]}"
#do
#       echo "The index is: $i"
#done

largeFileArrLen=${#largeFiles[@]}

for ((i=0; i<${largeFileArrLen}; i++));
do
#       echo "Index is:" $i "and the file is: ${largeFiles[$i]}"
        currDateTime=$(date +'%m/%d/%Y %H:%M:%S.%3N')
        #echo $currDateTime
        #rename the file by appending variable currDateTime
        #compress the file
        #move to archive
done
