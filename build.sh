#!/bin/bash -e

while getopts ":v:" o; do
	case $o in
	v)
		if [ "$OPTARG" != "" ]; then
			v=$OPTARG
		fi
		;;
	*) ;;
	esac
done

rm -rf out
mkdir -p deps out

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar "https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar"

cp LICENSE out
cp README.md out

ff() {
	fontforge -script scripts/fix.py "$@"
}

bnp() {
	java -jar deps/BitsNPicas.jar convertbitmap -f "$3" -o out/"$2.$3" "$1"
}

bnp src/eldur.kbitx eldur ttf
ff eldur ttf
bnp src/eldur.kbitx eldur bdf
sed -i -e '/^FONT/s/-[pc]-/-M-/i' -e '/^FONT/s/-80-/-50-/' out/eldur.bdf
ff eldur bdf
ff eldur otb 1

bdfresize -f 2 out/eldur.bdf >out/eldur2x.bdf
sed -i 's/^iso.*-FONT/FONT/g' out/eldur2x.bdf
ff eldur2x bdf
ff eldur2x otb 1

rm -f out/*-*.bdf

zip -r "out/eldur_$v.zip" out/*
