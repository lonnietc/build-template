#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}
#
# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=bind
VER=9.11.12
PKG=network/dns/server
SUMMARY="BIND DNS server"
DESC="ISC Bind DNS server"
PREFIX=/opt/ISCbind

# Build as 64-bit only
set_arch 64

# The licence cannot be automatically be verified using the rules in
# doc/licences
SKIP_LICENCES='*'

CONFIGURE_OPTS="
    --prefix=/opt/ISCbind
    --localstatedir=/var/opt/bind
    --with-libtool
    --with-openssl=/usr
    --enable-threads=yes
    --enable-devpoll=yes
    --enable-fixed-rrset
    --disable-getifaddrs
    --enable-shared
    --disable-static
    --without-python
    --with-zlib=/usr
"

MIRROR=https://downloads.isc.org/isc/bind9/
SKIP_CHECKSUM=1

init
download_source $VER $PROG $VER
patch_source
prep_build
build
strip_install
install_smf network bind.xml
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
