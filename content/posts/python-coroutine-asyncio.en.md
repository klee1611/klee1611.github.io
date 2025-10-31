---
title: "Python Coroutine Asyncio"
date: 2021-10-27T16:39:27+08:00
draft: false
categories:
- "Concurrency Programming"
tags: [Programming, Python, "Concurrent Processing"]
slug: 'python-coroutine-asyncio'
---
Before the advent of `asyncio`,  
when a Python program had many tasks that needed to be executed concurrently,  
and wanted to improve program performance,  
the only options were multiprocessing or threading.  
After Python 3.4, `asyncio` became another option.  
`asyncio` can be used to write coroutines,  
and execute coroutines concurrently using an event loop,  
reducing unnecessary waiting time in the program to improve performance.  
<!--more-->

## Coroutines
### Coroutine Definition
In the [Python official documentation](https://docs.python.org/3/glossary.html#term-coroutine),  
Python coroutines are defined as:  

>Coroutines are a more generalized form of subroutines. Subroutines are entered at one point and exited at another point. Coroutines can be entered, exited, and resumed at many different points. They can be implemented with the async def statement. See also PEP 492.

This means that Python coroutines are quite similar to subroutines.  
The difference is that a subroutine executes from start to finish in one go,  
and then terminates.  
A coroutine, on the other hand,  
can execute up to a certain point, pause, and then resume execution later.  

### Defining and Executing Coroutines with async, await, and asyncio.run
`async` can be used to define a coroutine.  
By adding `async` before the `def` keyword when defining a function, you can define a coroutine using `async def`.  
`await` is used to define a suspension point in a coroutine.  
When `await` is encountered,  
the coroutine can pause,  
and then resume execution later.  

`await` can only be followed by an awaitable object.  
Awaitable objects include coroutines or event loop tasks, etc.  

```python
import asyncio

async def ten_sec_sleep():
    await asyncio.sleep(10)
    print('10 sec sleep finish')

if __name__ == '__main__':
    asyncio.run(ten_sec_sleep())
```

## Event Loop
### What is an event loop
In the [Python official documentation](https://docs.python.org/3/glossary.html#term-coroutine),  
the event loop is introduced as:  

>The event loop is the core of every asyncio application. Event loops run asynchronous tasks and callbacks, perform network IO operations, and run subprocesses.

Simply put, it is used to run asynchronously executing tasks.  

An event loop executes only one task at a time.  
When running coroutines using an event loop,  
when a task reaches a programmer-defined suspension point,  
the event loop pauses and schedules that task,  
then switches to execute other work (which could be other tasks or callbacks, etc.).  
This makes the **combination of event loop and coroutine particularly suitable for handling I/O-bound tasks;**  
by defining the I/O operations of a coroutine as suspension points,  
and using an event loop to run these coroutines,  
the time spent waiting for I/O can be used to perform other work.  

### Executing Coroutines with an Event Loop
Executing a single coroutine:

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

The execution time using the `time` command is `10.09` seconds.

```
10 sec sleep finish, count: 0
       10.09 real         0.06 user         0.01 sys
```

Executing multiple coroutines concurrently:

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

Whenever `sleep(10)` is executed,  
the event loop can switch to another coroutine to execute.  

The concurrent execution time for coroutines using the `time` command is `10.09` seconds.  

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

## Performance Measurement
A program that continuously sends 10 requests to Google,  
without using coroutines:

```python
import requests


def issue_req(count):
    resp = requests.get('http://www.google.com.tw')
    print(f'count: {count}, resp status: {resp.status_code}')


if __name__ == '__main__':
    for i in range(10):
        issue_req(i)
```

The time required using the `time` command is `0.83` seconds.

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

Using coroutines to send requests concurrently:

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

The time required using the `time` command is `0.31` seconds.

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

Looking at these 10 requests,  
from `0.83` seconds to `0.31` seconds,  
the performance improved by `(0.83 - 0.31)/0.83 * 100% = 62.65%`,  
which is quite significant.  
For programs with many I/O-bound tasks,  
using coroutines is a good choice.  
