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

在 Python 3.4 之後出現了 `Asyncio` 可以在特定情境下提升效能，  
結合之前已經有的 Multiprocessing 和 Multithreading，  
我整理了一下這三項技術適合的原理、差異和使用情境做了幾篇紀錄。  
這一篇先簡單介紹三者的基本概念和適用情境。  

<!--more-->

## Multiprocessing

一支程式可以同時執行多個獨立的行程 (Process)。  
每個行程都有自己獨立的記憶體空間，  
也因此可以完全避開 Python GIL (Global Interpreter Lock) 的限制。  
這意味著它們可以真正地在多核心 CPU 上獨立的平行執行，  
互不干擾。  

**適用情境：**   
CPU 密集型任務 (CPU-bound)，  
例如大量的數學運算、資料處理、影像辨識等。  
可以有效利用多核心 CPU 的運算能力。

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

- **優點：**
    - 能夠利用 multi-core CPU 實現真正的平行運算。
    - 不受 GIL 限制。
    - 行程間記憶體獨立，穩定性高，不太會產生 Race Condition。
- **缺點：**
    - 獨立 Process 建立所需的資源較多。
    - 行程間通訊 (IPC) 較為複雜，需要透過 `Queue`、`Pipe` 等機制。

## Multithreading

在單一 Process 裡建立多個執行緒 (Thread)。  
這些 thread 共享同一個 Process 使用的記憶體空間，  
因此可以輕鬆地進行資料共享與交換。  

值得一提的是，  
在一定版本之前，  
Python 和其他程式語言如 C/C++ 等不同的是，  
Python 的 multithreading 會受到 Python GIL (Global Interpreter Lock) 的限制，  
即使是跑在多核心的 CPU 上，  
Python 的 multithreading 實際上也做不到平行運算。  

隨著 Python 的使用者越來越多，  
產生了 [PEP-703](https://peps.python.org/pep-0703/) 這樣的需求，  
直到 Python 3.13 之後開始實驗性的包含了可以選擇性關閉 GIL 的功能 (free-threading mode)，  
Python 3.14 開始出現了無 GIL 的 Free-threaded 的版本。  

> GIL (Global Interpreter Lock):
> GIL 是 CPython (官方的 Python 實現) 中的一個機制，
> 為了保護 Python object 不會被損壞，  
> 這個機制確保同一個時間點只有一個執行緒能執行 Python 的 bytecode。
> 這意味著在 CPU 密集型任務中，
> 即使在多核心 CPU 上，
> Python 的多執行緒也無法實現真正的平行運算。

不過當 Thread 遇到 I/O 操作 (如讀寫檔案、網路請求) 時會釋放 GIL，  
讓其他 Thread 有機會執行。  
因此 Multithreading 比較適合用來處理 I/O 密集型任務。

**適用情境：**   
I/O 密集型任務 (I/O-bound)，  
例如網路爬蟲、檔案下載、API 請求等。  

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

- **優點：**
    - 建立 thread 的開銷比 process 小。
    - 共享記憶體，資料交換方便。
- **缺點：**
    - 受 GIL 限制，無法利用多核心 CPU 處理 CPU 密集型任務。
    - 需要處理執行緒同步問題，如使用 `Lock` 來避免 Race condition。

## Asyncio I/O (Asyncio) 與 Coroutine 

非同步是 Python 3.4 之後引入的標準函式庫，  
概念上是利用 Event Loop 和 Coroutine 來實現 single thread 下的並行。  

Coroutine 可以看作是一種輕量級的 thread，  
可以被控制執行到某個點時暫停等待需要被執行的任務完成，  
與此同時將控制權交還給 event loop 去執行其他 coroutine。  

當暫停的條件完成後 (例如等待的 I/O 操作完成)，  
event loop 會再回來繼續執行該 coroutine。  

除了可以在暫停時間執行其他 coroutine 之外，  
也可以節省作業系統層級的執行緒切換，  
可以提升不少效能。  

**適用情境：**   
高度並行的 I/O 密集型任務，  
特別是需要同時處理大量網路連線的場景 (如 Web 伺服器、聊天應用)。

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

- **優點：**
    - thread 切換的開銷極低，能夠以極高的效率處理大量 I/O 操作。
    - 在 single thread 下運作，沒有 race condition 的問題。
- **缺點：**
    - 不適用於 CPU 密集型任務。
    - 需要使用 `async/await` 語法，且需要有對應的非同步函式庫支援 (如 `aiohttp`)。

## 比較總結

| 特性 | 多程序 (Multiprocessing) | 多執行緒 (Multithreading) | 非同步 (Asyncio) |
| :--- | :--- | :--- | :--- |
| **基本單位** | 行程 (Process) | 執行緒 (Thread) | 協程 (Coroutine) |
| **記憶體空間** | 獨立 | 共享 | 共享 (單執行緒) |
| **GIL 影響** | 無，可繞過 | 受限制 | 無 (單執行緒) |
| **平行/並行** | 平行 (Parallelism) | 並行 (Concurrency) | 並行 (Concurrency) |
| **適用情境** | CPU 密集型 | I/O 密集型 | 高度並行的 I/O 密集型 |
| **優點** | 可利用多核心 | 共享記憶體 | 極高 I/O 效率、低開銷 |
| **缺點** | 資源開銷大、IPC 複雜 | 受 GIL 限制、有競爭條件 | 不適用 CPU 密集型任務 |

- **如果是 CPU-bound 的任務需求**，需要大量 CPU 運算，那麼 `multiprocessing` 是最適合的，因為它能充分利用多核心 CPU 的威力。
- **如果是 IO-bound 的任務需求**，且邏輯相對簡單，`multithreading` 是一個不錯的選擇，因為它比 `multiprocessing` 更輕量。
- **如果是 IO-bound 且需要處理大量的並行連線** (例如開發 Web 伺服器或 API)，那麼 `asyncio` 是效率最高的。

