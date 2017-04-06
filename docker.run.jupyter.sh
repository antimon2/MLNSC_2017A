#!/bin/sh
docker run -it --rm -v $(pwd):/opt/notebooks/mlnsc -p 8888:8888 antimon2/mlnsc-dlscratch:latest jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --NotebookApp.password='' --NotebookApp.token='' --NotebookApp.password_required=False
