#!/usr/bin/env bash

convert_scalable_for_size() {
    SIZE=${1}
    TARGET_PATH=`echo ./${SIZE}x${SIZE}/mimetypes/`
    mkdir -p ${TARGET_PATH}

    for svgfile in $(ls ./scalable/*.svgz); do
        pngfile=`basename ${svgfile} | sed 's/svgz$/png/g'`
        jpgfile=`basename ${svgfile} | sed 's/svgz$/jpg/g'`

        echo "Processing $svgfile into png and jpg with size ${SIZE}"
        rsvg-convert -h ${SIZE} -f png $svgfile > ${TARGET_PATH}$pngfile
        convert -background white -alpha remove -alpha off ${TARGET_PATH}$pngfile ${TARGET_PATH}$jpgfile
    done
}

convert_scalable_for_size 16
convert_scalable_for_size 22
convert_scalable_for_size 32
convert_scalable_for_size 48
convert_scalable_for_size 64
convert_scalable_for_size 96
convert_scalable_for_size 128
convert_scalable_for_size 256
convert_scalable_for_size 512

