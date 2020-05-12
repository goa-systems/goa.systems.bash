#!/bin/bash

baseurl="https://cdn.azul.com/zulu/bin/"

function do_download() {
	wget -O "download/${1}" "${baseurl}${1}"
	for filename in download/*;do
		tar -x -f "${filename}" -C extract
		mv "${filename}" archive
	done

	# If second parameter is empty, don't create symlinks.
	if [ ! -z "$2" ]
	then
		for filename in extract/*;do
			ln -r -s ${filename} extract/$2
		done
	fi
	mv extract/* java
}


mkdir archive
mkdir download
mkdir extract
mkdir java

do_download "zulu14.28.21-ca-jdk14.0.1-linux_x64.tar.gz" "latest"
do_download "zulu11.39.15-ca-jdk11.0.7-linux_x64.tar.gz" "stable"
do_download "zulu8.46.0.19-ca-jdk8.0.252-linux_x64.tar.gz" "oldstable"
do_download "zulu13.31.11-ca-jdk13.0.3-linux_x64.tar.gz"

rm -r download
rm -r extract
