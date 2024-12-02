#!/bin/sh

APP_VERSION=$1

fatal() 
{
	echo -e "\033[0;31merror: $1\033[0m"
	exit 1
}

[ -z $APP_VERSION ] && fatal "no version!"

make APP_VERSION=$APP_VERSION all
./config.sh ./tools/bootloader_bk7238_uart1_v1.0.14.bin ./output/bk7238_${APP_VERSION}.bin ./output
./tools/beken_packager ./output/config.json
mv all_2M.1220.bin ./output/OpenBK7238_QIO_${APP_VERSION}.bin
mv bk7238_${APP_VERSION}_uart_2M.1220.bin ./output/OpenBK7238_UA_${APP_VERSION}.bin
./tools/rt_ota_packaging_tool_cli -f ./output/bk7238_${APP_VERSION}.bin -o ./output/OpenBK7238_${APP_VERSION}.rbl -p app -c gzip -s aes -k 0123456789ABCDEF0123456789ABCDEF -i 0123456789ABCDEF -v ${APP_VERSION}
./tools/package ./output/OpenBK7238_${APP_VERSION}.rbl ./output/OpenBK7238_UG_${APP_VERSION}.bin ${APP_VERSION}