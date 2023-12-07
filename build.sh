#!/bin/bash -e

rm -rf out
mkdir -p deps out

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

# kbitx to bdf
java -jar deps/BitsNPicas.jar convertbitmap -f bdf -o ./out/eldur.bdf ./src/eldur.kbitx
bdfresize -f 2 ./out/eldur.bdf >./out/eldur_2x.bdf

# kbitx to ttf
java -jar deps/BitsNPicas.jar convertbitmap -f ttf -o ./out/eldur.ttf ./src/eldur.kbitx

# bdf to otb
bitmapfont2otb out/eldur.bdf out/eldur.otb
bitmapfont2otb out/eldur_2x.bdf out/eldur_2x.otb

# bdf to dfont
fontforge -lang=ff -c 'Open($1); Generate($2)' ./out/eldur.bdf ./out/eldur.dfont
fontforge -lang=ff -c 'Open($1); Generate($2)' ./out/eldur_2x.bdf ./out/eldur_2x.dfont

rm -f ./out/*.afm
