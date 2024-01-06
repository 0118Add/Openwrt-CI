# 更改主机名
#sed -i "s/hostname='.*'/hostname='X86'/g" package/base-files/files/bin/config_generate

# 内核替换成 kernel 5.4.xxx
#sed -i 's/LINUX_KERNEL_HASH-5.4.203 = fc933f5b13066cfa54aacb5e86747a167bad1d8d23972e4a03ab5ee36c29798a/LINUX_KERNEL_HASH-5.4.211 = bfb43241b72cd55797af68bea1cebe630d37664c0f9a99b6e9263a63a67e2dec/g' ./include/kernel-version.mk
#sed -i 's/LINUX_VERSION-5.4 = .203/LINUX_VERSION-5.4 = .211/g' ./include/kernel-version.mk

# 修改默认IP为 192.168.2.1
#sed -i "s/192.168.1.1/192.168.2.1/g" package/base-files/files/bin/config_generate

# 修改连接数
#sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# 修正连接数
#sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf


#rm -rf feeds/luci/applications/luci-app-frpc
#git clone https://github.com/kiddin9/luci-theme-edge.git package/luci-theme-edge
#git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-argonne package/luci-theme-argonne
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
#git clone https://github.com/fw876/helloworld package/helloworld
#svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
#git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall
#git clone -b luci https://github.com/xiaorouji/openwrt-passwall package/passwall
#git clone https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr
#git clone https://github.com/kiddin9/openwrt-bypass package/bypass
#git clone https://github.com/messense/aliyundrive-webdav.git package/aliyundrive-webdav
#git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
#svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
#git clone https://github.com/0118Add/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic

#echo 'src-git my https://github.com/0118Add/NueXini_Packages' >>feeds.conf.default

#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po

# 调整 Dockerman 到 服务菜单
#sed -i 's/"admin",/"admin","services",/g' package/luci-app-dockerman/luasrc/controller/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/*.htm
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm
# 调整 bypass 到 GFW 菜单
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/view/bypass/*.htm
# 调整 SSRP 到 GFW 菜单
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm
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

#echo 'src-git my https://github.com/0118Add/NueXini_Packages' >>feeds.conf.default
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/redsocks2
#svn co https://github.com/coolsnowwolf/packages/trunk/net/microsocks package/microsocks
svn co https://github.com/coolsnowwolf/packages/trunk/net/kcptun package/kcptun

./scripts/feeds update -a
./scripts/feeds install -a
