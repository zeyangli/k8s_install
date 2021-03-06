
# wget https://raw.githubusercontent.com/hbstarjason/k8s_install/master/deploy-kind.sh && sh deploy-kind.sh
# https://uappexplorer.com/snaps
# sudo snap install microK8s  --classic

# install kubectl 
sudo snap install kubectl --classic
kubectl version

curl -Lo ./kind-linux-amd64 https://github.com/kubernetes-sigs/kind/releases/download/v0.3.0/kind-linux-amd64 && \
chmod +x ./kind-linux-amd64 && \
mv ./kind-linux-amd64 /usr/local/bin/kind && \
kind version

curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
docker-compose version

cat <<EOF >  kind-config.yaml
# https://kind.sigs.k8s.io/docs/user/quick-start/
# three node (two workers) cluster config
kind: Cluster
apiVersion: kind.sigs.k8s.io/v1alpha3
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --config=kind-config.yaml

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
kubectl cluster-info
kubectl get node 

sleep 30

# install helm 
sudo snap install helm --classic

kubectl apply -f  https://raw.githubusercontent.com/hbstarjason/k8s_install/master/helm-admin.yaml
helm init

helm version

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"

# https://blog.csdn.net/aixiaoyang168/article/details/79466938
# curl -Lo values.yaml https://raw.githubusercontent.com/kubernetes/charts/master/stable/spinnaker/values.yaml
# helm install -n spinnaker stable/spinnaker -f values.yaml --timeout 3600  --namespace spinnaker
