#!/bin/bash

username=""
password=""
echo
mail=$(curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" |  grep -oPm1 "(?<=<title>)[^<]+" | sed '1d' | wc -l)

if [ $mail -gt "19" ]; then
				echo "       20+"
else
				echo "       $mail"
fi
