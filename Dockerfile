# this is the dockerfile for the sandbow which will launch multiple firecracker VMs.
FROM ubuntu:20.04

ARG FC_VERSION=v1.10.1

# copy in the binary 
COPY launcher/kernel/vmlinux /usr/local/bin/vmlinux
COPY launcher/rootfs/rootfs.ext4 /usr/local/bin/rootfs.ext4
COPY launch-vm /usr/local/bin/launch-vm
COPY configure-basic /usr/local/bin/configure-basic
COPY configure-container /usr/local/bin/configure-container

# install dependencies
RUN /usr/local/bin/configure-container
# entrypoint was formally firestarter, but we don't want to start launching VMs until we need to.