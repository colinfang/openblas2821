The purpose of this repo is to reproduce segmentation fault

Related links

- https://gist.github.com/colinfang/02b45e6751264b044e02cb7edd209c09
- https://github.com/xianyi/OpenBLAS/issues/2821
- Docker hub [![](https://images.microbadger.com/badges/image/colinfang/openblas2821.svg)](https://hub.docker.com/repository/docker/colinfang/openblas2821)

```bash
# Pre-built image in docker hub
# docker run --rm -it colinfang/openblas2821 bash
# Or we can build locally.
docker build -t debug  .
docker run --rm -it debug bash
# OPENBLAS_NUM_THREADS=2 python test.py
# OPENBLAS_NUM_THREADS=2 gdb python -ex 'r test.py'
```

```bash
(base) root@529cdf20ad39:/src# OPENBLAS_NUM_THREADS=2 python test.py
2020-09-16 22:04:35,991 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
hdfsBuilderConnect(forceNewInstance=1, nn=foo, port=0, kerbTicketCachePath=(NULL), userName=(NULL)) error:
UnknownHostException: foojava.lang.IllegalArgumentException: java.net.UnknownHostException: foo
        at org.apache.hadoop.security.SecurityUtil.buildTokenService(SecurityUtil.java:447)
        at org.apache.hadoop.hdfs.NameNodeProxiesClient.createProxyWithClientProtocol(NameNodeProxiesClient.java:139)
        at org.apache.hadoop.hdfs.DFSClient.<init>(DFSClient.java:356)
        at org.apache.hadoop.hdfs.DFSClient.<init>(DFSClient.java:290)
        at org.apache.hadoop.hdfs.DistributedFileSystem.initialize(DistributedFileSystem.java:171)
        at org.apache.hadoop.fs.FileSystem.createFileSystem(FileSystem.java:3303)
        at org.apache.hadoop.fs.FileSystem.access$200(FileSystem.java:124)
        at org.apache.hadoop.fs.FileSystem$Cache.getInternal(FileSystem.java:3352)
        at org.apache.hadoop.fs.FileSystem$Cache.getUnique(FileSystem.java:3326)
        at org.apache.hadoop.fs.FileSystem.newInstance(FileSystem.java:532)
        at org.apache.hadoop.fs.FileSystem$2.run(FileSystem.java:502)
        at org.apache.hadoop.fs.FileSystem$2.run(FileSystem.java:499)
        at java.security.AccessController.doPrivileged(Native Method)
        at javax.security.auth.Subject.doAs(Subject.java:422)
        at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1730)
        at org.apache.hadoop.fs.FileSystem.newInstance(FileSystem.java:499)
Caused by: java.net.UnknownHostException: foo
        ... 16 more
Segmentation fault
```

The java error is expected (because I put a fake host foo). It doesn't block the program.

We hit the openblas segfault in the end.
