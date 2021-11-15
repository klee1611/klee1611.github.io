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
Docker can be seen as a simplified VM.  
Since it will not install the whole operating system,  
it comes with a smaller size and faster speed.  

### Image
**Image** contains a lightweight runtime environment,  
including some libraries and executables within it.  
<!--more-->

Images can be seen as the `.iso` file on VM for docker.  
It can only be read but not to be executed.  
If anyone ever wants to modify the image,  
he or she can only create a new image based on the old one.  

### Container
When the image is used and becomes a running environment,  
it is the **container**.  

Like VM,  
the docker container is also isolated from the host environment.  
Whatever is done in the container has nothing to do with the host environment,  
unless we have done some special settings.  

For example,  
we can open a port of a docker container,  
but the host port remains closed.  
But if we can also expose the port of the host if we want.  

### Repository
A **repository** is where we keep the images.  

It is like the repository of Git:  
There can be lots of repositories,  
and each of them is where to place the code of a project.  
Likewise,  
The repositories of docker are where to place images.  
Every image in the same repository has the same name but different tags.  
And also,  
there are many different repositories for different images.  

### Registry
A **registry** is also somewhere to place images.  

The difference between registry and repository is,  
the registry is a service where people can push their images from or pull images back to their local machine;  
like GitHub for Git.  
The most famous one is [Docker Hub](https://hub.docker.com/).  
While the repository is somewhere to keep images with the same name and different tags.  

## Basic Usage of Docker
### Install
It is really simple in Ubuntu,  

```bash
sudo apt-get install docker.io
```

### Pull Image
There are lots of images on [Docker Hub](https://hub.docker.com/) that can be used.  

If I want a clean Ubuntu environment,  
I can pull a Ubuntu image back to my local machine:  

```bash
docker pull ubuntu
```

Or if I want to specify a tag:  

```bash
docker pull ubuntu:14.04
```

### Run the Image
We can echo a `Hello world` using the image we just get:  

```bash
docker run ubuntu /bin/echo 'Hello world'
```

Should print `Hello world` on the terminal.  

What just happened is the `docker run` command creates a temporary container,  
terminates itself after the `echo` command.  

### List Images at Local

```bash
docker images
```

It should list the image we just pulled to our local machine.  

### Create a Container
Once we have a container,  
we have a running environment that can be changed by what we do.  

Creating a container with an image is just like using `.iso` to create a virtual machine.  

We can create a container running Ubuntu with the image we pulled:  

```bash
docker create -it ubuntu
```

We can also create a container with a name:  

```bash
docker create -it --name CONTAINER_NAME ubuntu
```

``i`` refers to 'input' (open `stdin` of the container).  
``t`` refers to 'tty' (so we can access it with terminal).  

Or if we want to create a container and run it:  

```bash
docker run -itd ubuntu
```

or  

```bash
docker run -itd --name CONTAINER_NAME ubuntu
```

``d`` refers to 'detach' (let the container runs in the background).  

### List Containers
```bash
docker ps -a
```

Should be able to list all the containers in the host machine.  

And we can see there is a difference in `status` between container created with `docker create` and `docker run`:  
Containers created with `docker create` is only created and have not been running,  
so the status is `created`;  
while containers created with `docker run` is not only created but also run,  
so the status is `up`.  

There is a  **container id** that can be used at running the container or terminate it.  

### Run Containers
So,  
if the container is created with `docker create` then it has to be run before we can access it:  

We can use container ID to run the container:  

```bash
docker start "CONTAINER_ID"
```

Or,  
if the container creates with a name,  
we can use the name to run it:  

```bash
docker start "CONTAINER_NAME"
```

If the status of the container is `exit`,  
it also has to be `start`ed to run before we can access it.  
Use  

```bash
docker ps -a
```

to check the `status` first.  

As for containers created with `docker run`,  
or the containers have already started to run by `docker start`,  
we can access them with `docker exec`:  

```bash
docker exec -it "CONTAINER_ID" bash
```

`bash` is the command we want it to run,  
it can be replaced with other commands like `echo` or something else.  

We can also use the container's name to access the container:  

```bash
docker exec -it "CONTAINER_NAME" bash
```

If the command used is `bash`,  
we should find ourselves in the container.  
The user has become `root`,  
and we can start to do some settings or install something on the container.  

If we want to leave the container:  

```bash
exit
```

The container is left running in the background after we `exit` it.  

### Stop Containers
It is pretty similar to turning off the virtual machine.  
Stops a container only changes the `status` of the container to be `exit`,  
it will not remove the container entirely.  

```bash
docker stop "CONTAINER_ID"
```

Or,  

```bash
docker stop "CONTAINER_NAME"
```

If we inspect with,

```bash
docker ps -a
```

We will find that the container remains to exist,  
only the `status` has changed to `exit`.  

### Export Container
Once a container is exported,  
it can be moved to another host machine.  

We can export a container to be a `.tar` file.  

For example,  
export a container to be `exported.tar`:  

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


