#!/bin/bash

# For OpenWrt 21.02 or lower version
# You have to manually upgrade Golang toolchain to 1.18 or higher to compile Xray-core.
# ./scripts/feeds update packages
# rm -rf feeds/packages/lang/golang
# svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang feeds/packages/lang/golang
# svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# change default lan address and hostname
# verified to be working
sed -i 's/192.168.1.1/192.168.88.3/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/Home/g' package/base-files/files/bin/config_generate
# sed -i '208s/ DNS(DDNS)/域名/'  feeds/luci/applications/luci-app-ddns/po/zh_Hans/ddns.po
# sed -i '16s/ACME /配置/' feeds/luci/applications/luci-app-acme/po/zh_Hans/acme.po
sed -i '76s/udpxy/直播电视/' feeds/luci/applications/luci-app-udpxy/po/zh_Hans/udpxy.po
sed -i '199s/UPnP/端口转发/' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po

# disable and remove wireless
sed -i 's/\+libiwinfo-lua//' feeds/luci/collections/luci/Makefile
sed -i 's/iwinfo//' feeds/luci/modules/luci-mod-admin-full/Makefile
sed -i 's/wpad-openssl//' target/linux/ramips/mt7621/target.mk

# Add router support
curl --retry 3 -s --globoff "https://gist.githubusercontent.com/1-1-2/335dbc8e138f39fb8fe6243d424fe476/raw/328209ec5bf504b39133ce4dcec918baf466970c/mt7621_jdcloud_re-sp-01b.dts" -o target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
sed -i '/Device\/adslr_g7/i\define Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 32448k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := lsblk block-mount e2fsprogs fdisk kmod-fs-ext4 kmod-sdhci-mt7620 kmod-usb3\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b\n\n' target/linux/ramips/image/mt7621.mk
sed -i -e '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' -e '/ramips_setup_macs/,/}/{/ampedwireless,ally-00x19k/i\        jdcloud,re-sp-01b)\n\t\tlan_mac=$(mtd_get_mac_ascii u-boot-env mac)\n\t\twan_mac=$(macaddr_add "$lan_mac" 1)\n\t\tlabel_mac=$lan_mac\n\t\t;;
    }' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i 's#key"'\''=//p'\''#& \| head -n1#' package/base-files/files/lib/functions/system.sh

# change default package
sed -i -e 's/dnsmasq/dnsmasq luci-app-upnp luci luci-app-udpxy luci-app-samba4 nano htop curl wget/'  include/target.mk