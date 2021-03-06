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
openssl req -new -key employee.key -out employee.csr -subj "/CN=employee/O=bitnami"

# on master 
cd /etc/kubernetes/pki

openssl x509 -req -in employee.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out employee.crt -days 500
kubectl config set-credentials employee --client-certificate=/home/employee/.certs/employee.crt  --client-key=/home/employee/.certs/employee.key
kubectl config set-context employee-context --cluster=minikube --namespace=office --user=employee
```

https://docs.bitnami.com/tutorials/configure-rbac-in-your-kubernetes-cluster/#use-case-1-create-user-with-limited-namespace-access
