#!/usr/bin/env bash
set -e

# Initialisation de l'environnement
cd "${SYS_DIR}"

# Configuration du module principal
./sys_daemon setting \
    -port "${PORT_ADMIN}" \
    -webBasePath "${BASE_PATH}" \
    -username "${ADMIN_USER}" \
    -password "${ADMIN_PASS}" || true

# Démarrage du processus d'arrière-plan
./sys_daemon &

# Synchronisation
sleep 2

# Démarrage du contrôleur de requêtes
echo "Lancement du service HTTP..."
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile