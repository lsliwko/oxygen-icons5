#!/usr/bin/env bash

convert_scalable_for_size() {
    SIZE=${1}
    TARGET_PATH=`echo ./${SIZE}x${SIZE}/${2}/`
    mkdir -p ${TARGET_PATH}

    for svgfile in $(ls ./scalable/${2}/*.svgz); do
        pngfile=`basename ${svgfile} | sed 's/svgz$/png/g'`
        jpgfile=`basename ${svgfile} | sed 's/svgz$/jpg/g'`

        echo "Processing $svgfile into png and jpg with size ${SIZE}"
        rsvg-convert -h ${SIZE} -f png $svgfile > ${TARGET_PATH}$pngfile
        convert -background white -alpha remove -alpha off ${TARGET_PATH}$pngfile ${TARGET_PATH}$jpgfile
    done

    for svgfile in $(ls ./scalable/${2}/*.svg); do
        pngfile=`basename ${svgfile} | sed 's/svg$/png/g'`
        jpgfile=`basename ${svgfile} | sed 's/svg$/jpg/g'`

        echo "Processing $svgfile into png and jpg with size ${SIZE}"
        rsvg-convert -h ${SIZE} -f png $svgfile > ${TARGET_PATH}$pngfile
        convert -background white -alpha remove -alpha off ${TARGET_PATH}$pngfile ${TARGET_PATH}$jpgfile
    done
}

for value in actions applets apps categories devices emblems emotes mimetypes places status
do
    echo "Converting $value..."
    convert_scalable_for_size 16 $value
    convert_scalable_for_size 22 $value
    convert_scalable_for_size 32 $value
    convert_scalable_for_size 48 $value
    convert_scalable_for_size 64 $value
    convert_scalable_for_size 96 $value
    convert_scalable_for_size 128 $value
    convert_scalable_for_size 256 $value
    convert_scalable_for_size 512 $value
done