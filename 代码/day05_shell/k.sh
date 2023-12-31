#!/bin/bash

for ((i=1;i<=10;i++))
do
   if [ $i -eq 3 ]
   then
      continue
   fi

   echo $i

   if [ $i -eq 8  ]
   then
      break
   fi
   
done
