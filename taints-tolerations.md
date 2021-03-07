# Example

## Taints nodes 
```
kubectl taint nodes node01 mykey=myvalue:NoSchedule
```


## Pods Examples 

A toleration "matches" a taint if the keys are the same and the effects are the same, and:
the operator is Exists (in which case no value should be specified), or
the operator is Equal and the values are equal.






## Check results
```
kubectl get pods -A | grep -i mypod
```
