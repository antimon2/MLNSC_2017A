MLNSC_2017A
===========

Public Repository of Machine Learning Nagoya Sub-Committee (MLNSC) DLScratch-Reading and Workshop.


Official Docker Image
---------------------

MLNSC official Docker Image is available ( https://hub.docker.com/r/antimon2/mlnsc-dlscratch ).  
Easy to use with the provided scripts.

### CLI

for Linux/macOS:

```
$ docker pull antimon2/mlnsc-dlscratch
$ ./docker.run.sh
```

for Windows (PowerShell):

```
PS> docker pull antimon2/mlnsc-dlscratch
PS> ./docker.run.bat
```

### Run Jupyter notebook

```
$ ./docker.run.jupyter.sh
```

or 

```
PS> ./docker.run.jupyter.bat
```

and then open `http://localhost:8888/`
