# Example

## Taints nodes 
```
kubectl taint nodes node01 mykey=myvalue:NoSchedule
```


## Pods Examples 
A toleration "matches" a taint if the keys are the same and the effects are the same, and:
the operator is Exists (in which case no value should be specified), or
the operator is Equal and the values are equal.
```
controlplane $ cat mypod1 mypod2 mypod3 mypod4
apiVersion: v1
kind: Pod
metadata:
  name: mypod1
spec:
  containers:
  - image: nginx
    name: mypod1
  tolerations:
  - key: mykey
    value: myvalue
    effect: NoSchedule
    operator: Equal
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod2
spec:
  containers:
  - image: nginx
    name: mypod2
  tolerations:
  - key: mykey
    value: myvalue
    effect: NoSchedule
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod3
spec:
  containers:
  - image: nginx
    name: mypod3
  tolerations:
  - key: mykey
    value: myvalue
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod4
spec:
  containers:
  - image: nginx
    name: mypod4
  tolerations:
  - key: mykey
    effect: NoSchedule
```


## Check results
```
kubectl get pods -A | grep -i mypod
```
Results:
```
default       mypod1                                 1/1     Running   0          48s
default       mypod2                                 1/1     Running   0          47s
default       mypod3                                 1/1     Running   0          44s
default       mypod4                                 0/1     Pending   0          21s
``
