#!/bin/bash

# TODO:
#
#

regex="50005|50012|12175|ERROR|WARN|CRITICAL"
d_flag=''
f_flag=''

#check if the directory supplied is directory or not
#then get a list of files in that directory and call
#the function getInfoFromFile function on each file
function getFilesFromDirectory() {
        if [ -d "$1" ]; then
#               echo "this is a directory"
                local files=( $(ls $1) )
                for i in "${files[@]}"
                do
#                       echo "The file is: $1$i"
                        echo "==================================================================================================================================================================="
                        #this is to get the absolute file path
                        getInfoFromFile "$1$i"
                done
        else
                echo "this is not a directory"
        fi
}

#check the file if it contains special keywords and then echo
#out the line number and the actual line
function getInfoFromFile() {
        echo -e "now searching file: \033[0;34m $1 \033[0m"
        echo -e "\n"
        local i=0
        while IFS= read -r line
        do
                ((i++))
                if [[ $line =~ $regex  ]]; then
                        echo "Found keyword on line number: $i"
                        echo -e "\t$line"
                fi
        done < $1
        echo -e ""
}

while getopts d:f:k: flag
do
        case "${flag}" in
                d)
                        dir=${OPTARG}
                        d_flag='true'
                ;;
                f)
                        file=${OPTARG}
                        f_flag='true'
                ;;
                k)
                        regex=${OPTARG}
                ;;
        esac
done

if [ $d_flag ]; then
#       echo "used dir: $dir";
        getFilesFromDirectory "$dir"
elif [ $f_flag ]; then
#       echo "used file: $file";
        getInfoFromFile "$file"
else
        echo "Please supply at least one flag of d or f for directory or full file path, respectively"
fi
