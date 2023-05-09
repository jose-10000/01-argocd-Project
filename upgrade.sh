#!/bin/bash
# 1. make this file executable with chmod +x upgrade.sh
# 2. run this file with ./upgrade.sh <version>, for example ./upgrade.sh v1.23.4

# exit when any command fails
set -e

# Get new version from command line
new_ver=$1

echo "new version: $new_ver"

# Simulate release of the new docker images
docker tag nginx:1.23.4 jose10000/nginx:$new_ver

# Push new version to dockerhub
docker push jose10000/nginx:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
git clone git@github.com:jose-10000/01-argocd-Project.git $tmp_dir

# Update image tag in deployment.yaml
sed -i "s/jose10000\/nginx:.*/jose10000\/nginx:$new_ver/g" $tmp_dir/argocd-project/environments/staging/my-app/1-deployment.yaml

# Commit and push
echo "Committing and pushing changes to GitHub"
echo "cd $tmp_dir"
cd $tmp_dir
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
echo "Removing $tmp_dir"
rm -rf $tmp_dir
