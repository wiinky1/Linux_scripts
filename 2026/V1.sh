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


#configuring account lockout policy
sudo tee /usr/share/pam-configs/faillock > /dev/null << 'EOF'
Name: Lockout on failed logins
Default: no
Priority: 0
Auth-Type: Primary
Auth:
	[default=die] pam_faillock.so authfail
EOF

sudo tee /usr/share/pam-configs/faillock_reset > /dev/null << 'EOF'
Name: Reset lockout on success
Default: no
Priority: 0
Auth-Type: Additional
Auth:
	required pam_faillock.so authsucc
EOF

sudo tee /usr/share/pam-configs/faillock_notify > /dev/null << 'EOF'
Name: Notify on account lockout
Default: no
Priority: 1024
Auth-Type: Primary
Auth:
	requisite pam_faillock.so preauth
EOF

sudo pam-auth-update --enable faillock faillock_reset faillock_notify

echo "####################################################################################################"
echo "Account lockout policy configured"
echo "####################################################################################################"