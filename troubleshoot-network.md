Lesson Reference
Log in to your K8s Control Plane node.

Check the status of kube-proxy, and check the kube-proxy logs:

kubectl get pods -n kube-system
kubectl logs -n kube-system <kube-proxy_POD_NAME>
Check the status of the K8s DNS pods:

kubectl get pods -n kube-system
Look for pods that have names beginning with coredns.

Create a simple Nginx Pod to use for testing, as well as a service to expose it:

vi nginx-netshoot.yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-netshoot
  labels:
    app: nginx-netshoot
spec:
  containers:
  - name: nginx
    image: nginx:1.19.1

---

apiVersion: v1
kind: Service
metadata:
  name: svc-netshoot
spec:
  type: ClusterIP
  selector:
    app: nginx-netshoot
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
kubectl create -f nginx-netshoot.yml
Create a Pod running the netshoot image in a container:

vi netshoot.yml
apiVersion: v1
kind: Pod
metadata:
  name: netshoot
spec:
  containers:
  - name: netshoot
    image: nicolaka/netshoot
    command: ['sh', '-c', 'while true; do sleep 5; done']
kubectl create -f netshoot.yml
Open an interactive shell to the netshoot container:

kubectl exec --stdin --tty netshoot -- /bin/sh
curl svc-netshoot
ping svc-netshoot
nslookup svc-netshoot
