
Network Policies
Lesson Reference
Create a new namespace.

kubectl create namespace np-test
Add a label to the Namespace.

kubectl label namespace np-test team=np-test
Create a web server Pod.

vi np-nginx.yml
apiVersion: v1
kind: Pod
metadata:
  name: np-nginx
  namespace: np-test
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx
kubectl create -f np-nginx.yml
Create a client Pod.

vi np-busybox.yml
apiVersion: v1
kind: Pod
metadata:
  name: np-busybox
  namespace: np-test
  labels:
    app: client
spec:
  containers:
  - name: busybox
    image: radial/busyboxplus:curl
    command: ['sh', '-c', 'while true; do sleep 5; done']
kubectl create -f np-busybox.yml
Get the IP address of the nginx Pod and save it to an environment variable.

kubectl get pods -n np-test -o wide

NGINX_IP=<np-nginx Pod IP>
Attempt to access the nginx Pod from the client Pod. This should succeed since no NetworkPolicies select the client Pod.

kubectl exec -n np-test np-busybox -- curl $NGINX_IP
Create a NetworkPolicy that selects the Nginx Pod.

vi my-networkpolicy.yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: my-networkpolicy
  namespace: np-test
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  - Egress
kubectl create -f my-networkpolicy.yml
This NetworkPolicy will block all traffic to and from the Nginx Pod. Attempt to communicate with the Pod again. It should fail this time.

kubectl exec -n np-test np-busybox -- curl $NGINX_IP
Modify the NetworkPolicy so that it allows incoming traffic on port 80 for all Pods in the np-test Namespace.

kubectl edit networkpolicy -n np-test my-networkpolicy
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: my-networkpolicy
  namespace: np-test
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          team: np-test
    ports:
    - port: 80
      protocol: TCP
Attempt to communicate with the Pod again. This time, it should work!

kubectl exec -n np-test np-busybox -- curl $NGINX_IP
