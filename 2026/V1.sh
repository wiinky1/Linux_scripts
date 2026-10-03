#!/usr/bin/env bash

#updating
sudo apt update

sudo apt upgrade -y

echo "##################################################################################################"
echo "UPDATED"
echo "##################################################################################################"


#configuring root password
sudo getent shadow root

sudo passwd -l root

sudo getent shadow root

echo "##################################################################################################"
echo "Root password nolonger blank"
echo "##################################################################################################"

#min password length
sudo apt update
sudo apt install -y libpam-pwquality

# Set minimum password length to 12
sudo sed -i '/pam_unix\.so/ s/$/ minlen=12/' /etc/pam.d/common-password

echo "##################################################################################################"
echo "Min password length set"
echo "##################################################################################################"