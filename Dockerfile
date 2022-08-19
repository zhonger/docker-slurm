FROM zhonger/ubuntu:advance

LABEL maintainer="zhonger zhonger@live.cn"

# APT updates
RUN sudo apt-get update \
    && sudo apt-get upgrade -y

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