# tips 

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

## pods removal
1. api grace period timer - 30 second
2. pods change to terminate
3. SIGTERM
4. remove from endpoint 
5. after grace - SIGKILL
6. API and etcd update

--grace-period=30
--force : remove immediatly 
