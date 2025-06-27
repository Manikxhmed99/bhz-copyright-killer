#!/bin/bash

# BHZ Copyright Killer Tool

# 📁 Create folders if not exist
mkdir -p input
mkdir -p output

clear
echo "🎬  BHZ COPYRIGHT KILLER"
echo "📂 Place your video in the 'input' folder first!"

read -p "🎥 Enter video filename (e.g. video.mp4): " filename
input="input/$filename"
output="output/safe_$filename"

# 🛠️ Run FFmpeg to edit video
ffmpeg -i "$input" \
-vf "crop=iw-20:ih-20,eq=brightness=0.03:saturation=1.25" \
-af "asetrate=44100*1.04,atempo=1/1.04" \
-preset ultrafast "$output"

echo "✅ Done! Output saved in: $output"
