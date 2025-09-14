#!/bin/bash
set -e

mkdir -p problems
cd problems

# Generate names A..Z, AA..ZZ
gen_names() {
    for c1 in {A..Z}; do
        echo "$c1"
    done
    for c1 in {A..Z}; do
        for c2 in {A..Z}; do
            echo "$c1$c2"
        done
    done
}

names=( $(gen_names) )
global_idx=0

while [[ $# -gt 0 ]]; do
    contest_id="$1"
    shift
    mode="$1"
    shift

    if [[ "$mode" == "all" ]]; then
        for p in /home/judges/"$contest_id"/problems/*; do
            new="${names[$global_idx]}"
            echo "ln -s /home/judges/$contest_id/problems/$(basename $p)/ $new"
            global_idx=$((global_idx+1))
        done
    elif [[ "$mode" == "range" ]]; then
        range="$1"
        shift
        range=${range// /}
        mstart=${range%-*}
        mend=${range#*-}
        ord() { printf "%d" "'$1"; }
        chr() { printf \\$(printf '%03o' "$1"); }

        start_code=$(ord "$mstart")
        end_code=$(ord "$mend")

        for ((c=start_code; c<=end_code; c++)); do
            p=$(chr "$c")
            new="${names[$global_idx]}"
            echo "ln -s /home/judges/$contest_id/problems/$p/ $new"
            global_idx=$((global_idx+1))
        done 
       # echo ":$mstart: is start :$mend: is end"
        #for p in ${mstart}..${mend}; do
        #    new="${names[$global_idx]}"
        #    echo "ln -s /home/judges/$contest_id/problems/$p/ $new"
        #    global_idx=$((global_idx+1))
        #done
    else
        while [[ $# -gt 0 ]]; do
            if [[ ! $1 =~ ^[0-9]{6}$ ]]; then
                p="$1"
                shift
                new="${names[$global_idx]}"
                echo "ln -s /home/judges/$contest_id/problems/$p/ $new"
                global_idx=$((global_idx+1))
            else
                break
            fi
        done
    fi
done
