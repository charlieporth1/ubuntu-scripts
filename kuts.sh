##Docker Installation 
$ wget -qO- https://get.docker.com/ | sh

###user to the “docker” group execute the following command:

$ sudo usermod -aG docker user

$ sudo reboot

###Verify Docker Installation

$ docker --version
Or
$ sudo systemctl status docker
Or
$ ls -l /var/run/docker.sock
Or
$ docker version
( this should show you both client and server )
Or

$ docker info

##Kubernetes Installation and Configuration
###After docker is ready then we can start to install the kubernetes.

###update sources.list.d for apt 
1. Install kubenetes package preparation
a. $  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add  
b. $  cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
   > deb http://apt.kubernetes.io/ kubernetes-xenial main
   > EOF
c. $  apt-get update

###PS Kubernetes 1.4 adds support for the alpha tool:
Kubeadm: admin tool to simplify starting K8S cluster
"kubeadm". The kubeadmn tool simplifies the process of starting a Kubernetes cluster.
Kubectl: command line
Kubelet: node manager
To use kubeadm we'll also need the kubectl cluster CLI tool and the kubelet node manager.
Kubecni: cni-container network interface
We'll also install Kubernetes CNI (Container Network Interface) support for multihost networking should we add additional nodes.

###Install required kubernetes binaries
1. Install Kubernetes basics
$ apt-get install -y kubelet kubeadm kubectl kubernetes-cni
2. Start the Kubenetes Master Component
$ kubeadm init
3. Exploring the cluster
$ ps -fwwp `pgrep kubelet`
UID        PID  PPID  C STIME TTY          TIME CMD
root       817     1  3 11:25 ?        00:01:25 /usr/bin/kubelet --kubeconfig=/etc/kubernetes/kubelet.conf --require-kubeconfig=true --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin --cluster-dns=100.64.0.10 --cluster-domain=cluster.local --v=4
Enable Networking
The very last line is the clue to our problem: "cni config unintialized". Our system is configured to use CNI but we have not installed a CNI networking system. We can easily add the Weave CNI VXLAN based container networking drivers using a POD spec from the Internet:

PS: if you try $ libel get pods --all-namespace, you should be able to see this error message at the end.

Thus, here we install the Weave CNI drivers.

$ kubectl apply -f https://git.io/weave-kube
daemonset "weave-net" created
This is for kube-system   weave-net-2ifri

### Kubernetes's components are leverage it's own container techniques. Thus we can check all the pods we created for running kubernetes

$ kubectl get pods --all-namespaces
user@ubuntu:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                             READY     STATUS   RESTARTS   AGE
kube-system   etcd-ubuntu                      1/1       Running   1          5d
kube-system   kube-apiserver-ubuntu            1/1       Running   3          5d
kube-system   kube-controller-manager-ubuntu   1/1       Running   1          5d
kube-system   kube-discovery-982812725-h210x   1/1       Running   1          5d
kube-system   kube-dns-2247936740-swjx1        3/3       Running   3          5d
kube-system   kube-proxy-amd64-s4hor           1/1       Running   1          5d
kube-system   kube-scheduler-ubuntu            1/1       Running   1          5d
kube-system   weave-net-2ifri 


PS: The git.io site is a short url service from github. The weave-kube route points to a Kibernetes spec for a DaemonSet which is a resource that runs on every node in a cluster. This Weave DaemonSet ensures that the weaveworks/weave-kube:1.7.1 image is running in a pod on all hosts, providing support for multihost networking throughout the cluster.

##Configure kubernetes cluster via kubectl

kubectl or kubectl help config or kubectl config view can be used kubectl control a remote cluster, we must specify the cluster endpoint to kubctl

The kubectl cli tries to reach API server on port 8080
$ curl http://localhost:8080

$ kubectl config set-cluster local --server=http://127.0.0.1:8080 --insecure-skip-tls-verify=true
cluster "local" set.

Setup Cluster's Context
$ ls -la .kube/
total 16
drwxr-xr-x 3 root root 4096 Oct 25 06:39 .
drwx------ 4 root root 4096 Oct 24 23:37 ..
-rw------- 1 root root  191 Oct 25 06:39 config
StartFragment EndFragment
drwxr-xr-x 3 root root 4096 Oct 24 23:37 schema

$ cat .kube/config
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: http://127.0.0.1:8080
  name: local
contexts: []
current-context: ""
kind: Config
preferences: {}
StartFragment EndFragment
users: []

$ kubectl config set-context local --cluster=local
StartFragment EndFragment
context "local" set.

$ kubectl config use-context local
StartFragment EndFragment
switched to context "local".

$ cat .kube/config
or
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: http://127.0.0.1:8080
  name: local
contexts:
- context:
    cluster: local
    user: ""
  name: local
current-context: local
kind: Config
preferences: {}
StartFragment EndFragment
users: []

##Test the cluster

$ kubectl cluster-info
Kubernetes master is running at http://localhost:8080
kube-dns is running at http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/kube-dns

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

$ kubectl get nodes
NAME      STATUS    AGE
ubuntu    Ready     5d
