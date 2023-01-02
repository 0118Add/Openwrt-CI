# 使用源码自带ShadowSocksR Plus+出国软件
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default


git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-autoreboot package/luci-app-autoreboot
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-firewall package/luci-app-firewall
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-filetransfer package/luci-app-filetransfer
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-ramfree package/luci-app-ramfree
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
svn co https://github.com/kiddin9/openwrt-packages/trunk/autocore package/autocore
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-lib-fs package/luci-lib-fs
#git clone https://github.com/fw876/helloworld.git package/helloworld
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/0118Add/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/redsocks2


#rm -rf package/lean/luci-app-frpc
#git clone https://github.com/8688Add/luci-app-frpc-mod.git package/lean/luci-app-frpc
#chmod 0755 package/lean/luci-app-frpc/root/etc/init.d/frp
