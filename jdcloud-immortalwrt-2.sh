#!/bin/bash

# For OpenWrt 21.02 or lower version
# You have to manually upgrade Golang toolchain to 1.18 or higher to compile Xray-core.
./scripts/feeds update packages
rm -rf feeds/packages/lang/golang
svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang feeds/packages/lang/golang
sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/Home/g' package/base-files/files/bin/config_generate
sed -i 's/\+libiwinfo-lua//' feeds/luci/collections/luci/Makefile
sed -i 's/\+libiwinfo//' feeds/luci/modules/luci-mod-dashboard/Makefile
sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-battstatus/Makefile
sed -i 's/\+rpcd-mod-iwinfo//' feeds/luci/modules/luci-mod-battstatus/Makefile
sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-network/Makefile
sed -i 's/\+rpcd-mod-iwinfo//' feeds/luci/modules/luci-mod-network/Makefile
sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-status/Makefile
sed -i 's/\+libiwinfo//' feeds/luci/modules/luci-mod-status/Makefile
sed -i -e 's/wpad-basic-openssl//' target/linux/ramips/mt7621/target.mk
sed -i -e 's/\+libpthread//' package/network/services/ppp/Makefile
sed -i -e 's/\+shellsync//' package/network/services/ppp/Makefile
sed -i -e 's/\+kmod-mppe//' package/network/services/ppp/Makefile
sed -i 's/"title": "udpxy",/"title": "IPTV",/' feeds/luci/applications/luci-app-udpxy/root/usr/share/luci/menu.d/luci-app-udpxy.json
sed -i 's/"ShadowSocksR Plus+"/"SSRP+"/'  feeds/luci/applications/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i '95,105d' target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
sed -i -e 's/27328k/32448k/' -e 's/kmod-fs-ext4 kmod-mt7603 kmod-mt7615e/lsblk kmod-fs-ext4 e2fsprogs fdisk luci-app-wireguard/' -e 's/kmod-mt7615-firmware kmod-sdhci-mt7620 kmod-usb3/kmod-sdhci-mt7620/' target/linux/ramips/image/mt7621.mk
sed -i -e 's/kmod-nf-nathelper/luci-app-ssr-plus/' -e 's/kmod-nf-nathelper-extra/luci-app-vlmcsd/' -e 's/kmod-ipt-raw/luci-app-upnp/' -e 's/luci-app-filetransfer/luci-app-udpxy/' include/target.mk
