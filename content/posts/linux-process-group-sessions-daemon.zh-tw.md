---
title: Process Groups, Sessions and Daemon Overview
date: 2020-01-02 02:06:00 +0800
categories:
- Operating System
tags: [Linux, OS]
slug: 'linux-process-group-sessions-daemon'
---
為了弄清楚某個 daemon 的東西，  
決定把 daemon 是什麼弄清楚，  
網路上找到的資料實在又多又不清楚，  
乾脆直接從 [The Linux Programming Interface](https://www.oreilly.com/library/view/the-linux-programming/9781593272203/) 把相關資料找出來做筆記。  
  
* **Process group** 是一堆 **related processes** 組成的集合
* **Session** 是一堆 **related process groups** 組成的集合
  
Process group 和 Session 的定義是為了方便做 **job control**。  
  
## Process Group
一堆 related processes 共享相同的 **process group identifier (PGID)**。  
這群 process 裡面會有一個 **process group leader** 是建立這個 process group 的 process，  
這個 process group leader 的 PID 就會是這個 process group 的 PGID。  
<!--more-->
  
任何一個新的 process 被建立出來的時候，  
他的 PGID 就會是他的 parent 的 PGID。  
  
Process group 的 lifetime 是從 process group leader 建立這個 process group 開始算，  
一直到所有在這個 process group 的 process 都離開這個 process group。  
(有可能是 process 做完結束了，  
或是 process 變換到了別的 process group)  
  
## Session
一群 related process groups 共享相同的 **session identifier (SID)**。  
這群 process group 裡面有一個 **session leader** 是建立這個 session 的 process，  
session leader 的 PID 就會是這個 session 的 SID。
  
任何一個新的 process 被建立出來的時候，  
他的 SID 會是他的 parent 的 SID。  
  
所有在同一個 session 裡的 process 都會共享一個**controlling terminal**，  
一個 controlling terminal 會在 session leader 第一次開啟一個 terminal device 的時候建立，  
而一個 terminal 只能當一個 session 的 controlling terminal。  
=> session 和 controlling terminal 是一對一的關係  
  
在任一時間點會有：  
* **foreground process group**: 在 session 中的一組 porcess group，  
只有這個 process group 裡面的 process 才能讀取從 controlling terminal 來的 input。  
* **background process groups**: 其他不是 foreground process group 的所有 process group，  
  
## Terminal 運作
流程大概是：  
開啟一個 terminal 的時候會有一個 session leader 會是 controlling process，  
會有一組 foreground process group 等著接從 terminal 讀取的東西，  
有可能是 user input 或是 user 給的 signal，  
同時也會有一些 background process groups 存在。  
當 terminal 結束的時候 kernel 會送 ``SIGHUP`` 給 session leader 通知他這個 terminal 結束了。  

## Shell Job Control
Process groups 和 session 主要是用來做 shell job control，  
舉一個登入的例子：  
  
使用者 login 用的那個 terminal 就是 controlling terminal，  
而 login shell 就是 session leader 同時也是這個 terminal 的 controlling process，  
從這個 shell 開始的所有 command 會建立出一個以上的 processes，  
這些 processes 會變成新的 process groups，  
從這些 process 再建立的新的 process 就會是那個建立他的 process 的 process group 的一份子。  
所有這些 process 都從這個 shell 建立，  
所以都屬於這個 login session。  

## Daemon
Daemon 具有的特性：  
* **long-lived**: 通常是在系統啟動的時候跟著啟動開始運作，  
一直到系統關機才結束。  
* **跑在 background 而且不具有 controlling terminal**: 確保 kernel 不會自動產生 job control 或 terminal 相關的 signal 去影響到 daemon。  
  
通常 daemon 會用 'd' 結尾。  
  
幾個常見的 daemon:
* cron
* sshd
* httpd

