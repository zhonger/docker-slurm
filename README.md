# Slurm Docker Image

## Description

This is a slurm dockerlized image for single node or clusters.

In order to use it more easily, we uploaded the image to three independent image hosting platforms:

- [Docker Hub](https://hub.docker.com/r/zhonger/slurm)
- [Quay.io](https://quay.io/repository/zhonger/slurm)
- [Aliyun](https://registry.cn-shanghai.aliyuncs.com/zhonger/slurm) (Shanghai)

## Features

- The basic function is to provide Slurm service.
- Considering the diversity of CPU arch nowadays, we provide 6 archs including amd64, arm64 and so on.
- Other small features: the support of QSUB inteface to submit jobs.

## How to use it

It's very easy to use it through `docker-compose` (**Recommend**).

```yaml
# docker-compose.yml
version: '3'

services:
  worker:
    image: zhonger/slurm:latest
    container_name: worker
    stdin_open: true
    tty: true
    volumes:
      - /etc/localtime:/etc/localtime
      - ./slurm.conf:/etc/slurm/slurm.conf
      - ./hosts:/etc/hosts
      # - ./data:/home/ubuntu/data
    restart: always
    hostname: worker
```

If you want to deploy with cluster mode, you need to use `docker-compose.yml` like the following:

```yaml
# docker-compose.yml
version: '3'

services:
  worker:
    image: zhonger/slurm:latest
    container_name: worker
    stdin_open: true
    tty: true
    volumes:
      - /etc/localtime:/etc/localtime
      - ./slurm.conf.cluster:/etc/slurm/slurm.conf
      - ./hosts.cluster:/etc/hosts
      # - ./data:/home/ubuntu/data
    ports:
      - 6817:6817
      - 6818:6818
    restart: always
    hostname: worker
```

Here, the two ports `6817` and `6818` are necessary for the communication of nodes.


```bash
docker-compose up -d
```

## More

If you want to know more about the idea and details, you can refer to [《Docker 快速部署 Slurm 集群》](https://lisz.me/tech/docker/docker-slurm-cluster.html). (Sorry, it's only Chinese now. In the future, we will provide English version.)

## 简介

这个 Ubuntu 基础镜像是为构建各种服务的 Docker 镜像而准备的。

为了便于使用，我们将镜像上传到了三个独立的镜像托管平台：

- [Docker Hub](https://hub.docker.com/r/zhonger/slurm)
- [Quay.io](https://quay.io/repository/zhonger/slurm)
- [Aliyun](https://registry.cn-shanghai.aliyuncs.com/zhonger/slurm) (上海)

## 特性

- 本镜像的基础功能是提供 Slurm 服务。
- 考虑现今 CPU 架构的多样性，本镜像支持包括 amd64、arm64 等在内的 6 种架构。
- 其他小特性：支持使用 QSUB 方式提交任务。

## 如何使用

通过 `docker-compose` 可以非常方便使用本镜像（**推荐**）。

```yaml
# docker-compose.yml
version: '3'

services:
  worker:
    image: zhonger/slurm:latest
    container_name: worker
    stdin_open: true
    tty: true
    volumes:
      - /etc/localtime:/etc/localtime
      - ./slurm.conf:/etc/slurm/slurm.conf
      - ./hosts:/etc/hosts
      # - ./data:/home/ubuntu/data
    restart: always
    hostname: worker
```

如果你想要使用本镜像部署 Slurm 集群，`docker-compose.yml` 文件需要修改如下：

```yaml
# docker-compose.yml
version: '3'

services:
  worker:
    image: zhonger/slurm:latest
    container_name: worker
    stdin_open: true
    tty: true
    volumes:
      - /etc/localtime:/etc/localtime
      - ./slurm.conf.cluster:/etc/slurm/slurm.conf
      - ./hosts.cluster:/etc/hosts
      # - ./data:/home/ubuntu/data
    ports:
      - 6817:6817
      - 6818:6818
    restart: always
    hostname: worker
```

此处的端口 `6817` 和 `6818` 对于 Slurm 集群中的节点沟通是必要的。

```bash
docker-compose up -d
```

## 了解更多

关于本镜像的更多思考和详细步骤，请访问 [《Docker 快速部署 Slurm 集群》](https://lisz.me/tech/docker/docker-slurm-cluster.html) 了解更多。