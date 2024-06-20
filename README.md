# kuzco-amdgpu (WIP)
> This repo is a work-in-progress and for demonstrational purposes.
> A simple repo showcasing how to run kuzco.xyz in a docker container mounting amdgpu's rocm

# Warning
> Kuzco [recently announced][ban-announ] that a restart policy may result in getting your worker banned.


# Overview
As of 2024/06/19 the default kuzco container doesn't seem suited for AMD gpu's.
I would recommend watching the official discord for official support in the future.

# Setup (Ubuntu 22.04 host)
### TODO
- [ ] Install AMD drivers on linux host
- [ ] Install docker (don't use docker desktop, use docker-engine)
- [ ] Double check the GPU is properly configured

# Docker
Rather than baking the models into the container this example demonstrates how to mount a local directory to cache any large files.

# Building
```sh
docker compose build
```

# Running
```sh
export WORKER_ID="YOUR_ID"
export WORKER_CODE="YOUR_CODE"
docker compose up -d
docker compose log -f
```

# Scaling
## TODO
- [ ] Add `replicas` key to the docker-compose.yaml file

[ban-announ]: https://discord.com/channels/1100110477599723550/1215659199846154261/1253105879386034228
