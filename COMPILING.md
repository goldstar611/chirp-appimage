
# chirp-appimage
AppImage Recipe for Chirp

This recipe builds a Chirp AppImage for the following architectures
- amd64 (AMD/Intel 64-bit)
- aarch64 (ARM 64-bit like raspberry pi 4, newer pi-zero)
- armhf (ARM 32-bit like raspberry pi 4/3/2/1, older pi-zero)

From the [tutorial](https://appimage-builder.readthedocs.io/en/latest/intro/install.html), 
you can get the build tools by running the following commands in a command prompt on Debian/Ubuntu/LinuxMint:
```
# Install build dependencies
sudo apt install git python2.7-minimal gettext python3-pip patchelf fakeroot strace fuse

# Install appimagetool
arch=$(uname -m)  
if [ "${arch}" = "armv7l" ]; then arch="armhf"; fi  # Raspberry pi fix
if [ "${arch}" = "armv6l" ]; then arch="armhf"; fi  # Raspberry pi 0 fix
sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-${arch}.AppImage -O /usr/local/bin/appimagetool
sudo chmod +x /usr/local/bin/appimagetool

# Install the appiamge-builder tool
sudo -H pip3 install appimage-builder
```

Building an AppImage is super easy if all the dependencies are still available in \*.deb format (like an old ubuntu archive).

Just run 
```
git clone https://github.com/goldstar611/chirp-appimage
cd chirp-appimage/
chmod +x ./build.sh
./build.sh
```

You will find `Chirp-daily-*-*.AppImage` in your directory after the command finishes.

## Using a proxy
If you would like to use a proxy or a apt caching utility (like apt-cacher-ng) you can set the `http_proxy` environment variable before running the build script.
```
export http_proxy=http://localhost:3142
./build.sh
```
