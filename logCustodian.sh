#!/bin/bash
#this script will find all the log files in dir /Scripts/ that are more than 25MB and then compress them
#0 --> where console/program reads from
#1 --> where console/program sends output
#2 --> where console/program sends error
# when we say 2>$1 we are saying we want the error output to be redirected to 1 and the dollar sign forces it (i think)

pathToSearch="/Scripts/"
largeFiles=( $(find $pathToSearch -type f -size +40k) ) #K,M,G for other file size - wrapping in outter parens to store as arr

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
        currDateTime=$(date +'%m.%d.%Y-%H.%M.%S.%3N')
#       echo -e "$currDateTime\n"
#       echo -e "current file being worked on ${largeFiles[$i]}\n"

        #rename the file by appending variable currDateTime
        baseFileName=$(basename "${largeFiles[$i]}" .log) #using basename with .log switch to get filename without extension
#       echo -e "new baseFileName: $baseFileName\n"
        newFileName="$baseFileName-$currDateTime.log"
#       echo -e "new file name: $newFileName\n"
        mv "${largeFiles[$i]}" "$newFileName"
        echo -e "renamed the file\n"

        #compress the file
        compressFile=$(tar cfz $newFileName.tgz $newFileName)
#       echo -e "compressed the file: $newFileName"

        #move to archive
        mv "./$newFileName.tgz" "./Archive/$newFileName.tgz"
#       echo -e "moved the compressed file to ./Archive"
        rm "$newFileName"
done
