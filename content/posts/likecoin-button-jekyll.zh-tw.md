---
title: Add LikeWidget to Jekyll theme
date: 2019-12-27 04:06:00 +0800
lastmod: 2021-11-14 22:38:00 +0800
categories:
- Blog
tags: [Likecoin, Cryptocurrency, Blockchain, Frontend, Github Pages]
slug: 'likecoin-button-jekyll'
---
## 更新
已從 Jekyll migrate 到 Hugo，  
這篇方法原理不變但 code 放的位置和內容要修正。  

## LikeCoin
前陣子對 LikeCoin 發生了一點興趣，  
LikeCoin 是一種虛擬貨幣，  
創立的初衷是想做為一種獎勵創作者的機制，  
創作者在文章裡放入 **Like Button**，  
讓大家對他的按鈕按讚鼓掌，  
他就能收到相對的 LikeCoin。  

至於作者能獲得多少 LikeCoin 就要看按讚讀者的帳戶種類，  
如果讀者註冊的是免費帳戶，  
那點下的讚就由 LikeCoin 的基金會按比例支付;  
如果讀者註冊的是付費帳戶，  
那就看該讀者當月按下多少讚按比例分配。  
詳情可以參考 [LikeCoin 的 Medium](https://medium.com/likecoin/%E8%AE%9A%E8%B3%9E%E5%85%AC%E6%B0%91%E6%87%B6%E4%BA%BA%E5%8C%85-e7079686bf6e)。  

<!--more-->
## 在 Jekyll Theme 加入 Like Rewords Button
因為看起來很有趣的樣子所以我就註冊了一個帳號，  
然後默默的發現 Like Button 的 Widget 有支援 Medium, WordPress, Oice, Matters, ...等等等等，  
但是因為 Jekyll theme 要怎麼設計完全是看個人，  
所以只能自己想辦法加。  

於是我只好去 Medium 隨便找了個有加 Like Button 的文章，  
把 Firefox 的 Developer Console 打開觀察了一下:  

![like_btn_in_medium](/images/likebutton_for_github_pages/code_for_likecoin.png)

原來是用 ``iframe``，  
``src`` 的網址看起來直接把黑筆塗掉的地方替換成自己的 **liker ID** 跟**文章網址**應該就能 Work 了。  
所以要把 Like Button 加到 blog post 裡有兩種方法:  
1. 把 ``iframe`` 加到 blog post  
2. 把 ``iframe`` 加到產生 blog post 的 template html  

顯然第二種方法比較好，  
只要加一次之後所有的 blog post 在產生的時候就可以自己生出 Like Button。  

我用的 jekyll theme 產生 blog post 的 template html 放在 ``_layouts/post.html``，  
所以我就在放 content 的地方的最後面加上了：  

```html
<div align="center">
    <iframe scrolling="no" src="https://button.like.co/in/embed/<MY_LIKER_ID>/button/?referrer={{ site.url }}{{ page.url }}" frameborder="0"></iframe>
</div>
```

Liker ID 要換成自己的 Liker ID，  
``site.url`` 和 ``page.url`` 是 ``Liquid`` 的語法，  
代表的是當下的那篇 blog post 的網址，  
加完之後之後每篇 blog post 都會自己產生一個 Like button 了。  
