FROM debian:bookworm

USER root

RUN apt update && apt install -y \
    mariadb-server \
    mariadb-client

COPY ./requirements/mariadb/tools/docker_entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker_entry.sh

CMD ["docker_entry.sh"]