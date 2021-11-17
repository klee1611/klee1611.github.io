---
title: Docker Notes 1 - Beginner
date: 2020-01-01 17:06:00 +0800
lastmod: 2021-11-17 18:53:00 +0800
categories:
- Docker
tags: [Docker, Virtual Environment]
slug: docker-operating-1
---
## Docker 基本概念
一言以蔽之，  
簡化版的 VM。  
因為 docker 不會把整個 operating system 都裝起來，  
所以大小比 VM 小很多速度也比 VM 快很多。  

### Image
跑在 container 上面的東西，  
裡面包了一個輕量級的 runtime environment，  
包含一些 library 跟 executable。  
<!--more-->

可以想像成 VM 上的 ``.iso``，  
只能被讀。  
要改的話就是產生一個新的 image。  

### Container
真的把 image 拿來跑起來的東西，  
就是把 image 拿來真的啟動放到 memory 去執行，  
跟 VM 一樣和 host environment 是完全隔離的，  
除非經過特別設定否則對 container 做什麼跟 host environment 都沒有什麼關係，  
例如說可以在 container 上把 port 開起來也不會影響到 host，  
但有需要的話也可以設定。  

### Repository
放 Image 的地方。  

可以拿 Git 的 Repository 做比喻，  
Git 會有很多 repository，  
每個 Repository 是拿來放一個專案的 code 的集合，  
Docker 所謂的 repository 也是一樣，  
Repository 是拿來放 image 的地方，  
通常在同一個 repository 的 image 會有一樣的名字但不一樣的 tag。  
所以也會有很多不同的 repository。  

### Registry
也是放 image 的地方。  

和 repository 不同的是，  
registry 是一種服務，  
可以讓大家把 image 放上去或拉回自己的機器，  
用 Git 來比喻就是像 Github。  
最有名的就是 [Docker Hub](https://hub.docker.com/)。  

## Docker 基本使用
### Install
在 Ubuntu 很簡單，  

```bash
sudo apt-get install docker.io
```

### Pull Image
官方 [Docker Hub](https://hub.docker.com/)，  
有很多 Image 可以抓，  
例如我想要一個乾淨無汙染的 Ubuntu 環境，  
就可以用 command 來抓一個 Ubuntu 的 image 回自己的機器 (host machine):  

```bash
docker pull ubuntu
```

或者要指定某一個 tag:

```bash
docker pull ubuntu:14.04
```

### Run the Image
可以用剛剛 pull 下來的 Ubuntu echo 一個 Hello World:  

```bash
docker run ubuntu /bin/echo 'Hello world'
```

應該會跳出一行 Hello world。  

這裡只是測試一下 Image，  
``docker run`` 建立了一個暫時的 Container，  
跑完 hello world 以後 container 就結束了。  

### 列出 Local 有哪些 Images

```bash
docker images
```

應該會出現剛剛裝過的那個 Ubuntu。  

### Create 一個 Container
Container 被開出來就是可以被改變的東西了!!  
用 image 建一個 container 就好像用 ``.iso`` 裝到 VM 裡。  

用剛剛有的 ubuntu 那個 image 來建一個 container:  

```bash
docker create -it ubuntu
```

也可以建立一個有名字的 Container:  

```bash
docker create -it --name CONTAINER_NAME ubuntu
```

``i`` 是指 input (讓 container 的 stdin 打開)，  
``t`` 是指 tty (有個 terminal 可以用)。  

或者如果要讓 Container 被 create 而且直接被啟動開始跑:  

```bash
docker run -itd ubuntu
```

或  

```bash
docker run -itd --name CONTAINER_NAME ubuntu
```

``d`` 是指 detach (讓 container 跑在 background)。  

### 列出有哪些 Container
```bash
docker ps -a
```

可以列出所有現在 host 上有的 container，  
應該會出現前面用 Ubuntu image 建立起來的 Container。  

可以看到 ``docker create`` 和 ``docker run`` 建立的 Container 的 ``status`` 會不一樣，  
``docker create`` 只有建立了這個 container 還沒有啟動他，  
所以 ``status`` 會是 ``created``；  
而 ``docker run`` 已經直接讓 container 被建立也被啟動了，  
所以 ``status`` 會是 ``Up``。  

最前面有個 **container id**，  
要去 run 這個 container 的時候可能會用到。  

### 啟動並進入 Container
如果是用 ``docker create`` 建立的 container 要**先被啟動**才能進入:  

可以用 **container id** 來啟動 container:  

```bash
docker start "CONTAINER_ID"
```

或者如果建立 Container 有指定名字，  
也可以用 **container 的名字** 來啟動 container:  

```bash
docker start "CONTAINER_NAME"
```

當 container 的 status 是 `exit` 時就需要先被 start 啟動才能對 container 做後續的改動。  
可以先用  

```bash
docker ps -a
```

看一下 status。  

已經被 ``docker run`` 啟動過先 run 在 background 的 container，  
或是以敬備 `docker start` 啟動的 container 都可以用 `docker exec` 進入:  

```bash
docker exec -it "CONTAINER_ID" bash
```

``bash`` 是要執行的 command，  
也可以用 `docker exec` 執行其他的 command 如 `echo` 等。  

如果 container 有名字也能直接用 container 的名字進入 container

```bash
docker exec -it "CONTAINER_NAME" bash
```

應該會發現已經進入到 Container 了，  
使用者會變成 Container 的 root，  
可以開始在這個 Container 上面做設定或裝東西。  

要離開 Container 環境的時候打個

```bash
exit
```

就好。  

離開以後 Container 依然會在 background 跑。  

### 停止 Container
就跟把 VM 關機差不多意思，  
讓 container 變成**未啟動**的狀態，  
讓 container 的 status 變成 `exit`。  

也是要用到 **container id** 或名字，  

```bash
docker stop "CONTAINER_ID"
```

或  

```bash
docker stop "CONTAINER_NAME"
```

如果這個時候再用

```bash
docker ps -a
```

看一下，  
可以發現 ``status`` 會變成 ``Exited``。  

### Export Container
就可以把 Container export 出來變成 `.tar`檔搬到別的主機上，  
也是要用到 **container id** 或 **container name**。  

假設要把 container export 出來變成 `exported.tar`:  

```bash
docker export "CONTAINER_ID" > exported.tar
```

或  

```bash
docker export "CONTAINER_NAME" > exported.tar
```

就能夠壓出一個 `.tar` 檔把 container 搬去別的主機。  

## Reference
[Docker docs](https://docs.docker.com/v17.09/get-started/)
