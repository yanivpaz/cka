# tips 
## list of installed packages
```
 dpkg -l |wc -l  OR  apt list --installed
```

## enable pods on the control plan
```
kubectl taint nodes --all node-role.kubernetes.io/master-
```

## get use and group
```
kubectl config view --raw -o jsonpath='{users[*].user.client-certification-data }' | base64 --decode > admin.crt

openssl x509 -in admin.crt -text -noout | head
```
output :
CN - user
O - group memebership


## Connection phases
connection 
authentication
authotization 
admission control - additional code before api server 
     
## command tips
kubectl get pod pod-name -v 6
kubectl proxy &
curl <url  from get pod >

kubectl get pods --watch -v 6 &

## pod lifecycle 
Creation 
Running 
Termination 


## run as 
kubectl get pods -n web   --as=system:serviceaccount:web:webautomation


## pods removal
1. api grace period timer - 30 second
2. pods change to terminate
3. SIGTERM
4. remove from endpoint 
5. after grace - SIGKILL
6. API and etcd update

--grace-period=30
--force : remove immediatly 


## svc domain 
```
# Working 
curl my-service:8000
curl my-service.default:8000
curl my-service.default.svc.cluster.local:8000

# Not working
curl my-service.default.svc:8000
curl: (6) Couldn't resolve host 'my-service.default.svc'
curl my-service.default.svc.cluster:8000
curl: (6) Couldn't resolve host 'my-service.default.svc.cluster'
```
