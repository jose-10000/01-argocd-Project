In this folder

1 create dev, staging and production folders

2 in each folder paste my-app folder and create apps and second-app folders

3 the second-app folder has de same files as my-app folder

4 in apps folder create my-app.yaml and second-app.yaml files
the files are quite similar, they only differ in two lines
name:
and
path:


5 in my-app.yaml file put the next
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app-foo
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://github.com/jose-10000/01-argocd-Project.git
    targetRevision: HEAD
    path: argocd-project/environments/staging/my-app
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


6 - in second-app.yaml file put the next

---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app-bar
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://github.com/jose-10000/01-argocd-Project.git
    targetRevision: HEAD
    path: argocd-project/environments/staging/second-app
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

