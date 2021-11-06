---
title: "Remove or Upgrade Global NPM Packages After Installing NVM"
date: 2021-11-06T19:31:32+08:00
draft: false
categories:
- Develop environment
tags: [Programming, Node.js]
slug: 'remove-upgrade-npm-global-packages-after-installing-nvm'
---

今天遇到一個問題，

安裝過 `nvm` 後安裝 global package 的路徑就被改變了，

導致想要移除之前安裝過的 global package 時沒辦法直接用 `npm uninstall -g` 移除。


怎麼發現這件事的呢？

很久以前我在 global 裝過一個 package 可以直接在 terminal 用 command 呼叫 command 執行，

但因為年代久遠，

要升級那個 package 的時候發現他不在 `npm list -g` 的範圍，

只好先用 `which` 看一下他在的位置，

接著發現是一個 link 然後就用 `ls -al` 看那個 link 連到哪裡，

發現是在 `/usr/lib/node_modules` 底下，

很明顯是用 `npm -g` 安裝的，

於是再仔細的看了一下 `npm list -g` 的結果，

發現其他的 global package 都列在 `/Users/<USER_NAME>/.nvm/versions/node/v16.5.0/lib` 底下，

在一陣 google 之後找到了一個方式 `nvm use system && npm ls -g --depth=0` 來列出原本安裝過的 global package 有哪些，

悲劇的是他跳出了


```
System version of node not found.
```

看來我已經移除了系統裡的 `node` ...


於是我又找到了一個 command `nvm deactivate` 暫時 disable `nvm` ，

然後用 `brew` 再安裝一次 `node` ，

接著再 `npm list -g` 一次，

終於讓我看到那個在安裝 `nvm` 之前安裝過的 package 了！！！

可喜可賀！！

終於可以順利的移除 / 升級之前安裝的 global package 了。

搞定之後要重新把 `nvm` 叫回來只要用 `source ~/.zshrc` 之類的重啟 shell 就可以了。
