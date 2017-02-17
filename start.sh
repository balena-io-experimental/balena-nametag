#!/bin/bash

URL=${URL:-"https://resin.io"}
STRING=${STRING:-"I can git push to my name badge!"}
NAME=${NAME:-"Ronald\nMcCollam"}

qrencode -m 1 -o qr.png "$URL"
convert bw.png -fill black -box white -gravity south -pointsize 14 -annotate +0+0 "$STRING" out.png
composite -gravity northwest qr.png out.png out.png
convert out.png -fill black -box white -gravity northeast -pointsize 14 -annotate +0+0 "$NAME" out.png

papirus-draw out.png
