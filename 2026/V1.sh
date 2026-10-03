#!/usr/bin/env bash

sudo getent shadow root

sudo passwd -l root

sudo getent shadow root

sudo apt update
sudo apt install -y libpam-pwquality


