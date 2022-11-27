# syntax=docker/dockerfile:experimental

FROM --platform=$BUILDPLATFORM public.ecr.aws/ubuntu/ubuntu:edge

# install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  tzdata \
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
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/$TARGETPLATFORM/kubectl -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

# yq
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
  wget https://github.com/mikefarah/yq/releases/download/v${YQ}/yq_linux_${ARCHITECTURE} -O /usr/local/bin/yq && \
  chmod +x /usr/local/bin/yq

