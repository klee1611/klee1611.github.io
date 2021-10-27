---
title: "Python Coroutine Asyncio"
date: 2021-10-27T16:39:27+08:00
draft: false
categories:
- "Concurrency Programming"
tags: [Programming, Python, "Concurrent Processing"]
slug: 'python-coroutine-asyncio'
---
在出現 `asyncio` 前，  
當一隻 Python 程式有很多需要並行執行的 task，  
想要提升程式效能，  
只能選用 multiprocessing 或 threading；  
Python 3.4 之後又多出了 `asyncio` 的選擇。  
`asyncio` 可以用來撰寫 coroutines，  
並使用 event loop 並行執行 coroutines，  
減少程式不必要的等待時間以提升效能。
<!--more-->

## Coroutines
### Coroutine 定義
在 [Python 官方文件](https://docs.python.org/3/glossary.html#term-coroutine) 定義裡，  
Python coroutines 是  

>Coroutines are a more generalized form of subroutines. Subroutines are entered at one point and exited at another point. Coroutines can be entered, exited, and resumed at many different points. They can be implemented with the async def statement. See also PEP 492.

意指 Python 的 coroutine 和 subroutines 相當類似，  
不同的地方在於 subroutine 是開始之後直接一次執行到底，  
執行完後結束；  
而 coroutine 則可以執行到某處暫停，  
之後再繼續恢復執行。  

### 用 async, await 和 asyncio.run 定義並執行 coroutine
`async` 可以用來定義一個 coroutine，  
只要在定義 function 的 `def` 前加上 `async` 就可以用 `async def` 定義一個 coroutine。  
`await` 用來定義一個 coroutine 的暫停處，  
執行到 `await` 時，  
coroutine 就可以暫停，  
之後再恢復執行。  

`await` 後面只能接 awaitable object，  
awaitable object 包含 coroutine 或 event loop 的 task 等。

```python
import asyncio

async def ten_sec_sleep():
    await asyncio.sleep(10)
    print('10 sec sleep finish')

if __name__ == '__main__':
    asyncio.run(ten_sec_sleep())
```

## Event Loop
### What is event loop
在 [Python 官方文件](https://docs.python.org/3/glossary.html#term-coroutine) 裡，  
介紹的 Event loop 

>The event loop is the core of every asyncio application. Event loops run asynchronous tasks and callbacks, perform network IO operations, and run subprocesses.

簡單來說就是用來跑異步執行的 task 的。  

Event loop 每次只會執行一個 task，  
使用 event loop 跑 coroutines 時，  
當 task 執行到 programmer 定義的暫停處，  
event loop 會將該 task 暫停並排程，  
接著切換執行其他的工作（可能是其他的 task 或 callback 等），   
這也使得 **event loop 和 coroutine 的組合特別適合用來處理 IO bound task；**   
將 coroutine I/O 運作的部分定為暫停處，  
並使用 event loop 來跑這些 coroutines 時就能夠將等待 I/O 的時間切換做其他的工作。  

### 以 Event loop 執行 coroutines
執行單一一個 coroutine：

```python
import asyncio

async def ten_sec_sleep(count):
    await asyncio.sleep(10)
    print(f'10 sec sleep finish, count: {count}')

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    task = loop.create_task(ten_sec_sleep(0))
    loop.run_until_complete(task)
```

執行時間用 `time` command 看是 `10.09` 秒

```
10 sec sleep finish, count: 0
       10.09 real         0.06 user         0.01 sys
```

多個 coroutine 並行執行：

```python
import asyncio

async def ten_sec_sleep(count):
    await asyncio.sleep(10)
    print(f'10 sec sleep finish, count: {count}')

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    tasks = []
    for i in range(10):
        tasks.append(loop.create_task(ten_sec_sleep(i)))
    loop.run_until_complete(asyncio.wait(tasks))
```

每當執行到 `sleep(10)` 的時候 event loop 就可以切換到其他 coroutine 去執行，

並行執行 coroutine 的時間用 `time` command 看是 `10.09` 秒

```
10 sec sleep finish, count: 0
10 sec sleep finish, count: 1
10 sec sleep finish, count: 2
10 sec sleep finish, count: 3
10 sec sleep finish, count: 4
10 sec sleep finish, count: 5
10 sec sleep finish, count: 6
10 sec sleep finish, count: 7
10 sec sleep finish, count: 8
10 sec sleep finish, count: 9
10.09 real         0.07 user         0.01 sys
```

## 效能測量
一支連續發 10 個 requests 到 google 的程式，
在不使用 coroutine 的情況下：

```python
import requests

def issue_req(count):
    resp = requests.get('http://www.google.com.tw')
    print(f'count: {count}, resp status: {resp.status_code}')

if __name__ == '__main__':
    for i in range(10):
        issue_req(i)
```

用 `time` command 看需要的時間是 `0.83` 秒

```
count: 0, resp status: 200
count: 1, resp status: 200
count: 2, resp status: 200
count: 3, resp status: 200
count: 4, resp status: 200
count: 5, resp status: 200
count: 6, resp status: 200
count: 7, resp status: 200
count: 8, resp status: 200
count: 9, resp status: 200
        0.83 real         0.16 user         0.05 sys
```

使用 coroutine 來並行發出 requests：

```python
import requests
import asyncio

async def issue_req(count):
    loop = asyncio.get_event_loop()
    resp = await loop.run_in_executor(
        None,
        requests.get,
        'http://www.google.com.tw'
    )
    print(f'count: {count}, resp status: {resp.status_code}')

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    tasks = []
    for i in range(10):
        tasks.append(loop.create_task(issue_req(i)))

    loop.run_until_complete(asyncio.wait(tasks))
```

用 `time` command 看需要的時間是 `0.31` 秒

```
count: 0, resp status: 200
count: 2, resp status: 200
count: 3, resp status: 200
count: 7, resp status: 200
count: 5, resp status: 200
count: 1, resp status: 200
count: 9, resp status: 200
count: 6, resp status: 200
count: 8, resp status: 200
count: 4, resp status: 200
        0.31 real         0.18 user         0.05 sys
```

以這 10 個 requests 來看，  
從 `0.83` 秒到 `0.31` 秒，  
效能提升了 `(0.83 - 0.31)/0.83 * 100% = 62.65%` ，  
相當顯著；  
對有相當多 I/O bound task 的程式來說，  
使用 coroutine 是個不錯的選擇。  
