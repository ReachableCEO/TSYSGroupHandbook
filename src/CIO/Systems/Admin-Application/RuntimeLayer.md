# TSYS Group Web Application Runtime Layer

## Introduction

The TSYS Group needs a web application runtime layer for it's myriad of applications.

## Broad Requirements for runtime layer

* No single point of failure
* High availability/auto recovery for containers
* Distributed/replicated persistent storage for containers

## Major components of runtime environment

### storage

Replicated storage that fulfills the persistent volume claim of docker containers.

Deployed on www1,2,3 virtual machines (k3s worker nodes).
Deployed on subord virtual machine (k3s worker node for r&d).

Using longhorn

### container runtime, control plane, control panel

* Kubernetes load balancer , (metallb). Only TCP load balancing is used , as all intelligence (certs/layer 7 etc) is handled by Opnsense
* Kubernetes runtime environment (k3s from Rancher labs)
  * workers
  * control plane
  * control panel
* Kubernetes runtime environment control panel
  * Rancher
  * authenticates to TSYS LDAP

Control plane is deployed on db1,2,3

Workers are deployed on www1,2,3

### Core container functionality (running as containers on the platform)

* docker registry
* IAM
* API gateway
* Jenkins
* all the above installed as containers running on the kubernetes runtime.
* all the above configured for  LDAP authentication
* all the above no other configuration of the components would be in scope

### Applications to deploy/migrate on the runtime platform

### PAAS

* blue/green and other standard deployment methodologies
* able to auto deploy from ci/cd 
* orchestrate all of the primitives (load balancer, port assignment etc) (docker-compose target? helm chart? is Rancher suitable?)

## General notes

## A suggested prescriptive technical stack / Work done so far

Followed some of this howto:
<https://rene.jochum.dev/rancher-k3s-with-galera/>

Enough to get k3s control plane and workers deployed:

```

root@db1:/var/log/maxscale# kubectl get nodes -o wide
NAME   STATUS   ROLES                  AGE   VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
db2    Ready    control-plane,master   30d   v1.20.4+k3s1   10.251.51.2   <none>        Ubuntu 20.04.2 LTS   5.4.0-70-generic   containerd://1.4.3-k3s3
db3    Ready    control-plane,master   30d   v1.20.4+k3s1   10.251.51.3   <none>        Ubuntu 20.04.2 LTS   5.4.0-70-generic   containerd://1.4.3-k3s3
db1    Ready    control-plane,master   30d   v1.20.4+k3s1   10.251.51.1   <none>        Ubuntu 20.04.2 LTS   5.4.0-70-generic   containerd://1.4.3-k3s3
www1   Ready    <none>                 30d   v1.20.4+k3s1   10.251.50.1   <none>        Ubuntu 20.04.2 LTS   5.4.0-70-generic   containerd://1.4.3-k3s3
www2   Ready    <none>                 30d   v1.20.4+k3s1   10.251.50.2   <none>        Ubuntu 20.04.2 LTS   5.4.0-70-generic   containerd://1.4.3-k3s3
root@db1:/var/log/maxscale#

```

and a bit of load balancing setup going:

```

fenixpi% kubectl get pods -A -o wide
NAMESPACE        NAME                                        READY   STATUS             RESTARTS   AGE   IP            NODE   NOMINATED NODE   READINESS GATES
metallb-system   speaker-7nsvs                               1/1     Running            10         30d   10.251.51.2   db2    <none>           <none>
kube-system      metrics-server-86cbb8457f-64ckz             1/1     Running            18         16d   10.42.2.23    db1    <none>           <none>
kube-system      local-path-provisioner-5ff76fc89d-kcg7k     1/1     Running            34         16d   10.42.2.22    db1    <none>           <none>
metallb-system   controller-fb659dc8-m2tlk                   1/1     Running            12         30d   10.42.0.42    db3    <none>           <none>
metallb-system   speaker-vfh2p                               1/1     Running            17         30d   10.251.51.3   db3    <none>           <none>
kube-system      coredns-854c77959c-59kpz                    1/1     Running            13         30d   10.42.0.41    db3    <none>           <none>
kube-system      ingress-nginx-controller-7fc74cf778-qxdpr   1/1     Running            15         30d   10.42.0.40    db3    <none>           <none>
metallb-system   speaker-7bzlw                               1/1     Running            3          30d   10.251.50.2   www2   <none>           <none>
metallb-system   speaker-hdwkm                               0/1     CrashLoopBackOff   4633       30d   10.251.51.1   db1    <none>           <none>
metallb-system   speaker-nhzf6                               0/1     CrashLoopBackOff   1458       30d   10.251.50.1   www1   <none>           <none>

```

Beyond that, it's greenfield.