#!/usr/bin/env bash
# 把本目录的补丁应用到官方 0.21.2 解包目录： bash apply.sh <marktext-0.21.2 目录>
set -eu
TARGET="${1:?用法: bash apply.sh <marktext-0.21.2 目录>}"
HERE="$(cd "$(dirname "$0")" && pwd)"
patch -p1 -d "$TARGET" < "$HERE/marktext_0.21.2_local_changes.patch"
echo "[apply] done"
