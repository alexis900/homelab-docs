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
| PXE | Proxmox | 30 | 10.0.30.20 | Arranque por red | 🟢 |

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

| Hostname | IP / CNAME | VLAN | Descripción | Estado |
|----------|------------|------|-------------|--------|
| docker-srv2.home.arpa | 10.0.1.10 | 1 | Host docker servicios LAN | Activo |
| sonarr.home.arpa | CNAME docker-srv2 | 1 | Alias Sonarr en docker-srv2 | Activo |
| radarr.home.arpa | CNAME docker-srv2 | 1 | Alias Radarr en docker-srv2 | Activo |
| jelly.home.arpa | CNAME docker-srv2 | 1 | Alias Jellyfin en docker-srv2 | Activo |
| photos.home.arpa | CNAME docker-srv2 | 1 | Alias fotos en docker-srv2 | Activo |
| u7-salon.home.arpa | 10.0.99.200 | 99 | AP UniFi U7 Lite salón | Activo |
| u7-ruter.home.arpa | 10.0.99.202 | 99 | AP UniFi U7 Lite router | Activo |
| npm.home.arpa | 10.0.20.10 | 20 | Nginx Proxy Manager (DMZ) | Activo |
| ns1.home.arpa (NS1) | 10.0.30.10 | 30 | Servidor DNS primario | Activo |
| ns2.home.arpa (NS2) | 10.0.30.11 | 30 | Servidor DNS secundario | Activo |
| mqtt.home.arpa | 10.0.30.12 | 30 | Broker MQTT (Zigbee/IoT) | Activo |
| z2m.home.arpa | CNAME mqtt | 30 | Alias Zigbee2MQTT → MQTT | Activo |
| hass.home.arpa | 10.0.30.14 | 30 | Home Assistant | Activo |
| ha.home.arpa | CNAME hass | 30 | Alias HA | Activo |
| pxe.home.arpa | 10.0.30.20 | 30 | Servidor PXE | Activo |
| uptime.home.arpa | 10.0.99.20 | 99 | Uptime Kuma (monitorización) | Activo |
| omada.home.arpa | 10.0.99.10 | 99 | Controlador Omada | Activo |
| unifi.home.arpa | 10.0.99.12 | 99 | Controlador UniFi OS | Activo |
| zeus.home.arpa | 10.0.99.100 | 99 | Nodo Proxmox principal (Zeus) | Activo |
| hermes.home.arpa | 10.0.99.102 | 99 | Nodo Proxmox Hermes | Activo |
| pbs.home.arpa | 10.0.99.110 | 99 | Proxmox Backup Server | Activo |
| core-sw01.home.arpa | 10.0.99.200 | 99 | Switch core TL-SG2008 | Activo |
| em-sw01.home.arpa | 10.0.99.202 | 99 | Switch Omada SG205GP #1 | Activo |
| em-sw02.home.arpa | 10.0.99.204 | 99 | Switch Omada SG205GP #2 | Activo |
| caddy-zeus.home.arpa | 10.0.99.x | 99 | CT Caddy (proxy interno, nodo Zeus) | Planificado |
| caddy-hermes.home.arpa | 10.0.99.x | 99 | CT Caddy (proxy interno, nodo Hermes) | Planificado |

> Añadir/actualizar esta tabla cuando se creen nuevos registros o cambien IPs/hostnames.

## Servidor PXE

- **FQDN:** `pxe.home.arpa` (10.0.30.20)
- **VLAN:** 30
- **Rol:** entrega de arranque por red para despliegues o rescates de hardware; documentado formalmente en `rfc/completadas/RFC-2026-0011-DOC.md`.
- **Estado actual (2026-02-14):** Operativo solo para UEFI. El arranque PXE quedo recuperado para UEFI tras completar la correccion documentada en `rfc/completadas/RFC-2026-0012-NET.md`; BIOS queda fuera de alcance por decision operativa.

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
  - AP-1 — VLAN 99 (Gestión), IP 10.0.99.200
  - AP-2 — VLAN 99 (Gestión), IP 10.0.99.202

### SSIDs

| SSID | VLAN / Tag | Bandas | Seguridad | Aislamiento | Propósito | APs |
|------|------------|--------|-----------|------------|-----------|-----|
| LAN | 1 (untagged) | 2.4 GHz, 5 GHz | WPA3 Personal | Desactivado | Acceso general de usuarios | AP-1, AP-2 |
| HOME_IoT | 40 (tagged) | 2.4 GHz | WPA2 Personal | Desactivado | Dispositivos IoT | AP-1, AP-2 |

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

### Dispositivos Zigbee (Inventario)

| Nombre propuesto | IEEE | Modelo | Marca | Ubicación |
|---|---|---|---|---|
| bano_termohigro | 0xa4c1382757848383 | LYWSD03MMC-z | Xiaomi | Baño |
| techo_1a_planta_led1 | 0x44e2f8fffe36d25d | LED2104R3 | IKEA | 1a planta |
| techo_2a_planta_led1 | 0x44e2f8fffe3a2a96 | LED2104R3 | IKEA | 2a planta |
| techo_comedor_led1 | 0x90ab96fffe9b9862 | LED2005R5/LED2106R3 | IKEA | Comedor |
| techo_1a_planta_led2 | 0x8c65a3fffee8ba1d | LED2104R3 | IKEA | 1a planta |
| techo_2a_planta_led2 | 0x44e2f8fffe18e570 | LED2104R3 | IKEA | 2a planta |
| techo_comedor_led2 | 0x980c33fffec21db6 | LED2005R5/LED2106R3 | IKEA | Comedor |
| techo_comedor_led3 | 0x90ab96fffea4af3a | LED2005R5/LED2106R3 | IKEA | Comedor |
| cocina_leds_tira | 0x28dba7fffeec22e5 | ICPSHC24-30EU-IL-1/ICPSHC24-10EU-IL-2 | IKEA | Cocina |
| luz_exterior_rele | 0x70c59cfffe493dce | ZBMINIR2 | Sonoff | Exterior |
| oficina_alejandro_bombilla_1 | 0x8c65a3fffedfb89b | LED2104R3 | IKEA | Oficina Alejandro |
| oficina_alejandro_bombilla_2 | 0x44e2f8fffe3a2f5f | LED2104R3 | IKEA | Oficina Alejandro |
| oficina_alejandro_bombilla_3 | 0x8c65a3fffee4a49c | LED2104R3 | IKEA | Oficina Alejandro |
| cocina_movimiento | 0x881a14fffee850b5 | E2134 | IKEA | Cocina |
| cocina_termohigro | 0xa4c138fbd78e4d8b | LYWSD03MMC-z | Xiaomi | Cocina |
| comedor_termohigro | 0xa4c13859a3e356ab | LYWSD03MMC-z | Xiaomi | Comedor |
| dormitorio_termohigro | 0xa4c138ae9a024402 | LYWSD03MMC-z | Xiaomi | Dormitorio |
| oficina_alejandro_termohigro | 0xa4c138e913e72473 | LYWSD03MMC-z | Xiaomi | Oficina Alejandro |
| zigbee_router_1 | 0xb43522fffe1e5c62 | DONGLE-E_R | SONOFF (Sonoff Zigbee 3.0 USB Dongle Plus (EFR32MG21) with router firmware) | Nodo Hermes |
