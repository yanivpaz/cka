You can set up a basic nginx proxy for the healthz endpoint by first installing nginx"

sudo apt-get install -y nginx
Create an nginx configuration for the health check proxy:

cat > kubernetes.default.svc.cluster.local << EOF
server {
  listen      80;
  server_name kubernetes.default.svc.cluster.local;

  location /healthz {
     proxy_pass                    https://127.0.0.1:6443/healthz;
     proxy_ssl_trusted_certificate /var/lib/kubernetes/ca.pem;
  }
}
EOF
Set up the proxy configuration so that it is loaded by nginx:

sudo mv kubernetes.default.svc.cluster.local /etc/nginx/sites-available/kubernetes.default.svc.cluster.local
sudo ln -s /etc/nginx/sites-available/kubernetes.default.svc.cluster.local /etc/nginx/sites-enabled/
sudo systemctl restart nginx
sudo systemctl enable nginx
You can verify that everything is working like so:

curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz



# Lbal 
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo mkdir -p /etc/nginx/tcpconf.d
sudo vi /etc/nginx/nginx.conf
Add the following to the end of nginx.conf:

include /etc/nginx/tcpconf.d/*;
Set up some environment variables for the lead balancer config file:

CONTROLLER0_IP=<controller 0 private ip>
CONTROLLER1_IP=<controller 1 private ip>
Create the load balancer nginx config file:

cat << EOF | sudo tee /etc/nginx/tcpconf.d/kubernetes.conf
stream {
    upstream kubernetes {
        server $CONTROLLER0_IP:6443;
        server $CONTROLLER1_IP:6443;
    }

    server {
        listen 6443;
        listen 443;
        proxy_pass kubernetes;
    }
}
EOF
Reload the nginx configuration:

sudo nginx -s reload
You can verify that the load balancer is working like so:

curl -k https://localhost:6443/version
You should get back some json containing version information for your Kubernetes cluster.
