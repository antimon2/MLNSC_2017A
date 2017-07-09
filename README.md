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


Setup `dataset` directory
-------------------------

Since Chapter 3, the workshop requires some dataset provided by official repository. Please run the script as follows.

### for Linux/macOS

Run the script as below:

```
$ cd dataset
$ ./get_mnist_py.sh
```

or, if you caught some errors when runnning this, you run docker-container first and run the script as follows:

```
$ ./docker.run.sh
root@xxxxxxxxxxxx:/opt/notebooks# cd mlnsc/dataset
root@xxxxxxxxxxxx:/opt/notebooks/mlnsc/dataset# ./get_mnist_py.sh
root@xxxxxxxxxxxx:/opt/notebooks/mlnsc/dataset# exit
```

### for Windows

You run docker-container first with `./docker.run.bat`, and run the script in the container as follows:

```
root@xxxxxxxxxxxx:/opt/notebooks# cd mlnsc/dataset
root@xxxxxxxxxxxx:/opt/notebooks/mlnsc/dataset# ./get_mnist_py.sh
root@xxxxxxxxxxxx:/opt/notebooks/mlnsc/dataset# exit
```
