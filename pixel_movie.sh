#!/usr/bin/bash

image=input.jpg
size=800			# original x dimension
time=0.2			# time in secs


function create_im {

	gm convert -resize $i $image - | gm convert -resize $size - ./temp/$i.jpg;
	gm convert -font arial -fill blue -pointsize 20 -draw  "text 20, 30 '$i" ./temp/$i.jpg ./temp/$i.jpg;
	echo file temp/$i.jpg >> input.txt;
	echo duration $time >> input.txt;
}

mkdir temp

for i in {8..49}; do create_im; done

for i in {50..98..2}; do create_im; done

for i in {100..500..10}; do create_im; done

for ((i=520;i<=$size; i=i+20)); do create_im; done


ffmpeg -f concat -i input.txt -vsync vfr -pix_fmt yuv420p output.mp4;

rm -r temp;
rm input.txt;