# Create user



## with token  using service account 
```
kubectl create serviceaccount sareadonlyuser
kubectl create clusterrole readonlyuserrole --verb=get --verb=list --verb=watch --resource=pods
kubectl create clusterrolebinding readonlyuserclusterrolebinding --serviceaccount=default:sareadonlyuser --clusterrole=readonlyuserrole 
TOKEN=$(kubectl describe secrets "$(kubectl describe serviceaccount sareadonlyuser | grep -i Tokens | awk '{print $2}')" | grep token: | awk '{print $2}')
kubectl config set-credentials mycred --token=$TOKEN
kubectl config set-context sareadercontext --cluster=kubernetes --user=mycred
kubectl config use-context sareadercontext
```
https://stackoverflow.com/questions/44948483/create-user-in-kubernetes-for-kubectl



## with certificate 
```
openssl genrsa -out employee.key 2048
openssl req -new -key employee.key -out employee.csr -subj "/CN=employee/O=paz"

# on master 
cd /etc/kubernetes/pki
# copy csr employee.csr 
openssl x509 -req -in employee.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out employee.crt -days 500

kubectl create clusterrolebinding readonlyuserclusterrolebinding2 --clusterrole=readonlyuserrole --user=employee --group=paz
kubectl config set-credentials employee --client-certificate=employee.crt  --client-key=employee.key
kubectl config set-context employee-context --cluster=kubernetes --user=employee
kubectl config use-context employee-context
```

https://docs.bitnami.com/tutorials/configure-rbac-in-your-kubernetes-cluster/#use-case-1-create-user-with-limited-namespace-access


##  test
```
kubectl get pods -A
# ensure you get no
kubectl auth can-i create pods
```


## The kube config will eventually be like 
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data:
    server: https://10.0.1.101:6443
  name: kubernetes
users:
- name: employee
  user:
    client-certificate: /home/cloud_user/employee.crt
    client-key: /home/cloud_user/employee.key
- name: mycred
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6Ik1DdERmcDQ1VEFtcWFGYVFPV0l
contexts:
- context:
    cluster: kubernetes
    user: employee
  name: employee-context
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
- context:
    cluster: kubernetes
    user: mycred
  name: sareadercontext
current-context: employee-context
kind: Config
preferences: {}
```
