#!/bin/bash

# For OpenWrt 21.02 or lower version
# You have to manually upgrade Golang toolchain to 1.18 or higher to compile Xray-core.
# ./scripts/feeds update packages
# rm -rf feeds/packages/lang/golang
# svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang feeds/packages/lang/golang

# change default lan address and hostname
# verified to be working
sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/Home/g' package/base-files/files/bin/config_generate
sed -i 's/\+shellsync//' package/network/services/ppp/Makefile
sed -i 's/\+kmod-mppe//' package/network/services/ppp/Makefile
sed -i 's/"ShadowSocksR Plus+"/"SSRP+"/'  feeds/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua

# disable and remove wireless
sed -i 's/\+libiwinfo-lua//' feeds/luci/collections/luci/Makefile
sed -i 's/iwinfo//' feeds/luci/modules/luci-mod-admin-full/Makefile
sed -i 's/wpad-openssl//' target/linux/ramips/mt7621/target.mk

curl --retry 3 -s --globoff "https://gist.githubusercontent.com/1-1-2/335dbc8e138f39fb8fe6243d424fe476/raw/328209ec5bf504b39133ce4dcec918baf466970c/mt7621_jdcloud_re-sp-01b.dts" -o target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
sed -i '/Device\/adslr_g7/i\define Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 32448k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := lsblk block-mount e2fsprogs fdisk kmod-fs-ext4 kmod-sdhci-mt7620 kmod-usb3\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b\n\n' target/linux/ramips/image/mt7621.mk
sed -i -e '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' -e '/ramips_setup_macs/,/}/{/ampedwireless,ally-00x19k/i\        jdcloud,re-sp-01b)\n\t\tlan_mac=$(mtd_get_mac_ascii u-boot-env mac)\n\t\twan_mac=$(macaddr_add "$lan_mac" 1)\n\t\tlabel_mac=$lan_mac\n\t\t;;
    }' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i 's#key"'\''=//p'\''#& \| head -n1#' package/base-files/files/lib/functions/system.sh

# Add package needed
sed -i -e '59s/ddns-scripts_aliyun ddns-scripts_dnspod/ddns-scripts_cloudflare.com-v4 luci-ssl-openssl luci-app-udpxy luci-app-acme acme-dnsapi acme-deploy acme-notify luci-proto-wireguard luci-app-wireguard luci-app-samba4 nano htop curl/'  include/target.mk
# Add nfs/emmc/upgrade
sed -i -e '60s/luci-app-arpbind luci-app-filetransfer luci-app-vsftpd/nfs-utils kmod-fs-nfs kmod-fs-nfs-v4 kmod-fs-nfs-v3 nfs-kernel-server kmod-loop/' include/target.mk
# remove packages not needed
sed -i -e '61s/luci-app-nlbwmon/luci-app-nfs luci-app-serverchan/' include/target.mk