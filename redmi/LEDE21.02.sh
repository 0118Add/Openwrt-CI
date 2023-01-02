#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#rm -f tools/Makefile
sed -i '$a src-git custom https://github.com/0118Add/ADD_Packages.git;main' feeds.conf.default
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
#echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
#echo 'src-git small-package https://github.com/kenzok8/small-package' >>feeds.conf.default
git clone https://github.com/0118Add/luci-app-frpc-mod.git package/luci-app-frp
chmod 0755 package/luci-app-frp/root/etc/init.d/frp
#svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/redsocks2
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-v2ray-server package/other/lean/luci-app-v2ray-server
#git clone https://github.com/immortalwrt-collections/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
