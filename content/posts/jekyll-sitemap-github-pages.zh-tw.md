---
title: Github Pages and Jekyll - sitemap
date: 2019-12-30 22:19:00 +0800
lastmod: 2021-11-15 17:30:00 +0800
categories:
- Blog
tags: [Programming, Jekyll, SEO, Github Pages]
slug: jekyll-sitemap-github-pages
---
## 更新
已從 Jekyll migrate 到 Hugo，  
這篇方法僅適用 Jekyll。  

## Sitemap
sitemap 基本上就一個 ``.xml`` 檔案，  
裡面包含了網站有哪些頁面連結，  
讓搜尋引擎去爬，  
搜尋引擎爬完以後就可以建立 index，  
之後有人在搜尋引擎打關鍵字才搜尋的到。  

## Jekyll-sitemap
Jekyll 有一個 plugin 叫做 [jekyll-stiemap](https://github.com/jekyll/jekyll-sitemap)，  
可以在每次 build 網站之後自動產生 sitemap。  

<!--more-->
如果是自己的機器架站的話其實是個不錯的選擇，  
一開始我在 Github Page 用 Jekyll 建 Blog 也是用這個，  
但後來發現不曉得究竟是版本問題還是因為 Github Pages 在 build 網站的時候用的是不同的方法或參數，  
sitemap 是生出來了沒有錯，  
但是網址前段的部分因為莫名其妙的原因被吃掉了。  

## 自己生 sitemap
最後只好 Google 一下看看有沒有人是自己生 sitemap 的，  
就找到了[這個](https://poychang.github.io/generating-sitemap-in-jekyll-without-plugin/)，  
似乎可以 work，  
於是直接抓來改，  
然後放到 repository 的 ``sitemap.xml``，  
build 完之後檢查一下沒有問題就成功了。  
