---
title: WSL 2 on Windows Part 2 - Terminal 介面設定
tags: [WSL, Ubuntu, Windows terminal]
categories:
  - Develop environment
date: 2021-04-11 00:14:00 +0800
slug: wsl-2-on-windows-part-2
---
![wsl2_terminal_screenshot](/images/wsl2_terminal_screenshot.png)

把在 Linux 和 Mac 上 terminal 的設定也搬到 Windows 上，  
方便操作。

## Windows Terminal 功能
用 Windows terminal 可以
* 啟用多個分頁 (在多個 Linux CLI、Windows CLI、PowerShell等之間快速切換)
* 自訂按鍵 (開啟或關閉分頁、複製+貼上等快速鍵)
* 使用搜尋功能
* 自訂佈景主題
  
這些功能比原生 WSL 能支援的多的多，  
也可以設定的和我在 Linux 或 Mac 的開發環境比較相似，  
於是就決定選用 windows terminal 了。  

## Windows terminal 設定
到 Microsoft store 搜尋 Windows terminal 並安裝完成後，  
就可以開始設定 Windows terminal。  
  
### 將 WSL 設定為 Windows terminal 預設開啟環境 
在 windows terminal 的 [V] 箭頭選單選擇"設定(settings)"，  
會出現一個 JSON 檔可以修改，  
從 ``profiles`` 的 ``list`` 找到想要做為預設的 Linux distribution，  
例如:
```
{
    "guid": "{xxxxxxxxxxxxxxx}",
    "hidden": false,
    "name": "Ubuntu-18.04",
    "commandline": "wsl.exe",
    "source": "Windows.Terminal.Wsl"
}
```
把 guid 後面那串被大括號括起來的 ID 複製起來，  
用那個 ID 取代原本預設開啟的 profile 的 ID:
```
"defaultProfile": "{yyyyyy}"
```
(把 yyyyyy 的地方換成 Linux distribution 的 GUID)

### 設定 Windows terminal 預設開啟目錄  
把 JSON 設定檔的 Linux distribution profile 中的  
```
"commandline": "wsl.exe",
```
後面補上預設要開啟的目錄 (``~`` 即為使用者 linux 的 home direcotry)
```
"commandline": "wsl.exe ~",
```

### 設定 Windows terminal Scheme
在 JSON 設定檔的 Linux distribution profile 裡加上這行:
```
"colorScheme": "One Half Dark",
```
``One Half Dark`` 是 Windows 提供的其中一種色彩配置，  
還有其他種可以在 [Microsoft Doc: Windows 終端機中的色彩配置](https://docs.microsoft.com/zh-tw/windows/terminal/customize-settings/color-schemes) 中找尋。

### 設定 Windows terminal 字型
在 JSON 設定檔的 Linux distribution profile 裡加上
```
"fontFace": "xxxxx",
```
``xxxxx`` 的地方是字型的名稱。  
如果有需要使用 Powerline 的需求的話可以先安裝好 [Powerline fonts](https://github.com/powerline/fonts)，  
再把想要的字型名稱填進去。  


## Reference
[Microsoft Doc: 安裝和設定 Windows 終端機](https://docs.microsoft.com/zh-tw/windows/terminal/get-started)  
[設定 Windows Terminal 作為 WSL 操作介面](https://samkuo.me/post/2020/05/windows-terminal-default-wsl-ubuntu-shell/)  
[Microsoft Doc: Windows 終端機中的色彩配置](https://docs.microsoft.com/zh-tw/windows/terminal/customize-settings/color-schemes)
