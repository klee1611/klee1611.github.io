---
title: WSL 2 on Windows Part 1 - 安裝啟用
author: Kourtney Lee 李國秀
tags:
  - WSL
  - Ubuntu
categories:
  - Develop environment
date: 2021-04-10 15:52:00
slug: 'wsl-2-on-windows-part-1'
---
工作的時候習慣用 Linux 或 mac 的 terminal，  
找了個時間在家裡的 PC 上把 WSL 的環境也設定一下方便切換工作環境。  


## WSL 2 和 WSL 1 的差異
WSL 2 是基於 Hyper-V 在 virtual machine 中**跑完整的 Linux kernal**，  
WSL 1 則是在 Windows 系統上對 Linux 功能的模擬，  
因此 WSL 2 比 WSL 1 **支援更多 Linux 原生的功能和 system call**。
<!-- more -->

如果需要用到 Linux 底層的應用，  
WSL 2 支援的能力比 WSL 1 更好。  
一般情況下 WSL 2 啟動 process 的效能也更好，  
但需要讀取 host 系統的檔案時除外。  

但因為 WSL 2 是在 VM 上跑 Linux kernal，  
因此和做為 host 的 Windows 的整合相對較 WSL 1 差。  
在 WSL 2 裡的 process 無法在 Windwos 的工作管理員控管，  
Windows 和 WSL 2 的網路連線方式也多了一層。  

因為 WSL 2 用了 Hyper-V 的關係，  
所以有聽過跟 VMWare 不相容的災情。  
我沒有用 VMWare 所以不知道是不是真的有這個 issue，  
但用 Docker 的時候沒有產生問題。

[Microsoft Doc](https://docs.microsoft.com/zh-tw/windows/wsl/compare-versions) 有列舉出 WSL 1 和 WSL 2 詳細的比較。

## Requirement
1. Windwos 版本要是 Windows 10，低於這些版本的話請善用 Windows 更新:
	* 若為 X64 系統：版本 1903 或更高版本，含 組建 18362 或更高組建。
	* 若為 ARM64 系統：版本 2004 或更高版本，含 組建 19041 或更高組建。  

2. 機器要**開啟虛擬化功能**，  
通常在主機板的 BIOS 設定裡可以找到，  
找找跟 CPU 設定相關的地方應該會有一些 **Intel Virtualization** 有關的設定，  
把它開起來。


## 安裝啟用 WSL 2
用 admin 權限開啟 PowerShell，  
1. 啟用Windows 子系統 Linux 版: 執行  
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
2. 啟用虛擬機器平台選用功能: 執行
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
3. 重新啟動電腦
4. 下載安裝 [WSL 2 Linux 核心更新套件](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
5. 將 WSL 2 設定為預設版本
```
wsl --set-default-version 2
```
6. 去 Microsoft Store 找想安裝的 Linux distribution，  
並安裝設定帳號密碼
7. 可以在 PowerShell 中檢查安裝的 Linux distribution 的 WSL 版本:
```
wsl -l -v
```
也可以更改 Linux distribution 的 WSL 版本:
```
wsl --set-version <distribution name> <versionNumber>
```


## Reference
[Microsoft WSL 2 安裝指南](https://docs.microsoft.com/zh-tw/windows/wsl/install-win10)  
[Microsoft DOC: 比較 WSL 1 和 WSL 2](https://docs.microsoft.com/zh-tw/windows/wsl/compare-versions)
