#!/bin/bash
# 🎬 BHZ Premium Copyright Killer Script

# 📁 Create input/output folders
mkdir -p input output

clear
echo "🎥  BHZ PREMIUM COPYRIGHT KILLER"
echo "📁 Place your video and music in the input folder"
echo "👉 Video formats: mp4/mkv/mov, Music: mp3/wav"
read -p "🎞️ Enter video filename (e.g. video.mp4): " videofile
read -p "🎵 Enter background music filename (e.g. bg.mp3): " musicfile

invid="input/$videofile"
inmus="input/$musicfile"
timestamp=$(date +%Y%m%d%H%M%S)
outvid="output/safe_${videofile%.*}_$timestamp.mp4"

# ✅ Apply multiple copyright protection layers
ffmpeg -i "$invid" -i "$inmus" \
  -filter_complex "[0:v]scale=1280:-2,eq=brightness=0.05:saturation=1.2,setpts=PTS-STARTPTS,drawbox=x=10:y=10:w=200:h=100:color=black@0.5:t=fill[vid]; [1:a]volume=0.4[aud]" \
  -map "[vid]" -map "[aud]" -c:v libx264 -c:a aac -shortest "$outvid"

echo "✅ Done! Output saved to: $outvid"
