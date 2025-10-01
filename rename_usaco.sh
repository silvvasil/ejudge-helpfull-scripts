#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"

mkdir $directory/tests

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist"
    exit 1
fi

for file in "$directory"/I.*; do
    if [ -e "$file" ]; then
        filename=$(basename "$file")
        number="${filename#I.}"
        
        printf -v newname "%02d" "$number"
        if [[ "$newname" =~ ^[0-9]+$ ]]; then
            mv -v "$file" "$directory/tests/$newname"
        fi
    fi
done


for file in "$directory"/O.*; do
    if [ -e "$file" ]; then
        filename=$(basename "$file")
        number="${filename#O.}"
        printf -v newname "%02d" "$number"

        if [[ "$newname" =~ ^[0-9]+$ ]]; then
            mv -v "$file" "$directory/tests/$newname.a"
        fi
    fi
done



echo "Renaming complete"
