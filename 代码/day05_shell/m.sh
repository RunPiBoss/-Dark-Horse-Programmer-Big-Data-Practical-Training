#!/bin/bash
sum=0

fun2() {
   a=10
   b=2000

   sum=$[a + b]
}

fun2
echo $?
echo "和: $sum"
