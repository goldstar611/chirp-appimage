#!/bin/bash
set -xe

rm -f Chirp-*-*.AppImage

git clone --depth=1 https://github.com/kk7ds/chirp | true
cd chirp
  git pull
  export CHIRP_VERSION="daily-$(date +%Y%m%d)"
  # Update in-app version
  sed -i "s/CHIRP_VERSION = \".*\"/CHIRP_VERSION = \"${CHIRP_VERSION}\"/" chirp/__init__.py
  # No need to import chirp or chirp.drivers on a linux build
  sed -i "s/^from chirp.drivers import .*$//" setup.py
  sed -i "s/^import chirp$//" setup.py
cd ..

# x86_64 (64-bit Intel/AMD)
export TARGET_ARCH_APT=amd64
export TARGET_ARCH_APPIMAGE=x86_64
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://archive.ubuntu.com/ubuntu jammy main universe"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x871920D1991BC93C"
appimage-builder --recipe AppImageBuilder.yml

# armhf (32-bit ARM)
export TARGET_ARCH_APT=armhf
export TARGET_ARCH_APPIMAGE=armhf
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://ports.ubuntu.com/ubuntu-ports jammy main universe"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x871920D1991BC93C"
appimage-builder --recipe AppImageBuilder.yml

# arm64/aarch64 (64-bit ARM)
export TARGET_ARCH_APT=arm64
export TARGET_ARCH_APPIMAGE=aarch64
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://ports.ubuntu.com/ubuntu-ports jammy main universe"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x871920D1991BC93C"
appimage-builder --recipe AppImageBuilder.yml

