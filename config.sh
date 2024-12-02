#!/bin/bash

bootpath=$1
apppath=$2
output=$3/config.json

cat <<EOF > $output
{
    "count": 2,
    "magic": "RT-Thread",
    "section": [
        {
            "firmware": "${bootpath//\//\\/}",
            "partition": "bootloader",
            "size": "65280",
            "start_addr": "0x00000000",
            "version": "2M.1220"
        },
        {
            "firmware": "${apppath//\//\\/}",
            "partition": "app",
            "size": "1156K",
            "start_addr": "0x00011000",
            "version": "2M.1220"
        }
    ],
    "version": "0.1"
}
EOF