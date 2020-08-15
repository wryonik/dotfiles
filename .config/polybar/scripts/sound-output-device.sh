#!/bin/bash

var=$(pacmd list | grep "active port" | awk '{ print $3 }' | awk -F '-' '{ print $3 }' | awk -F '>' '{ print $1 }' | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1' | head -n 1)

if [[ $var = "Headphones" ]]; then
	echo " Headphone"
else
	echo " Speaker"
fi

