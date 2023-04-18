#!/bin/bash

# 1. Add the Helm repository
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

# 2. Serach the repository and take a look at the available charts
helm search repo metrics-server

# 3. Update the Helm repository
helm repo update

# 4. Save the Helm chart to a local directory
helm show values metrics-server/metrics-server --version 3.8.4 > metrics-server-defaults.yaml

# 5. Create a new application.yaml file
cat <<EOF > application.yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: metrics-server
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://kubernetes-sigs.github.io/metrics-server/
    targetRevision: 3.8.4
    chart: metrics-server
    helm:
      version: v3
      releaseName: my-metrics
      passCredentials: false
      parameters:
        - name: "image.tag"
          value: v0.6.2
      values: |
        defaultArgs:
        - --cert-dir=/tmp
        - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
        - --kubelet-use-node-status-port
        - --metric-resolution=15s
        - --kubelet-insecure-tls
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - Validate=true
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
EOF

# 6. Deploy the application
kubectl apply -f application.yaml

# 7. Check the application status in argocd
    # http://localhost:8081/applications/metrics-server

# 8. Delete the application
kubectl delete -f application.yaml


