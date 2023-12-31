#!/bin/bash

read -p "请输入第一个参数的值: " a
read -p "请输入第二个参数的值: " b

if [ $a -eq $b ]
then
    echo "$a 等于 $b"
elif [ $a -gt $b  ]
then
    echo "$a 大于 $b"
else
    echo "$a 小于 $b"
fi
