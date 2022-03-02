# chirp-appimage
AppImage Recipe for Chirp

You will need
1. appimage-builder
2. appimagetool
3. patchelf

From the [tutorial](https://appimage-builder.readthedocs.io/en/latest/intro/install.html), 
you can get both tools by running the following commands in a command prompt.
```
sudo apt install git python2.7-minimal python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev fakeroot strace fuse

# Install appimagetool AppImage
sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
sudo chmod +x /usr/local/bin/appimagetool
```

I had issues installing the python appimage-builder package as sudo, getting the following error:
```
  Attempting uninstall: pyyaml
    Found existing installation: PyYAML 3.13
ERROR: Cannot uninstall 'PyYAML'. It is a distutils installed project and thus we cannot accurately determine which 
       files belong to it which would lead to only a partial uninstall.
```
So I installed without sudo, but this places the binary at `/home/user/.local/bin/appimage-builder`
so I updated my PATH variable.

Building an AppImage is super easy if all the dependencies are hosted somewhere (like an old ubuntu archive).
Just run 
```
git clone https://github.com/goldstar611/chirp-appimage
cd chirp-appimage/
appimage-builder --recipe recipe.yml
```
and you're done. You will find `Chirp-0.1.0-*.AppImage` in your directory after the command finishes.
