#!/bin/bash

#download the necessary images

url="http://dataprivacylab.org/courses/dataworld/images"

folders[0]="abbey1"
folders[1]="abbey2"
folders[2]="buzau"
folders[3]="fast1"
folders[4]="iup"
folders[5]="miemasu1"
folders[6]="miemasu2"
folders[7]="mismasu3"
folders[8]="mjpg1"

for folder in "${folders[@]}"
do
  command="curl -s $url/$folder/ | grep \"\\.jpg\" | awk '{ print \$5 }' | cut -d'>' -f 1 | cut -d'\"' -f 2"

  pics=`eval $command`

  arr=($pics)
  for i in {0..4}
  do
    curl -s "$url/$folder/${arr[i]}" > "$folder-${arr[i]}"
  done

done
