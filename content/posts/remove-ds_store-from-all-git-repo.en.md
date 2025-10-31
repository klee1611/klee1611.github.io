---
title: Remove .DS_Store tracking in all Git repositories
date: 2019-12-25 20:40:00 +0800
lastmod: 2021-11-14 02:40:33 +0800
categories:
- Git
tags: [Git, gitignore, Tool]
slug: 'remove-ds_store-from-all-git-repo'
---
Every time a new folder is created and files are added in macOS, a ``.DS_Store`` file is generated within that folder. This results in numerous ``.DS_Store`` files scattered across macOS, and it's quite annoying to add ``**/.DS_Store`` to every ``.gitignore`` file each time a new Git repository is created. Therefore, I found a method to prevent ``.DS_Store`` files from being tracked in all Git repositories.  

## The ``git config`` command
The ``git config`` command can be used to set a variety of Git settings.  
The most common uses are ``git config --global user.name`` and ``git config --global user.email``,  
which set ``user.name`` and ``user.email`` globally,  
allowing all Git repositories to use these settings.
<!--more-->

This command can also be used to set local settings for a single Git repository.  
If we wish to use a different username or email within a specific repository,  
we can use ``git config --local user.name`` and ``git config --local user.email`` to achieve this.  

There is a ``core.excludesfile`` setting for ``git config``,  
which can be set to an ignore configuration file to specify files that all Git repositories should ignore.  

Therefore, all we need to do is write ``.DS_Store`` and ``**/.DS_Store`` into a file,  
and then set ``core.excludesfile`` to point to that file.  
Then all Git repositories will ignore ``.DS_Store`` files.  

We can achieve this by using these commands:  

```bash
echo ".DS_Store" >> ~/.gitignore_global
echo "**/.DS_Store" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```
