#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

echo "开始 DIY2 配置……"
echo "========================="

function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}
function merge_feed(){
    if [ ! -d "feed/$1" ]; then
        echo >> feeds.conf.default
        echo "src-git $1 $2" >> feeds.conf.default
    fi
    ./scripts/feeds update $1
    ./scripts/feeds install -a -p $1
}
rm -rf package/custom; mkdir package/custom

# 更改主机名
#sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

# 更改固件版本信息
#sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION=''|g" package/base-files/files/etc/openwrt_release
#sed -i "s|DISTRIB_DESCRIPTION='.*'|DISTRIB_DESCRIPTION='OpenWrt 21.02'|g" package/base-files/files/etc/openwrt_release

# 移除 SNAPSHOT 标签
sed -i 's,-SNAPSHOT,,g' include/version.mk
sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in

# 修改IP地址
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改连接数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# node - prebuilt
rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt feeds/packages/lang/node

# 替换内核
#sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g' target/linux/x86/Makefile

# 替换文件
#wget -O ./package/kernel/linux/modules/netsupport.mk https://raw.githubusercontent.com/0118Add/OpenWrt/main/scripts/netsupport.mk

# 内核替换成 kernel 5.xxx
#sed -i 's/LINUX_KERNEL_HASH-5.4.238 = 70a2b2da85598eba6a73cdc0749e441cbdf3011d9babcb7028a46aa8d98aa91f/LINUX_KERNEL_HASH-5.4.238 = 70a2b2da85598eba6a73cdc0749e441cbdf3011d9babcb7028a46aa8d98aa91f/g' ./include/kernel-5.4
#sed -i 's/LINUX_VERSION-5.4 = .238/LINUX_VERSION-5.4 = .238/g' ./include/kernel-5.4

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#添加额外软件包
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
#rm -rf package/helloworld/{shadowsocksr-libev}
#rm -rf package/openwrt-passwall/{xray-core,xray-plugin,shadowsocks-rust}
rm -rf feeds/packages/net/alist
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-alist
rm -rf feeds/luci/applications/luci-app-ddns-go
rm -rf feeds/luci/applications/luci-app-vssr
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-wechatpush
rm -rf feeds/luci/applications/luci-app-unblockneteasemusic
#rm -rf feeds/luci/applications/luci-app-zerotier
git clone https://github.com/0118Add/luci-app-vssr package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/sirpdboy/luci-app-ddns-go package/luci-app-ddns-go
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-dockerman package/luci-app-dockerman
#svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-zerotier package/luci-app-zerotier
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
merge_package https://github.com/kiddin9/openwrt-packages openwrt-packages/wrtbwmon
merge_package https://github.com/kiddin9/openwrt-packages openwrt-packages/luci-app-bypass
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall
#git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2
#git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/brook
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/chinadns-ng
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/dns2socks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/dns2tcp
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/gn
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/hysteria
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/ipt2socks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/microsocks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/naiveproxy
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/pdnsd-alt
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/shadowsocksr-libev
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/simple-obfs
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/sing-box
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/ssocks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/tcping
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-go
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-plus
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/tuic-client
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-core
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-geodata
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-plugin
git clone https://github.com/sbwml/openwrt_helloworld package/helloworld -b v5
#git clone https://github.com/fw876/helloworld.git package/helloworld
merge_package https://github.com/fw876/helloworld helloworld/shadow-tls
merge_package https://github.com/0118Add/helloworld helloworld/shadowsocks-rust
merge_package https://github.com/fw876/helloworld helloworld/xray-core
merge_package https://github.com/fw876/helloworld helloworld/xray-plugin
merge_package https://github.com/fw876/helloworld helloworld/luci-app-ssr-plus
git clone https://github.com/tty228/luci-app-wechatpush package/luci-app-wechatpush
git clone https://github.com/sbwml/luci-app-alist package/alist
git clone https://github.com/sirpdboy/luci-app-partexp package/luci-app-partexp
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
#git clone -b dev --depth 1 https://github.com/vernesong/OpenClash package/luci-app-openclash
#git clone https://github.com/sbwml/luci-app-daed-next package/luci-app-daed-next
git clone --depth=1 -b dev https://github.com/vernesong/OpenClash package/luci-app-openclash

# 去掉ssr+中shadowsocksr-libev的libopenssl-legacy依赖支持
sed -i 's/ +libopenssl-legacy//g' package/helloworld/shadowsocksr-libev/Makefile

# 修改插件名字
#sed -i 's/Frp 内网穿透/内网穿透/g' package/luci-app-frpc/po/zh-cn/frp.po
sed -i 's/Alist 文件列表/网络云盘/g' package/alist/luci-app-alist/po/zh-cn/alist.po
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/custom/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
#sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json

# 调整 V2ray服务 到 VPN 菜单
#sed -i 's/services/vpn/g' package/openwrt_packages/luci-app-v2ray-server/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/openwrt_packages/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
#sed -i 's/services/vpn/g' package/openwrt_packages/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

# 调整 Alist 文件列表 到 系统 菜单
sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/controller/*.lua
sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/model/cbi/alist/*.lua
sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/view/alist/*.htm

# 调整 Dockerman 到 服务 菜单
#sed -i 's/"admin",/"admin","services",/g' package/luci-app-dockerman/luasrc/controller/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/*.htm
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# 调整 bypass 到 GFW 菜单
sed -i 's/services/vpn/g' package/custom/luci-app-bypass/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/custom/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
sed -i 's/services/vpn/g' package/custom/luci-app-bypass/luasrc/view/bypass/*.htm

# 调整 SSRP 到 GFW 菜单
sed -i 's/services/vpn/g' package/custom/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/custom/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' package/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# 调整 Pass Wall 到 GFW 菜单
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/passwall/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm

# 调整 Pass Wall 2 到 GFW 菜单
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/model/cbi/passwall2/client/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/model/cbi/passwall2/server/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/passwall2/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/app_update/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/auto_switch/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/global/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/log/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/node_list/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/rule/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/server/*.htm

# 调整 Hello World 到 GFW 菜单
sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/view/vssr/*.htm

# 调整 Open Clash 到 GFW 菜单
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/*.lua
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/view/openclash/*.htm

# 修改权限
chmod 0755 package/custom/luci-app-bypass/root/etc/init.d/bypass

./scripts/feeds update -a
./scripts/feeds install -a
