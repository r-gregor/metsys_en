#! /usr/bin/env bash

ydl='/usr/local/bin/yt-dlp --proxy http://10.91.8.21:80'

while read LINE; do
	echo -ne "$LINE\t\t -- "
	$ydl -I 1:1 --skip-download --print playlist_title $LINE
done < playlists-from-sites.txt

