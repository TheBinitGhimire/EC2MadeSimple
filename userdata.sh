#!/bin/bash
# Sample Amazon EC2 User Data!
: '
EC2 Made Simple: https://github.com/TheBinitGhimire/EC2MadeSimple
		Making Elastic Compute Cloud Instances easy-to-connect!
'
sudo echo -e "binit\nbinit" | sudo passwd &> /dev/null; # Replace "binit" with your desired superuser (root) password!
sudo echo -e "PermitRootLogin yes\nChallengeResponseAuthentication no\nUsePAM yes\nX11Forwarding yes\nPrintMotd no\nAcceptEnv LANG LC_*\nSubsystem       sftp    /usr/lib/openssh/sftp-server" > /etc/ssh/sshd_config;
sudo systemctl restart sshd;
