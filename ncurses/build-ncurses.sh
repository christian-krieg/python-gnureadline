###
#
# Resources:
#
# https://github.com/christian-krieg/python-build-standalone/commit/02e8695eed1ea479e3b189d107d4da91ed1140b5
#
# python-build-standalone/cpython-unix/build-ncurses.sh


#!/usr/bin/env bash

set -ex

NCURSES_VERSION=6.4

ROOT=`pwd`/..
#ROOT=..

tar -xf ncurses-${NCURSES_VERSION}.tar.gz

pushd ncurses-${NCURSES_VERSION}

#    --prefix=/tools/deps
CONFIGURE_FLAGS="
    --build=${BUILD_TRIPLE}
    --host=${TARGET_TRIPLE}
    --prefix=/
    --without-cxx
    --without-tests
    --without-manpages
    --disable-stripping
    --enable-widec"

CFLAGS="${EXTRA_TARGET_CFLAGS} -fPIC" CPPFLAGS="${EXTRA_TARGET_CFLAGS} -fPIC" LDFLAGS="${EXTRA_TARGET_LDFLAGS}" ./configure ${CONFIGURE_FLAGS}
make -j `nproc`
make -j `nproc` install DESTDIR=${ROOT}/deps
