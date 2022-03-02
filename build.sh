#!/bin/bash
set -xe

rm -f Chirp-*-*.AppImage

git clone --depth=1 https://github.com/kk7ds/chirp | true
cd chirp
  git pull
  LATEST_COMMIT_DATE=$(git log -1 --date=format:"%Y%m%d" --format="%ad")
  LATEST_COMMIT_SHORT=$(git rev-parse --short HEAD)
  export CHIRP_VERSION="daily-${LATEST_COMMIT_DATE}+${LATEST_COMMIT_SHORT}"
cd ..

export SOURCE_LINE_1='deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse'
export SOURCE_LINE_2='deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse'
export TARGET_ARCH_APT=amd64
export TARGET_ARCH_APPIMAGE=x86_64
appimage-builder --recipe recipe.yml

export SOURCE_LINE_1='deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports bionic main'
export SOURCE_LINE_2='deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports xenial main'
export TARGET_ARCH_APT=arm64
export TARGET_ARCH_APPIMAGE=aarch64
appimage-builder --recipe recipe.yml

export SOURCE_LINE_1='deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports bionic main'
export SOURCE_LINE_2='deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial main'
export TARGET_ARCH_APT=armhf
export TARGET_ARCH_APPIMAGE=armhf
appimage-builder --recipe recipe.yml
