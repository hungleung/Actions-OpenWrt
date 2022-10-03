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

# disable wireless components
sed -i 's/\+libiwinfo-lua//' feeds/luci/collections/luci/Makefile
sed -i 's/\+libiwinfo//' feeds/luci/modules/luci-mod-dashboard/Makefile
sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-battstatus/Makefile
sed -i 's/\+rpcd-mod-iwinfo//' feeds/luci/modules/luci-mod-battstatus/Makefile
sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-network/Makefile
sed -i 's/\+rpcd-mod-iwinfo//' feeds/luci/modules/luci-mod-network/Makefile
sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-status/Makefile
sed -i 's/\+libiwinfo//' feeds/luci/modules/luci-mod-status/Makefile
sed -i 's/wpad-basic-openssl//' target/linux/ramips/mt7621/target.mk

# disable multi pppoe
# sed -i -e 's/\+libpthread//' package/network/services/ppp/Makefile
sed -i 's/\+shellsync//' package/network/services/ppp/Makefile
sed -i 's/\+kmod-mppe//' package/network/services/ppp/Makefile

# change menu title
sed -i 's/"title": "udpxy",/"title": "IPTV",/' feeds/luci/applications/luci-app-udpxy/root/usr/share/luci/menu.d/luci-app-udpxy.json
sed -i 's/"ShadowSocksR Plus+"/"SSRP+"/'  feeds/luci/applications/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua

# change default firmware size and package
sed -i '95,105d' target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
sed -i -e 's/27328k/32448k/' -e 's/kmod-fs-ext4 kmod-mt7603 kmod-mt7615e/lsblk kmod-fs-ext4 e2fsprogs fdisk/' -e 's/kmod-mt7615-firmware kmod-sdhci-mt7620 kmod-usb3/kmod-sdhci-mt7620/' target/linux/ramips/image/mt7621.mk

# change default package
sed -i 's/luci-app-filetransfer/luci-app-udpxy luci-app-ssr-plus luci-app-vlmcsd luci-app-upnp luci-app-wireguard/' include/target.mk
