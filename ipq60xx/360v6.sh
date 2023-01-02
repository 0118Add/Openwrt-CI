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

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#使用源码自带ShadowSocksR Plus+出国软件
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

# 修改概览里时间显示为中文数字
#sed -i 's/os.date()/os.date("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/arm/index.htm

# 修改系统文件
curl -fsSL https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/ipq60xx/index.htm > ./package/addition/autocore/files/arm/index.htm

#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/kiddin9/openwrt-bypass.git package/luci-app-bypass
#git clone https://github.com/fw876/helloworld.git package/helloworld
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#rm -rf feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#git clone https://github.com/0118Add/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-v2ray-server package/luci-app-v2ray-server

#rm -rf package/lean/luci-app-frpc
#git clone https://github.com/8688Add/luci-app-frpc-mod.git package/lean/luci-app-frpc
#chmod 0755 package/lean/luci-app-frpc/root/etc/init.d/frp

# 修改插件名字
#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
