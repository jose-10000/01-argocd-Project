# 1. first deploy the secret
kubectl apply -f 3-example/git-repo-secret.yaml
# 2. deploy the application
kubectl apply -f 3-example/application.yaml
# 3. go to argocd and verify the application
#     # http://localhost:8081


