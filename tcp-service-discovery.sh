#!/bin/sh
ip=`ifconfig |grep -Po '(?<=addr:).*(?=Bc)'`
usage() {
    echo Usage: $0 hostname ports
    echo "For example: $0 myhost.example.net 22,80,1024-1030"
}


if [ -z $1 ]; then
    echo "No host specified" > /dev/stderr
    usage
    exit 1
fi

if [ -z $1 ]; then
    echo "No ports specified" > /dev/stderr
    usage
    exit 1
fi
Scan=$(nmap -P0  -n -p $1 $ip)

OldIFS=$IFS
IFS="
"
Pattern=".*/tcp open .*"


# The important part

echo '{"data":['

cnt=0

for Line in $Scan; do
    Tmp=$(echo $Line | sed -e 's/^[[:space:]]*//' | sed -r 's/ +/ /g' | grep $Pattern)
    if [ $? -eq 0 ]; then
        Port=$(echo -n $Tmp | cut -d "/" -f 1 | tr -d "\n")
        Name=$(echo -n $Tmp | cut -d " " -f 3 | tr -d "\n")

        if [ "$Name" = "unknown" ]; then
            Name="port $Port"
        fi

	if [ $cnt -gt 0 ]; then
		printf  ','
		echo
	fi
	printf '{"{#PORT}":"%s", "{#NAME}":"%s"}' "$Port" "$Name"

	((cnt++))

    fi
done

echo
echo ']}'

IFS=$OldIFS
