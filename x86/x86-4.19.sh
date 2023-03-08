#使用源码自带ShadowSocksR Plus+出国软件
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

# 替换内核
#sed -i 's/PATCHVER:=4.19/PATCHVER:=4.14/g' ./target/linux/x86/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

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
sed -i 's/LINUX_KERNEL_HASH-4.19.246 = 00ad2f5a36c91221a2ade0078b93bf84b60d494bd1ef51eaccb5bdb6277dba3a/LINUX_KERNEL_HASH-4.19.275 = afe96fa160e26faf31d3d81e8251fe93d28664998a557a524a4c2e167c71860a/g' ./include/kernel-version.mk
sed -i 's/LINUX_VERSION-4.19 = .246/LINUX_VERSION-4.19 = .275/g' ./include/kernel-version.mk
#sed -i 's/LINUX_KERNEL_HASH-5.4.203 = fc933f5b13066cfa54aacb5e86747a167bad1d8d23972e4a03ab5ee36c29798a/LINUX_KERNEL_HASH-5.4.211 = bfb43241b72cd55797af68bea1cebe630d37664c0f9a99b6e9263a63a67e2dec/g' ./include/kernel-5.4
#sed -i 's/LINUX_VERSION-5.4 = .203/LINUX_VERSION-5.4 = .211/g' ./include/kernel-5.4

# 修改默认主题
#sed -i 's/bootstrap/opentopd/' feeds/luci/collections/luci/Makefile

#添加额外软件包
#rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang
#rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/luci/applications/luci-app-frpc
#rm -rf feeds/luci/applications/luci-app-vssr
rm -rf feeds/luci/applications/luci-app-passwall
#rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-unblockneteasemusic
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/0118Add/openwrt_packages package/openwrt_packages
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-frpc package/luci-app-frpc
#svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
git clone https://github.com/0118Add/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-netdata package/luci-app-netdata
svn co https://github.com/0118Add/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2
git clone https://github.com/sirpdboy/luci-app-partexp.git package/luci-app-partexp
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
git clone https://github.com/sbwml/luci-app-alist.git package/alist
#git clone https://github.com/gngpp/luci-theme-design.git package/luci-theme-design
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
#git clone https://github.com/messense/aliyundrive-webdav.git package/aliyundrive-webdav
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash

# golang
#sed -i 's/GO_VERSION_MAJOR_MINOR:=.*/GO_VERSION_MAJOR_MINOR:=1.19/g' feeds/packages/lang/golang/golang/Makefile
#sed -i 's/GO_VERSION_PATCH:=.*/GO_VERSION_PATCH:=4/g' feeds/packages/lang/golang/golang/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=eda74db4ac494800a3e66ee784e495bfbb9b8e535df924a8b01b1a8028b7f368/g' feeds/packages/lang/golang/golang/Makefile


# 修改插件名字
sed -i 's/一键分区扩容/分区扩容/g' package/luci-app-partexp/po/zh-cn/partexp.po
#sed -i 's/Frp 内网穿透/内网穿透/g' package/luci-app-frpc/po/zh-cn/frp.po
#sed -i 's/Alist 文件列表/网络云盘/g' package/alist/luci-app-alist/po/zh-cn/alist.po
#sed -i 's/PassWall 2/PassWall/g' package/passwall2/luci-app-passwall2/po/zh-cn/passwall2.po
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
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
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/api/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/api/*.lua
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

./scripts/feeds update -a
./scripts/feeds install -a
