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

# 更改固件版本信息
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION=''|g" package/base-files/files/etc/openwrt_release
sed -i "s|DISTRIB_DESCRIPTION='.*'|DISTRIB_DESCRIPTION='OpenWrt 18.06 SNAPSHOT'|g" package/base-files/files/etc/openwrt_release

# 修改IP地址
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#rm -rf package/lean/autocore
#git clone https://github.com/0118Add/myautocore.git package/myautocore
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/kiddin9/openwrt-bypass.git package/bypass
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#rm -rf feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#rm -rf package/lean/luci-app-frpc
#git clone https://github.com/8688Add/luci-app-frpc-mod.git package/lean/luci-app-frpc
#chmod 0755 package/lean/luci-app-frpc/root/etc/init.d/frp
#git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#git clone https://github.com/0118Add/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-v2ray-server package/luci-app-v2ray-server

# 修改插件名字
#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
