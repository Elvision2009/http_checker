#!/bin/bash

echo
echo > tmp.txt
if [ -n "$1" ]
then

	while [ -n "$1" ]
	do
		case "$1" in
		-f) file="$2"
		cat $file | grep -Ev "^$" > tmp.txt
		cat tmp.txt > $file
                shift ;;
		-m) param="$2"
		shift ;;
                -o) o_file="$2"
                 shift ;;
		-c) clear="123";;
		-h) echo "This program check HTTP links and give response codes"
		    echo ""
		    echo "Param:  Example:                Description"
		    echo ""
		    echo "-f	-f input_file.txt	Choose file with links for check"
		    echo "-m	-m 200,301		Choose status codes for match"
		    echo "-o	-o output_file.txt	Choose output file"
 		    echo "-c	-c			Checked links only. Without status codes"
		    echo "-h	-h			This help"
		    echo ""
		    echo "Example:"
		    echo "./checker.sh -f input.txt -o output.txt -m 200,301 -c"
		    echo ""
		    echo "Check all links from file input.txt and output only links with statuse code 200 or 301" 
		    echo "into file output.txt without status codes in file. Don't use -c if you want to see status codes in output file!"

		exit;;
		*) echo "$1 is not an option"
		exit;;
	esac
	shift
	done

while read  link
	do
	echo -n "$link " >> tmp.txt 
	curl -s -o /dev/null -w "%{http_code}" $link >> tmp.txt
	echo "" >> tmp.txt
	echo -n "$link "
	curl -s -o /dev/null -w "%{http_code}" $link
	echo ""
	done < $file

if [ -n "$param" ]
then
	param=${param//,/|}
        cat tmp.txt | grep -E "$param" > tmp_2.txt
	cat tmp_2.txt > tmp.txt 
fi

echo ""

if [ -n "$clear" ]
then
if [ -n "$o_file" ]
then
	cat tmp.txt | cut -f1 -d ' ' > $o_file
	echo "All data has been saved in file $o_file " 
else
	cat tmp.txt | cut -f1 -d ' ' > tmp_2.txt
	cat tmp_2.txt > tmp.txt
	echo "All data has been saved in file tmp.txt"
	echo ""
	echo "WARNING!!! File will be destroyed when you run scrip next time!"
fi

else
	if [ -n "$o_file" ]
then
        cat tmp.txt > $o_file 
        echo "All data has been saved in file $o_file " 
else
        echo "All data has been saved in file tmp.txt"
        echo ""
        echo "WARNING!!! File will be destroyed when you run scrip next time!"
 
fi

 
fi


else
echo "Use -h for help. "
fi
