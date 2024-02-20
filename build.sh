#!/bin/bash -e

while getopts ":v:" o; do
	case $o in
	v)
		[ "$OPTARG" != "" ] && v="_$OPTARG"
		;;
	*) ;;
	esac
done

rm -rf out
mkdir -p deps out

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

cp LICENSE out

# kbitx -> bdf
java -jar deps/BitsNPicas.jar convertbitmap -f bdf -o "out/eldur$v.bdf" src/eldur.kbitx
bdfresize -f 2 "out/eldur$v.bdf" >"out/eldur_2x$v.bdf"

# kbitx -> otb
java -jar deps/BitsNPicas.jar convertbitmap -f otb -o "out/eldur$v.otb" src/eldur.kbitx
bdfresize -f 2 "out/eldur$v.otb" >"out/eldur_2x$v.otb"

# kbitx -> ttf
java -jar deps/BitsNPicas.jar convertbitmap -f ttf -o "out/eldur$v.ttf" src/eldur.kbitx

rm -f out/*.afm
zip -r "out/eldur$v.zip" out/*
