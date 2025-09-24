#!/bin/bash
hatancastvideo() {
# Usage: hatancastvideo file.cast
echo -e "input: $1"
ttygif --input "$1" --output "hatancastvideo.gif" --fps=33
ffmpeg -f gif -i "hatancastvideo.gif" -pix_fmt yuv420p -c:v libx264 -movflags +faststart -filter:v crop='floor(in_w/2)*2:floor(in_h/2)*2' "hatancastvideo.mp4"
echo -e "output: hatancastvideo.mp4"
}
