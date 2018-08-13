#/bin/bash

OCCURENCY=$(cat packList | grep "https" | wc -l)
USER=$(whoami)
i=1

while [ $i -le $OCCURENCY ]
do
	echo $i
	URL=$(cat packList | grep "https" | sed -n "$i"p)
	FOLDER=$(echo $URL | cut -d '/' -f 5 | awk -F\. '{print $1}')
	git clone $URL "/home/robot/.vim/pack/my-plugins/start/$FOLDER"
	i=$(($i+1))
done
