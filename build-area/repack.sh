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

mkdir __tmp
cd __tmp

ar x ../$1
zstd -q -d *.zst
gzip control.tar data.tar
ar r ../$2 debian-binary control.tar.gz data.tar.gz

cd ..
rm -rf __tmp
