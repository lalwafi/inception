#!/usr/bin/env bash

set -e

# Create directories if they don't exist
mkdir -p $CERT_DIR
mkdir -p $(dirname $NGINX_CONF)

# Generate SSL certificate
openssl req -x509 -newkey rsa:2048 -days 365 -nodes -keyout $CERT_KEY -out $CERT -subj "/CN=$HOST_NAME"

# Create nginx configuration with properly expanded variables
cat > $NGINX_CONF << EOF
server {
    listen 443 ssl http2;
    server_name $HOST_LOGIN;

    root $WP_ROUTE;
    index index.php index.html index.htm index.nginx-debian.html;

    ssl_protocols TLSv1.2;
    ssl_certificate $CERT;
    ssl_certificate_key $CERT_KEY;

    location / {
        try_files \$uri \$uri/ /index.php?\$args =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
    }
}
EOF

nginx -g "daemon off;"
