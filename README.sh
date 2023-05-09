Argocd deployment
1 Install kubectl 
2 Install Docker
3 Install Minikube

# 4 Start Minikube, and deploy argocd
minikube start --kubernetes-version=1.26.1 --driver=docker
terraform init
terraform apply
# 5 Verify
kubectl get nodes
### The app is in argocd-project/environments/staging/my-app
# 6 Get the argocd password and login
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

# 7 Deploy the app
kubectl apply -f 1-example/application.yaml

# 8 Execute the script update.sh to update the app
./update.sh v1.23.4

# 9 Check the app in the browser


