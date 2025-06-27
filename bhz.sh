#!/bin/bash

# BHZ Copyright Killer Tool
clear
echo "🎬 BHZ COPYRIGHT KILLER"
read -p "🎥 Enter video path: " path
output="safe_$(basename "$path")"
ffmpeg -i "$path" \
-vf "crop=iw-20:ih-20,eq=brightness=0.03:saturation=1.25" \
-af "asetrate=44100*1.04,atempo=1/1.04" \
-preset ultrafast "$output"
echo "✅ Done! Output saved as: $output"