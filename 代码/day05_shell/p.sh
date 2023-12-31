#!/bin/bash

# 1 随机数 1 ~ 100
r=$[RANDOM % 100 + 1]

echo "随机数: $r"
# 2 循环  while
while true
do
    # 3 获取用户输入的数字
    read -p "请输入 1 ~ 100的随机数" num
    # 4 判断 
    if [ ${num} -eq $r ]
    then
        echo "恭喜您, 答对了"
        break;
    elif [ ${num} -gt $r ]
    then
        echo "猜大了"
    else
        echo "猜小了"
    fi
done

