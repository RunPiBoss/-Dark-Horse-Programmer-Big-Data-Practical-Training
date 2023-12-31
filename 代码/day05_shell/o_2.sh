#!/bin/bash


source /root/o_1.sh

len=${#arr[*]}

for(( i=0;i<=len;i++ ))
do
    echo ${arr[i]}
done

