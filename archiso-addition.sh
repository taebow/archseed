#!/usr/bin/bash

TMP_DIR=/tmp/archiso-tmp
IMAGES_DIR=./images
PROFILE_DIR=./profiles
PROFILE_NAME=releng
PROFILE_PATH=$PROFILE_DIR/$PROFILE_NAME



cp -Rv /usr/share/archiso/configs/$PROFILE_NAME $PROFILE_DIR/
mkdir -p $PROFILE_PATH/airootfs/usr/bin

cp ./src/fd-mkpart $PROFILE_PATH/airootfs/usr/bin/
echo 'file_permissions["/usr/bin/fd-mkpart"]="0:0:755"' >> $PROFILE_PATH/profiledef.sh


cp ./src/fd-install $PROFILE_PATH/airootfs/usr/bin/
echo 'file_permissions["/usr/bin/fd-install"]="0:0:755"' >> $PROFILE_PATH/profiledef.sh


echo 'KEYMAP=dvorak' >> $PROFILE_PATH/airootfs/etc/vconsole.conf
sed -i -e 's/^timeout .*/timeout 0/' -e 's/^beep on/beep off/' $PROFILE_PATH/efiboot/loader/loader.conf

sudo mkarchiso -v -r -w $TMP_DIR -o $IMAGES_DIR $PROFILE_PATH