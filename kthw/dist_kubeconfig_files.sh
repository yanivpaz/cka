#!/bin/bash -xv
export worker1=5b856d70921c.mylabserver.com
export worker2=9224efa6041c.mylabserver.com
scp ${worker1}.kubeconfig kube-proxy.kubeconfig cloud_user@${worker1}:~/
scp ${worker2}.kubeconfig kube-proxy.kubeconfig cloud_user@${worker2}:~/

exit

export controller1=f095d943cd1c.mylabserver.com
export controller2=64135d4e2b1c.mylabserver.com

scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig cloud_user@${controller1}:~/
scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig cloud_user@${controller2}:~/
