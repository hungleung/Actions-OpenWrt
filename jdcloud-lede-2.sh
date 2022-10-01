#!/bin/bash

# For OpenWrt 21.02 or lower version
# You have to manually upgrade Golang toolchain to 1.18 or higher to compile Xray-core.
sed -i 's/192.168.1.1/192.168.1.254/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/Home/g' package/base-files/files/bin/config_generate
sed -i 's/\+libiwinfo-lua//' feeds/luci/collections/luci/Makefile
# sed -i 's/\+libiwinfo//' feeds/luci/modules/luci-mod-dashboard/Makefile
# sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-battstatus/Makefile
# sed -i 's/\+rpcd-mod-iwinfo//' feeds/luci/modules/luci-mod-battstatus/Makefile
# sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-network/Makefile
# sed -i 's/\+rpcd-mod-iwinfo//' feeds/luci/modules/luci-mod-network/Makefile
# sed -i 's/\+libiwinfo-lua//' feeds/luci/modules/luci-mod-status/Makefile
# sed -i 's/\+libiwinfo//' feeds/luci/modules/luci-mod-status/Makefile
sed -i -e 's/wpad-openssl//' target/linux/ramips/mt7621/target.mk
sed -i -e 's/\+libpthread//' package/network/services/ppp/Makefile
sed -i -e 's/\+shellsync//' package/network/services/ppp/Makefile
sed -i -e 's/\+kmod-mppe//' package/network/services/ppp/Makefile
# sed -i 's/"title": "udpxy",/"title": "IPTV",/' feeds/luci/applications/luci-app-udpxy/root/usr/share/luci/menu.d/luci-app-udpxy.json
sed -i 's/"ShadowSocksR Plus+"/"SSRP+"/'  feeds/luci/applications/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
curl --retry 3 -s --globoff "https://gist.githubusercontent.com/1-1-2/335dbc8e138f39fb8fe6243d424fe476/raw/[lean's%20lede]mt7621_jdcloud_re-sp-01b.dts" -o target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
sed -i '95,105d' target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
sed -i '/Device\/adslr_g7/i\define Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 32448k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := lsblk block-mount kmod-fs-ext4 e2fsprogs fdisk kmod-sdhci-mt7620 odhcp6c luci-app-udpxy luci-app-wireguard\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b\n\n' target/linux/ramips/image/mt7621.mk
sed -i '/linksys,e5600|\\/i\        jdcloud,re-sp-01b)\n		local index="$(find_mtd_index "config")"\n		local label_mac=\$(macaddr_canonicalize \$(dd if="/dev/mtd${index}" bs=12 skip=17449 iflag=skip_bytes count=1 2>\/dev\/null))\n		[ "$PHYNBR" -eq 0 ] \&\& echo \$label_mac > \/sys\${DEVPATH}\/macaddress\n		[ "$PHYNBR" -eq 1 ] \&\& macaddr_add \$label_mac 0x800000 > \/sys\${DEVPATH}\/macaddress\n		;;' target/linux/ramips/mt7621/base-files/etc/hotplug.d/ieee80211/10_fix_wifi_mac
sed -i -e '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' -e '/ramips_setup_macs/,/}/{/ampedwireless,ally-00x19k/i\        jdcloud,re-sp-01b)\n\t\tlan_mac=$(mtd_get_mac_ascii u-boot-env mac)\n\t\twan_mac=$(macaddr_add "$lan_mac" 1)\n\t\tlabel_mac=$lan_mac\n\t\t;;
}' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i 's#key"'\''=//p'\''#& \| head -n1#' package/base-files/files/lib/functions/system.sh
sed -i -e 's/ddns-scripts_aliyun//' -e 's/ddns-scripts_dnspod//' -e 's/luci-app-ddns//' -e 's/luci-app-autoreboot//' -e 's/luci-app-arpbind//' -e 's/luci-app-vsftpd//' -e 's/luci-app-accesscontrol//' -e 's/luci-app-nlbwmon//' -e 's/luci-app-wol//' -e 's/luci-app-filetransfer//' include/target.mk
