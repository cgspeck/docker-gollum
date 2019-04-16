#! /bin/bash -e
docker run \
    --rm \
    --name=golum \
    -p 4567:4567 \
    -e PUID=1000 \
    -e PGID=1000 \
    cgspeck/gollum:latest
