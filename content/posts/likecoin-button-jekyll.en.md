---
title: Add LikeWidget to Jekyll theme
date: 2019-12-27 04:06:00 +0800
lastmod: 2021-11-14 22:38:00 +0800
categories:
- Blog
tags: [Likecoin, Cryptocurrency, Frontend, Github Pages]
slug: 'likecoin-button-jekyll'
---
## Update
I've moved my blog from Jekyll to Hugo.  
The way to add like button stays the same,  
but the code and where to place the code have to change.  

## LikeCoin
I came across LikeCoin and it piqued my interest.  
LikeCoin is a cryptocurrency,  
which is invented to encourage content creators.  

The content creator can embed a **Like Button** within the content/web page,  
so anyone with a like account who appreciates the content can click the button,  
and the content creator will receive the corresponding LikeCoin.  

The amount of LikeCoin the content creator will receive depends on the account type of the likers.  
The LikeCoin Foundation will pay in proportion for the free account likers,  
and payment accounts will pay in proportion for how many likes they click at the month.  
The detail can be found at [LikeCoin's Medium](https://medium.com/likecoin).  

<!--more-->
## Like Rewords Button for Jekyll Theme
So I register an account,  
and find that the like button widget supports Medium, WordPress, Oice, Matters, ...etc,  
but since Jekyll is customized designed,  
we have to find our way to add the Like button ourselves.  

So I find an article embeded a Like button in Medium,  
and inspect with the developer console from my browser:  

![like_btn_in_medium](/images/likebutton_for_github_pages/code_for_likecoin.png)

Seems like it is using ``iframe``，  
put the address of ``src`` to be our **liker ID** and the **article address** to make it work.  
So, there are two different ways to add a like button to the blog post:  
1. Add the ``iframe`` to every blog post
2. Add the ``iframe`` to the template which generates the blog posts

Clearly,  
the second way is better.  

So I find the template which generates the blog posts at ``_layouts/post.html`` in my Jekyll theme,  
so I add this to the template after the content was located:

```html
<div align="center">
    <iframe scrolling="no" src="https://button.like.co/in/embed/<MY_LIKER_ID>/button/?referrer={{ site.url }}{{ page.url }}" frameborder="0"></iframe>
</div>
```

Remember to replace the Liker ID to be your own.  
``site.url`` and ``page.url`` are ``Liquid``'s grammar,  
which stands for the URL for the current blog post.  
After adding this every blog post generated should have a like button at the end of the article.  
