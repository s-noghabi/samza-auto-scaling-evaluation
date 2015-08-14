#!/bin/bash
# to run dir to generate file, max size in ont file, total size
maxSize=$2
dirPath=$1
totalSize=$3
count=$maxSize
kvfile="keyValueInput.json"

for i in `seq 1 $totalSize`; do

if [ $count = $maxSize ]; then


kvFile="$dirPath/keyValueInput-$i.json"
rm -rf $kvFile

touch $kvFile

count=0
fi


    
    echo "{\"k\":$i}" >> $kvFile
    count=$[ count + 1]
done

