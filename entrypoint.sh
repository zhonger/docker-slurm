#!/bin/sh

sudo service munge restart
sudo service slurmd restart
sudo service slurmctld restart
sinfo
/bin/zsh