*This project has been created as part of the 42 curriculum by lalwafi.*

## Description

Inception is a Docker-based infrastructure project that sets up a WordPress
website served by NGINX over HTTPS, backed by a MariaDB database.
All services run in isolated containers inside a virtual machine.
The goal is to learn system administration concepts using Docker and
Docker Compose, including container networking, persistent storage,
and secure service configuration.

## Project Description

This project uses Docker Compose to orchestrate 3 services inside a VM:

- **NGINX** — Web server and reverse proxy. The only entry point via port 443 (HTTPS only). Handles TLS termination using a self-signed certificate.
- **WordPress + PHP-FPM** — Content management system running via PHP-FPM on port 9000. No NGINX inside this container.
- **MariaDB** — Database server on port 3306. Stores all WordPress data (posts, users, settings).

### Virtual Machines vs Docker

Virtual Machines emulate an entire operating system with their own kernel.
They are heavy, require gigabytes of storage, and take minutes to start.
They are fully isolated but resource-intensive.

Docker containers share the host OS kernel, making them lightweight and fast.
They start in seconds, use megabytes instead of gigabytes, and are portable.
This project uses Docker inside a VM to get the benefits of both.

### Secrets vs Environment Variables

Environment variables are visible via docker inspect and in process listings.
They are convenient but not secure for sensitive data like passwords.

Docker secrets store sensitive data in files that are only accessible
to authorized services. They are more secure for production credentials.
This project uses a .env file for configuration and recommends Docker
secrets for storing any confidential information.

### Docker Network vs Host Network

Host network shares the host machine's network stack with no isolation.
All host ports are accessible which is a security risk.
Using host network is forbidden in this project.

Docker bridge network creates a private internal network between containers.
Only explicitly exposed ports are accessible from outside.
This project uses a custom bridge network called inception so containers
can communicate securely by name (e.g. mariadb, wordpress).

### Docker Volumes vs Bind Mounts

Bind mounts link a specific host directory to a container.
They are fragile, host-dependent, and not recommended for production.
Bind mounts are forbidden for the persistent volumes in this project.

Named volumes are managed by Docker, portable, and safer for persistent data.
This project uses two named volumes stored at /home/lalwafi/data/ on the host:
one for the WordPress files and one for the MariaDB database.

## Instructions

### Requirements
- Virtual Machine with Debian Bullseye
- Docker and Docker Compose installed
- make installed
- Git installed

### Installation
```bash
git clone <your-repo-url>
cd inception
make
```

### Access
- Website: https://lalwafi.42.fr
- Admin panel: https://lalwafi.42.fr/wp-admin
- Admin username: lalwafi_admin
- Regular user: lalwafi_user

### Stop
```bash
make fclean
```

### Rebuild from scratch
```bash
make re
```

## Resources

* [Docker official documentation](https://docs.docker.com/)
* [Docker Compose reference](https://docs.docker.com/compose/compose-file/)
* [NGINX documentation](https://nginx.org/en/docs/)
* [WordPress WP-CLI documentation](https://wp-cli.org/)
* [MariaDB documentation](https://mariadb.com/kb/en/documentation/)
* [PHP-FPM configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
* [OpenSSL self-signed certificates](https://www.openssl.org/docs/)
* [Understanding Docker volumes](https://docs.docker.com/storage/volumes/)
* [TLS/SSL overview](https://www.cloudflare.com/learning/ssl/what-is-ssl/)
* [PID 1 in Docker containers](https://medium.com/@boutnaru/the-linux-process-journey-pid-1-init-60765a069f17)

AI tools were used to assist with structure validation, debugging, and compliance verification.
All AI-generated suggestions were reviewed, tested, and validated before being included in the project. The code was understood and verified line by line before submission.
