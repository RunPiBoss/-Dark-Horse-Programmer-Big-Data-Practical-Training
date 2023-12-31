#!/bin/bash

read -p "请输入您的年龄: " age

if [ $age -ge 18  ]  
then 
    echo "成年人"
else
    echo "未成年人"
fi
