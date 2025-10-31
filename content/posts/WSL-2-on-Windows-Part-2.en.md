---
title: WSL 2 on Windows Part 2 - Terminal Interface Settings
tags: [WSL, Ubuntu, Windows terminal]
categories:
  - Develop environment
date: 2021-04-11 00:14:00 +0800
slug: wsl-2-on-windows-part-2
---
![wsl2_terminal_screenshot](/images/wsl2_terminal_screenshot.png)

Bringing the terminal settings from Linux and Mac to Windows
for easier operation.

## Windows Terminal Features
With Windows Terminal, you can:
* Enable multiple tabs (quickly switch between multiple Linux CLIs, Windows CLIs, PowerShell, etc.)
* Customize key bindings (shortcuts for opening/closing tabs, copy/paste, etc.)
* Use search functionality
* Customize themes

These features offer much more than native WSL support,
and allow for a setup similar to my Linux or Mac development environments,
which is why I decided to use Windows Terminal.

## Windows Terminal Settings
After searching for and installing Windows Terminal from the Microsoft Store,
you can start configuring it.

### Setting WSL as the Default Opening Environment for Windows Terminal
In the Windows Terminal's [V] arrow menu, select "Settings,"
which will open a JSON file for modification.
From the `profiles` > `list`, find the Linux distribution you want to set as default,
for example:
```
{
    "guid": "{xxxxxxxxxxxxxxx}",
    "hidden": false,
    "name": "Ubuntu-18.04",
    "commandline": "wsl.exe",
    "source": "Windows.Terminal.Wsl"
}
```
Copy the GUID string enclosed in curly braces after `guid`,
and replace the ID of the originally default profile with that ID:
```
"defaultProfile": "{yyyyyy}"
```
(Replace `yyyyyy` with the GUID of your Linux distribution)

### Setting the Default Starting Directory for Windows Terminal
In the Linux distribution profile within the JSON settings file,
append the default directory to open (``~`` refers to the user's Linux home directory)
to the `commandline`:
```
"commandline": "wsl.exe ~",
```

### Setting the Windows Terminal Scheme
Add this line to the Linux distribution profile in the JSON settings file:
```
"colorScheme": "One Half Dark",
```
``One Half Dark`` is one of the color schemes provided by Windows.
Other schemes can be found in [Microsoft Doc: Color schemes in Windows Terminal](https://docs.microsoft.com/zh-tw/windows/terminal/customize-settings/color-schemes).

### Setting the Windows Terminal Font
Add this to the Linux distribution profile in the JSON settings file:
```
"fontFace": "xxxxx",
```
``xxxxx`` is the name of the font.
If you need to use Powerline, you can first install [Powerline fonts](https://github.com/powerline/fonts),
then fill in the desired font name.


## Reference
[Microsoft Doc: Install and set up Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started)  
[Microsoft Doc: Color schemes in Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)  
[Set Windows Terminal as WSL operating interface](https://samkuo.me/post/2020/05/windows-terminal-default-wsl-ubuntu-shell/)  
