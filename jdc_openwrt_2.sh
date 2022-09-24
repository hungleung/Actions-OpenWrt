#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm
#=================================================

# mkdir -p package/helloworld
for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt" "redsocks2"; do \
  svn checkout "https://github.com/immortalwrt/packages/trunk/net/$i" "package/helloworld/$i"; \
done

#1. Modify default IP
sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate

# 修改主机名为 JDC_Mark1
sed -i 's/OpenWrt/Home/g' package/base-files/files/bin/config_generate
sed -i 's/\+libiwinfo-lua//' feeds/luci/collections/luci/Makefile
sed -i 's/wpad-basic-wolfssl//' target/linux/ramips/mt7621/target.mk

#2. Clear the login password
#sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

#3. Replace with JerryKuKu’s Argon
#rm openwrt/package/lean/luci-theme-argon -rf

# load dts
# echo '载入 mt7621_jdcloud_re-sp-01b.dts'
curl --retry 3 -s --globoff "https://gist.githubusercontent.com/1-1-2/335dbc8e138f39fb8fe6243d424fe476/raw/[lean's%20lede]mt7621_jdcloud_re-sp-01b.dts" -o target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
# ls -l target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts

# fix2 + fix4.2
# echo '修补 mt7621.mk'
sed -i '/Device\/adslr_g7/i\define Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 32448k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := lsblk block-mount kmod-fs-ext4 e2fsprogs fdisk kmod-sdhci-mt7620\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b\n\n' target/linux/ramips/image/mt7621.mk

# fix3 + fix5.2
# echo '修补 02-network'
sed -i -e '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' -e '/ramips_setup_macs/,/}/{/ampedwireless,ally-00x19k/i\        jdcloud,re-sp-01b)\n\t\tlan_mac=$(mtd_get_mac_ascii u-boot-env mac)\n\t\twan_mac=$(macaddr_add "$lan_mac" 1)\n\t\tlabel_mac=$lan_mac\n\t\t;;
}' target/linux/ramips/mt7621/base-files/etc/board.d/02_network

# fix5.1
# echo '修补 system.sh 以正常读写 MAC'
sed -i 's#key"'\''=//p'\''#& \| head -n1#' package/base-files/files/lib/functions/system.sh

sed -i -e 's/dnsmasq/luci-app-ssr-plus/' -e 's/odhcp6c/luci-app-vlmcsd/' -e 's/odhcpd-ipv6only/luci-app-upnp luci-app-udpxy/' include/target.mk
