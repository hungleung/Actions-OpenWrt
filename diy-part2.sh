#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.88.3/g' package/base-files/files/bin/config_generate

# Default packages - the really basic set
# kmod-fs-f2fs solve the issue that settings can not be saved
sed -i '59s/ddns-scripts_aliyun ddns-scripts_dnspod/htop msd_lite/' include/target.mk
sed -i '60s/luci-app-ssr-plus/luci-ssl-openssl luci-app-udpxy luci-app-acme acme-dnsapi/' include/target.mk

sed -i '20s/kmod-mmc kmod-sdhci //' target/linux/x86/Makefile
sed -i '21s/kmod-atlantic kmod-bnx2x kmod-i40e kmod-i40evf kmod-iavf kmod-igb kmod-igbvf kmod-igc kmod-e1000e kmod-pcnet32 kmod-tulip kmod-via-velocity kmod-vmxnet3/kmod-e1000e/' target/linux/x86/Makefile
sed -i '22s/kmod-sound-hda-core kmod-sound-hda-codec-realtek kmod-sound-hda-codec-via kmod-sound-via82xx kmod-sound-hda-intel kmod-sound-hda-codec-hdmi kmod-sound-i8x0/curl/' target/linux/x86/Makefile
sed -i '23s/kmod-usb-net kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8150 kmod-usb-net-aqc111/bind-dig/' target/linux/x86/Makefile
sed -i '24s/kmod-usb-net-rtl8152-vendor/kmod-fs-f2fs/' target/linux/x86/Makefile

# vhd
# sed -i '273s/n/y/' config/Config-images.in
# sed -i '272d' config/Config-images.in
# sed -i '265s/y/n/' config/Config-images.in
# sed -i '205s/n/y/' config/Config-images.in
# sed -i '82s/n/y/' config/Config-images.in

# cancel shellsync
# sed -i '41s/+shellsync //' package/network/services/ppp/Makefile
