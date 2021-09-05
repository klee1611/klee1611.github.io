---
title: Concurrent Processing and Parallel Processing
date: 2019-12-25 19:40:00 +0800
categories:
- Concurrency
tags: [Programming, Concurrent Processing, Parallel Processing]
slug: 'concurrent-process-parallel-process'
---

Concurrent Processing 和 Parallel Processing 指的都是 CPU 在 一段時間內執行多個 process，

但兩者在概念上有些差異；

根據 [The Art of Concurrency](http://shop.oreilly.com/product/9780596521547.do) ，

Concurrent 指的是 

    two or more processes are in progress at the same time
<!--more-->
而 Parallel 指的是

    two or more processes executing simultaneously

看起來很相似但實際上並不一樣。Concurrent 指的是兩個或多個 process 都正在執行中，而 parallel 指的是兩個或多個 process 同時執行。

舉例來說，當有兩個 Process，一個為 Process A 另一個為 Process B。

### Parallel Processing
Parallel processing 可能長這樣：

![parallel_processing](/images/concurrent_processing_and_parallel_processing/parallel_processing.jpeg)

Process A 和 Process B 同時都在執行。

### Concurrent Processing
但對 Concurrent processing 來說，執行的狀況可以像上面的 Parallel processing，也可以長這樣：

![consurrent_processing](/images/concurrent_processing_and_parallel_processing/concurrent_processing.jpeg)

Process A 和 Process B 都處於 in progress 的狀態但是兩者是交互執行的。

### Summary
要特別注意的一點是，parallel processing 是 concurrent processing 的一種。  
只要是有**兩個以上的 process 同時在執行中就是 Concurrent processing**，達成這樣的目標有很多種做法，而 parallel processing 只是其中之一。


