#!/bin/bash -xv

export controller1=f095d943cd1c.mylabserver.com
export controller2=64135d4e2b1c.mylabserver.com

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

cat > encryption-config.yaml << EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

scp  encryption-config.yaml cloud_user@${controller1}:~/
scp encryption-config.yaml cloud_user@${controller2}:~/
