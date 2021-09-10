---
title: Docker 操作紀錄(二)
date: 2020-01-09 20:40:00 +0800
categories:
- Docker
tags: [Docker, Virtual Environment]
slug: docker-operating-2
---

接上一篇 [Docker 操作紀錄 (一)](/zh-tw/posts/docker-operating-1.html)

  
## Docker 基本使用
### 刪除 Container
記得先用 ``stop`` 停止 container 才能刪。  
```bash
docker rm CONTAINER_NAME
```
  
或
  
```bash
docker rm CONTAINER_ID
```
<!-- more -->
  
刪完之後可以用  
```bash
docker ps -a
```
確認一下是不是 container 就消失了。 
  
### 用之前 Export 過的 Container 建立 image
之前 export 過一個 container 出來叫 c_test.tar，  
可以用它來建立一個新的 image:  
  
```bash
cat c_test.tar | docker import - ubuntu_test_repo:1.0
```
  
後面那個 ``ubuntu_test_repo`` 是 repository 的名字，  
``1.0`` 是 tag，  
可以用
```bash
docker images
```
  
列出來看一下。  
有了 image 就可以建立新的 container 了。  

### 刪除 Image
如果我用  
```bash
docker images 
```
列出的 image 有這些:  

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
aaa                 2.0                 b30c39fffb75        4 seconds ago       64.2MB
aaa                 1.0                 6b8046192d83        8 seconds ago       64.2MB
ubuntu_test_repo    1.0                 864c36a752c3        5 hours ago         64.2MB
ubuntu              latest              549b9b86cb8d        2 weeks ago         64.2MB
hello-world         latest              fce289e99eb9        12 months ago       1.84kB
```

要刪除 repository 名稱為 aaa，  
tag 為 1.0 的 image:  
```bash
docker rmi aaa:1.0
```
就可以了。  
所有用這個 image 的 container 要先被 ``rm`` 掉。  

## Dockerfile
是一個檔案，  
可以讓使用者用更簡單的方式來建立 image。  

分成四個部分:  
* Image
* Maintainer (誰要對這個 dockerfile 負責)
* 操作 command
* Container 啟動時的 command

舉一個 nginx 的例子:  
```
# 這是 dockerfile 的註解方式

# Image
FROM ubuntu

# Maintainer
MAINTAINER user user@example.com

# 操作 command
RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y nginx

# Container 啟動時的 command
CMD ["nginx", "-g", "daemon off;"]
```

## 建立 Image
可以用 ``docker build`` 來建立 image。  
  
把剛剛那個 nginx 的 Dockerfile 放在 ``/tmp/d_file`` 下，  
名稱叫 ``test_d_file`` 要 build 成 image，  
並給那個 image 一個 ``test-nginx-img/1.0`` 的 tag:
```bash
docker build -t test-nginx-img/1.0 -f /tmp/d_file/test_d_file .
```
build 完之後用 ``docker images`` 看一下:
```
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
test-nginx-img/1.0   latest              7293588d00a9        27 seconds ago      152MB
```

## Reference
[Docker docs](https://docs.docker.com/v17.09/get-started/)

