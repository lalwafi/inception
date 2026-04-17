# Developer Documentation

## Prerequisites
- Debian Bullseye VM
- Docker and Docker Compose installed
- make installed
- Git installed

## Setting up from scratch

### 1. Clone the repository
```bash
git clone <your-repo-url>
cd inception
```

### 2. Create the .env file
```bash
nano srcs/.env
```
Fill in all required variables:
- HOST_NAME, HOST_LOGIN
- DB_NAME, DB_USER, DB_PASS, DB_ROOT_PASS
- WP_ADMIN_USER, WP_ADMIN_PASS, WP_ADMIN_EMAIL
- WP_USER, WP_EMAIL, WP_PASS
- WP_URL, WP_TITLE, WP_ROUTE
- DB_HOST, DB_CONF_ROUTE, DB_INSTALL
- CERT, CERT_KEY, CERT_DIR, NGINX_CONF

### 3. Add domain to /etc/hosts
```bash
sudo nano /etc/hosts
# Add: 127.0.0.1   lalwafi.42.fr
```

## Build and launch
```bash
make
```

## Useful commands
```bash
# See running containers
docker ps

# See logs
docker logs <container_name>

# Enter a container
docker exec -it <container_name> bash

# Stop containers
docker-compose down

# Full reset
make fclean

# Rebuild
make re
```

## Where is data stored?
- WordPress files: /home/lalwafi/data/wordpress
- Database files: /home/lalwafi/data/mariadb

## Project structure
```
inception/
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── tools/script.sh
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/www.conf
        │   └── tools/script.sh
        └── nginx/
            ├── Dockerfile
            └── tools/conf.sh
```

## Container architecture
- NGINX listens on port 443 (HTTPS, TLSv1.2/1.3)
- NGINX forwards PHP requests to WordPress on port 9000
- WordPress connects to MariaDB on port 3306
- All containers communicate via the inception bridge network