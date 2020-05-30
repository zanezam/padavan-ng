include $(ROOTDIR)/user/shared/board.mk

KERNELZ		= $(IMAGEDIR)/zImage
RAMDISK		= $(IMAGEDIR)/ramdisk
ifdef FIRMWARE_BUILDS_REV
IMAGE_BASE	= $(IMAGEDIR)/$(CONFIG_FIRMWARE_PRODUCT_ID)_$(FIRMWARE_KERNEL_VER).$(FIRMWARE_ROOTFS_VER)-$(FIRMWARE_BUILDS_VER)-$(FIRMWARE_BUILDS_REV)_$(CONFIG_TEMPLATE)
else
IMAGE_BASE	= $(IMAGEDIR)/$(CONFIG_FIRMWARE_PRODUCT_ID)_$(FIRMWARE_KERNEL_VER).$(FIRMWARE_ROOTFS_VER)-$(FIRMWARE_BUILDS_VER)_$(CONFIG_TEMPLATE)
endif
ROMFS_DIR	= $(ROOTDIR)/romfs
TOOLS_DIR	:= $(ROOTDIR)/tools
CUR_DIR		= $(shell pwd)
COMP		= lzma
ifneq (,$(filter y,$(CONFIG_MTD_NAND_RALINK) $(CONFIG_MTD_NAND_MTK)))
PART_ALIGN	= 131072
else
PART_ALIGN	= 16
endif
ROMFS_DIRS	= \
	bin \
	dev dev/pts \
	home \
	etc \
	etc_ro etc_ro/ppp/peers etc_ro/ppp/plugins etc_ro/ppp/3g \
		etc_ro/Wireless etc_ro/Wireless \
	lib lib/modules \
	mnt \
	media \
	opt \
	proc \
	sbin \
	sys \
	usr usr/bin usr/sbin usr/lib/pppd usr/codepages \
	tmp \
	var

#########################################################################################################################
# Dir per system options
#
ifneq ($(CONFIG_KERNEL_START_ADDR),)
ENTRYPOINT	:= $(CONFIG_KERNEL_START_ADDR)
else
ifdef CONFIG_RALINK_MT7621
ENTRYPOINT	:= 80001000
else
ENTRYPOINT	:= 80000000
endif
endif
export ENTRYPOINT
#########################################################################################################################

romfs:
	[ -d $(ROMFSDIR)/$$i ] || mkdir -p $(ROMFSDIR)
	for i in $(ROMFS_DIRS); do \
		[ -d $(ROMFSDIR)/$$i ] || mkdir -p $(ROMFSDIR)/$$i; \
	done
	for i in `ls $(BOARDDIR)/SingleSKU*.dat` ; do \
		[ -f $$i ] && cp -f $$i $(ROMFSDIR)/etc_ro/Wireless; \
	done
########### INSTALL LIBGCC_S.SO NEEDED FOR UCLIBC-NG ########
	$(ROMFSINST) $(CONFIG_CROSS_COMPILER_ROOT)/mipsel-linux-uclibc/sysroot/lib/libgcc_s.so.1 /lib/libgcc_s.so.1
################# IF MAIN CPU IS MT7620 #####################
ifdef CONFIG_RALINK_MT7620
ifneq (,$(filter $(CONFIG_RT_FIRST_CARD),7620 2860))
ifeq ($(CONFIG_EXTERNAL_PA_EXTERNAL_LNA),y)
	$(ROMFSINST) MT7620_AP_2T2R-4L_external_LNA_external_PA_V15.bin /etc_ro/Wireless/MT7620_AP_2T2R-4L_V15.bin
else
ifeq ($(CONFIG_INTERNAL_PA_EXTERNAL_LNA),y)
	$(ROMFSINST) MT7620_AP_2T2R-4L_external_LNA_internal_PA_V15.bin /etc_ro/Wireless/MT7620_AP_2T2R-4L_V15.bin
else
	$(ROMFSINST) MT7620_AP_2T2R-4L_internal_LNA_internal_PA_V15.bin /etc_ro/Wireless/MT7620_AP_2T2R-4L_V15.bin
endif
endif
endif
endif
################# IF MAIN CPU IS MT7628 #####################
ifdef CONFIG_RALINK_MT7628
ifeq ($(CONFIG_RT_FIRST_CARD),7628)
	$(ROMFSINST) /etc_ro/Wireless/MT7628_EEPROM.bin
endif
endif
################# IF MAIN CPU IS RT3883 #####################
ifdef CONFIG_RALINK_RT3883
ifeq ($(CONFIG_RALINK_RT3883_3T3R),y)
	$(ROMFSINST) /etc_ro/Wireless/RT3883_AP_3T3R_V0_1.bin
else
	$(ROMFSINST) /etc_ro/Wireless/RT3662_AP_2T2R_V0_0.bin
endif
ifdef CONFIG_RT3090_AP
	$(ROMFSINST) /etc_ro/Wireless/RT3092_PCIe_LNA_2T2R_ALC_V1_2.bin
endif
ifdef CONFIG_RT3352_INIC_MII
	mkdir -p $(ROMFSDIR)/iNIC_RT3352
	$(ROMFSINST) /iNIC_RT3352/iNIC_ap.bin
endif
endif
###############################################################
ifeq ($(CONFIG_RALINK_RT3050_1T1R),y)
	$(ROMFSINST) /etc_ro/Wireless/RT3050_AP_1T1R_V1_0.bin
endif
ifeq ($(CONFIG_RALINK_RT3051_1T2R),y)
	$(ROMFSINST) /etc_ro/Wireless/RT3051_AP_1T2R_V1_0.bin
endif
ifeq ($(CONFIG_RALINK_RT3052_2T2R),y)
	$(ROMFSINST) /etc_ro/Wireless/RT3052_AP_2T2R_V1_1.bin
endif
ifeq ($(CONFIG_RALINK_RT5350_1T1R),y)
	$(ROMFSINST) /etc_ro/Wireless/RT5350_AP_1T1R_V1_0.bin
endif
ifeq ($(CONFIG_RALINK_RT3352_2T2R),y)
ifeq ($(CONFIG_RT2860V2_AP_RTMP_INTERNAL_TX_ALC),y)
	$(ROMFSINST) RT3352_AP_2T2R_V11.bin /etc_ro/Wireless/RT3352_AP_2T2R-4L_V12.BIN
else
	$(ROMFSINST) RT3352_AP_2T2R-1LNA_V12.bin /etc_ro/Wireless/RT3352_AP_2T2R-4L_V12.BIN
endif
endif
ifdef CONFIG_RT5592_AP
ifeq ($(CONFIG_RT5592_AP_EP_SUPPORT),y)
	$(ROMFSINST) /etc_ro/Wireless/RT5592EP_PCIe_2T2R_5G_V1_4.bin
else
	$(ROMFSINST) /etc_ro/Wireless/RT5592_PCIe_2T2R_V1_7.bin
endif
endif
ifdef CONFIG_MT7610_AP
	$(ROMFSINST) /etc_ro/Wireless/MT7610E-V10-FEM.bin
endif
ifdef CONFIG_MT76X2_AP
ifeq ($(CONFIG_RT_FIRST_CARD),7602)
	$(ROMFSINST) /etc_ro/Wireless/MT7602E_EEPROM.bin
else
ifeq ($(CONFIG_RT_SECOND_CARD),7602)
	$(ROMFSINST) /etc_ro/Wireless/MT7602E_EEPROM.bin
endif
endif
ifeq ($(CONFIG_RT_FIRST_CARD),7612)
	$(ROMFSINST) /etc_ro/Wireless/MT7612E_EEPROM.bin
else
ifeq ($(CONFIG_RT_SECOND_CARD),7612)
	$(ROMFSINST) /etc_ro/Wireless/MT7612E_EEPROM.bin
endif
endif
endif
ifdef CONFIG_MT76X3_AP
	$(ROMFSINST) /etc_ro/Wireless/MT7603E_EEPROM.bin
endif

romfs.post::
	[ -d $(IMAGEDIR) ] || mkdir -p $(IMAGEDIR)
	sudo /sbin/ldconfig -r $(ROMFSDIR) -C /etc_ro/ld.so.cache
	rm -f $(RAMDISK)
	rm -f $(KERNELZ).lzma
	$(TOOLS_DIR)/mksquashfs_xz/mksquashfs $(ROMFSDIR) $(RAMDISK) -all-root -no-exports -noappend -nopad -noI -no-xattrs

image:
	##############CREATE IMAGE#################
	$(CROSS_COMPILE)objcopy -O binary -R .note -R .comment -S $(ROOTDIR)/$(LINUXDIR)/vmlinux $(KERNELZ)
	cd $(IMAGEDIR) ; rm -f $(KERNELZ).*; \
	$(TOOLS_DIR)/lzma/lzma e -a1 -d25 $(KERNELZ) $(KERNELZ).$(COMP)
ifeq ($(CONFIG_BLK_DEV_INITRD),)
	@SIZE=`wc -c $(KERNELZ).$(COMP) | awk '{ print $$1 }'` ; \
	SIZE=`expr $$SIZE + 64` ; \
	DIV=`expr $$SIZE % $(PART_ALIGN)` ; \
	if [ $$DIV -gt 0 ] ; then \
		PAD=`expr $(PART_ALIGN) - $$DIV` ; \
		dd if=/dev/zero count=1 bs=$$PAD conv=sync 2> /dev/null | tr \\000 \\377 >> $(KERNELZ).$(COMP) ; \
	fi
	# Padded Kernel Image Size
	@wc -c $(KERNELZ).$(COMP)
	# Original RootFs Size
	@du -sb $(ROMFSDIR)
	# Compressed RootFs Size
	@wc -c $(RAMDISK)
ifeq ($(TPLINK_HWID),)
	# Padded Kernel Image + Compressed Rootfs Size
	@cat $(RAMDISK) >> $(KERNELZ).$(COMP)
	@wc -c $(KERNELZ).$(COMP)
endif
	#===========================================
endif
	# Pack final image and write headers
ifeq ($(TPLINK_HWID),)
	@cd $(IMAGEDIR) ; \
	ENTRY=`LANG=C LC_ALL=C readelf -h $(ROOTDIR)/$(LINUXDIR)/vmlinux | grep "Entry" | awk '{print $$4}'` ; \
	ISIZE=`wc -c $(KERNELZ).$(COMP) | awk '{print $$1}'` ; \
	RSIZE=`wc -c $(RAMDISK) | awk '{print $$1}'` ; \
	KRN_SIZE=`expr $$ISIZE - $$RSIZE + 64` ; \
	$(TOOLS_DIR)/mkimage/mkimage -A mips -O linux -T kernel -C $(COMP) -a $(ENTRYPOINT) -e $$ENTRY -k $$KRN_SIZE \
	-n $(CONFIG_FIRMWARE_PRODUCT_ID) -V $(FIRMWARE_KERNEL_VER) $(FIRMWARE_ROOTFS_VER) -d $(KERNELZ).$(COMP) $(IMAGE_BASE).trx ; \
	echo "#===========================================\nFirmware size: $$(stat -c %s $(IMAGE_BASE).trx)"
else
	@cd $(IMAGEDIR) ; \
	ENTRY=`LANG=C LC_ALL=C readelf -h $(ROOTDIR)/$(LINUXDIR)/vmlinux | grep "Entry" | awk '{print $$4}'` ; \
	$(TOOLS_DIR)/mktplinkfw/mktplinkfw2 -L $(ENTRYPOINT) -E $$ENTRY -H $(TPLINK_HWID) -W $(TPLINK_HWREV) \
	-w $(TPLINK_HWREVADD) -F "$(TPLINK_FLASHLAYOUT)" -T $(TPLINK_HVERSION) -V "ver. 2.0" -a 0x4 -j \
	-k $(KERNELZ).$(COMP) -r $(RAMDISK) -o $(IMAGE_BASE).bin -s -e ; \
	echo "#===========================================\nFirmware size: $$(stat -c %s $(IMAGE_BASE).bin)"
endif
	@echo "Firmware max allowed size: $(FIRMWARE_MAXSIZE)\n"

clean:
	rm -f $(RAMDISK)
