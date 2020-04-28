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

git clone https://github.com/mchome/openwrt-vlmcsd.git ./package/openwrt-vlmcsd
git clone https://github.com/mchome/luci-app-vlmcsd.git ./package/luci-app-vlmcsd
git clone https://github.com/kuoruan/openwrt-v2ray.git ./package/openwrt-v2ray
git clone https://github.com/kuoruan/luci-app-v2ray.git ./package/luci-app-v2ray
./scripts/feeds update -a
./scripts/feeds install -a
