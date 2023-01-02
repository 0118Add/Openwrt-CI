#修改版本号
#sed -i 's/OpenWrt/BGG $(TZ=UTC-8 date "+%Y.%m.%d")' package/lean/default-settings/files/zzz-default-settings

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 使用源码自带ShadowSocksR Plus+出国软件
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

#rm -rf feeds/luci/applications/luci-app-vssr
rm -rf feeds/luci/applications/luci-app-ssr-plus
#rm -rf feeds/luci/applications/luci-app-unblockneteasemusic
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/0118Add/pass-ssrp.git package/luci-app-ssr-plus
#svn co https://github.com/0118Add/pass-ssrp/trunk/helloworld/luci-app-ssr-plus package/helloworld/luci-app-ssr-plus
#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/luci-app-ssr-plus/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#git clone https://github.com/kiddin9/openwrt-bypass.git package/bypass
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#rm -rf feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#rm -rf feeds/luci/applications/luci-app-frpc
#git clone https://github.com/8688Add/luci-app-frpc-mod.git package/lean/luci-app-frpc
#chmod 0755 package/lean/luci-app-frpc/root/etc/init.d/frp
#git clone https://github.com/0118Add/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
#git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
#git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic-mini.git package/luci-app-unblockneteasemusic-mini
#git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
#sed -i 's/"ShadowSocksR Plus+"/"国际互联 Plus+"/g' package/lean/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/"解锁网易云灰色歌曲"/"解锁网易Music"/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
