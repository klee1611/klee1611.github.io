---
title: Add LikeWidget to Jekyll theme
date: 2019-12-27 04:06:00 +0800
lastmod: 2021-11-14 22:38:00 +0800
categories:
- Blog
tags: [Likecoin, Frontend, Github Pages]
slug: 'likecoin-button-jekyll'
---
## Update
I've moved my blog from Jekyll to Hugo.  
The method for adding a like button remains similar,  
but the code and its placement need to be adjusted.  

## LikeCoin
I came across LikeCoin and it piqued my interest.  
LikeCoin is a cryptocurrency,  
which was created to encourage content creators.  

Content creators can embed a **Like Button** within their content or web pages.  
Anyone with a LikeCoin account who appreciates the content can click the button,  
and the content creator will receive the corresponding LikeCoin.  

The amount of LikeCoin a content creator receives depends on the account type of the likers.  
The LikeCoin Foundation proportionally rewards free account likers,  
while payment accounts are proportionally charged based on the number of likes they click each month.  
More details can be found on [LikeCoin's Medium](https://medium.com/likecoin).  

<!--more-->
## Like Rewards Button for Jekyll Theme
So I registered an account and found that the like button widget supports platforms like Medium, WordPress, Oice, Matters, etc. However, since Jekyll themes are custom-designed, we need to manually integrate the Like button.  

So I found an article with an embedded Like button on Medium and inspected it using my browser's developer console:  

![like_btn_in_medium](/images/likebutton_for_github_pages/code_for_likecoin.png)

It appears to be using an ``iframe``. To make it work, the ``src`` attribute needs to include our **liker ID** and the **article address**.  
So, there are two different ways to add a like button to the blog post:  
1. Add the ``iframe`` to every blog post
2. Add the ``iframe`` to the template which generates the blog posts

Clearly,  
the second approach is better.  

So I located the template that generates blog posts at ``_layouts/post.html`` in my Jekyll theme,  
and I added this code to the template after the content section:

```html
<div align="center">
    <iframe scrolling="no" src="https://button.like.co/in/embed/<MY_LIKER_ID>/button/?referrer={{ site.url }}{{ page.url }}" frameborder="0"></iframe>
</div>
```

Remember to replace the Liker ID with your own.  
``site.url`` and ``page.url`` are Liquid syntax,  
representing the URL for the current blog post.  
After adding this, every generated blog post should have a like button at the end of the article.  
