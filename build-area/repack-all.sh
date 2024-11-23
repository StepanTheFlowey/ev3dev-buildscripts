#/bin/sh

echo "Repacking kernel debs..."
./repack.sh linux-headers-* k-headers.deb &
./repack.sh linux-image-* k-image.deb &
./repack.sh linux-libc-* k-libc.deb
wait
