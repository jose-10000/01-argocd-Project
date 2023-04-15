#!/bin/bash
# Argocd deployment
# 1. Install kubectl
sudo apt install kubectl 

# 2. Install Docker
sudo apt install Docker

# 3. Install Minikube
sudo apt install Minikube

# 4. Start Minikube
minikube start --kubernetes-version=1.26.1 --driver=docker

# 5. Verify
kubectl get nodes

# 6. Describe node
kubectl describe node minikube | less

# 7. Install Helm 
install helm
# 8. Add ArgoCD Helm repo
helm repo add argo https://argoproj.github.io/argo-helm

# 9. Update Helm repo
helm repo update

# 10. Search for ArgoCD chart
helm search repo argocd

# 11. Get ArgoCD default values
helm show values argo/argo-cd --version 3.35.4 > argocd-values.yaml

# 12. Install Terraform
sudo apt install terraform

# 13. Make terraform directory
mkdir terraform

# 14. Change directory
cd terraform

# 15. Create provider.tf
touch 0-provider.tf

# 16. Create 1-argocd.tf
touch 1-argocd.tf

# 17. Create values directory
mkdir values

# 18. Change directory
cd values

# 19. Create argocd-values.yaml
touch argocd-values.yaml

# 20. Change directory
cd ..

# 21.Initialize terraform
terraform init

# 22. Create terraform plan
terraform plan

# 23. Apply terraform plan
terraform apply

# 24. List all helm deployment
helm list -A

# 25. Get pods
kubectl get pods -n argocd

# 26. Get secrets
kubectl get secrets -n argocd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

# 27. Copy the password, execute de next command, open a browser and paste the password in it.
kubectl port-forward svc/argocd-server -n argocd 8081:443

# 28. Open a browser and paste the following URL
    # http://localhost:8081

# 29. Login with the username and password
    # Username: admin
    # Password: <paste the password here>

# 30. Pull a dockerhub repository
docker pull nginx:1.23.4

# 31. Tag the image
docker tag nginx:1.23.4 <paste the dockerhub username here>/nginx:0.1.0

# 32. Push the image to dockerhub
docker push <paste the dockerhub username here>/nginx:v0.1.0

# 33. Go to github and create a new repository
    # Name: any name
    # Description: any description
    # Public: true
    # Initialize this repository with a README: true
    # Add .gitignore: None
    # Add a license: None

# 34. Go to the repository and copy the URL
    #clone the repository
    git clone <paste the URL here>

# 35. Change directory
cd <paste the name of the repository here>

# 36. Create a new folder
mkdir my-app

# 37. Change directory
cd my-app

# 38. Create a new file
touch 0-namespace.yaml

# 39. Create a new file
touch 1-deployment.yaml

# 40. paste the following code in the 0-namespace.yaml file
            # apiVersion: v1
            # kind: Namespace
            # metadata:
            #   name: my-app

# 41. paste the following code in the 1-deployment.yaml file
            # apiVersion: apps/v1
            # kind: Deployment
            # metadata:
            #   name: nginx-deployment
            #   namespace: production
            #   labels:
            #     app: nginx
            # spec:
            #   replicas: 1
            #   selector:
            #     matchLabels:
            #       app: nginx
            #   template:
            #     metadata:
            #       labels:
            #         app: nginx
            #     spec:
            #       containers:
            #       - name: nginx
            #         image: <paste the dockerhub username here>/nginx:v0.1.0
            #         ports:
            #         - containerPort: 80

# 42. Create a new file



