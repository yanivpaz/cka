```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mysc
parameters:
provisioner: kubernetes.io/no-provisioner
allowVolumeExpansion: true
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: mysc
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/var/output"
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: foo-pvc
spec:
  storageClassName: mysc
  accessModes:
    - ReadWriteOnce
  volumeName: task-pv-volume
  resources:
    requests:
      storage: 100Mi
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: foo-pvc

```
