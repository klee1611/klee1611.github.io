---
title: Github Pages and Jekyll - sitemap
date: 2019-12-30 22:19:00 +0800
lastmod: 2021-11-15 17:30:00 +0800
categories:
- Blog
tags: [Programming, Jekyll, SEO, Github Pages]
slug: jekyll-sitemap-github-pages
---
## Update
I've moved from Jekyll to Hugo.  
This method is only applicable to Jekyll.  

## Sitemap
A sitemap is an `.xml` file that contains links to all the pages within a website.  
With a sitemap,  
a search engine can discover the pages and subsequently create indexes for them.  
Then, people browsing the internet can find those pages using keywords.  

## Jekyll-sitemap
There is a plugin called [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap) for Jekyll,  
which automatically generates a sitemap whenever the website is rebuilt.  

<!--more-->
It is a good choice if you build your website locally,  
but with GitHub Pages,  
it doesn't work as expected.  

It's unclear if this is due to the parameters or how GitHub builds websites;  
The sitemap is generated,  
but the URLs are incorrect.  

## Generates sitemap without plugin
So I found [this](https://poychang.github.io/generating-sitemap-in-jekyll-without-plugin/),  
which seemed to work, so I decided to give it a try,  
modified it, and placed it in `sitemap.xml` inside the repository,  
and it did work!  
