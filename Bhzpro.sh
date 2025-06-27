#!/bin/bash
# 🎬 BHZ Premium Copyright Killer Script

# 📁 Create input/output folders
mkdir -p input output

clear
echo "🎬 BHZ PREMIUM COPYRIGHT KILLER"
echo "📂 Place your video and music in 'input' folder."
echo "👉 Video formats: mp4/mkv/mov, Music: mp3"
read -p "🎥 Enter video filename (e.g. vid.mp4): " videofile
read -p "🎵 Enter background music filename (e.g. music.mp3): " musicfile

invid="input/$videofile"
inmus="input/$musicfile"
timestamp=$(date +%Y%m%d%H%M%S)
outvid="output/safe_${videofile%.*}_$timestamp.mp4"

echo "⚙️ Processing..."

ffmpeg -i "$invid" -i "$inmus" \
-filter_complex "\
[0:v]crop=iw-20:ih-20,scale=720:406,drawbox=x=0:y=0:w=iw:h=20:color=black@0.8:t=fill,\
drawbox=x=0:y=ih-20:w=iw:h=20:color=black@0.8:t=fill,drawtext=text='BHZ SAFE FRAME':fontcolor=white:fontsize=18:x=10:y=10,transpose=1[v];\
[0:a]asetrate=44100*1.04,atempo=1/1.04[a0];\
[1:a]volume=0.3[a1];\
[a0][a1]amix=inputs=2:duration=first[a]" \
-map "[v]" -map "[a]" -c:v libx264 -c:a aac -r 24 -preset ultrafast "$outvid"

echo "✅ Done! Saved to: $outvid"