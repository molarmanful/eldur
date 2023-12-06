#!/usr/bin/env bash

rm -rf out
mkdir -p deps out

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

exts=(ttf otb dfont psf)

java -jar deps/BitsNPicas.jar convertbitmap -f bdf -o ./out/eldur.bdf ./src/eldur.kbitx
bdfresize -f 2 ./out/eldur.bdf >./out/eldur_2x.bdf

for ext in "${exts[@]}"; do
	out="out/eldur.$ext"
	out2x="out/eldur_2x.$ext"
	java -jar deps/BitsNPicas.jar convertbitmap -f "$ext" -o "$out" ./out/eldur.bdf
	java -jar deps/BitsNPicas.jar convertbitmap -f "$ext" -o "$out2x" ./out/eldur_2x.bdf
done
