#!/bin/bash
set -euo pipefail

# Define paths
MAA_DIR="$HOME/.maa"
OCR_DIR="$MAA_DIR/resouce/ocr" # Using "resouce" as requested
TMP_DIR="/tmp/maa-installer"
MAA_ZIP="$TMP_DIR/maa.zip"
MAA_ZIP_TMP="$TMP_DIR/maa.zip.part"
OCR_ZIP="$TMP_DIR/ocr.zip"
OCR_ZIP_TMP="$TMP_DIR/ocr.zip.part"

# Create directories
mkdir -p "$MAA_DIR"
mkdir -p "$OCR_DIR"
mkdir -p "$TMP_DIR"

if [[ -f "$MAA_ZIP" ]]; then
  echo "1. MAAFramework zip already exists, skipping download..."
else
  echo "1. Downloading MAAFramework v5.10.1..."
  rm -f "$MAA_ZIP_TMP"
  curl -L "https://github.com/MaaXYZ/MaaFramework/releases/download/v5.10.1/MAA-macos-aarch64-v5.10.1.zip" -o "$MAA_ZIP_TMP"
  mv "$MAA_ZIP_TMP" "$MAA_ZIP"
fi

echo "2. Extracting MAAFramework to $MAA_DIR..."
unzip -o "$MAA_ZIP" -d "$MAA_DIR"

echo "3. Removing macOS quarantine attribute..."
sudo xattr -dr com.apple.quarantine "$MAA_DIR"

if [[ -f "$OCR_ZIP" ]]; then
  echo "4. OCR zip already exists, skipping download..."
else
  echo "4. Downloading OCR resources..."
  rm -f "$OCR_ZIP_TMP"
  curl -L "https://github.com/a690700752/MAA-installer/raw/refs/heads/master/ppocr_v5-zh_cn.zip" -o "$OCR_ZIP_TMP"
  mv "$OCR_ZIP_TMP" "$OCR_ZIP"
fi

echo "5. Extracting OCR resources to $OCR_DIR..."
unzip -o "$OCR_ZIP" -d "$OCR_DIR"

echo "6. Installing mpelb..."
curl -fsSL https://raw.githubusercontent.com/kqcoxn/MaaPipelineEditor/main/tools/install.sh | bash

# Ensure mpelb is in PATH for the current session if it was just installed
export PATH="$HOME/.local/bin:$PATH"

echo "7. Configuring mpelb lib path..."
mpelb config set-lib "$MAA_DIR/bin"

echo "8. Configuring mpelb resource path..."
mpelb config set-resource "$MAA_DIR/resouce"

echo "------------------------------------------------"
echo "安装完成！"
echo "在maa项目下执行 mpelb 启动编辑器"
echo "执行 uvx MaaDebugger 启动运行器(如果 MaaDebugger 启动报错，使用 all_proxy= uvx --python 3.13 MaaDebugger 试试)。"

# Cleanup
rm -rf "$TMP_DIR"
