#!/bin/bash -e

rm -rf out
mkdir -p deps out

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

# kbitx to bdf
java -jar deps/BitsNPicas.jar convertbitmap -f bdf -o ./out/eldur.bdf ./src/eldur.kbitx
bdfresize -f 2 ./out/eldur.bdf >./out/eldur_2x.bdf

# kbitx to otb
java -jar deps/BitsNPicas.jar convertbitmap -f otb -o ./out/eldur.otb ./src/eldur.kbitx
bdfresize -f 2 ./out/eldur.bdf >./out/eldur_2x.otb

# kbitx to ttf
java -jar deps/BitsNPicas.jar convertbitmap -f ttf -o ./out/eldur.ttf ./src/eldur.kbitx

rm -f ./out/*.afm
