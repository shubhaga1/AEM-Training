#!/usr/local/bin/bash
SSH_USERNAME=$1 SSH_KEY=$2 IP_LIST=$3
usage(){
echo "
This script will take the username, password, pem file and a file containing a list of instance IPs. It will iterate through the IP list and copy the ssh key to each of the /home/username of instances.
Usage: add_user_pem.sh <username> <path to id_rsa or pem file> <path to file containing list of IPs> "
}
if [ $# -lt 3 ] 
then
   usag
	exit
fi
#read -s -p "Enter password for ${SSH_USERNAME} : " SSH_PASSWORD
echo "$IP_LIST"
while IFS=','
read -a line 
do
	echo "${line[0]} and password is ${line[1]}"
	echo "sshpass -p ${line[1]} ssh-copy-id -i ${SSH_KEY} ${SSH_USERNAME}@${line[0]} "
	sshpass -p ${line[1]} ssh-copy-id -i ${SSH_KEY} ${SSH_USERNAME}@${line[0]} 
done < $IP_LIST
echo "done"