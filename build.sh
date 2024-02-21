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

[ ! -f deps/BitsNPicas.jar ] && wget -O deps/BitsNPicas.jar https://github.com/kreativekorp/bitsnpicas/releases/latest/download/BitsNPicas.jar

cp LICENSE out
cp README.md out

bnp() {
	java -jar deps/BitsNPicas.jar convertbitmap -f "$3" -o out/"$2.$3" "$1"
}

bnp src/eldur.kbitx eldur ttf
bnp src/eldur.kbitx eldur bdf
sed -i -e '/^FONT/s/-[pc]-/-M-/i' -e '/^FONT/s/-80-/-50-/' out/eldur.bdf
bnp src/eldur.kbitx eldur otb

bdfresize -f 2 out/eldur.bdf >out/eldur2x.bdf
sed -i -e 's/^iso.*-FONT/FONT/g' -e 's/eldur/eldur2x/g' out/eldur2x.bdf
bnp out/eldur2x.bdf eldur2x otb

rm -f out/*-*.bdf

zip -r "out/eldur_$v.zip" out/*
