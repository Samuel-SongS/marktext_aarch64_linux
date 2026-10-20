# MarkText ARM64 构建说明（Ubuntu arm64）

## 结论：源码是原版 0.21.2，ARM 构建是"构建配置 + 产物"层面的事
- 与官方 `marktext-0.21.2` tar 包逐文件对比（排除 `node_modules`、`dist`、`out`、`.git`），**源码差异只有 12 个 `packages/desktop/static/locales/*.min.json`**（构建时重新生成的压缩 locale，属副产物），**没有功能源码改动**。
- 因此仓库里值得留的不是"源码补丁"，而是**构建配方**与（可选）**产物**。

## 产物
- `~/Applications/MarkText/`（Electron 解包目录，约 267 MB）与 `~/Applications/MarkText` 可执行入口。
- 源码树：`~/build/marktext`（0.21.2 解包后构建）；原包：`~/build/marktext-0.21.2.tar.gz`（23.9 MB）。
- 构建日志：`~/build/electron-builder.log`、`electron-builder2.log`、`electron-rebuild.log`、`pnpm-install.log`。

## 建议放入 fork 的内容
1. **本说明 + 构建命令**（下）；
2. 可选：把构建出的 AppImage 作为 **GitHub Release** 附件（不要塞进 git 历史）；
3. **不要**提交 `node_modules/`、`dist/`、`out/`。

## 构建步骤（arm64）——以下版本取自本机构建日志，可复现
- Node `>=20.19.0`、pnpm `10.33.4`、Electron `42.1.0`、electron-builder `26.15.3`
- 构建配置：`packages/desktop/electron-builder.yml`（未改动）
- 实际命令与产物（日志原文）：
```
packaging  platform=linux arch=arm64 electron=42.1.0 appOutDir=.../dist/linux-arm64-unpacked
building   target=AppImage arch=arm64 file=.../dist/marktext-linux-0.21.2.AppImage
building   target=tar.gz   arch=arm64 file=.../dist/marktext-linux-0.21.2.tar.gz
building   target=deb      arch=arm64 file=.../dist/marktext-linux-0.21.2.deb
```
```bash
tar -xzf marktext-0.21.2.tar.gz && cd marktext-0.21.2
pnpm install
pnpm run build                          # pnpm --filter marktext build
pnpm exec electron-builder --linux --arm64
```
- 产物在 `~/build/marktext/dist/`（AppImage / tar.gz / deb）与 `~/Applications/MarkText/`。

## 与 fork 的关系
目标仓库：`https://github.com/Samuel-SongS/marktext_aarch64_linux`（MIT 允许 fork）。建议新建分支 `arm64-build`，只放本说明与最小构建脚本；源码保持与上游一致，便于日后跟随上游升级。
