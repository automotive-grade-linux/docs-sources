#!/bin/bash

cd $(dirname $0)
CURDIR=$(pwd)

FORMAT=pdf
#DEBUG_FLAG=--debug
DEBUG_FLAG=

DRY=
[ "$1" = "-dry" ] && DRY=echo

OUT_DIR=./build
[ -d $OUT_DIR ] || mkdir -p $OUT_DIR

cat <<EOF | { while read doc_dir ; do $DRY iot-gendocs.sh -rp $doc_dir -o $OUT_DIR $DEBUG_FLAG $FORMAT; done }
./sdk-devkit
./host-configuration
./candevstudio
EOF

