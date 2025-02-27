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

This will compile the kernel and save it to `launcher/kernel/vmlinux`