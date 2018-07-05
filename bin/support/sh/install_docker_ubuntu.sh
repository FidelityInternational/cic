#!/usr/bin/env bash

sudo apt-get -y  update

# install Docker
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository -y \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

sudo apt-get update
sudo apt-get -y install docker-ce

docker version > /dev/null 2>&1 || (sudo usermod -aG docker "${USER}" && newgrp - )


