# this example is connected to /argocd-project/environments
# please read the file /argocd-project/README.md

# 01. Create a new application.yaml file
vim application.yaml
# 02. Paste the following code in the application.yaml file 

---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: apps-staging
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://github.com/jose-10000/01-argocd-Project.git
    targetRevision: HEAD
    path: argocd-project/environments/staging/apps
  destination:
    server: https://kubernetes.default.svc
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - Validate=true
      - CreateNamespace=false
      - PrunePropagationPolicy=foreground
      - PruneLast=true

# 03. Add the changes to github
git add .
git commit -m "add application.yaml"
git push

# deploy the application
kubectl apply -f application.yaml
