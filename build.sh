#!/bin/bash

mkdir -p deps

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

mkdir -p out/{ttf,otb,bdf}
for ext in ttf otb bdf; do
	java -jar deps/BitsNPicas.jar convertbitmap -f "$ext" -o "out/eldur.$ext" ./src/eldur.kbitx
done
