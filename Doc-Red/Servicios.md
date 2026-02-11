# Servicios y Contenedores

## Resumen de Servicios

| CT/Servicio | Nodo | VLAN | IP | Función | Estado |
|-------------|------|------|-----|---------|--------|
| Omada | Proxmox | 99 | 10.0.99.10 | Gestión centralizada de switches Omada | 🟢 |
| UniFi OS | Proxmox | 99 | 10.0.99.12 | Gestión centralizada de APs UniFi | 🟢 |
| DNS (NS1) | Proxmox | 30 | 10.0.30.10 | Servidor DNS primario | 🟢 |
| DNS (NS2) | Proxmox | 30 | 10.0.30.11 | Servidor DNS secundario | 🟢 |
| Uptime Kuma | Proxmox (Docker en CT) | 99 | 10.0.99.20 | Monitorización de servicios (uptime.home.arpa) | 🟢 |
| NPM | Proxmox | 20 | 10.0.20.10 | Nginx Proxy Manager (DMZ) | 🟢 |
| Zigbee2MQTT | Proxmox | 30 | 10.0.30.13 | Puente Zigbee → MQTT | 🟢 |

## Servicios DNS

### NS1 (Primario)

- **VLAN:** 30
- **Software:** BIND9
- **Función:** Resolución interna y externa
- **Zonas:** Internas (lab.local, etc.) + delegadas
- **Backup:** Semanal

### NS2 (Secundario)

- **VLAN:** 30
- **Software:** BIND9
- **Función:** Redundancia DNS
- **Sincronización:** Transferencias de zona desde NS1

### Entradas DNS internas (inventario)

| Hostname | IP | VLAN | Descripción | Estado |
|----------|----|------|-------------|--------|
| uptime.home.arpa | 10.0.99.20 | 99 | Uptime Kuma (monitorización) | Activo |
| ns1.home.arpa (NS1) | 10.0.30.10 | 30 | Servidor DNS primario | Activo |
| ns2.home.arpa (NS2) | 10.0.30.11 | 30 | Servidor DNS secundario | Activo |
| omada.home.arpa | 10.0.99.10 | 99 | Controlador Omada | Activo |
| unifi.home.arpa | 10.0.99.12 | 99 | Controlador UniFi OS | Activo |
| npm.home.arpa | 10.0.20.10 | 20 | Nginx Proxy Manager (DMZ) | Activo |
| zigbee2mqtt.home.arpa | 10.0.30.13 | 30 | Puente Zigbee (Z2M) → MQTT | Activo |

> Añadir/actualizar esta tabla cuando se creen nuevos registros o cambien IPs/hostnames.

## Gestión Omada

- **VLAN:** 99
- **Software:** Omada Controller
- **Función:** Gestión centralizada de switches Omada (TP-Link TL-SG2008)
- **Acceso:** Web UI y API
- **Integración:** Control de VLANs, puertos, trunk y políticas de red en switches
- **Switches gestionados:**
  - **TP-Link TL-SG2008** (switch principal, core, en producción)
  - **TP-Link Omada SG205GP #1** (switch secundario, adoptado y operativo; administración en VLAN 99)
  - **TP-Link Omada SG205GP #2** (switch secundario, adoptado y operativo; administración en VLAN 99)

## Gestión UniFi OS

- **VLAN:** 99
- **Software:** UniFi OS
- **Función:** Gestión centralizada de APs UniFi
- **Acceso:** Web UI, SSH y API
- **Integración:** Control de SSIDs, banda ancha, roaming y políticas de WiFi
- **APs desplegados (U7 Lite, 31/01/2026):**
  - AP-1 — VLAN 1 (LAN), IP 10.0.1.250
  - AP-2 — VLAN 1 (LAN), IP 10.0.1.252
  - **Pendiente:** Migrar gestión de APs a VLAN 99 (RFC-2026-0007-WIFI)

### SSIDs

| SSID | VLAN / Tag | Bandas | Seguridad | Aislamiento | Propósito | APs |
|------|------------|--------|-----------|------------|-----------|-----|
| LAN | 1 (untagged) | 2.4 GHz, 5 GHz | WPA2/WPA3 Personal (mixto) | Desactivado | Acceso general de usuarios | AP-1, AP-2 |
| IoT | 40 (tagged) | 2.4 GHz | WPA2 Personal | Activado (cliente-cliente bloqueado) | Dispositivos IoT aislados | AP-1, AP-2 |

## Monitorización: Uptime Kuma

- **VLAN:** 99
- **Despliegue:** Contenedor Docker dentro de un CT en nodo Proxmox
- **Función:** Monitoreo de servicios internos y externos
- **Alertas:** Correo, Telegram
- **Frecuencia:** Chequeos cada 1-5 minutos según servicio
- **Estado futuro:** Netdata pendiente de despliegue para métricas de sistema

## Proxy Inverso: Nginx Proxy Manager (NPM)

- **VLAN:** 20 (DMZ)
- **Función:** Exposición segura de servicios a internet
- **Certificados:** Let's Encrypt (HTTPS automático)
- **Redireccionamiento:** Multi-dominio
- **Dependencia:** NS1/NS2 para resolución de nombres

## Domótica: Zigbee2MQTT

- **VLAN:** 30
- **Función:** Integración de dispositivos Zigbee vía MQTT
- **Broker:** MQTT interno
- **Dispositivos:** Sensores, controles Zigbee
