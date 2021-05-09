#!/bin/bash

# TODO:
# Get it to work with directory, single file works as expected
#

regex="50005|50012|12175|ERROR|WARN|CRITICAL"
d_flag=''
f_flag=''

#for i in "${keyWords[@]}";
#do
#       echo $i
#done

function getInfoFromFile() {
        echo "searching file < $1 > for keywords"
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
}

while getopts d:f: flag
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
        esac
done

if [ $d_flag ]; then
        echo "used dir: $dir";
elif [ $f_flag ]; then
#       echo "used file: $file";
        getInfoFromFile "$file"
else
        echo "Please supply at least one flag of d or f for directory or full file path, respectively"
fi
