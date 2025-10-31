---
title: Difference between Concurrent Processing and Parallel Processing
date: 2019-12-25 19:40:00 +0800
lastmod: 2021-11-14 00:28:00 +0800
categories:
- Concurrency
tags: [Programming, Concurrent Processing, Parallel Processing]
slug: 'concurrent-process-parallel-process'
---

Both 'Concurrent Processing' and 'Parallel Processing' refer to **multiple processes executing on the CPU within a period**,  
but they are two different things.

According to [The Art of Concurrency](http://shop.oreilly.com/product/9780596521547.do),  
Concurrent means:
<!--more-->

> two or more processes are in progress at the same time

While Parallel means:
> two or more processes executing simultaneously

They look pretty similar but are actually different.  
For example,  
two processes are executing,  
process A and process B.  

### Parallel Processing
Parallel processing may look like this：

![parallel_processing](/images/concurrent_processing_and_parallel_processing/parallel_processing.jpeg)

Both Process A and Process B are being executed.   

### Concurrent Processing
However, for concurrent processing,  
the execution might look like the diagram above,  
or it might look like this:  

![consurrent_processing](/images/concurrent_processing_and_parallel_processing/concurrent_processing.jpeg)

Both Process A and Process B are in progress,  
but they are **not executing at the same time**.

### Notice
**Parallel processing is only a type of concurrent processing.**  
As long as there are **multiple processes in progress**,  
it is **concurrent processing**.  

There are many ways to achieve concurrent processing,  
and parallel processing is only one of them.  
