#!/bin/bash

dir=/root/aaa/bbb/ccc

if [ ! -e $dir ]
then
    mkdir -p $dir
fi
