---
title: Docker Notes 1 - Beginner
date: 2020-01-01 17:06:00 +0800
lastmod: 2021-11-16 00:35:00 +0800
categories:
- Docker
tags: [Docker, Virtual Environment]
slug: docker-operating-1
---
## Basic Concept
Docker can be seen as a simplified virtual machine (VM).  
Since it doesn't install a full operating system, it offers a smaller footprint and faster speed.  

### Image
**An Image** contains a lightweight runtime environment,  
including its libraries and executables.  
<!--more-->

Images can be thought of as the `.iso` file for a Docker VM.  
It can only be read, not executed directly.  
If one wants to modify an image, they can only create a new image based on the existing one.  

### Container
When an image is used to create a running environment,  
it becomes a **container**.  

Like a VM,  
the Docker container is isolated from the host environment.  
Whatever is done within the container does not affect the host environment,  
unless specific settings are configured.  

For example,  
We can expose a port of a Docker container,  
while the host port remains closed.  
However, we can also expose the host's port if desired.  

### Repository
A **repository** is where images are stored.  

It is similar to a Git repository:  
There can be many repositories,  
and each serves as a place to store the code of a project.  
Similarly, Docker repositories are where images are stored.  
Every image within the same repository shares the same name but has different tags.  
Additionally, there are many different repositories for various images.  

### Registry
A **registry** is also a place to store images.  

The difference between a registry and a repository is that a registry is a service where users can push or pull images to and from their local machines, similar to GitHub for Git.  
The most famous one is [Docker Hub](https://hub.docker.com/).  
Whereas a repository is a location to keep images with the same name but different tags.  

## Basic Usage of Docker
### Install
It is very simple in Ubuntu:  

```bash
sudo apt-get install docker.io
```

### Pull Image
There are many images on [Docker Hub](https://hub.docker.com/) that can be used.  

If I want a clean Ubuntu environment,  
I can pull an Ubuntu image to my local machine:  

```bash
docker pull ubuntu
```

Or if I want to specify a tag:  

```bash
docker pull ubuntu:14.04
```

### Run the Image
We can echo `Hello world` using the image we just obtained:  

```bash
docker run ubuntu /bin/echo 'Hello world'
```

This should print `Hello world` on the terminal.  

What just happened is that the `docker run` command creates a temporary container,  
and terminates itself after the `echo` command completes.  

### List Images at Local

```bash
docker images
```

It should list the image we just pulled to our local machine.  

### Create a Container
Once we have a container,  
we have a running environment that can be modified by our actions.  

Creating a container from an image is just like using an `.iso` to create a virtual machine.  

We can create a container running Ubuntu with the image we pulled:  

```bash
docker create -it ubuntu
```

We can also create a container with a name:  

```bash
docker create -it --name CONTAINER_NAME ubuntu
```

``i`` refers to 'interactive' (opens `stdin` of the container).  
``t`` refers to 'TTY' (allocates a pseudo-TTY so we can interact with it via a terminal).  

Or if we want to create a container and run it:  

```bash
docker run -itd ubuntu
```

or  

```bash
docker run -itd --name CONTAINER_NAME ubuntu
```

``d`` refers to 'detach' (runs the container in the background).  

### List Containers
```bash
docker ps -a
```

This should list all containers on the host machine.  

And we can observe a difference in `status` between containers created with `docker create` and `docker run`:  
Containers created with `docker create` are only created and not yet running,  
so their status is `created`;  
whereas containers created with `docker run` are both created and run,  
so their status is `up`.  

There is a **container ID** that can be used to run or terminate the container.  

### Run Containers
So,  
if a container is created with `docker create`, it must be run before we can access it:  

We can use the container ID to run the container:  

```bash
docker start "CONTAINER_ID"
```

Or,  
if the container was created with a name,  
we can use that name to run it:  

```bash
docker start "CONTAINER_NAME"
```

If the container's status is `exited`,  
it also needs to be `start`ed to run before we can access it.  
Use  

```bash
docker ps -a
```

to check the `status` first.  

For containers created with `docker run`,  
or those already started with `docker start`,  
we can access them with `docker exec`:  

```bash
docker exec -it "CONTAINER_ID" bash
```

`bash` is the command we want to run;  
it can be replaced with other commands like `echo` or anything else.  

We can also use the container's name to access it:  

```bash
docker exec -it "CONTAINER_NAME" bash
```

If `bash` is the command used,  
we should find ourselves inside the container.  
The user becomes `root`,  
and we can start configuring settings or installing software within the container.  

If we want to leave the container:  

```bash
exit
```

The container remains running in the background after we `exit` it.  

### Stop Containers
This is quite similar to turning off a virtual machine.  
Stopping a container only changes its `status` to `exited`;  
it does not remove the container entirely.  

```bash
docker stop "CONTAINER_ID"
```

Or,  

```bash
docker stop "CONTAINER_NAME"
```

If we inspect it with,

```bash
docker ps -a
```

We will find that the container still exists,  
but its `status` has changed to `exited`.  

### Export Container
Once a container is exported,  
it can be moved to another host machine.  

We can export a container as a `.tar` file.  

For example,  
export a container as `exported.tar`:  

```bash
docker export "CONTAINER_ID" > exported.tar
```

Or,  

```bash
docker export "CONTAINER_NAME" > exported.tar
```

Then we can move the `.tar` file to another machine.  

## Reference
[Docker docs](https://docs.docker.com/v17.09/get-started/)


