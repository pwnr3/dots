#!/bin/sh

function show_help {
	echo "Usage: $0 <version> <target> [-h] [-i686]"
}

if [[ $# < 2 ]]; then
	show_help
	exit 1
fi

# DIR_TCACHE='tcache'
# GLIBC_VERSION=$1
# TARGET=$2
ARCH=''

while :; do
	case $3 in
		-h|-\?|--help)
			show_help
			exit
			;;
		-i686|-i386)
			ARCH='i386'
			;;
		'')
			break
			;;
	esac
	shift
done

arch=$(file $2 | cut -d':' -f2 | cut -d' ' -f3)
if [[ $arch == '32-bit' ]]
then
	ARCH='i386'
else
	ARCH='amd64'
fi

curr_interp=$(readelf -l "$2" | grep 'Requesting' | cut -d':' -f2 | tr -d ' ]')
if [[ $1 == 0 ]] # use system default
then
	if [[ $ARCH == 'amd64' ]]
	then
		target_rpath="/usr/lib"
		target_interp="/usr/lib64/ld-linux-x86-64.so.2"
	else
		target_rpath="/usr/lib32"
		target_interp="/usr/lib/ld-linux.so.2"
	fi
else
	OUTPUT_DIR="$HOME/glibcs/$1-${ARCH}"
	
	# Get glibc source
	if [ ! -e "$OUTPUT_DIR/libc-$1.so" ]; then
	    echo "Error: Glibc-version wasn't build. Build it first:"
			exit 1
	fi
	
	target_rpath="$OUTPUT_DIR"
	target_interp="$OUTPUT_DIR/ld-$1.so"
fi

if [[ $curr_interp != $target_interp ]];
then
    patchelf --set-interpreter "$target_interp" --set-rpath "$target_rpath" "$2"
fi

# LD_PRELOAD="$OUTPUT_DIR/libc-$1.so" "$2"
