#!/bin/bash

I=100

#get the total size of the original images
original_size=$(ls -l | grep -P "$1" | awk '{ x += $5 } END { print x }')

while [ $I -gt 0 ]; do
  mkdir -p $I

  # optimize all the images
  for pic in *.jpg; do
    jpegoptim --max=$I --dest="$I/" --strip-all $pic > /dev/null 2>&1
  done

  #calculate their new size
  new_size=$(ls -l $I/ | grep -P "$1" | awk '{ x += $5 } END { print x }')

  #get the percentage difference in total file size
  percent=$(bc -l <<< "scale=4; ($new_size/$original_size) * 100")

  #output a CSV line for processing
  echo "$I,$new_size,$original_size,$percent"

  let I=I-10
done
