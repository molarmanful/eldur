#!/usr/bin/env bash

mkdir -p deps out

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

for ext in ttf otb bdf; do
    java -jar deps/BitsNPicas.jar convertbitmap -f "$ext" -o "out/eldur.$ext" ./src/eldur.kbitx
done
