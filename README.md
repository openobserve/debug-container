# A debug container

This debug container can be used for debugging applications in your kubernetes cluster.

This container comes pre-installed with below libraries

1. ca-certificates 
1. curl 
1. dnsutils 
1. git 
1. iputils-ping 
1. jq 
1. nmap 
1. openssh-client 
1. tree 
1. tzdata 
1. vim-tiny 
1. wget 
1. kubectl
1. yq


In order to run a pod with this container in your cluster:

> kubectl apply -f debugger.yaml

> kubectl -n default get pod

> kubectl -n default exec -it pod/{pod name} -- bash
