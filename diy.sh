#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk

git clone https://github.com/kuoruan/openwrt-v2ray.git ./package/openwrt-v2ray
git clone https://github.com/kuoruan/luci-app-v2ray.git ./package/luci-app-v2ray
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git ./package/luci-app-adguardhome
./scripts/feeds update -a
./scripts/feeds install -a
