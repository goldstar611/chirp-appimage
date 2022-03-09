#!/bin/bash
set -xe

rm -f Chirp-*-*.AppImage

git clone --depth=1 https://github.com/kk7ds/chirp | true
cd chirp
  git pull
  export CHIRP_VERSION="$(date +%Y%m%d)"
  # Update in-app version
  sed -i "s/CHIRP_VERSION = \".*\"/CHIRP_VERSION = \"${CHIRP_VERSION}\"/" chirp/__init__.py
  # No need to import chirp or chirp.drivers on a linux build
  sed -i "s/^from chirp.drivers import .*$//" setup.py
  sed -i "s/^import chirp$//" setup.py
cd ..

# i386 (32-bit Intel/AMD)
export TARGET_ARCH_APT=i386
export TARGET_ARCH_APPIMAGE=i686
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://archive.ubuntu.com/ubuntu/ bionic main"
export SOURCE_LINE_2="deb [arch=${TARGET_ARCH_APT}] http://archive.ubuntu.com/ubuntu/ xenial main"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3b4fe6acc0b21f32"
export KEY_URL_2="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x40976EAF437D05B5"
appimage-builder --recipe AppImageBuilder.yml

# x86_64 (64-bit Intel/AMD)
export TARGET_ARCH_APT=amd64
export TARGET_ARCH_APPIMAGE=x86_64
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://archive.ubuntu.com/ubuntu/ bionic main"
export SOURCE_LINE_2="deb [arch=${TARGET_ARCH_APT}] http://archive.ubuntu.com/ubuntu/ xenial main"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3b4fe6acc0b21f32"
export KEY_URL_2="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x40976EAF437D05B5"
appimage-builder --recipe AppImageBuilder.yml

# armhf (32-bit ARM)
export TARGET_ARCH_APT=armhf
export TARGET_ARCH_APPIMAGE=armhf
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://ports.ubuntu.com/ubuntu-ports bionic main"
export SOURCE_LINE_2="deb [arch=${TARGET_ARCH_APT}] http://ports.ubuntu.com/ubuntu-ports xenial main"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3b4fe6acc0b21f32"
export KEY_URL_2="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x40976EAF437D05B5"
appimage-builder --recipe AppImageBuilder.yml

# arm64/aarch64 (64-bit ARM)
export TARGET_ARCH_APT=arm64
export TARGET_ARCH_APPIMAGE=aarch64
export SOURCE_LINE_1="deb [arch=${TARGET_ARCH_APT}] http://ports.ubuntu.com/ubuntu-ports bionic main"
export SOURCE_LINE_2="deb [arch=${TARGET_ARCH_APT}] http://ports.ubuntu.com/ubuntu-ports xenial main"
export KEY_URL_1="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3b4fe6acc0b21f32"
export KEY_URL_2="http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x40976EAF437D05B5"
appimage-builder --recipe AppImageBuilder.yml

