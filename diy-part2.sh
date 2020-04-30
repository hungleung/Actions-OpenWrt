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
sed -i 's/192.168.1.1/192.168.10.25/g' package/base-files/files/bin/config_generate

# Default packages - the really basic set
# kmod-fs-f2fs solve the issue that settings can not be saved
sed -i 's/block-mount/curl bind-dig htop kmod-fs-f2fs/g' include/target.mk
sed -i 's/luci-app-adbyby-plus luci-app-autoreboot/luci-ssl-openssl/g' include/target.mk
sed -i 's/luci-app-filetransfer luci-app-vsftpd luci-app-ssr-plus luci-app-unblockmusic/luci-app-ssr-plus/g' include/target.mk
sed -i 's/luci-app-arpbind luci-app-vlmcsd luci-app-wol luci-app-ramfree/luci-app-vlmcsd/g' include/target.mk
sed -i 's/luci-app-sfe luci-app-flowoffload luci-app-nlbwmon luci-app-accesscontrol luci-app-cpufreq/luci-app-sfe luci-app-flowoffload luci-app-cpufreq/g' include/target.mk
sed -i 's/ddns-scripts_aliyun ddns-scripts_dnspod/luci-app-udpxy luci-app-acme acme-dnsapi/g' include/target.mk

sed -i 's/DEFAULT_PACKAGES += partx-utils mkf2fs fdisk e2fsprogs wpad kmod-usb-hid \\//g' target/linux/x86/Makefile
sed -i 's/kmod-ath5k kmod-ath9k kmod-ath9k-htc kmod-ath10k kmod-rt2800-usb kmod-e1000e kmod-igb kmod-igbvf kmod-ixgbe kmod-pcnet32 kmod-tulip kmod-vmxnet3 kmod-i40e kmod-i40evf kmod-r8125 kmod-8139cp kmod-8139too kmod-fs-f2fs \\//g' target/linux/x86/Makefile
sed -i 's/htop lm-sensors autocore automount autosamba luci-app-ipsec-vpnd luci-proto-bonding luci-app-unblockmusic luci-app-zerotier luci-app-xlnetacc ddns-scripts_aliyun ddns-scripts_dnspod ca-certificates \\//g' target/linux/x86/Makefile
sed -i 's/luci-app-airplay2 luci-app-music-remote-center luci-app-qbittorrent luci-app-amule luci-app-openvpn-server \\//g' target/linux/x86/Makefile
sed -i 's/ath10k-firmware-qca988x ath10k-firmware-qca9888 ath10k-firmware-qca9984 brcmfmac-firmware-43602a1-pcie \\//g' target/linux/x86/Makefile
sed -i 's/kmod-sound-hda-core kmod-sound-hda-codec-realtek kmod-sound-hda-codec-via kmod-sound-via82xx kmod-sound-hda-intel kmod-sound-hda-codec-hdmi kmod-sound-i8x0 kmod-usb-audio \\//g' target/linux/x86/Makefile
sed -i 's/kmod-usb-net kmod-usb-net-asix kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8150 kmod-usb-net-rtl8152//g' target/linux/x86/Makefile

sed -i 's/kmod-e1000e kmod-e1000 kmod-r8169 kmod-igb kmod-bnx2/kmod-e1000e/g' target/linux/x86/64/target.mk

# vhd
sed -i '273s/n/y/' config/Config-images.in
sed -i '272d' config/Config-images.in
sed -i '265s/y/n/' config/Config-images.in
sed -i '205s/n/y/' config/Config-images.in
sed -i '82s/n/y/' config/Config-images.in

# cancel shellsync
sed -i '41s/+shellsync //' package/network/services/ppp/Makefile
