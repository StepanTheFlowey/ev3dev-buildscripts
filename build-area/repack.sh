#/bin/sh

usage() {
  echo "Usage: $0 <in> <out>"
}

if [ -z $1 ]; then
  usage
  exit
fi

if [ -z $2 ]; then
  usage
  exit
fi

echo "Repacking $1 into $2 ..."

TMP=$(mktemp -d -p .)
cd "$TMP"

ar x ../$1
zstd -cdq control.tar.zst | gzip -9 > control.tar.gz &
zstd -cdq data.tar.zst | gzip -9 > data.tar.gz
wait
ar r ../$2 debian-binary control.tar.gz data.tar.gz

cd ..
rm -rf "$TMP"
