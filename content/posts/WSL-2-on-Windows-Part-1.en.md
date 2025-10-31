---
title: WSL 2 on Windows Part 1 - Installation and Activation
tags:
  - WSL
  - Ubuntu
categories:
  - Develop environment
date: 2021-04-10 15:52:00
slug: 'wsl-2-on-windows-part-1'
---
I'm used to using Linux or Mac terminals for work.  
I took some time to set up the WSL environment on my home PC to easily switch work environments.  

## Differences between WSL 2 and WSL 1
WSL 2 is based on Hyper-V and **runs a full Linux kernel** in a virtual machine.  
WSL 1 is a simulation of Linux functionalities on the Windows system.  
Therefore, WSL 2 **supports more native Linux features and system calls** than WSL 1.  
<!-- more -->

If you need to use low-level Linux applications,  
WSL 2 offers better support than WSL 1.  
Generally, WSL 2 also has better performance for starting processes,  
except when reading files from the host system.  

However, because WSL 2 runs a Linux kernel in a VM,  
its integration with Windows as the host is relatively poorer than WSL 1.  
Processes within WSL 2 cannot be managed by Windows Task Manager,  
and there's an additional layer in the network connection between Windows and WSL 2.  

Due to WSL 2's use of Hyper-V,  
I've heard reports of incompatibility issues with VMWare.  
I don't use VMWare, so I don't know if this issue is real,  
but I haven't encountered any problems when using Docker.  

[Microsoft Doc](https://docs.microsoft.com/zh-tw/windows/wsl/compare-versions) lists a detailed comparison of WSL 1 and WSL 2.  

## Requirements
1. Windows version must be Windows 10. If your version is lower, please use Windows Update:
	* For X64 systems: Version 1903 or higher, with Build 18362 or higher.
	* For ARM64 systems: Version 2004 or higher, with Build 19041 or higher.

2. The machine must have **virtualization features enabled**.  
This can usually be found in the motherboard's BIOS settings.  
Look for settings related to CPU configuration, such as **Intel Virtualization**,  
and enable it.  


## Installing and Activating WSL 2
Open PowerShell with administrator privileges.  
1. Enable Windows Subsystem for Linux: Run
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
2. Enable Virtual Machine Platform optional feature: Run
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
3. Restart your computer.
4. Download and install the [WSL 2 Linux kernel update package](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi).
5. Set WSL 2 as the default version:
```
wsl --set-default-version 2
```
6. Go to the Microsoft Store,  
find the Linux distribution you want to install,  
and install it, setting up your account and password.  
7. You can check the WSL version of the installed Linux distribution in PowerShell:
```
wsl -l -v
```
You can also change the WSL version of a Linux distribution:
```
wsl --set-version <distribution name> <versionNumber>
```


## Reference
[Microsoft WSL 2 Installation Guide](https://docs.microsoft.com/zh-tw/windows/wsl/install-win10)  
[Microsoft DOC: Compare WSL 1 and WSL 2](https://docs.microsoft.com/zh-tw/windows/wsl/compare-versions)
