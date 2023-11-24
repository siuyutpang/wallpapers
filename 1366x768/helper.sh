#!/usr/bin/env bash

path="${1:-.}"

rename_pics() {
    shopt -s nullglob

    declare -i i=1

    # 防止在重命名过程中导致名字冲突
    for pic in "$path"/*.{jpg,png}; do
        if [ -f "$pic" ]; then
            ext="${pic##*.}"
            mv $pic "${pic%/*}/"$(printf "%08d" $i)".$ext"
            i+=1
        fi
    done

    i=1

    for pic in "$path"/*.{jpg,png}; do
        if [ -f "$pic" ]; then
            ext="${pic##*.}"
            mv $pic "${pic%/*}/"$(printf "%02d" $i)".$ext"
            i+=1
        fi
    done

    shopt -u nullglob
}


generate_md() {
    shopt -s nullglob

    local location="$path/README.md"
    echo "wallpapers showcase" > $location
    for pic in $(ls "$path"/*.{jpg,png}); do
        echo "${pic##*/}" >> $location
        echo "![$pic]($pic)" >> $location
    done

    shopt -u nullglob
}

main() {
    # rename_pics
    generate_md
}

main

