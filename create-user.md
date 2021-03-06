# Create user

## with certificate 
```


```
https://docs.bitnami.com/tutorials/configure-rbac-in-your-kubernetes-cluster/#use-case-1-create-user-with-limited-namespace-access

## with token  using service account 
```
kubectl create serviceaccount sareadonlyuser
kubectl create clusterrole readonlyuserrole --verb=get --verb=list --verb=watch --resource=pods
kubectl create clusterrolebinding readonlyuserclusterrolebinding --serviceaccount=default:sareadonlyuser --clusterrole=sareadonlyuser
TOKEN=$(kubectl describe secrets "$(kubectl describe serviceaccount sareadonlyuser | grep -i Tokens | awk '{print $2}')" | grep token: | awk '{print $2}')
kubectl config set-credentials sareadonlyuser --token=$TOKEN
kubectl config set-context podreadercontext --cluster=kubernetes --user=readonlyuser
kubectl config use-context podreadercontext
```
https://stackoverflow.com/questions/44948483/create-user-in-kubernetes-for-kubectl
