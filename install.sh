#!/bin/bash

# 使用 Github 加速代理，防止下载慢或失败
PROXY="https://ghproxy.net/"
# 你的 GitHub 用户名和仓库名 (记得替换下面的 chuanyin888)
REPO="chuanyin888/earnapp-deploy"
# Release 的版本号
VERSION="1.0.0"

BASE_URL="${PROXY}https://github.com/${REPO}/releases/download/${VERSION}"

WORK_DIR="/tmp/earnapp_install"
mkdir -p $WORK_DIR && cd $WORK_DIR

echo "=> 正在从 GitHub 拉取安装文件..."
wget -q --show-progress -O earnapp "${BASE_URL}/earnapp"
wget -q --show-progress -O images.tar "${BASE_URL}/images.tar"
wget -q --show-progress -O install_offline.sh "${BASE_URL}/install_offline.sh"

echo "=> 赋予执行权限..."
chmod +x earnapp install_offline.sh

echo "=> 开始执行离线安装脚本..."
bash install_offline.sh

# 可选清理

# cd /tmp && rm -rf $WORK_DIR

