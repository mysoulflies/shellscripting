#!/bin/sh
if [ $# -ne 2 ] 
then 
	echo "Usage: $0 source-dir dest-dir"; 
	exit 1; 
fi

for data in `find $1 -type d`
do
		if [ `basename $data` != `basename $1` ]
		then 
			data_cut=${data#$1}

			if [ -e $2/$data_cut ]
			then 
				`rm -r $2/$data_cut`
			fi

			mkdir $2/$data_cut
		fi
done 

for filez in `find $1 -type f`
do
	filecut=${filez#$1}
 	filename= echo "`basename $filez`"
	dest_pos=${filecut%$filename}
	`cp $filez $2/$dest_pos`
done
