# Example
## Links
https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/


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
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod5
spec:
  containers:
  - image: nginx
    name: mypod5
  tolerations:
  - key: mykey
    operator: "Exists"
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod6
spec:
  containers:
  - image: nginx
    name: mypod6
  tolerations:
  - key: mykey
    effect: NoSchedule
    operator: "Exists"
```


## Check results
```
kubectl get pods -A | grep -i mypod
```
Results:
```
default       mypod1                                 1/1     Running   0          9m28s
default       mypod2                                 1/1     Running   0          9m27s
default       mypod3                                 1/1     Running   0          9m24s
default       mypod4                                 0/1     Pending   0          9m1s
default       mypod5                                 1/1     Running   0          10s
default       mypod6                                 1/1     Running   0          12s
``
