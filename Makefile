OBK_DIR=../../src
CROSS_COMPILE=arm-none-eabi-
CC	:= $(CROSS_COMPILE)gcc
OP	:= $(CROSS_COMPILE)objcopy
AR	:= $(CROSS_COMPILE)ar
AS	:= $(CROSS_COMPILE)as
LD	:= $(CROSS_COMPILE)gcc
NM	:= $(CROSS_COMPILE)nm
OD	:= $(CROSS_COMPILE)objdump
RD	:= $(CROSS_COMPILE)readelf
ST	:= $(CROSS_COMPILE)strip

APP_BIN_NAME=bk7238

all: application 

OBJ_DIR=./obj
BIN_DIR=./bin
OUT_DIR = ./output

INCLUDES=-D_GNU_SOURCE -DCFG_OS_FREERTOS=1 -DWIFI_BLE_COEXIST -fno-common -DMBEDTLS_CONFIG_FILE="tls_config.h"
INCLUDES+=-DSDK_COMMIT_ID="0b37d01" -DWOLFSSL_BEKEN  -I./config -I./release -I./fixes
INCLUDES+=-I./os/FreeRTOSv9.0.0/FreeRTOS/Source/portable/Keil/ARM968es 
INCLUDES+=-I./os/FreeRTOSv9.0.0/FreeRTOS/Source/include  
INCLUDES+=-I./beken378/common -I./beken378/release 
INCLUDES+=-I./beken378/demo -I./beken378 
INCLUDES+=-I./beken378/app -I./beken378/app/config 
INCLUDES+=-I./beken378/app/standalone-station -I./beken378/app/standalone-ap 
INCLUDES+=-I./beken378/app/video_work -I./beken378/app/net_work 
INCLUDES+=-I./beken378/ip/common -I./beken378/ip/ke/ 
INCLUDES+=-I./beken378/ip/mac/ -I./beken378/ip/lmac/src/hal 
INCLUDES+=-I./beken378/ip/lmac/src/mm -I./beken378/ip/lmac/src/ps 
INCLUDES+=-I./beken378/ip/lmac/src/rd -I./beken378/ip/lmac/src/rwnx 
INCLUDES+=-I./beken378/ip/lmac/src/rx -I./beken378/ip/lmac/src/scan 
INCLUDES+=-I./beken378/ip/lmac/src/sta -I./beken378/ip/lmac/src/tx 
INCLUDES+=-I./beken378/ip/lmac/src/vif -I./beken378/ip/lmac/src/rx/rxl 
INCLUDES+=-I./beken378/ip/lmac/src/tx/txl -I./beken378/ip/lmac/src/p2p 
INCLUDES+=-I./beken378/ip/lmac/src/chan -I./beken378/ip/lmac/src/td 
INCLUDES+=-I./beken378/ip/lmac/src/tpc -I./beken378/ip/lmac/src/tdls 
INCLUDES+=-I./beken378/ip/umac/src/mesh -I./beken378/ip/umac/src/mfp 
INCLUDES+=-I./beken378/ip/umac/src/rc -I./beken378/ip/umac/src/apm 
INCLUDES+=-I./beken378/ip/umac/src/bam -I./beken378/ip/umac/src/ftm 
INCLUDES+=-I./beken378/ip/umac/src/llc -I./beken378/ip/umac/src/me 
INCLUDES+=-I./beken378/ip/umac/src/rxu -I./beken378/ip/umac/src/scanu 
INCLUDES+=-I./beken378/ip/umac/src/sm -I./beken378/ip/umac/src/txu 
INCLUDES+=-I./beken378/driver/include -I./beken378/driver/common/reg 
INCLUDES+=-I./beken378/driver/entry -I./beken378/driver/dma 
INCLUDES+=-I./beken378/driver/intc -I./beken378/driver/phy 
INCLUDES+=-I./beken378/driver/pwm -I./beken378/driver/rc_beken 
INCLUDES+=-I./beken378/driver/flash -I./beken378/driver/rw_pub 
INCLUDES+=-I./beken378/driver/common/reg -I./beken378/driver/common 
INCLUDES+=-I./beken378/driver/uart -I./beken378/driver/sys_ctrl 
INCLUDES+=-I./beken378/driver/gpio -I./beken378/driver/general_dma 
INCLUDES+=-I./beken378/driver/spidma -I./beken378/driver/icu 
INCLUDES+=-I./beken378/driver/i2c -I./beken378/driver/spi 
INCLUDES+=-I./beken378/driver/jpeg -I./beken378/driver/usb 
INCLUDES+=-I./beken378/func/include -I./beken378/func/ble_wifi_exchange 
INCLUDES+=-I./beken378/func/rf_test -I./beken378/func/user_driver 
INCLUDES+=-I./beken378/func/power_save -I./beken378/func/uart_debug 
INCLUDES+=-I./beken378/func/ethernet_intf -I./beken378/func/camera_intf 
INCLUDES+=-I./beken378/func/video_transfer -I./beken378/func/wpa_supplicant_2_9/hostapd 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/bk_patch 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/src/utils 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/src/ap 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/src/common 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/src/drivers 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/src 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/src/wps 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/wpa_supplicant 
INCLUDES+=-I./beken378/func/wpa_supplicant_2_9/bk_patch 
INCLUDES+=-I./beken378/func/lwip_intf/lwip-2.0.2/port 
INCLUDES+=-I./beken378/func/lwip_intf/lwip-2.0.2/src 
INCLUDES+=-I./beken378/func/lwip_intf/lwip-2.0.2/src/include 
INCLUDES+=-I./beken378/func/lwip_intf/lwip-2.0.2/src/include/netif 
INCLUDES+=-I./beken378/func/lwip_intf/lwip-2.0.2/src/include/lwip 
INCLUDES+=-I./beken378/func/temp_detect -I./beken378/func/spidma_intf 
INCLUDES+=-I./beken378/func/saradc_intf -I./beken378/func/rwnx_intf 
INCLUDES+=-I./beken378/func/joint_up -I./beken378/func/base64 
INCLUDES+=-I./beken378/func/easy_flash -I./beken378/func/easy_flash/inc 
INCLUDES+=-I./beken378/func/easy_flash/port -I./beken378/func/rf_use 
INCLUDES+=-I./beken378/func/usb -I./beken378/func/misc 
INCLUDES+=-I./beken378/func/sensor -I./beken378/os/include 
INCLUDES+=-I./beken378/os/FreeRTOSv9.0.0 -I./beken378/func/utf8 
INCLUDES+=-I./beken378/app/http -I./beken378/func/force_sleep 
INCLUDES+=-I./os/FreeRTOSv9.0.0/FreeRTOS/Source -I./beken378/func/paho-mqtt/client 
INCLUDES+=-I./beken378/func/paho-mqtt/client/src -I./beken378/func/paho-mqtt/packet/src 
INCLUDES+=-I./beken378/func/paho-mqtt/mqtt_ui -I./beken378/func/paho-mqtt/mqtt_ui/ssl_mqtt 
INCLUDES+=-I./beken378/func/paho-mqtt/mqtt_ui/tcp_mqtt -I./beken378/driver/ble/ble_5_2/arch/armv5 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/arch/armv5/compiler 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/arch/armv5/ll 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ahi/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/inc 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/src/gap/gapc 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/src/gap/gapm 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/src/gap 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/src/gatt 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/src/inc 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/hl/src/l2cap 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/iso/data_path 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/iso/data_path/isogen/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/iso/data_path/isogen/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/iso/data_path/isoohci/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/iso/data_path/isoohci/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/import/reg 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/src/llc 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/src/lld 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/src/lli 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/ble/ll/src/llm 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/em/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/hci/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/hci/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/sch/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/ip/sch/import 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/aes/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/aes/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/common/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/dbg/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/ecc_p256/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/h4tl/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/ke/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/ke/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/rwip/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/rwip/import/reg 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_lib/modules/rwip/src 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/app/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/bk_comm/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/bas/bass/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/hogp/ 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/hogp/hogpd/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/find/findt/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/dis/diss/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/profiles/bk_sdp/api 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/ble_pub/ui 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/platform/7238/config 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/platform/7238/driver/reg 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/platform/7238/driver/rf 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/platform/7238/driver/uart 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/platform/7238/entry 
INCLUDES+=-I./beken378/driver/ble/ble_5_2/platform/7238/nvds/api 
INCLUDES+=-I./beken378/driver/usb/include -I./beken378/driver/usb/include/class 
INCLUDES+=-I./beken378/driver/usb/src/cd -I./beken378/driver/usb/src/drivers/ 
INCLUDES+=-I./beken378/driver/usb/src/drivers/comm -I./beken378/driver/usb/src/drivers/hid 
INCLUDES+=-I./beken378/driver/usb/src/drivers/msd -I./beken378/driver/usb/src/drivers/compl 
INCLUDES+=-I./beken378/driver/usb/src/drivers/hub -I./beken378/driver/usb/src/drivers/trans 
INCLUDES+=-I./beken378/driver/usb/src/example/msd -I./beken378/driver/usb/src/hid 
INCLUDES+=-I./beken378/driver/usb/src/lib -I./beken378/driver/usb/src/msc 
INCLUDES+=-I./beken378/driver/usb/src/systems/none/afs 
INCLUDES+=-I./beken378/driver/usb/src/systems/none 
INCLUDES+=-I./beken378/driver/usb/src/uvc 
INCLUDES+=-I./beken378/func/mbedtls/mbedtls/include 
INCLUDES+=-I./beken378/func/mbedtls/mbedtls/include/mbedtls 
INCLUDES+=-I./beken378/func/mbedtls/mbedtls_ui/ 
INCLUDES+=-I./beken378/func/mbedtls/mbedtls-port/inc 
INCLUDES+=-I./beken378/func/ntp -I./beken378/func/rtc

LDFLAGS=-lble_pub -los -llwip -lmbedtls -ldriver -lfunc -lmisc \
	-lwpa -lrwnx_bk7238 -lsrc_s -lrf_use_bk7238 -lrf_test_bk7238 \
	-luart_debug_bk7238 -lsupplicant_bk7238 -lcal_bk7238 -lble_bk7238 -lbk_aware -lstdc++

CFLAGS=-c -g -mthumb -mcpu=arm968e-s -march=armv5te -mthumb-interwork -mlittle-endian \
	-Os -std=c99 -ffunction-sections -Wall -Wno-format -Wno-unknown-pragmas \
	-fsigned-char -fdata-sections -nostdlib -fno-strict-aliasing -DPLATFORM_BEKEN=1 -DPLATFORM_BK7238=1 \
	-DUSER_SW_VER='"$(APP_VERSION)"' -flto

CXXFLAGS=-c -mthumb -Os -fno-common -ffunction-sections -fdata-sections --specs=nosys.specs \
	--specs=nano.specs -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wall \
	-Wstack-usage=8192 -Wextra -Wunreachable-code -Wvla -Wformat -Wformat-nonliteral \
	-Wformat-security -Wno-deprecated-declarations -Wno-unknown-warning-option -Wno-maybe-uninitialized \
	-Wno-missing-field-initializers -Wno-unused-parameter -Wno-psabi -Wno-cast-function-type \
	-fno-strict-aliasing -std=gnu++14 -fno-rtti -Wnon-virtual-dtor -mthumb -mcpu=arm968e-s -mthumb-interwork \
	-mlittle-endian -march=armv5te -Wno-conversion -Os -Wno-sign-compare -Wno-unused-function \
	-Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-parameter -Wno-literal-suffix \
	-Wno-write-strings -Wno-error=format -DPLATFORM_BEKEN=1 -DPLATFORM_BK7238=1 -DUSER_SW_VER='"$(APP_VERSION)"' -flto

#SFLAGS=-g -marm -mthumb-interwork -mcpu=arm968e-s -march=armv5te -x assembler-with-cpp

SRC_DIRS += $(shell find $(OBK_DIR) -type d)

SRC_C += $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.c))
SRC_C += $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.s)) 
SRC_C += $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.S)) 
SRC_CPP += $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.cpp)) 

SRC_C += ./fixes/mqtt.c

SRC_O = $(patsubst %.c,%.o,$(SRC_C))
SRC_CPP_O = $(patsubst %.cpp,%.o,$(SRC_CPP))

SRC_C_LIST = $(notdir $(SRC_C))
SRC_CPP_LIST = $(notdir $(SRC_CPP)) 
OBJ_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.o,$(SRC_C_LIST)))
OBJ_CPP_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.cpp,%.o,$(SRC_CPP_LIST)))

.PHONY: application
test_target: prerequirement $(SRC_O) $(SRC_CPP_O)

application: test_target
	$(CC) -o $(OUT_DIR)/$(APP_BIN_NAME)_$(APP_VERSION).elf -L./beken378/lib \
	-u user_main -g -Wl,--gc-sections -marm -mcpu=arm968e-s -mthumb-interwork -nostdlib -flto  \
	-Xlinker -Map=$(OUT_DIR)/$(APP_BIN_NAME)_$(APP_VERSION).map -Wl,-wrap,malloc -Wl,-wrap,_malloc_r \
	-Wl,-wrap,free -Wl,-wrap,_free_r \
	-Wl,-wrap,zalloc -Wl,-wrap,calloc -Wl,-wrap,realloc  -Wl,-wrap,_realloc_r -Wl,-wrap,printf \
	-Wl,-wrap,vsnprintf -Wl,-wrap,snprintf -Wl,-wrap,sprintf -Wl,-wrap,puts -Wl,-wrap,strnlen \
	-Wl,-wrap,__assert_func -Wl,-wrap,strtod -Wl,-wrap,qsort -Wl,-wrap,sscanf -Wl,-wrap,__errno \
	-Wl,-wrap,rand -Wl,-wrap,srand -Wl,-wrap,strtol -Wl,-wrap,strtoul -Wl,-wrap,strtoll \
	-Wl,-wrap,strtoull -Wl,-wrap,pow -Wl,-wrap,exp -Wl,-wrap,log \
	-Wl,--start-group $(OBJ_LIST) $(OBJ_CPP_LIST) \
	-lble_pub -los -llwip -lmbedtls -ldriver -lfunc -lmisc -lwpa -lrwnx_bk7238 -lsrc_s \
	-lrf_use_bk7238 -lrf_test_bk7238  -luart_debug_bk7238 -lsupplicant_bk7238 -lcal_bk7238 -lble_bk7238 -lbk_aware -lstdc++ \
	-lg_nano -Wl,--end-group -T./build/bk72xx_bsp.lds \
	-Xlinker -Map=$(OUT_DIR)/$(APP_BIN_NAME)_$(APP_VERSION).map

	$(OP) --strip-unneeded -O binary $(OUT_DIR)/$(APP_BIN_NAME)_$(APP_VERSION).elf $(OUT_DIR)/$(APP_BIN_NAME)_$(APP_VERSION).bin

.PHONY: prerequirement
prerequirement:
	echo prerequirement0
	@echo ===========================================================
	@echo Build $(APP_BIN_NAME)
	@echo ===========================================================
	echo prerequirement1
	mkdir -p $(OBJ_DIR)
	mkdir -p $(BIN_DIR)
	echo prerequirement2
	
	@mkdir -p $(OUT_DIR)

$(SRC_O): %.o : %.c
	@ echo "build_c $@"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -MM -MT $@ -MF $(OBJ_DIR)/$(notdir $(patsubst %.o,%.d,$@))
	@cp $@ $(OBJ_DIR)/$(notdir $@)
	@chmod 777 $(OBJ_DIR)/$(notdir $@)

$(SRC_CPP_O): %.o : %.cpp
	@ echo "build_cpp $@"
	@$(CC) $(CXXFLAGS) $(INCLUDES) -c $< -o $@
	@$(CC) $(CXXFLAGS) $(INCLUDES) -c $< -MM -MT $@ -MF $(OBJ_DIR)/$(notdir $(patsubst %.o,%.d,$@))
	@cp $@ $(OBJ_DIR)/$(notdir $@)
	@chmod 777 $(OBJ_DIR)/$(notdir $@)

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)
	rm -f $(SRC_O)
	rm -f $(SRC_CPP_O)