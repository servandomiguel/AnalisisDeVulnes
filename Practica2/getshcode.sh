#!/bin/bash

if [ -z $1 ]
then 
	echo "Usage: ./getshcode file_name param\n"
	echo "	Params:"
	echo "		-u unicode"
	echo "		-n numbers and letters"
	echo "		[not specified] \x format"
	exit 1
fi

if [ ! -f $1 ]
then
	echo "File not found!"
	exit 1
fi


if [ -z $2 ]
then
	objdump -d -j .text $1 | grep -e '^ ' | tr '[[:space:]]' '\n' |\
            egrep '^[a-fA-F0-9]{2}$' | xargs | sed 's/^/ /' | sed 's/ /\\x/g'

elif [ $2 == "-u" ]
then
	objdump -d -j .text $1 | grep -e '^ ' | tr '[[:space:]]' '\n' |\
                egrep '^[a-fA-F0-9]{2}$' | xargs | sed 's/^/ /' |\
                sed 's/ /\\u00/g'

elif [ $2 == "-n" ]
then
	objdump -d -j .text $1 | grep -e '^ ' | tr '[[:space:]]' '\n' | \
		egrep '^[a-fA-F0-9]{2}$' | xargs | sed 's/ //g'

else 	
	echo "Usage: ./getshcode file_name param\n"
	echo "	Params:"
	echo "		-u unicode"
	echo "		-n numbers and letters"
	echo "		[not specified] \x format"
	exit 1
fi
