#! /bin/bash

password='***'

TARGET_SERVERS=(
	'username@ssh1.test.com'
    'username@ssh2.test.com'
)

echo -e "\nServers List: \n"

serverCount=${#TARGET_SERVERS[*]}

idx=0

while(( $idx<$serverCount ))
do
    lineNo=$((idx+1))
    printf "%-4s %s\n" $lineNo ${TARGET_SERVERS[$idx]}
    let "idx++"
done

echo

read -p "Please choose a server No: " serverNo

if [ $serverNo -lt 1 -o $serverNo -gt $serverCount ]
then
    echo "Input paramter invalidate!"
    exit 0
fi

targetServer=${TARGET_SERVERS[$((serverNo-1))]}

expect -c "
    set timeout 3
    spawn ssh ${targetServer}
    expect {
      \"yes/no\" {send yes\r;exp_continue}
      \"password\" {send ${password}\r;exp_continue}
      \"$\*\" {send \"cd /opt/active/logs\r\"}
    }
    interact
"