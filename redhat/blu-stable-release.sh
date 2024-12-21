#!/bin/bash

# shellcheck disable=all

releasenum=$1

# Releasenum is really just the last digit as we have series based on Fedora Release
# by default we assume 0, but if you need to do a rebuild with a fix before a new release
# you can call the script with a 1 or whatever digit you wish for the releasenum.
if [ -z "$releasenum" ]; then
	releasenum="1"
fi

for release in $( cat redhat/release_targets );  do 
	case "$release" in
	41) build=30$releasenum
	    ;;
	40) build=20$releasenum
	    ;;
	39) build=10$releasenum
	    ;;
	esac
	make IS_FEDORA=1 DIST=".fc$release" BUILDID="" DISTLOCALVERSION=".blu" BUILD=$build dist-srpm
	make IS_FEDORA=1 DIST=".fc$release" BUILDID="" DISTLOCALVERSION=".blu" BUILD=$build dist-headers-srpm
done
