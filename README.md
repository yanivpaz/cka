# access to jkubernetes

* Extract all crt and keys from kubeconfig
* Run the following command 
```
curl https://10.0.1.101:6443 --key /tmp/admin.key --cert /tmp/admin.crt --cacert /tmp/ca.crt
```
