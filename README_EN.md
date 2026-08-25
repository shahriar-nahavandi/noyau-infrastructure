# SysCore Infrastructure Container

## Overview
This project provides a unified, lightweight, and containerized backend infrastructure. It utilizes Caddy as the primary web controller to efficiently route incoming data to underlying system modules and backend sockets over a single port. 

The architecture is designed for environments that require consolidating multiple internal services behind a single entry point, ensuring smooth deployment in modern cloud platforms.

## Features
- **Single-Port Architecture:** All modules and data bridges communicate through a single external port.
- **Modern Web Controller:** Uses Caddy for efficient, configuration-as-code routing without unnecessary overhead.
- **Public Interface:** Serves a standard maintenance/landing page on the root path for general visitors.
- **Modular Routing:** Segregates administrative access, data packages, and socket bridges into distinct paths.

## Deployment
Build the container image:
```bash
docker build -t syscore-node .
```

Run the container:
```bash
docker run -d --name syscore -p 3000:3000 syscore-node
```

## Environment Variables
You can customize the internal configuration by passing environment variables:
- `PORT_ADMIN`: Internal port for the admin module (Default: 2053)
- `BASE_PATH`: URL path for administrative access (Default: /sys_admin_core/)
- `ADMIN_USER`: Default administrator username
- `ADMIN_PASS`: Default administrator password
