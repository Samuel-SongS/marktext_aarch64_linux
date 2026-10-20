# marktext_aarch64_linux · arm64 构建归档

本分支是**构建归档**，不是上游源码的分支：`upstream` 源码本身是**原版 MarkText 0.21.2**（MIT），可重新下载；这里保存的是**唯一且不可重建**的部分。

## 内容
- `BUILD_arm64.md`：可复现的构建配方（Electron 42.1.0、electron-builder 26.15.3、pnpm 10.33.4、`electron-builder --linux --arm64`、产物 AppImage/tar.gz/deb）。
- `marktext_0.21.2_local_changes.patch`：本机源码树相对官方 `marktext-0.21.2.tar.gz` 的全部差异（12 个文件，全部是 `packages/desktop/static/locales/*.min.json` 的构建时重生成，无功能改动）。
- `apply.sh`：把补丁应用到官方 0.21.2 解包目录。

## 为什么用孤立分支
避免为了备份一个 400 KB 的补丁去拉取上游完整历史；源码本身可从上游取回，构建产物已另存到本地备份盘。

## 复现
```bash
curl -L -o marktext-0.21.2.tar.gz https://github.com/marktext/marktext/archive/refs/tags/v0.21.2.tar.gz
tar -xzf marktext-0.21.2.tar.gz && cd marktext-0.21.2
bash /path/to/apply.sh .
pnpm install && pnpm run build
pnpm exec electron-builder --linux --arm64
```
