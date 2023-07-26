FROM zhonger/ubuntu:advance-focal

LABEL maintainer="zhonger zhonger@live.cn"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# APT updates
USER root
RUN apt-get update \
    && apt-get upgrade -y 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata \ 
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo "Asia/Tokyo" > /etc/timezone

USER ubuntu

# Install munge & slurm
RUN sudo apt-get install munge slurm-wlm slurm-wlm-doc slurm-wlm-torque -y \
    && sudo rm -rf  /var/spool/slurm \
    && sudo mkdir /var/spool/slurm \
    && sudo chown -R slurm:slurm /var/spool/slurm \
    && sudo rm -rf /var/run/slurm/ \
    && sudo mkdir /var/run/slurm/ \
    && sudo chown -R slurm:slurm /var/run/slurm/

# Config slurm
COPY slurm.conf /etc/slurm/slurm.conf
RUN sudo service munge restart \
    && sudo service slurmd restart \
    && sudo service slurmctld restart

# Clean APT-cache
RUN sudo apt-get autoremove -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]