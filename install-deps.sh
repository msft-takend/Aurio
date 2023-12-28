#!/bin/bash
VERSION=ffmpeg-n6.1-latest-win64-lgpl-shared-6.1
LOCALNAME=linux64
ARCHIVE=$VERSION.tar.xz
DEST=./libs/ffmpeg

wget -O $ARCHIVE https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/$ARCHIVE && \
  tar xf $ARCHIVE -C $DEST && \
  rm $ARCHIVE && \
  rm -rf $DEST/$LOCALNAME && \
  mv $DEST/$VERSION $DEST/$LOCALNAME