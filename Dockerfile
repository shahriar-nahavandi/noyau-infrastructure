FROM debian:bookworm-slim

ARG CORE_URL="https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz"
ARG TMP_ARCHIVE="/tmp/core_pkg.tar.gz"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Paris \
    SYS_DIR=/usr/local/sys_core \
    PORT_ADMIN=2053 \
    BASE_PATH=/sys_admin_core/ \
    ADMIN_USER=admin \
    ADMIN_PASS=admin

# Installation des dépendances requises (gnupg added)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl bash ca-certificates tzdata sqlite3 debian-keyring debian-archive-keyring apt-transport-https gnupg \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list \
    && apt-get update && apt-get install -y caddy \
    && rm -rf /var/lib/apt/lists/*

# Déploiement du module système
RUN curl -L "${CORE_URL}" -o "${TMP_ARCHIVE}" \
    && tar -xzf "${TMP_ARCHIVE}" -C /usr/local/ \
    && rm -f "${TMP_ARCHIVE}" \
    && mv /usr/local/x-ui /usr/local/sys_core \
    && mv /usr/local/sys_core/x-ui /usr/local/sys_core/sys_daemon \
    && chmod +x /usr/local/sys_core/sys_daemon

# Préparation des répertoires d'exécution
RUN mkdir -p /var/www/html /etc/caddy

COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
COPY index.html /var/www/html/index.html
RUN chmod +x /start.sh

# Ouverture du port de service
EXPOSE 3000

CMD ["/start.sh"]
