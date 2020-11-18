#!/bin/bash
clear;
function hr(){
	printf %"$COLUMNS"s | tr " " "-";
	printf "\n";
}

printf "\n||| Welcome to EC2 Made Simple (v0.1)\041 ||| Making Elastic Compute Cloud Instances easy-to-connect\041 |||\n||| [[ Author: Binit Ghimire (@TheBinitGhimire) ]] |||\n\n";
hr;

if [ "$EUID" -ne 0 ]
	then
		echo "Please run EC2MadeSimple as root!"
		echo $hr;
	exit
fi


echo -e "\nSetting Password for root user!\n";
echo -n "Enter Password: ";
read -s password;
echo -e "$password\n$password" | passwd &> /dev/null;
printf "\nPassword has been set\041\n\n";

hr;
echo -e "\nKilling all processes for normal user and deleting the user!\n";
user=$(eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1);
if [[ $user ]];
then
	userdel -rf $user &> /dev/null;
	printf "\nUser $user has been deleted\041\n";
fi

hr;
echo -e "\nDisabling Private Key File based Authentication!\n"
echo -e "PermitRootLogin yes\nChallengeResponseAuthentication no\nUsePAM yes\nX11Forwarding yes\nPrintMotd no\nAcceptEnv LANG LC_*\nSubsystem       sftp    /usr/lib/openssh/sftp-server" > /etc/ssh/sshd_config;
printf "\nPrivate Key Authentication has been removed\041\n\n";

hr;
printf "\nConnect to this EC2 Instance over SSH as root@"$(curl -s ifconfig.me)" with the password: $password\041 (without exclamation mark\041)\n\n" && hr && printf "\nThank You for using EC2 Made Simple\041\n\n" && hr && printf "\n";
systemctl restart sshd;