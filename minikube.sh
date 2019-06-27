# https://gist.github.com/kevin-smets/b91a34cea662d0c523968472a81788f7

brew update && brew install kubectl && brew cask install docker minikube virtualbox

minikube dashboard
minikube addons enable ingress

minikube ip
minikube ssh
minikube dashboard
minikube service list


docker run -d -p 5000:5000 --restart=always --name registry registry:2

brew install kubernetes-helm
helm init
kubectl describe deploy tiller-deploy — namespace=kube-system


kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
kubectl get pods
kubectl expose deployment hello-minikube --type=NodePort
kubectl get services
curl $(minikube service hello-minikube --url)
eval $(minikube docker-env)
docker ps
kubectl delete services hello-minikube
kubectl delete deployment hello-minikube



############### https://yq.aliyun.com/articles/221687

# 
curl -Lo minikube http://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v1.1.1/minikube-darwin-amd64 \
&& chmod +x minikube && sudo mv minikube /usr/local/bin/

# 
minikube start --registry-mirror=https://registry.docker-cn.com --kubernetes-version v1.12.1
