#!/bin/bash

# 使用 Github 加速代理
PROXY="https://ghproxy.net/"
# 你的 GitHub 仓库
REPO="chuanyin888/earnapp-deploy"
# Release 的版本号 (请确保和 GitHub 上的 Tag 完全一致，例如 v1.0.0)
VERSION="v1.0.1"

BASE_URL="${PROXY}https://github.com/${REPO}/releases/download/${VERSION}"

WORK_DIR="/tmp/earnapp_install"
mkdir -p $WORK_DIR && cd $WORK_DIR

echo "=> 检查并拉取离线安装包..."

# 1. 检查并下载 earnapp
if [ -s "earnapp" ]; then
    echo "✅ 发现本地已存在 earnapp，跳过下载。"
else
    echo "⬇️ 正在下载 earnapp..."
    wget -q --show-progress -O earnapp "${BASE_URL}/earnapp"
fi

# 2. 检查并下载 images.tar (300MB大文件)
if [ -s "images.tar" ]; then
    echo "✅ 发现本地已存在 images.tar，跳过下载。"
else
    echo "⬇️ 正在下载 images.tar (文件较大，请耐心等待)..."
    wget -q --show-progress -O images.tar "${BASE_URL}/images.tar"
fi

# 3. 获取最新版离线安装脚本 (脚本很小，每次强制拉取最新的防出错)
echo "⬇️ 正在获取离线安装脚本..."
wget -q --show-progress -O install_offline.sh "${BASE_URL}/install_offline.sh"

echo "=> 赋予执行权限并修复格式..."
chmod +x earnapp install_offline.sh

# 【核心防翻车技巧】自动删掉脚本里可能带有的 Windows 回车符(\r)，防止 command not found 报错
sed -i 's/\r$//' install_offline.sh

echo "=> 开始执行离线安装逻辑..."
bash install_offline.sh
