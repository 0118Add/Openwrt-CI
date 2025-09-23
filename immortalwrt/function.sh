#!/bin/bash

# 打包Toolchain
if [[ $REBUILD_TOOLCHAIN = 'true' ]]; then
    echo -e "\e[1;33m开始打包toolchain目录\e[0m"
    cd $OPENWRT_PATH
    sed -i 's/ $(tool.*\/stamp-compile)//' Makefile
    [ -d ".ccache" ] && (ccache=".ccache"; ls -alh .ccache)
    du -h --max-depth=1 ./staging_dir
    du -h --max-depth=1 ./ --exclude=staging_dir
    tar -I zstdmt -cf $GITHUB_WORKSPACE/output/$CACHE_NAME.tzst staging_dir/host* staging_dir/tool* $ccache
    ls -lh $GITHUB_WORKSPACE/output
    [ -e $GITHUB_WORKSPACE/output/$CACHE_NAME.tzst ] || exit 1
    exit 0
fi

[ -d $GITHUB_WORKSPACE/output ] || mkdir $GITHUB_WORKSPACE/output

color() {
    case $1 in
        cr) echo -e "\e[1;31m$2\e[0m" ;;
        cg) echo -e "\e[1;32m$2\e[0m" ;;
        cy) echo -e "\e[1;33m$2\e[0m" ;;
        cb) echo -e "\e[1;34m$2\e[0m" ;;
        cp) echo -e "\e[1;35m$2\e[0m" ;;
        cc) echo -e "\e[1;36m$2\e[0m" ;;
    esac
}

status() {
    local check=$? end_time=$(date '+%H:%M:%S') total_time
    total_time="==> 用时 $[$(date +%s -d $end_time) - $(date +%s -d $begin_time)] 秒"
    [[ $total_time =~ [0-9]+ ]] || total_time=""
    if [[ $check = 0 ]]; then
        printf "%-62s %s %s %s %s %s %s %s\n" \
        $(color cy $1) [ $(color cg ✔) ] $(echo -e "\e[1m$total_time")
    else
        printf "%-62s %s %s %s %s %s %s %s\n" \
        $(color cy $1) [ $(color cr ✕) ] $(echo -e "\e[1m$total_time")
    fi
}

find_dir() {
    find $1 -maxdepth 3 -type d -name $2 -print -quit 2>/dev/null
}

print_info() {
    printf "%s %-40s %s %s %s\n" $1 $2 $3 $4 $5
    # read -r param1 param2 param3 param4 param5 <<< $1
    # printf "%s %-40s %s %s %s\n" $param1 $param2 $param3 $param4 $param5
}

# 添加整个源仓库(git clone)
git_clone() {
    local repo_url branch target_dir current_dir
    if [[ "$1" == */* ]]; then
        repo_url="$1"
        shift
    else
        branch="-b $1 --single-branch"
        repo_url="$2"
        shift 2
    fi
    if [[ -n "$@" ]]; then
        target_dir="$@"
    else
        target_dir="${repo_url##*/}"
    fi
    git clone -q $branch --depth=1 $repo_url $target_dir 2>/dev/null || {
        print_info $(color cr 拉取) $repo_url [ $(color cr ✕) ]
        return 0
    }
    rm -rf $target_dir/{.git*,README*.md,LICENSE}
    current_dir=$(find_dir "package/ feeds/ target/" "$target_dir")
    if ([[ -d $current_dir ]] && rm -rf $current_dir); then
        mv -f $target_dir ${current_dir%/*}
        print_info $(color cg 替换) $target_dir [ $(color cg ✔) ]
    else
        mv -f $target_dir $destination_dir
        print_info $(color cb 添加) $target_dir [ $(color cb ✔) ]
    fi
}

# 添加源仓库内的指定目录
clone_dir() {
    local repo_url branch temp_dir=$(mktemp -d)
    if [[ "$1" == */* ]]; then
        repo_url="$1"
        shift
    else
        branch="-b $1 --single-branch"
        repo_url="$2"
        shift 2
    fi
    git clone -q $branch --depth=1 $repo_url $temp_dir 2>/dev/null || {
        print_info $(color cr 拉取) $repo_url [ $(color cr ✕) ]
        return 0
    }
    local target_dir source_dir current_dir
    for target_dir in "$@"; do
        source_dir=$(find_dir "$temp_dir" "$target_dir")
        [[ -d $source_dir ]] || \
        source_dir=$(find $temp_dir -maxdepth 4 -type d -name $target_dir -print -quit) && \
        [[ -d $source_dir ]] || {
            print_info $(color cr 查找) $target_dir [ $(color cr ✕) ]
            continue
        }
        current_dir=$(find_dir "package/ feeds/ target/" "$target_dir")
        if ([[ -d $current_dir ]] && rm -rf $current_dir); then
            mv -f $source_dir ${current_dir%/*}
            print_info $(color cg 替换) $target_dir [ $(color cg ✔) ]
        else
            mv -f $source_dir $destination_dir
            print_info $(color cb 添加) $target_dir [ $(color cb ✔) ]
        fi
    done
    rm -rf $temp_dir
}

# 添加源仓库内的所有目录
clone_all() {
    local repo_url branch temp_dir=$(mktemp -d)
    if [[ "$1" == */* ]]; then
        repo_url="$1"
        shift
    else
        branch="-b $1 --single-branch"
        repo_url="$2"
        shift 2
    fi
    git clone -q $branch --depth=1 $repo_url $temp_dir 2>/dev/null || {
        print_info $(color cr 拉取) $repo_url [ $(color cr ✕) ]
        return 0
    }
    local target_dir source_dir current_dir
    for target_dir in $(ls -l $temp_dir/$@ | awk '/^d/ {print $NF}'); do
        source_dir=$(find_dir "$temp_dir" "$target_dir")
        current_dir=$(find_dir "package/ feeds/ target/" "$target_dir")
        if ([[ -d $current_dir ]] && rm -rf $current_dir); then
            mv -f $source_dir ${current_dir%/*}
            print_info $(color cg 替换) $target_dir [ $(color cg ✔) ]
        else
            mv -f $source_dir $destination_dir
            print_info $(color cb 添加) $target_dir [ $(color cb ✔) ]
        fi
    done
    rm -rf $temp_dir
}

# 设置编译源码与分支
REPO_URL="https://github.com/immortalwrt/immortalwrt"
echo "REPO_URL=$REPO_URL" >>$GITHUB_ENV
REPO_BRANCH="master"
echo "REPO_BRANCH=$REPO_BRANCH" >>$GITHUB_ENV

# 开始拉取编译源码
#begin_time=$(date '+%H:%M:%S')
#[[ $REPO_BRANCH != "master" ]] && BRANCH="-b $REPO_BRANCH --single-branch"
#cd /workdir
#git clone -q $BRANCH $REPO_URL openwrt
#status "拉取编译源码"
#ln -sf /workdir/openwrt $GITHUB_WORKSPACE/openwrt
#[ -d openwrt ] && cd openwrt || exit
#echo "OPENWRT_PATH=$PWD" >>$GITHUB_ENV

# 开始生成全局变量
begin_time=$(date '+%H:%M:%S')
[ -e $GITHUB_WORKSPACE/$CONFIG_FILE ] && cp -f $GITHUB_WORKSPACE/$CONFIG_FILE .config
make defconfig 1>/dev/null 2>&1

# 源仓库与分支
SOURCE_REPO=$(basename $REPO_URL)
echo "SOURCE_REPO=$SOURCE_REPO" >>$GITHUB_ENV
echo "LITE_BRANCH=${REPO_BRANCH#*-}" >>$GITHUB_ENV

# 平台架构
TARGET_NAME=$(awk -F '"' '/CONFIG_TARGET_BOARD/{print $2}' .config)
SUBTARGET_NAME=$(awk -F '"' '/CONFIG_TARGET_SUBTARGET/{print $2}' .config)
DEVICE_TARGET=$TARGET_NAME-$SUBTARGET_NAME
echo "DEVICE_TARGET=$DEVICE_TARGET" >>$GITHUB_ENV

# 内核版本
KERNEL=$(grep -oP 'KERNEL_PATCHVER:=\K[^ ]+' target/linux/$TARGET_NAME/Makefile)
KERNEL_VERSION=$(awk -F '-' '/KERNEL/{print $2}' target/linux/generic/kernel-$KERNEL | awk '{print $1}')
echo "KERNEL_VERSION=$KERNEL_VERSION" >>$GITHUB_ENV

# Toolchain缓存文件名
TOOLS_HASH=$(git log --pretty=tformat:"%h" -n1 tools toolchain)
CACHE_NAME="$SOURCE_REPO-${REPO_BRANCH#*-}-$DEVICE_TARGET-cache-$TOOLS_HASH"
echo "CACHE_NAME=$CACHE_NAME" >>$GITHUB_ENV

# 源码更新信息
COMMIT_AUTHOR=$(git show -s --date=short --format="作者: %an")
echo "COMMIT_AUTHOR=$COMMIT_AUTHOR" >>$GITHUB_ENV
COMMIT_DATE=$(git show -s --date=short --format="时间: %ci")
echo "COMMIT_DATE=$COMMIT_DATE" >>$GITHUB_ENV
COMMIT_MESSAGE=$(git show -s --date=short --format="内容: %s")
echo "COMMIT_MESSAGE=$COMMIT_MESSAGE" >>$GITHUB_ENV
COMMIT_HASH=$(git show -s --date=short --format="hash: %H")
echo "COMMIT_HASH=$COMMIT_HASH" >>$GITHUB_ENV
status "生成全局变量"

# 下载并部署Toolchain
if [[ $TOOLCHAIN = 'true' ]]; then
    cache_xa=$(curl -sL api.github.com/repos/$GITHUB_REPOSITORY/releases | awk -F '"' '/download_url/{print $4}' | grep $CACHE_NAME)
    cache_xc=$(curl -sL api.github.com/repos/Jejz168/toolchain-cache/releases | awk -F '"' '/download_url/{print $4}' | grep $CACHE_NAME)
    if [[ $cache_xa || $cache_xc ]]; then
        begin_time=$(date '+%H:%M:%S')
        [ $cache_xa ] && wget -qc -t=3 $cache_xa || wget -qc -t=3 $cache_xc
        [ -e *.tzst ]; status "下载toolchain缓存文件"
        [ -e *.tzst ] && {
            begin_time=$(date '+%H:%M:%S')
            tar -I unzstd -xf *.tzst || tar -xf *.tzst
            [ $cache_xa ] || (cp *.tzst $GITHUB_WORKSPACE/output && echo "OUTPUT_RELEASE=true" >>$GITHUB_ENV)
            sed -i 's/ $(tool.*\/stamp-compile)//' Makefile
            [ -d staging_dir ]; status "部署toolchain编译缓存"
        }
    else
        echo "REBUILD_TOOLCHAIN=true" >>$GITHUB_ENV
    fi
else
    echo "REBUILD_TOOLCHAIN=true" >>$GITHUB_ENV
fi

# 开始更新&安装插件
begin_time=$(date '+%H:%M:%S')
./scripts/feeds update -a 1>/dev/null 2>&1
./scripts/feeds install -a 1>/dev/null 2>&1
status "更新&安装插件"

# 创建插件保存目录
destination_dir="package/A"
[ -d $destination_dir ] || mkdir -p $destination_dir

color cy "添加&替换插件"
