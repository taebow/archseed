#!/bin/bash
sleep 5
kitty bash -c '
read -p "Press enter to exit..."
'
rm -- "$HOME/.config/autostart/post-install.sh"
