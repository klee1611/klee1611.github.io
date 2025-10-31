--- 
title: Docker Operations Log (Part 2)
date: 2020-01-09 20:40:00 +0800
categories:
- Docker
tags: [Docker, Virtual Environment]
slug: docker-operating-2
---

Continuing from [Docker Operations Log (Part 1)](/zh-tw/posts/docker-operating-1.html)

## Basic Docker Usage
### Deleting a Container
Remember to stop the container using `stop` before deleting it.
```bash
docker rm CONTAINER_NAME
```

Or

```bash
docker rm CONTAINER_ID
```
<!-- more -->

After deletion, you can use
```bash
docker ps -a
```
to confirm if the container has disappeared.

### Creating an Image from a Previously Exported Container
If you previously exported a container as `c_test.tar`,
you can use it to create a new image:

```bash
cat c_test.tar | docker import - ubuntu_test_repo:1.0
```

`ubuntu_test_repo` is the repository name, and `1.0` is the tag.   
You can use
```bash
docker images
```
to list and check it.  
Once you have an image, you can create new containers from it.

### Deleting an Image
If I use
```bash
docker images
```
and the listed images are:

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
aaa                 2.0                 b30c39fffb75        4 seconds ago       64.2MB
aaa                 1.0                 6b8046192d83        8 seconds ago       64.2MB
ubuntu_test_repo    1.0                 864c36a752c3        5 hours ago         64.2MB
ubuntu              latest              549b9b86cb8d        2 weeks ago         1.84kB
hello-world         latest              fce289e99eb9        12 months ago       1.84kB
```

To delete the image with repository name `aaa` and tag `1.0`:
```bash
docker rmi aaa:1.0
```
This will work.  
All containers using this image must be `rm`'d first.

## Dockerfile
A Dockerfile is a file that allows users to create images in a simpler way.

It is divided into four parts:
* Image
* Maintainer (who is responsible for this Dockerfile)
* Operation commands
* Command to run when the container starts

Here's an Nginx example:
```
# This is how to comment in a Dockerfile

# Image
FROM ubuntu

# Maintainer
MAINTAINER user user@example.com

# Operation commands
RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y nginx

# Container Start Command
CMD ["nginx", "-g", "daemon off;"]
```

## Building an Image
You can use `docker build` to create an image.

If the Nginx Dockerfile mentioned above is located at `/tmp/d_file`
and named `test_d_file`, to build it into an image
and tag it as `test-nginx-img/1.0`:
```bash
docker build -t test-nginx-img/1.0 -f /tmp/d_file/test_d_file .
```
After building, check with `docker images`:
```
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
test-nginx-img/1.0   latest              7293588d00a9        27 seconds ago      152MB
```

## Reference
[Docker docs](https://docs.docker.com/v17.09/get-started/)
