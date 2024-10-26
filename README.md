# Downstream kernel build tooling

This repository contains a toolchain and Dockerfile for creating a container which can build the ancient 3.4
vendor kernel for Samsung Gear 2 (SM-R380/SM-R381, codename rinato).

To build the container containing a multilib and suitably ancient userspace for supporting the toolchain, run:

```sh
docker build -t rinato-downstream-build .
```

Alternatively, you can also use the pre-built image from Docker hub under
`docker.io/casept/rinato-downstream-build:latest`.

To run the image:

```sh
docker run -v path/to/kernel/sources:/src --rm -it rinato-downstream-build 
```

Alternatively, the toolchain is also provided as a Nix flake.
In this case, all binaries are prefixed with `rinato-` to avoid collisions
with e.g. a newer ARM toolchain in the same env.
