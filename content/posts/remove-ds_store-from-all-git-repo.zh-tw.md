---
title: 從所有的 git repository 移除 .DS_Store 追蹤
date: 2019-12-25 20:40:00 +0800
lastmod: 2021-11-14 02:40:33 +0800
categories:
- Git
tags: [Git, gitignore, Tool]
slug: 'remove-ds_store-from-all-git-repo'
---
每當建立一個新的資料夾並在裡面放了一些檔案，  
MacOS 就會在該資料夾下自動產生一個 ``.DS_Store`` 檔案，  
也就導致了 ``.DS_Store`` 在 macOS 裡面散的到處都是。  
而每次有新的 Git repository 就一定要在 ``.gitignore`` 裡加 ``.DS_Store`` 和 ``**/.DS_Store`` 實在是很煩人，  
所以就研究了一下找了個辦法一次設定好之後就能夠一勞永逸。  

## ``git config`` 指令
``git config`` 這個指令可以拿來對 git 的各種值做設定，  
最出名的就是 ``git config --global user.name`` 和 ``git config --global user.email``這種，  
對 ``user.name`` 和 ``user.email`` 做 global 的設定，  
之後每個 Repository 就可以沿用設定好的 ``user.name`` 和 ``user.email``；  
<!--more-->

這個指令也可以針對個別的 git repository 做單獨設定，  
如果想要針對個別 Repository 設定不同的 ``user.name`` 和 ``user.email``，  
只要在那個 Repository 下用``git config --local user.name`` 和 ``git config --local user.email`` 去單獨做local 的設定就好。  

``git config`` 有一個叫 ``core.excludesfile`` 的設定，  
可以用來指定一個檔案，  
裡面可以放希望被 ignore 的檔案，  
把這個東西設定到 global，  
之後所有的 repository 就都會忽略那個檔案裡面包含的東西。  

所以如果要讓所有的 Repository 都忽略 ``.DS_Store``，  
就只要把 ``.DS_Store`` 和 ``**/.DS_Store`` 寫到一個檔案，  
再把 ``core.excludesfile`` 的值設定成那個檔案就可以了。  

可以用下面的指令做到這件事:  

```bash
echo ".DS_Store" >> ~/.gitignore_global
echo "**/.DS_Store" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```
