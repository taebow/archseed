#!/usr/bin/bash

TMP_DIR=/tmp/archiso-tmp
IMAGES_DIR=./images
PROFILE_DIR=./profiles
PROFILE_NAME=releng
PROFILE_PATH=$PROFILE_DIR/$PROFILE_NAME



cp -Rv /usr/share/archiso/configs/$PROFILE_NAME $PROFILE_DIR/
mkdir -p $PROFILE_PATH/airootfs/usr/bin

cp ./src/mkpart $PROFILE_PATH/airootfs/usr/bin/
echo 'file_permissions["/usr/bin/mkpart"]="0:0:755"' >> $PROFILE_PATH/profiledef.sh

sudo mkarchiso -v -r -w $TMP_DIR -o $IMAGES_DIR $PROFILE_PATH