DEVICE_VARS += TPLINK_SUPPORT_STRING

define Build/wax610-netgear-tar
	mkdir $@.tmp
	mv $@ $@.tmp/nand-ipq6018-apps.img
	md5sum $@.tmp/nand-ipq6018-apps.img | cut -c 1-32 > $@.tmp/nand-ipq6018-apps.md5sum
	echo "WAX610" > $@.tmp/metadata.txt
	echo "WAX610-610Y_V99.9.9.9" > $@.tmp/version
	tar -C $@.tmp/ -cf $@ .
	rm -rf $@.tmp
endef

define Device/8devices_mango-dvk
	$(call Device/FitImageLzma)
	DEVICE_VENDOR := 8devices
	DEVICE_MODEL := Mango-DVK
	IMAGE_SIZE := 27776k
	BLOCKSIZE := 64k
	SOC := ipq6010
	SUPPORTED_DEVICES += 8devices,mango
	IMAGE/sysupgrade.bin := append-kernel | pad-to 64k | append-rootfs | pad-rootfs | check-size | append-metadata
	DEVICE_PACKAGES := ipq-wifi-8devices_mango
endef
TARGET_DEVICES += 8devices_mango-dvk

define Device/alfa-network_ap120c-ax
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := ALFA Network
	DEVICE_MODEL := AP120C-AX
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-alfa-network_ap120c-ax
endef
TARGET_DEVICES += alfa-network_ap120c-ax

define Device/cambiumnetworks_xe3-4
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Cambium Networks
	DEVICE_MODEL := XE3-4
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp01-c3-xv3-4
	DEVICE_PACKAGES := ipq-wifi-cambiumnetworks_xe34 ath11k-firmware-qcn9074
endef
TARGET_DEVICES += cambiumnetworks_xe3-4

define Device/kt_ar06-012h
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := KT
	DEVICE_MODEL := AR06-012H
	DEVICE_DTS := ipq6000-kt-ar06-012h
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-kt_ar06-012h
endef
TARGET_DEVICES += kt_ar06-012h

define Device/lg_gapd-7500
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := LG
	DEVICE_MODEL := GAPD-7500
  DEVICE_DTS := ipq6000-lg-gapd-7500
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-lg_gapd-7500 kmod-switch-rtl8367b
endef
TARGET_DEVICES += lg_gapd-7500

define Device/glinet_gl-common
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := GL.iNet
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	IMAGES += factory.bin
	IMAGE/factory.bin := append-ubi | append-gl-metadata
endef

define Device/glinet_gl-ax1800
	$(call Device/glinet_gl-common)
	DEVICE_MODEL := GL-AX1800
	DEVICE_PACKAGES := ipq-wifi-glinet_gl-ax1800
	SUPPORTED_DEVICES += glinet,ax1800
endef
TARGET_DEVICES += glinet_gl-ax1800

define Device/glinet_gl-axt1800
	$(call Device/glinet_gl-common)
	DEVICE_MODEL := GL-AXT1800
	DEVICE_PACKAGES := ipq-wifi-glinet_gl-axt1800 kmod-hwmon-pwmfan
	SUPPORTED_DEVICES += glinet,axt1800
endef
TARGET_DEVICES += glinet_gl-axt1800

define Device/linksys_mr
	$(call Device/FitImage)
	DEVICE_VENDOR := Linksys
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	KERNEL_SIZE := 8192k
	IMAGES += factory.bin
	IMAGE/factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-ubi | linksys-image type=$$$$(DEVICE_MODEL)
	DEVICE_PACKAGE := kmod-usb-ledtrig-usbport
endef

define Device/linksys_mr7350
	$(call Device/linksys_mr)
	DEVICE_MODEL := MR7350
	SOC := ipq6000
	NAND_SIZE := 256m
	IMAGE_SIZE := 75776k
	DEVICE_PACKAGES += ipq-wifi-linksys_mr7350 kmod-leds-pca963x
endef
TARGET_DEVICES += linksys_mr7350

define Device/linksys_mr7500
	$(call Device/linksys_mr)
	DEVICE_MODEL := MR7500
	SOC := ipq6010
	NAND_SIZE := 512m
	IMAGE_SIZE := 147456k
	DEVICE_PACKAGES += ipq-wifi-linksys_mr7500 ath11k-firmware-qcn9074
endef
TARGET_DEVICES += linksys_mr7500

define Device/netgear_wax214
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Netgear
	DEVICE_MODEL := WAX214
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-netgear_wax214
endef
TARGET_DEVICES += netgear_wax214

define Device/netgear_wax610-common
	$(call Device/FitImage)
	DEVICE_VENDOR := Netgear
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp03-c1
	KERNEL_IN_UBI := 1
	IMAGES += ui-factory.tar
	IMAGE/ui-factory.tar := append-ubi | qsdk-ipq-factory-nand | pad-to 4096 | wax610-netgear-tar
endef

define Device/netgear_wax610
	$(Device/netgear_wax610-common)
	DEVICE_MODEL := WAX610
	DEVICE_PACKAGES := ipq-wifi-netgear_wax610
endef
TARGET_DEVICES += netgear_wax610

define Device/netgear_wax610y
	$(Device/netgear_wax610-common)
	DEVICE_MODEL := WAX610Y
	DEVICE_PACKAGES := ipq-wifi-netgear_wax610y
endef
TARGET_DEVICES += netgear_wax610y

define Device/qihoo_360v6
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Qihoo
	DEVICE_MODEL := 360V6
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-qihoo_360v6
endef
TARGET_DEVICES += qihoo_360v6

define Device/tplink_eap6xx-common
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := TP-Link
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := kmod-phy-realtek
	IMAGES += web-ui-factory.bin
	IMAGE/web-ui-factory.bin := append-ubi | tplink-image-2022
endef

define Device/tplink_eap610od
	$(call Device/tplink_eap6xx-common)
	DEVICE_MODEL := EAP610-Outdoor
	DEVICE_PACKAGES += ipq-wifi-tplink_eap610od
	TPLINK_SUPPORT_STRING := SupportList:\r\n \
		EAP610-Outdoor(TP-Link|UN|AX1800-D):1.0\r\n \
		EAP610-Outdoor(TP-Link|JP|AX1800-D):1.0\r\n \
		EAP610-Outdoor(TP-Link|CA|AX1800-D):1.0
endef
TARGET_DEVICES += tplink_eap610od

define Device/tplink_eap623od-hd-v1
	$(call Device/tplink_eap6xx-common)
	DEVICE_MODEL := EAP623-Outdoor HD
	DEVICE_VARIANT := v1
	DEVICE_PACKAGES += ipq-wifi-tplink_eap623od-hd-v1
	TPLINK_SUPPORT_STRING := SupportList:\r\n \
		EAP623-Outdoor HD(TP-Link|UN|AX1800-D):1.0
endef
TARGET_DEVICES += tplink_eap623od-hd-v1

define Device/tplink_eap625od-hd-v1
	$(call Device/tplink_eap6xx-common)
	DEVICE_MODEL := EAP625-Outdoor HD
	DEVICE_VARIANT := v1
	DEVICE_PACKAGES += ipq-wifi-tplink_eap625od-hd-v1
	TPLINK_SUPPORT_STRING := SupportList:\r\n \
		EAP625-Outdoor HD(TP-Link|UN|AX1800-D):1.0\r\n \
		EAP625-Outdoor HD(TP-Link|CA|AX1800-D):1.0\r\n \
		EAP625-Outdoor HD(TP-Link|AU|AX1800-D):1.0\r\n \
		EAP625-Outdoor HD(TP-Link|KR|AX1800-D):1.0
endef
TARGET_DEVICES += tplink_eap625od-hd-v1

define Device/yuncore_fap650
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Yuncore
	DEVICE_MODEL := FAP650
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-yuncore_fap650
	IMAGES := factory.ubi factory.ubin sysupgrade.bin
	IMAGE/factory.ubin := append-ubi | qsdk-ipq-factory-nand
endef
TARGET_DEVICES += yuncore_fap650

define Device/anysafe_e1
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := AnySafe
	DEVICE_MODEL := E1
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp01-c3
	DEVICE_PACKAGES := ipq-wifi-anysafe_e1 ath11k-firmware-qcn9074 kmod-hwmon-pwmfan
endef
TARGET_DEVICES += anysafe_e1

define Device/cmiot_ax18
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := CMIOT
	DEVICE_MODEL := AX18
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-cmiot_ax18
endef
TARGET_DEVICES += cmiot_ax18

define Device/redmi_ax5
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Redmi
	DEVICE_MODEL := AX5
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-redmi_ax5
endef
TARGET_DEVICES += redmi_ax5

define Device/xiaomi_ax1800
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Xiaomi
	DEVICE_MODEL := AX1800
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-xiaomi_ax1800
endef
TARGET_DEVICES += xiaomi_ax1800

define Device/zn_m2
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := ZN
	DEVICE_MODEL := M2
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-zn_m2
endef
TARGET_DEVICES += zn_m2

define Device/redmi_ax5-jdcloud
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	DEVICE_VENDOR := Redmi
	DEVICE_MODEL := AX5 JDCloud
	KERNEL_SIZE := 6144k
	BLOCKSIZE := 128k
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-redmi_ax5-jdcloud
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | append-metadata
endef
TARGET_DEVICES += redmi_ax5-jdcloud

define Device/link_nn6000-v1
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	DEVICE_VENDOR := Link
	DEVICE_MODEL := NN6000 v1
	KERNEL_SIZE := 6144k
	BLOCKSIZE := 128k
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-link_nn6000
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | append-metadata
endef
TARGET_DEVICES += link_nn6000-v1

define Device/link_nn6000-v2
	$(Device/link_nn6000-v1)
	DEVICE_MODEL := NN6000 v2
endef
TARGET_DEVICES += link_nn6000-v2

define Device/jdcloud_re-ss-01
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	DEVICE_VENDOR := JDCloud
	DEVICE_MODEL := RE-SS-01
	KERNEL_SIZE := 6144k
	BLOCKSIZE := 128k
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c2
	DEVICE_PACKAGES := ipq-wifi-jdcloud_re-ss-01
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | append-metadata
endef
TARGET_DEVICES += jdcloud_re-ss-01

define Device/jdcloud_re-cs-02
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	DEVICE_VENDOR := JDCloud
	DEVICE_MODEL := RE-CS-02
	KERNEL_SIZE := 6144k
	BLOCKSIZE := 128k
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp03-c3
	DEVICE_PACKAGES := ipq-wifi-jdcloud_re-cs-02 ath11k-firmware-qcn9074
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | append-metadata
endef
TARGET_DEVICES += jdcloud_re-cs-02

define Device/jdcloud_re-cs-07
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	DEVICE_VENDOR := JDCloud
	DEVICE_MODEL := RE-CS-07
	KERNEL_SIZE := 6144k
	BLOCKSIZE := 128k
	SOC := ipq6010
	DEVICE_DTS_CONFIG := config@cp03-c4
	DEVICE_PACKAGES := -ath11k-firmware-ipq6018 -ath11k-firmware-qcn9074 -kmod-ath11k -kmod-ath11k-ahb -kmod-ath11k-pci -hostapd-common -wpad-openssl
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | append-metadata
endef
TARGET_DEVICES += jdcloud_re-cs-07
