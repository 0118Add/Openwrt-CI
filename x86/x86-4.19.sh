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

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改主机名
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

# 更改固件版本信息
#sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION=''|g" package/base-files/files/etc/openwrt_release
#sed -i "s|DISTRIB_DESCRIPTION='.*'|DISTRIB_DESCRIPTION='OpenWrt 18.06'|g" package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt 18.06'/g" package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=''/g" package/base-files/files/etc/openwrt_release

# 修改系统文件
#curl -fsSL https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/diy/x86_lede/immortalwrt.index.htm > ./package/emortal/autocore/files/generic/index.htm
curl -fsSL https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/diy/x86_lede/cpuinfo > ./package/emortal/autocore/files/generic/cpuinfo

# 内核替换成 kernel 4.19(14).xxx
#sed -i 's/LINUX_KERNEL_HASH-4.19.246 = 00ad2f5a36c91221a2ade0078b93bf84b60d494bd1ef51eaccb5bdb6277dba3a/LINUX_KERNEL_HASH-4.19.279 = 736cc3bc3d7368651ba08fbbbedcd37b2370705a395ea87d4477ba499d9f9880/g' ./include/kernel-version.mk
#sed -i 's/LINUX_VERSION-4.19 = .246/LINUX_VERSION-4.19 = .279/g' ./include/kernel-version.mk
sed -i 's/LINUX_KERNEL_HASH-4.19.246 = 00ad2f5a36c91221a2ade0078b93bf84b60d494bd1ef51eaccb5bdb6277dba3a/LINUX_KERNEL_HASH-4.19.277 = f682d9a202e059763fb4ef32a0287e6b5a49305ac34fb3161021df0fcd94f58c/g' ./include/kernel-version.mk
sed -i 's/LINUX_VERSION-4.19 = .246/LINUX_VERSION-4.19 = .277/g' ./include/kernel-version.mk

# node - prebuilt
rm -rf feeds/packages/lang/node
git clone https://github.com/8688Add/feeds_packages_lang_node-prebuilt feeds/packages/lang/node

# 修改默认主题
#sed -i 's/bootstrap/opentopd/' feeds/luci/collections/luci/Makefile

#添加额外软件包
#rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang
#rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-app-argon-config
rm -rf feeds/luci/applications/luci-app-frpc
rm -rf feeds/luci/applications/luci-app-vssr
rm -rf feeds/luci/applications/luci-app-ddns-go
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-unblockneteasemusic
#rm -rf feeds/luci/applications/luci-app-zerotier
#git clone https://github.com/0118Add/luci-app-vssr package/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/sirpdboy/luci-app-ddns-go package/luci-app-ddns-go
#merge_package https://github.com/kiddin9/openwrt-packages openwrt-packages/luci-app-zerotier
git clone -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
#merge_package https://github.com/kiddin9/openwrt-packages openwrt-packages/wrtbwmon
merge_package https://github.com/kiddin9/openwrt-packages openwrt-packages/luci-app-bypass
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall
#git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2
#git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/brook
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/chinadns-ng
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/dns2socks
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/dns2tcp
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/gn
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/hysteria
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/ipt2socks
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/microsocks
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/naiveproxy
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/pdnsd-alt
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/shadowsocksr-libev
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/simple-obfs
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/sing-box
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/ssocks
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/tcping
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-go
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-plus
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/tuic-client
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-core
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-geodata
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-plugin
#git clone https://github.com/justice2001/luci-app-multi-frpc package/luci-app-multi-frpc
#git clone https://github.com/fw876/helloworld.git package/helloworld
#merge_package https://github.com/fw876/helloworld helloworld/shadow-tls
#merge_package https://github.com/0118Add/helloworld helloworld/shadowsocks-rust
#merge_package https://github.com/fw876/helloworld helloworld/xray-core
#merge_package https://github.com/fw876/helloworld helloworld/xray-plugin
#merge_package https://github.com/fw876/helloworld helloworld/luci-app-ssr-plus
#git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-wechatpush
#git clone https://github.com/sbwml/luci-app-alist package/alist
git clone https://github.com/sirpdboy/luci-app-partexp package/luci-app-partexp
#git clone -b dev --depth 1 https://github.com/vernesong/OpenClash package/luci-app-openclash
git clone --depth=1 -b dev https://github.com/vernesong/OpenClash package/luci-app-openclash
git clone https://github.com/gngpp/luci-theme-design package/luci-theme-design

# 去掉ssr+中shadowsocksr-libev的libopenssl-legacy依赖支持
#sed -i 's/ +libopenssl-legacy//g' package/helloworld/shadowsocksr-libev/Makefile

# 修改插件名字
#sed -i 's/Argon 主题设置/Argon设置/g' feeds/luci/applications/luci-app-argon-config/po/zh-cn/argon-config.po
#sed -i 's/Design 主题设置/Design设置/g' feeds/luci/applications/luci-app-design-config/po/zh-cn/design-config.po
sed -i 's/一键分区扩容/分区扩容/g' package/luci-app-partexp/po/zh-cn/partexp.po
#sed -i 's/Frp 内网穿透/内网穿透/g' package/luci-app-frpc/po/zh-cn/frp.po
sed -i 's/Frpc内网穿透/内网穿透/g' package/luci-app-multi-frpc/po/zh-cn/frp.po
#sed -i 's/Alist 文件列表/网络云盘/g' package/alist/luci-app-alist/po/zh-cn/alist.po
#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua

# 调整 V2ray服务 到 VPN 菜单
#sed -i 's/services/vpn/g' package/openwrt_packages/luci-app-v2ray-server/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/openwrt_packages/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
#sed -i 's/services/vpn/g' package/openwrt_packages/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

# 调整 Alist 文件列表 到 系统 菜单
#sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/controller/*.lua
#sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/model/cbi/alist/*.lua
#sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/view/alist/*.htm

# 调整 Dockerman 到 服务 菜单
#sed -i 's/"admin",/"admin","services",/g' package/luci-app-dockerman/luasrc/controller/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/*.htm
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# 调整 Zerotier 到 服务 菜单
sed -i 's/vpn/services/g' package/custom/luci-app-zerotier/luasrc/controller/*.lua
sed -i 's/vpn/services/g' package/custom/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua
sed -i 's/vpn/services/g' package/custom/luci-app-zerotier/luasrc/view/zerotier/*.htm

# 调整 bypass 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/view/bypass/*.htm

# 调整 SSRP 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-ssr-plus/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
#sed -i 's/services/vpn/g' package/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# 调整 Pass Wall 到 GFW 菜单
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/passwall/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/auto_switch/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm

# 调整 Hello World 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/view/vssr/*.htm

# 调整 Open Clash 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/view/openclash/*.htm

# 赋予权限
#chmod 0755 package/luci-app-zerotier/root/etc/init.d/zerotier
#chmod 0755 package/zerotier/files/etc/init.d/zerotier
#chmod 0755 package/luci-app-frpc/root/etc/init.d/frp

./scripts/feeds update -a
./scripts/feeds install -a
