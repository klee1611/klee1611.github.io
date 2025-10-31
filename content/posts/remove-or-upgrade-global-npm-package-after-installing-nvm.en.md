---
title: "Managing Pre-existing Global NPM Packages After Installing NVM"
date: 2021-11-06T19:31:32+08:00
draft: false
categories:
- Develop environment
tags: [NVM, NPM, Node.js, Global Packages, Troubleshooting]
slug: 'managing-pre-exist-global-npm-packages-after-installing-nvm'
aliases:
- /posts/remove-upgrade-npm-global-packages-after-installing-nvm.html
toc: true
find_last_modify_date: true
---

Today I encountered a problem:

After installing `nvm`, the path for installing global packages changed,

making it impossible to directly remove previously installed global packages using `npm uninstall -g`.


How did I discover this?

A long time ago, I installed a global package that could be executed directly from the terminal using a command.

But because it was so long ago,

when I tried to upgrade that package, I found it wasn't listed in `npm list -g`.

So, I first used `which` to find its location,

then discovered it was a symbolic link and used `ls -al` to see where that link pointed.

I found it was under `/usr/lib/node_modules`,

which clearly indicated it was installed with `npm -g`.

Then I carefully re-examined the output of `npm list -g`,

and found that other global packages were listed under `/Users/<USER_NAME>/.nvm/versions/node/v16.5.0/lib`.

After some Googling, I found a way to list the global packages installed before `nvm` using `nvm use system && npm ls -g --depth=0`.

Tragically, it showed:


```
System version of node not found.
```

It seems I had already removed `node` from the system...


So, I found another command, `nvm deactivate`, to temporarily disable `nvm`.

Then, I reinstalled `node` using `brew`.

After that, I ran `npm list -g` again,

and finally saw the package that was installed before `nvm`!!!

Hooray!!

I could finally successfully remove/upgrade the previously installed global package.

After resolving the issue, to bring `nvm` back, simply restart the shell with `source ~/.zshrc` or similar.
