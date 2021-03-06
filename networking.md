# Networking 

```
kubectl delete  -f https://docs.projectcalico.org/latest/manifests/calico.yaml  
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```
