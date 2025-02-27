# Firecracker sandbox 🧨
Have fun playing with firecrackers! This repository contains everything needed to create and run "sandboxes" (firecracker VMs)
based off of Docker images. It was originally created as a proof-of-concept for sandboxing arbitrary code execution; whether run by humans or AI agents. The design reflects this in some cases. 

## Getting Started

### Creating a linux kernel image
You will need a compiled linux kernel image to build your firecracker VMs. This project includes a "batteries included" kernel builder that builds a kernel in docker; provided by [fadams/firecracker-in-docker](https://github.com/fadams/firecracker-in-docker).

You can change the kernel image you want to build by replacing `kernel-builder/.config` with one of the options from `kernel-builder/resources`; make sure to name the file `kernel-builder/.config`. 

```shell 
cd kernel-builder 

# create the docker image that will be used to compule the kernel
docker build -t firecracker-kernel-builder . --load # use --load if you're on docker buildx

# once you have set the config you want to kernel-builder/config; the default is like 5.15 
./kernel-builder
```

This will compile the kernel and save it to `launcher/kernel/vmlinux`. Don't commit this file.

### Creating a filesystem for your microvms using docker.

You can create a microVM filesystem from a docker image on a remote repository, for example using python 3.12:
```shell
export PATH=$PATH:$(pwd)/image-builder
image-builder python:3.12-slim
```

Or, you can use a docker image that you've already compiled and loaded into your docker build cache:
```shell
export PATH=$PATH:$(pwd)/image-builder
docker build -t some-docker-image -f Dockerfile-something .
docker save some-docker-image some-docker-image.tar
image-builder some-docker-image.tar
```

### Configuring your host Kernel
Run the following command on your host container to configure the kernel to allow tracking more connections - this is necessary to enable "NAT-ing" the guest firecracker VMs through the host in a highly concurrent manner. 

```shell
sudo ./configure-host
```

## Running the sandbox in docker

If you want to run the VMs inside of a docker container, you need to build the sandbox VM image:
```shell
docker build -t firecracker-sandbox . --load 
```


## Running VMs on the host
If you want to run the VMs on your host, you need to configure the host. NOTE that these are non-trivial changes and grant some additional privileges to manage networks to specific binaries on the host. 
