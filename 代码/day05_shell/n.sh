#!/bin/bash

# 1 定义数组
arr=(11 22 33 44 55)

# 2 修改数组元素的内容
arr[2]=$[arr[2] * 2]

# 3 获取数组元素内容
echo ${arr[0]}
echo ${arr[1]}
echo ${arr[2]}
echo ${arr[3]}
echo ${arr[4]}
