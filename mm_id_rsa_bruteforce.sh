#!/bin/bash
# id_rsa password brute force script
# requires ssh-keygen
# Usage: ./mm_idr_sa_bruteforce.sh <password file> <id_rsa file>
# Version 1.0 - Author: maio AT readonlymaio.org

# check if ssh-keygen is installed
which ssh-keygen&>/dev/null
if [ "$?" != 0 ]; then
    echo "ERR -- ssh-keygen not found! I can't work without that."
    exit
fi

# read/test password file
if [ ! -r $1 ]; then
    echo "ERR -- Password file" $1 "not found or unreadable"
    exit
fi

# read/test key file
if [ ! -r $2 ]; then
    echo "ERR -- Key file" $2 "not found or unreadable"
    exit
fi

echo "I'm testing these passwords:" $1 "Against this key file:" $2

while read password; do
    ssh-keygen -y -f $2 -P $password&>/dev/null
        if [ $? -eq 0 ]; then
            echo "****************"
            echo "*Found password:" $password
            echo "****************"
            exit
        fi
done < $1
echo "Sorry... no password found. I give up :("
