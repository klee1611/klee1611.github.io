---
title: 從所有的 git repository 移除 .DS_Store 追蹤
date: 2019-12-25 20:40:00 +0800
categories:
- Git
tags: [Git, gitignore, Tool]
slug: 'remove-ds_store-from-all-git-repo'
---

因為 ``.DS_Store`` 在 macOS 裡面到處都是，  
開個子資料夾裡面放了點東西就瞬間又多了一個 ``.DS_Store``，  
每次有新的 Git repository 就一定要在 ``.gitignore`` 裡加 ``.DS_Store`` 和 ``**/.DS_Store`` 實在是很煩人，  
所以就研究了一下看看能不能一次設定好之後就能夠一勞永逸XD  
  
## ``git config``
``git config`` 這個 command 可以拿來對 git 的各種值做設定，  
最基本的就是 ``git config --global user.name`` 和 ``git config --global user.email``這種，  
對 ``user.name`` 和 ``user.email`` 做 global 的設定，  
之後每個 Repository 就可以沿用設定好的 ``user.name`` 和 ``user.email``；  
<!--more-->
如果要再針對個別 Repository 設定不同的 ``user.name`` 和 ``user.email`` 就只要在那個 Repository 再下 local 的設定就好，  
就是 ``git config --local user.name`` 和 ``git config --local user.email``。  
  
``git config`` 有一個叫 ``core.excludesfile`` 的值，  
可以用來指定一個檔案，  
裡面可以放希望被 ignore 的檔案，  
把這個東西設定到 global，  
之後所有的 repository 就都會忽略那個檔案裡面包含的東西。  
  
所以如果要讓所有的 Repository 都忽略 ``.DS_Store``，  
就只要把 ``.DS_Store`` 和 ``**/.DS_Store`` 寫到一個檔案，  
再把 ``core.excludesfile`` 的值設定成那個檔案就可以了。  
上 code:  
  
```bash
echo ".DS_Store" >> ~/.gitignore_global
echo "**/.DS_Store" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```

