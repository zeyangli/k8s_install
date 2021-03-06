
# https://www.katacoda.com/courses/kubernetes/helm-package-manager
# helm init && wget https://raw.githubusercontent.com/hbstarjason/k8s_install/master/deploy-nfs.sh && sh deploy-nfs.sh

LOCAL_IP=$(ifconfig ens3 |grep "inet addr"| cut -f 2 -d ":"|cut -f 1 -d " ")

mkdir -p /data/nfs && chmod a+rw /data/nfs

apt-get update && apt-get install -y nfs-kernel-server nfs-common

cat << EOF >> /etc/exports
/data/nfs *(rw,sync,insecure,no_subtree_check,no_root_squash)
EOF

exportfs -r
/etc/init.d/nfs-kernel-server restart

showmount -e localhost

mkdir -p /data/nfs-mount
mount ${LOCAL_IP}:/data/nfs  /data/nfs-mount
df -h

# umount /data/nfs-mount
# ip addr > /data/nfs-mount/test.txt
# cat /data/nfs/test.txt

# install NFS-Client Provisioner 
helm install -n nfs stable/nfs-client-provisioner --set nfs.server=${LOCAL_IP} --set nfs.path=/data/nfs --set storageClass.name=standard --namespace nfs

helm ls
kubectl get sc

cat << EOF > nfs-sc-pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nfs-sc-pvc
  annotations:
    volume.beta.kubernetes.io/storage-class: "standard"
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 10Gi
EOF

kubectl create -f nfs-sc-pvc.yaml 
kubectl get pv 
kubectl get pvc 
