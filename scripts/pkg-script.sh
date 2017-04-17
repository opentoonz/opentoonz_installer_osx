#!/bin/sh
STUFF_DIR="OpenToonz_1.1_stuff"
tar xzvf stuff.tar.bz2
mv stuff $STUFF_DIR
mkdir /Applications/OpenToonz
cp -nr $STUFF_DIR /Applications/OpenToonz
chmod -R 777 /Applications/OpenToonz
rm -rf $STUFF_DIR

