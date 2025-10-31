---
title: "Multiprocessing, Multithreading and Asyncio in Python Part 1 - Basic Concept"
date: 2025-10-25T10:39:27+08:00
draft: false
categories:
- "Concurrency Programming"
tags: [Python, Concurrency, Parallelism, Multiprocessing, Multithreading, Asyncio, Coroutine, GIL, Performance]
slug: 'python-concurrency-parallelism-multiprocessing-multithreading-asyncio'
toc: true
find_last_modify_date: true
---

After Python 3.4,  
`Asyncio` emerged,  
which can improve performance in specific scenarios.   
Combined with the pre-existing Multiprocessing and Multithreading,   
I have compiled a few records on the principles, differences, and use cases for these three technologies.  
This first post will briefly introduce the basic concepts and suitable scenarios for each of the three.  

<!--more-->

## Multiprocessing

A program can execute multiple independent processes simultaneously.  
Each process has its own independent memory space,  
and therefore can completely bypass the limitations of Python's GIL (Global Interpreter Lock).  
This means they can truly execute in parallel on multi-core CPUs, independently and without interference.  

**Use Case:**   
CPU-bound tasks,  
such as extensive mathematical calculations, data processing, image recognition, etc.  
It can effectively utilize the computing power of multi-core CPUs.

```python
import multiprocessing
import time

def cpu_bound_task(n):
    count = 0
    for i in range(n):
        count += i
    print(f"Finished task with {n}")

if __name__ == '__main__':
    start_time = time.time()
    processes = []
    for i in range(4):
        p = multiprocessing.Process(target=cpu_bound_task, args=(10**7,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()

    end_time = time.time()
    print(f"Multiprocessing took {end_time - start_time:.2f} seconds.")
```

- **Pros:**
    - Can achieve true parallelism using multi-core CPUs.
    - Not limited by the GIL.
    - Independent memory space between processes leads to high stability and less likelihood of Race Conditions.
- **Cons:**
    - Creating independent processes requires more resources.
    - Inter-process communication (IPC) is more complex, requiring mechanisms like `Queue`, `Pipe`, etc.

## Multithreading

Multiple threads are created within a single process.  
These threads share the same memory space used by the process,  
allowing for easy data sharing and exchange.  

It is worth noting that,  
before a certain version,  
unlike other programming languages such as C/C++,  
Python's multithreading was limited by the Python GIL (Global Interpreter Lock).  
Even when running on a multi-core CPU,  
Python's multithreading could not actually achieve parallel computing.  

As the number of Python users grew,  
demands like [PEP-703](https://peps.python.org/pep-0703/) emerged.  
Starting from Python 3.13, an experimental feature to optionally disable the GIL (free-threading mode) was included.  
Python 3.14 introduced a GIL-free, Free-threaded version.

> GIL (Global Interpreter Lock):
> The GIL is a mechanism in CPython (the official Python implementation)
> designed to protect Python objects from being corrupted.  
> This mechanism ensures that only one thread can execute Python bytecode at any given time.
> This means that for CPU-bound tasks,
> even on a multi-core CPU,
> Python's multithreading cannot achieve true parallel computing.

However, when a thread encounters an I/O operation (like reading/writing a file or a network request), it releases the GIL,  
allowing other threads a chance to run.  
Therefore, Multithreading is more suitable for handling I/O-bound tasks.

**Use Case:**   
I/O-bound tasks,  
such as web scraping, file downloads, API requests, etc.  

```python
import threading
import requests
import time

def io_bound_task(url):
    try:
        response = requests.get(url)
        print(f"Downloaded {url} with status {response.status_code}")
    except Exception as e:
        print(f"Error downloading {url}: {e}")

if __name__ == '__main__':
    urls = ["https://www.google.com"] * 5
    start_time = time.time()
    threads = []
    for url in urls:
        t = threading.Thread(target=io_bound_task, args=(url,))
        threads.append(t)
        t.start()

    for t in threads:
        t.join()

    end_time = time.time()
    print(f"Multithreading took {end_time - start_time:.2f} seconds.")
```

- **Pros:**
    - The overhead of creating a thread is smaller than that of a process.
    - Shared memory makes data exchange convenient.
- **Cons:**
    - Limited by the GIL, cannot utilize multi-core CPUs for CPU-bound tasks.
    - Requires handling thread synchronization issues, such as using `Lock` to avoid Race conditions.

## Asyncio I/O and Coroutines

Asyncio is a standard library introduced after Python 3.4.  
Conceptually, it uses an Event Loop and Coroutines to achieve concurrency on a single thread.  

A Coroutine can be seen as a lightweight thread.  
It can be controlled to pause at a certain point to wait for a task to complete,  
while simultaneously returning control to the event loop to execute other coroutines.  

When the condition for the pause is met (e.g., the awaited I/O operation is complete),  
the event loop will return to continue executing that coroutine.  

Besides being able to execute other coroutines during the pause,  
it also saves the overhead of OS-level thread switching,  
which can significantly improve performance.  

**Use Case:**   
Highly concurrent I/O-bound tasks,  
especially scenarios that require handling a large number of network connections simultaneously (like Web servers, chat applications).

```python
import asyncio
import aiohttp
import time

async def async_io_bound_task(session, url):
    try:
        async with session.get(url) as response:
            print(f"Downloaded {url} with status {response.status}")
    except Exception as e:
        print(f"Error downloading {url}: {e}")

async def main():
    urls = ["https://www.google.com"] * 5
    start_time = time.time()
    async with aiohttp.ClientSession() as session:
        tasks = [async_io_bound_task(session, url) for url in urls]
        await asyncio.gather(*tasks)
    end_time = time.time()
    print(f"Asyncio took {end_time - start_time:.2f} seconds.")

if __name__ == '__main__':
    asyncio.run(main())
```

- **Pros:**
    - Extremely low thread switching overhead, capable of handling a large number of I/O operations with high efficiency.
    - Operates on a single thread, so there are no race condition issues.
- **Cons:**
    - Not suitable for CPU-bound tasks.
    - Requires using `async/await` syntax and corresponding asynchronous library support (like `aiohttp`).

## Comparison Summary

| Feature | Multiprocessing | Multithreading | Asyncio |
| :--- | :--- | :--- | :--- |
| **Basic Unit** | Process | Thread | Coroutine |
| **Memory Space** | Independent | Shared | Shared (Single-threaded) |
| **GIL Impact** | None, can be bypassed | Restricted | None (Single-threaded) |
| **Parallelism/Concurrency** | Parallelism | Concurrency | Concurrency |
| **Use Case** | CPU-bound | I/O-bound | Highly concurrent I/O-bound |
| **Pros** | Can utilize multi-core | Shared memory | Extremely high I/O efficiency, low overhead |
| **Cons** | High resource overhead, complex IPC | GIL limitation, has race conditions | Not for CPU-bound tasks |

- **If your task is CPU-bound**, requiring a lot of CPU computation, then `multiprocessing` is the most suitable choice because it allows you to fully utilize the power of multi-core CPUs.
- **If your task is IO-bound** and the logic is relatively simple, `multithreading` is a good choice because it is more lightweight than `multiprocessing`.
- **If your task is IO-bound and requires handling a large number of concurrent connections** (e.g., developing a Web server or API), then `asyncio` is the most efficient.
