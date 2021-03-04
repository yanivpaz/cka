# examples  for network policies
## NetworkPolicy that blocks all traffic to pods in this mynamespace2, except for traffic from pods in the same namespace on port 80.
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mypod2
  namespace: mynamespace2
spec:
  podSelector:{}
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          app: "mynamespace2"
    ports:
    - protocol: TCP
      port: 80 
```

## NetworkPolicy that blocks all traffic to and from mypod in mynamespace 

option 1
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: myname
  namespace: mynamespace
spec:
  podSelector:
    matchLabels:
      app: mypod
  ingress: {}
  egress: {}


option 2:
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: myname
  namespace: mynamespace
spec:
  podSelector:
    matchLabels:
      app: myname
  policyTypes:
  - Ingress
  - Egress
 
```
