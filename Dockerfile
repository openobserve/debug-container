# syntax=docker/dockerfile:experimental

FROM --platform=$BUILDPLATFORM public.ecr.aws/ubuntu/ubuntu:edge

ENV YQ="4.29.2"

# install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  bind9-dnsutils \
  iputils-ping \
  jq \
  git \
  nmap \
  openssh-client \
  tree \
  vim-tiny \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Config ca-certificates for wget
RUN echo "ca_certificate=/etc/ssl/certs/ca-certificates.crt" > $HOME/.wgetrc

# kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/$BUILDPLATFORM/kubectl -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

# yq
RUN if [ "$BUILDPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$BUILDPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$BUILDPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
  wget https://github.com/mikefarah/yq/releases/download/v${YQ}/yq_linux_${ARCHITECTURE} -O /usr/local/bin/yq && \
  chmod +x /usr/local/bin/yq

