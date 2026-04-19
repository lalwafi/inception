# User Documentation

## What services are provided?
- **WordPress website** — https://lalwafi.42.fr
- **WordPress admin panel** — https://lalwafi.42.fr/wp-admin
- **MariaDB database** — internal only

## How to start the project
```bash
cd inception
make
```

## How to stop the project
```bash
make fclean
```

## How to access the website
Open your browser and go to:
```
https://lalwafi.42.fr
```
Accept the security warning — this is normal for a self-signed certificate.

## How to access the admin panel
```
https://lalwafi.42.fr/wp-admin
```

## Where are the credentials?
All credentials are stored in:
```
inception/srcs/.env
```
This file is NOT pushed to git for security reasons.

## How to check services are running
```bash
docker ps
```
You should see 3 containers: nginx, wordpress, mariadb.

## How to check logs
```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```