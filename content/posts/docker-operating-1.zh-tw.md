---
title: Docker 操作紀錄(一)
date: 2020-01-01 17:06:00 +0800
categories:
- Docker
tags: [Docker, Virtual Environment]
slug: docker-operating-1
---
亂七八糟的 project 太多，  
每個 project 用的 module 版本又不一樣，  
有些東西要測試的時候還要把 port 打開有點危險，  
乾脆直接用 docker 把不同的 project 拆開免得互相干擾，  
還不用把自己實體機器的 port 打開來測程式能不能跑。  
  
還可以抓各種 Image 來放到 Container 上搞壞再重開(?  
  
## Docker 基本概念
一言以蔽之，  
簡化版的 VM。  
因為 docker 不會把整個 operating system 都裝起來，  
<!--more-->
所以大小比 VM 小很多速度也比 VM 快很多。  
  
### Image
跑在 container 上面的東西，  
裡面包了一個輕量級的 runtime environment，  
就是一些 library 跟 executable，  
可以想像成 VM 上的 .iso，  
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
  
### 抓 Image
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
  
### 跑看看抓下來的 Image 來測試一下
剛剛抓了 Ubuntu，  
試看看能不能用那個 Ubuntu echo 一個 Hello World:  
```bash
docker run ubuntu /bin/echo 'Hello world'
```
  
應該會跳出一行 Hello world
  
這裡只是測試一下 Image，  
``docker run`` 建立了一個暫時的 Container，  
跑完 hello world 以後 container 就結束了。  
  
### 列出裝過哪些 Images
```bash
docker images
```
  
應該會出現剛剛裝過的那個 Ubuntu  
  
### 用現有的 Image 來 create 一個 Container
Container 被開出來就是可以被改變的東西了!!  
用 image 建一個 container 就好像用 .iso 裝到 VM 裡。  
  
用剛剛有的 ubuntu 那個 image 來建一個 container:  
```bash
docker create -it ubuntu
```
  
也可以建立一個有名字的 Container:  
```bash
docker create -it --name CONTAINER_NAME ubuntu
```
  
或者如果要讓 Container 被 create 而且直接被啟動:  
(只是啟動，還沒有進入那個 container)
  
```bash
docker run -itd ubuntu
```
  
或  
  
```bash
docker run -itd --name CONTAINER_NAME ubuntu
```
  
不論是用 ``create`` 還是 ``run`` 都有下參數 ``i`` 跟 ``t``，
``i`` 是指 input (讓 container 的 stdin 打開)，  
``t`` 是指 tty (有個 terminal 可以用)。  
``docker run`` 的 ``d`` 是 detach (讓 container 跑在 background)。  
  
### 列出有哪些 Container
```bash
docker ps -a
```
  
可以列出所有現在 host 上有的 container，  
應該會出現前面用 Ubuntu image 建立起來的 Container。  
  
用 ``docker create`` 和 ``docker run`` 建立的 Container 的 ``status`` 會不一樣，  
``docker create`` 只有建立了這個 container 還沒有啟動他，  
所以 ``status`` 會是 ``created``；  
``docker run`` 已經直接讓 container 被建立也被啟動了，  
所以 ``status`` 會是 ``Up``。  
  
最前面有個 **container id**，  
要去 run 這個 container 的時候可能會用到。  
  
### 啟動並進入 Container
如果是用 ``docker create`` 建立的 container 要**先被啟動**才能進入:  
* 沒有名字的 Container 就用 **container id** 來跑起來並進入:  
```bash
docker start -i "CONTAINER_ID"
```
* 有名字的 Container 可以用 **container 的名字** 來跑起來並進入:  
```bash
docker start -i "CONTAINER_NAME"
```
除了剛被 create 的 container 要先被 start 才能進入，  
被停止的 container 也要先被 start 才能進入。  
可以先用
```bash
docker ps -a
```
看一下 status，  
不是 ``Up`` 狀態的就先 start 啟動他。  
  
已經被 ``docker run`` 啟動過先 run 在 background 的 container 可以直接進入:  
* 沒有名字的 Container 就用 **container id** 來進入:  
```bash
docker exec -it "CONTAINER_ID" bash
```
(*bash* 是要執行的 command)
  
* 有名字的 Container 可以用 **container 的名字**來進入:  
```bash
docker exec -it "CONTAINER_NAME" bash
```
(*bash* 是要執行的 command)
  
應該會發現已經進入到 Container 了，  
使用者會變成 Container 的 root，  
可以開始在這個 Container 上面做設定或裝東西。  
要離開 Container 環境的時候打個
```bash
exit
```
就好。  
離開以後 Container 依然會在，  
不過會變成**Exited** 的狀態，  
下次再回去進入這個 Container 的時候要先啟動他，  
不過設定跟裝過的東西都會在。  
  
### 停止 Container
就跟把 VM 關機差不多意思，  
讓 container 變成**未啟動**的狀態，  
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
就可以把 Container 搬到別的主機上，  
也是要用到 **container id** 或 **container name**，  
假設我打算把 export 出來的 container 叫做 c_test:  
```bash
docker export "CONTAINER_ID" > c_test.tar
```
或  
```bash
docker export "CONTAINER_NAME" > c_test.tar
```
  
這時候會是一個壓縮檔，  
已經可以拿去搬了。  
  

## Reference
[Docker docs](https://docs.docker.com/v17.09/get-started/)


