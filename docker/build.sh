#!/bin/sh
docker build --platform linux/amd64 -t pext/rpi:rpi3 -f Dockerfile . 
