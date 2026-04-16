# MAA-installer

MAAFramework macOS (aarch64) 一键安装工具。

## 快速安装

在终端执行以下命令即可一键完成 MAAFramework、OCR 资源和 `mpelb` 的安装与配置：

```bash
curl -fsSL https://raw.githubusercontent.com/a690700752/MAA-installer/master/install.sh | bash
```

## 包含内容

1. **MAAFramework v5.10.1**: 核心框架。
2. **OCR 资源**: `ppocr_v5-zh_cn` 模型。
3. **MPE Local Bridge (mpelb)**: 管道编辑器本地桥。

## 使用说明

### 启动编辑器
在你的 MAA 项目目录下执行：
```bash
mpelb
```

### 启动运行器
执行：
```bash
uvx MaaDebugger
```
*如果报错，请尝试强制指定 Python 版本：*
```bash
uvx --python 3.13 MaaDebugger
```

## 安装路径
- **MAA 根目录**: `~/.maa`
- **二进制文件**: `~/.maa/bin`
- **OCR 资源**: `~/.maa/resouce/ocr`
