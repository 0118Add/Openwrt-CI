#修改版本号
#sed -i 's/OpenWrt/BGG $(TZ=UTC-8 date "+%Y.%m.%d")' package/lean/default-settings/files/zzz-default-settings

# echo '删除重复插件'
rm -rf ./package/lean/trojan
#rm -rf ./package/lean/v2ray
rm -rf ./package/lean/adbyby
rm -rf ./package/lean/luci-app-adbyby-plus

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 使用源码自带ShadowSocksR Plus+出国软件
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#git clone https://github.com/Mattraks/helloworld.git package/luci-app-ssr-plus
#git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/0118Add/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
#rm -rf package/lean/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#rm -rf package/lean/mt
#svn co https://github.com/0118Add/lede/trunk/package/lean/mt package/lean/mt
rm -rf package/lean/luci-app-frpc
git clone https://github.com/8688Add/luci-app-frpc-mod.git package/lean/luci-app-frpc
chmod 0755 package/lean/luci-app-frpc/root/etc/init.d/frp
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/adbyby package/lean/adbyby
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-adbyby-plus package/lean/luci-app-adbyby-plus
svn co https://github.com/imy7/luci-app-turboacc/trunk/Lean package/luci-app-turboacc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-unblockmusic package/luci-app-unblockmusic
rm -rf package/lean/luci-app-v2ray-server
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-v2ray-server package/luci-app-v2ray-server

#rm -rf package/lean/luci-app-flowoffload
#svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-flowoffload package/lean/luci-app-flowoffload
#rm -rf package/lean/luci-app-unblockmusic
#svn co https://github.com/project-openwrt/openwrt/trunk/package/lean/luci-app-unblockmusic package/lean/luci-app-unblockmusic
#git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic-mini.git package/luci-app-unblockneteasemusic-mini
#rm -rf package/lean/luci-app-flowoffload
#svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-flowoffload package/lean/luci-app-flowoffload
#git clone https://github.com/reaiyaogun/luci-app-turboacc.git package/luci-app-turboacc
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/luci-app-flowoffload package/lean/luci-app-flowoffload
svn co https://github.com/1980Add/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/tcping package/lean/tcping

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
#sed -i 's/"ShadowSocksR Plus+"/"国际互联 Plus+"/g' package/lean/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/"解锁网易云灰色歌曲"/"解锁网易Music"/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
