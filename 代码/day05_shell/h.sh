#!/bin/bash
sum=0

for(( i=1;i<=100;i++ ))
do
   # echo $i
   sum=$[sum + i]
done

echo "和: $sum"
