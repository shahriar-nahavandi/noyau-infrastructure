# Conteneur d'Infrastructure SysCore

## Présentation
Ce projet fournit une infrastructure backend conteneurisée, unifiée et légère. Il utilise Caddy comme contrôleur web principal pour acheminer efficacement les données entrantes vers les modules système sous-jacents et les sockets backend via un seul port.

L'architecture est conçue pour les environnements nécessitant la consolidation de plusieurs services internes derrière un point d'entrée unique, garantissant un déploiement fluide sur les plateformes cloud modernes.

## Fonctionnalités
- **Architecture à port unique:** Tous les modules et ponts de données communiquent via un seul port externe.
- **Contrôleur web moderne:** Utilise Caddy pour un routage efficace sans surcharge inutile.
- **Interface publique:** Affiche une page de maintenance standard sur le chemin d'accès principal pour les visiteurs généraux.
- **Routage modulaire:** Sépare l'accès administratif, les paquets de données et les ponts de sockets dans des chemins distincts.

## Déploiement
Construire l'image du conteneur:
```bash
docker build -t syscore-node .
```

Lancer le conteneur:
```bash
docker run -d --name syscore -p 3000:3000 syscore-node
```

## Variables d'environnement
Vous pouvez personnaliser la configuration interne à l'aide des variables d'environnement suivantes:
- `PORT_ADMIN`: Port interne pour le module d'administration (Défaut: 2053)
- `BASE_PATH`: Chemin d'accès URL pour l'administration (Défaut: /sys_admin_core/)
- `ADMIN_USER`: Nom d'utilisateur administrateur par défaut
- `ADMIN_PASS`: Mot de passe administrateur par défaut
