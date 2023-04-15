Argocd deployment
1 Install kubectl 
2 Install Docker
3 Install Minikube
4 minikube start --kubernetes-version=1.26.1 --driver=docker
Verify
5 kubectl get nodes
6 kubectl describe node minikube | less
7 install helm
8 helm repo add argo 




