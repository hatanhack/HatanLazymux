hatanfbvid(){
# Usage: hatanfbvid "POST_URL"
if test -d ~/hatanfbvid; then
        true
else
        mkdir ~/hatanfbvid
fi
if test -d ~/hatanfbvid/output; then
        true
else
        mkdir ~/hatanfbvid/output
fi
cd ~/hatanfbvid
url="$1"
youtube-dl -F ${url}
read -p "audio format: " fbaudio
read -p "video format: " fbvideo
audioext="m4a"
videoext="mp4"
echo -e "[hatanfbvid] url: ${url}"
echo -e "[hatanfbvid] downloading the audio..."
youtube-dl -f ${fbaudio} ${url}
echo -e "[hatanfbvid] downloading the video..."
youtube-dl -f ${fbvideo} ${url}
ex=(${url//\// })
audiofile="$(ls | grep ${audioext})"
videofile="$(ls | grep ${videoext})"
echo -e "[hatanfbvid] add the audio to the video..."
ffmpeg -i "${videofile}" -i "${audiofile}" -c:v copy -map 0:v:0 -map 1:a:0 -c:a aac -b:a 192k "${ex[4]}.${videoext}"
rm "${audiofile}"
rm "${videofile}"
mv "${ex[4]}.${videoext}" output
echo -e "[hatanfbvid] done. output: output/${ex[4]}.${videoext}"
}
