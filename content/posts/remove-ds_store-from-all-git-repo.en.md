---
title: Remove .DS_Store tracking in all Git repositories
date: 2019-12-25 20:40:00 +0800
lastmod: 2021-11-14 02:40:33 +0800
categories:
- Git
tags: [Git, gitignore, Tool]
slug: 'remove-ds_store-from-all-git-repo'
---
Every time we create a new folder and add some files in MacOS,  
it generates a ``.DS_Store`` file in that folder,  
which causes lots of ``.DS_Store`` files spreading all over the places in MacOS,  
and it is pretty annoying to add ``**/.DS_Store`` into every ``.gitignore`` file every time we create a new Git repository,  
so I find a way to prevent the ``.DS_Store`` file from being tracked in every Git repository.  

## The ``git config`` command
The ``git config`` command can be used to set a variety of settings for git.  
The most famous ones are ``git config --global user.name`` and ``git config --global user.email``,  
which sets ``user.name`` and ``user.email`` globally,  
so every git repositories can use these settings.
<!--more-->

This command can also be used to set local settings for a single git repository.  
If we wish to use a different user name or email under a specific repository,  
we can use ``git config --local user.name`` and ``git config --local user.email`` to achieve the goal.  

There is a ``core.excludesfile`` setting for ``git config``,  
which can be set to a ignore configuration file to specify files we want all git repositories to ignore.  

So all we have to do is to write ``.DS_Store`` and ``**/.DS_Store`` into a file,  
and set ``core.excludesfile`` to the file.  
Then all the git repositories will ignore ``.DS_Store``.  

We can do that by using these commands:  

```bash
echo ".DS_Store" >> ~/.gitignore_global
echo "**/.DS_Store" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```
