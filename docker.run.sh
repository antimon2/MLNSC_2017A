#!/bin/sh
docker run -it --rm -v $(pwd):/opt/notebooks/mlnsc -p 8888:8888 antimon2/mlnsc-dlscratch:latest
