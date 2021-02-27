#!/bin/bash -xv
export worker1=5b856d70921c.mylabserver.com
export worker2=9224efa6041c.mylabserver.com
scp ca.pem ${worker2}-key.pem ${worker2}.pem cloud_user@${worker2}:~/
scp ca.pem ${worker1}-key.pem ${worker1}.pem cloud_user@${worker1}:~/


export controller1=f095d943cd1c.mylabserver.com
export controller2=64135d4e2b1c.mylabserver.com

scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem cloud_user@${controller1}:~/
scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem cloud_user@${controller2}:~/
