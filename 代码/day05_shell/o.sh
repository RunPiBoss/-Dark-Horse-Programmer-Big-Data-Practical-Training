#!/bin/bash

arr=(11 33 55 77 99)

for e in ${arr[*]}
do
    echo $e
done

echo "------------------"

len=${#arr[*]}

for(( i=0;i<=len;i++ ))
do
    echo ${arr[i]}
done
