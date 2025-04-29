#!/bin/bash
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

echo "开始配置……"
echo "========================="

chmod +x ${GITHUB_WORKSPACE}/immortalwrt/function.sh
source ${GITHUB_WORKSPACE}/immortalwrt/function.sh

# 更改主机名
#sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

# 更改固件版本信息
#sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION=''|g" package/base-files/files/etc/openwrt_release
#sed -i "s|DISTRIB_DESCRIPTION='.*'|DISTRIB_DESCRIPTION='OpenWrt %V'|g" package/base-files/files/etc/openwrt_release

# 修改x86内核到6.6版
#sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=6.6/g' ./target/linux/x86/Makefile

# 内核替换
#sed -i 's/LINUX_KERNEL_HASH-6.6.71 = 219715ba2dcfa6539fba09ad3f9212772f3507189eb60d77f8e89b06c32e724e/LINUX_KERNEL_HASH-6.6.66 = 9d757937c4661c2f512c62641b74ef74eff9bb13dc5dbcbaaa108c21152f1e52/g' ./include/kernel-6.6
#sed -i 's/LINUX_VERSION-6.6 = .71/LINUX_VERSION-6.6 = .66/g' ./include/kernel-6.6

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改连接数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# 修复上移下移按钮翻译
sed -i 's/<%:Up%>/<%:Move up%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm
sed -i 's/<%:Down%>/<%:Move down%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm

# 修复procps-ng-top导致首页cpu使用率无法获取
sed -i 's#top -n1#\/bin\/busybox top -n1#g' feeds/luci/modules/luci-base/root/usr/share/rpcd/ucode/luci

# ------------------PassWall 科学上网--------------------------
# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,pdnsd-alt,brook,chinadns-ng,dns2socks,dns2tcp,gn,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,trojan-go,trojan-plus,tuic-client,v2ray-plugin,xray-plugin}
# 核心库
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
rm -rf package/passwall-packages/{chinadns-ng,naiveproxy,v2ray-geodata}
merge_package v5 https://github.com/sbwml/openwrt_helloworld package/passwall-packages chinadns-ng naiveproxy v2ray-geodata
# app
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-smartdns}
#git clone -b luci-smartdns-dev --single-branch https://github.com/lwb1978/openwrt-passwall package/passwall-luci
# git clone https://github.com/xiaorouji/openwrt-passwall package/passwall-luci
# ------------------------------------------------------------

# SmartDNS ZeroTier
#rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-zerotier
git clone --single-branch https://github.com/lwb1978/luci-app-smartdns package/luci-app-smartdns
git clone https://github.com/lwb1978/luci-app-zerotier package/luci-app-zerotier
sed -i 's/vpn/services/g' package/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json
# 替换immortalwrt 软件仓库smartdns版本为官方最新版
rm -rf feeds/packages/net/smartdns
cp -rf ${GITHUB_WORKSPACE}/patch/smartdns feeds/packages/net

# openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 -b dev https://github.com/vernesong/OpenClash package/OpenClash

# homeproxy
#rm -rf feeds/luci/applications/luci-app-homeproxy
#git clone --depth 1 -b test https://github.com/m0eak/homeproxy package/homeproxy
#sed -i "s/ImmortalWrt/OpenWrt/g" package/homeproxy/po/zh_Hans/homeproxy.po
#sed -i "s/ImmortalWrt proxy/OpenWrt proxy/g" package/homeproxy/htdocs/luci-static/resources/view/homeproxy/{client.js,server.js}
sed -i "s/ImmortalWrt/OpenWrt/g" feeds/luci/applications/luci-app-homeproxy/po/zh_Hans/homeproxy.po
sed -i "s/ImmortalWrt proxy/OpenWrt proxy/g" feeds/luci/applications/luci-app-homeproxy/htdocs/luci-static/resources/view/homeproxy/{client.js,server.js}

# mihomo
git clone https://github.com/nikkinikki-org/OpenWrt-nikki  package/OpenWrt-nikki
#sed -i 's/MihomoTProxy/Mihomo/g' package/openwrt-mihomo/luci-app-mihomo/po/zh_Hans/mihomo.po
#sed -i 's/MihomoTProxy/Mihomo/g' package/openwrt-mihomo/luci-app-mihomo/root/usr/share/luci/menu.d/luci-app-mihomo.json

# neko
#git clone -b nekobox --depth 1 https://github.com/Thaolga/openwrt-nekobox package/nekobox

# 防火墙4添加自定义nft命令支持
# curl -s https://$mirror/openwrt/patch/firewall4/100-openwrt-firewall4-add-custom-nft-command-support.patch | patch -p1
patch -p1 < ${GITHUB_WORKSPACE}/patch/firewall4/100-openwrt-firewall4-add-custom-nft-command-support.patch

pushd feeds/luci
	# 防火墙4添加自定义nft命令选项卡
	# curl -s https://$mirror/openwrt/patch/firewall4/luci-24.10/0004-luci-add-firewall-add-custom-nft-rule-support.patch | patch -p1
	patch -p1 < ${GITHUB_WORKSPACE}/patch/firewall4/0004-luci-add-firewall-add-custom-nft-rule-support.patch
	# 状态-防火墙页面去掉iptables警告，并添加nftables、iptables标签页
	# curl -s https://$mirror/openwrt/patch/luci/0004-luci-mod-status-firewall-disable-legacy-firewall-rul.patch | patch -p1
	patch -p1 < ${GITHUB_WORKSPACE}/patch/firewall4/0004-luci-mod-status-firewall-disable-legacy-firewall-rul.patch
popd

# 补充 firewall4 luci 中文翻译
cat >> "feeds/luci/applications/luci-app-firewall/po/zh_Hans/firewall.po" <<-EOF
	
	msgid ""
	"Custom rules allow you to execute arbitrary nft commands which are not "
	"otherwise covered by the firewall framework. The rules are executed after "
	"each firewall restart, right after the default ruleset has been loaded."
	msgstr ""
	"自定义规则允许您执行不属于防火墙框架的任意 nft 命令。每次重启防火墙时，"
	"这些规则在默认的规则运行后立即执行。"
	
	msgid ""
	"Applicable to internet environments where the router is not assigned an IPv6 prefix, "
	"such as when using an upstream optical modem for dial-up."
	msgstr ""
	"适用于路由器未分配 IPv6 前缀的互联网环境，例如上游使用光猫拨号时。"

	msgid "NFtables Firewall"
	msgstr "NFtables 防火墙"

	msgid "IPtables Firewall"
	msgstr "IPtables 防火墙"
EOF

# 精简 UPnP 菜单名称
sed -i 's#\"title\": \"UPnP IGD \& PCP/NAT-PMP\"#\"title\": \"UPnP\"#g' feeds/luci/applications/luci-app-upnp/root/usr/share/luci/menu.d/luci-app-upnp.json
# 移动 UPnP 到 “网络” 子菜单
#sed -i 's/services/network/g' feeds/luci/applications/luci-app-upnp/root/usr/share/luci/menu.d/luci-app-upnp.json

# vim - fix E1187: Failed to source defaults.vim
pushd feeds/packages
	vim_ver=$(cat utils/vim/Makefile | grep -i "PKG_VERSION:=" | awk 'BEGIN{FS="="};{print $2}' | awk 'BEGIN{FS=".";OFS="."};{print $1,$2}')
	[ "$vim_ver" = "9.0" ] && {
		echo "修复 vim E1187 的错误"
		# curl -s https://github.com/openwrt/packages/commit/699d3fbee266b676e21b7ed310471c0ed74012c9.patch | patch -p1
		patch -p1 < ${GITHUB_WORKSPACE}/patch/vim/0001-vim-fix-renamed-defaults-config-file.patch
	}
popd

# 调整Dockerman到服务菜单
sed -i 's/"admin",/"admin","services",/g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/model/*.lua
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# 修正部分从第三方仓库拉取的软件 Makefile 路径问题
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# 自定义默认配置
sed -i '/exit 0$/d' package/emortal/default-settings/files/99-default-settings
cat ${GITHUB_WORKSPACE}/immortalwrt/default-settings >> package/emortal/default-settings/files/99-default-settings
curl -fsSL https://raw.githubusercontent.com/0118Add/Openwrt-CI/main/patch/10_system.js > ./feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
curl -fsSL https://raw.githubusercontent.com/0118Add/Cloudbuild/main/patches/29_ports.js > ./feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/29_ports.js

# comment out the following line to restore the full description
#sed -i '/# timezone/i grep -q '\''/tmp/sysinfo/model'\'' /etc/rc.local || sudo sed -i '\''/exit 0/i [ "$(cat /sys\\/class\\/dmi\\/id\\/sys_vendor 2>\\/dev\\/null)" = "Default string" ] \&\& echo "x86_64" > \\/tmp\\/sysinfo\\/model'\'' /etc/rc.local\n' package/emortal/default-settings/files/99-default-settings
sed -i '/# timezone/i sed -i "s/\\(DISTRIB_DESCRIPTION=\\).*/\\1'\''ImmortalWrt $(sed -n "s/DISTRIB_DESCRIPTION='\''ImmortalWrt \\([^ ]*\\) .*/\\1/p" /etc/openwrt_release)'\'',/" /etc/openwrt_release\nsource /etc/openwrt_release \&\& sed -i -e "s/distversion\\s=\\s\\".*\\"/distversion = \\"$DISTRIB_ID $DISTRIB_RELEASE ($DISTRIB_REVISION)\\"/g" -e '\''s/distname    = .*$/distname    = ""/g'\'' /usr/lib/lua/luci/version.lua\nsed -i "s/luciname    = \\".*\\"/luciname    = \\"LuCI openwrt-24.10\\"/g" /usr/lib/lua/luci/version.lua\nsed -i "s/luciversion = \\".*\\"/luciversion = \\"\\"/g" /usr/lib/lua/luci/version.lua\necho "export const revision = '\''\'\'', branch = '\''LuCI openwrt-24.10'\'';" > /usr/share/ucode/luci/version.uc\n/etc/init.d/rpcd restart\n' package/emortal/default-settings/files/99-default-settings
#sed -i '/# timezone/i sed -i "s/\\(DISTRIB_DESCRIPTION=\\).*/\\1'\''ImmortalWrt $(sed -n "s/DISTRIB_DESCRIPTION='\''ImmortalWrt \\([^ ]*\\) .*/\\1/p" /etc/openwrt_release)'\'',/" /etc/openwrt_release\nsource /etc/openwrt_release \&\& sed -i -e "s/distversion\\s=\\s\\".*\\"/distversion = \\"$DISTRIB_ID $DISTRIB_RELEASE ($DISTRIB_REVISION)\\"/g" -e '\''s/distname    = .*$/distname    = ""/g'\'' /usr/lib/lua/luci/version.lua\nsed -i "s/luciname    = \\".*\\"/luciname    = \\"LuCI openwrt-24.10\\"/g" /usr/lib/lua/luci/version.lua\nsed -i "s/luciversion = \\".*\\"/luciversion = \\"v'$(date +%Y%m%d)'\\"/g" /usr/lib/lua/luci/version.lua\necho "export const revision = '\''v'$(date +%Y%m%d)'\'\'', branch = '\''LuCI openwrt-24.10'\'';" > /usr/share/ucode/luci/version.uc\n/etc/init.d/rpcd restart\n' package/emortal/default-settings/files/99-default-settings
curl -fsSL https://raw.githubusercontent.com/0118Add/Openwrt-CI/main/patch/os-release > package/base-files/files/etc/os-release

# 拷贝自定义文件
if [ -n "$(ls -A "${GITHUB_WORKSPACE}/immortalwrt/diy" 2>/dev/null)" ]; then
	cp -Rf ${GITHUB_WORKSPACE}/immortalwrt/diy/* .
fi

./scripts/feeds update -a
./scripts/feeds install -a

echo "========================="
echo "配置完成……"
