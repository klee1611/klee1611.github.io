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
This method only fits Jekyll.  

## Sitemap
A sitemap is a `.xml` file that contains the links to all the pages inside a website.  
With a sitemap,  
a search engine knows the pages and can therefore create indexes for them.  
Then, people surfing the internet can find those pages with keywords after that.  

## Jekyll-sitemap
There is a plugin called [jekyll-stiemap](https://github.com/jekyll/jekyll-sitemap) for Jekyll,  
which generates a sitemap automatically whenever the website is re-building.  

<!--more-->
It is a good choice if you build your website on your machine,  
but with GitHub Pages,  
it is broken.  

Not sure if that is because of the parameters or the way Github used to build a website;  
The sitemap is generated,  
but the address was not correct.  

## Generates sitemap without plugin
So I find [this](https://poychang.github.io/generating-sitemap-in-jekyll-without-plugin/),  
which seems to work so I decided to give it a try,  
modify and put it to `sitemap.xml` inside the repository,  
and it did work!  
