#!/bin/bash

for e in $@
do
   echo $e
done

for e in $(ls /root)
do
  echo $e
done
