#!/bin/bash

#routine checks...
if [ $# -lt 2 ] 
then 
	echo "Usage: $0 source-dir dest-dir [option param -w overwrite]"; 
	exit 1; 
fi

if [ ! -d $1 ]
then 
	echo $1 is not a directory
	exit 1
fi

if [ ! -d $2 ]
then 
	echo $2 is not a directory
	exit 1
fi
#end routine checks

#START empty dir check and -w option enabled
if [ "$(ls -A $2 2> /dev/null)" != "" ]
then
     echo "$2 is not an empty directory"
fi

if [ -z $3  ]
then 
	echo can not overwrite in $2
	exit 1
else 
	if [ $3 = "-w" ] 
	then 
		echo overwriting $2...
	else	
		echo illegal argument
		exit 1
	fi
fi

#STOP empty dir check and -w option enabled

cd $1

for data in `find .`
do
		if [ "$data" = "." ] 
		then 
			continue
		fi

		if [ -d $data ] 
		then
			if [ -e $2/$data ]
			then 
				rm -rf $2/$data
			fi

			mkdir $2/$data

		else 
			data_cut=${data#"./"}
			cp $data $2/$data
		fi
done 
