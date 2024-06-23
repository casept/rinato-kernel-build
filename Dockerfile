# Build a container suitable for compiling Rinato vendor kernel
FROM docker.io/ubuntu:14.04
# Ubuntu's ARM toolchain results in a kernel that panics on boot, use Samsung's toolchain that's known to work.
# It's 32 bit, so we need to install some multilib stuff.
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential libc6:i386 libncurses5:i386 libstdc++6:i386 multiarch-support
COPY toolchain-downstream /opt/toolchain
ENV PATH=/opt/toolchain/bin:$PATH
ENTRYPOINT /bin/bash
