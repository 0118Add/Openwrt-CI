#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# By: BGG
#===============================================


# 更换5.4内核
sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.19/g' target/linux/x86/Makefile

# 更改主机名
sed -i "s/hostname='.*'/hostname='X86'/g" package/base-files/files/bin/config_generate

# 内核替换成 kernel 5.4.xxx
#sed -i 's/LINUX_KERNEL_HASH-5.4.203 = fc933f5b13066cfa54aacb5e86747a167bad1d8d23972e4a03ab5ee36c29798a/LINUX_KERNEL_HASH-5.4.210 = 940396878c2c183531669d87831eda60a86fbf4662904922c49151b50afc888e/g' ./include/kernel-5.4
#sed -i 's/LINUX_VERSION-5.4 = .203/LINUX_VERSION-5.4 = .210/g' ./include/kernel-5.4

# 设置密码为空
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

git clone https://github.com/gd0772/package package/gd772
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
wget https://raw.githubusercontent.com/0118Add/patch/main/gd772.sh
bash gd772.sh
