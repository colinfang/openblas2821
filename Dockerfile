FROM ubuntu:20.04

RUN apt update
RUN apt install -qy openjdk-8-jdk
RUN apt install -qy wget

WORKDIR /opt
RUN wget -q https://downloads.apache.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
RUN tar -xzf hadoop-3.2.1.tar.gz

ENV HADOOP_HOME /opt/hadoop-3.2.1

# Use pip numpy no segfault

# RUN apt install -qy python3 python3-pip
# RUN pip3 install "numpy==1.19" "scipy==1.5" "pyarrow==1.0"
# RUN ldd /usr/local/lib/python3.8/dist-packages/numpy/core/_multiarray_umath.cpython-38-x86_64-linux-gnu.so

# Use conda numpy

RUN wget -q -O miniconda3.sh "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
ARG conda_path=/opt/miniconda3
ARG conda_bin=${conda_path}/bin
ARG conda_exe=${conda_bin}/conda
RUN sh /opt/miniconda3.sh -b -p ${conda_path}
RUN ${conda_exe} init
RUN ${conda_exe} install -y "numpy=1.19" "scipy=1.5" "nomkl" "pyarrow=0.15"
# pip install no segfault
# RUN ${conda_bin}/pip install "numpy==1.19" "scipy==1.5" "pyarrow==1.0"

RUN ldd /opt/miniconda3/lib/python3.8/site-packages/numpy/core/_multiarray_umath.cpython-38-x86_64-linux-gnu.so

WORKDIR /src

ADD test.py test.py

