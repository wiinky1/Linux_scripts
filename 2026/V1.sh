#!/usr/bin/env bash

#updating
sudo apt update

sudo apt upgrade -y


#configuring root password
sudo getent shadow root

sudo passwd -l root

sudo getent shadow root

#min password length
sudo apt update

sudo apt install -y libpam-pwquality

