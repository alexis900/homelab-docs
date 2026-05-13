# Servicios y Contenedores

## Resumen Rápido

| Servicio | VLAN | IP | Función | Estado |
|---|---|---|---|---|
| Omada | 99 | 10.0.99.10 | Gestión de switches Omada | 🟢 |
| UniFi OS | 99 | 10.0.99.12 | Gestión de APs UniFi | 🟢 |
| DNS NS1 | 30 | 10.0.30.10 | DNS primario | 🟢 |
| DNS NS2 | 30 | 10.0.30.11 | DNS secundario | 🟢 |
| Uptime Kuma | 99 | 10.0.99.20 | Monitorización | 🟢 |
| NPM | 20 | 10.0.20.10 | Proxy inverso | 🟢 |
| Zigbee2MQTT | 30 | 10.0.30.13 | Puente Zigbee a MQTT | 🟢 |
| PXE | 30 | 10.0.30.20 | Arranque por red | 🟢 |
| Home Assistant | 30 | 10.0.30.14 | Automatización y control | 🟢 |

## Servicios de Infraestructura

### DNS

- NS1 y NS2 viven en VLAN 30.
- La función es resolución interna y redundancia.
- Las zonas locales se apoyan en `home.arpa`.

### Gestión

- Omada controla switches.
- UniFi OS controla APs.
- Uptime Kuma monitoriza servicios y disponibilidad.

### Exposición

- NPM vive en VLAN 20.
- Su función es publicar servicios con HTTPS y certificados gestionados.

### Domótica

- Zigbee2MQTT vive en VLAN 30.
- MQTT interno es el punto de integración con Home Assistant.
- Home Assistant vive en VLAN 30 y sirve como centro de automatización.

## Inventario DNS

| Hostname | IP / CNAME | VLAN | Descripción | Estado |
|---|---|---:|---|---|
| docker-srv2.home.arpa | 10.0.1.10 | 1 | Host docker de servicios LAN | Activo |
| sonarr.home.arpa | CNAME docker-srv2 | 1 | Alias Sonarr | Activo |
| radarr.home.arpa | CNAME docker-srv2 | 1 | Alias Radarr | Activo |
| jelly.home.arpa | CNAME docker-srv2 | 1 | Alias Jellyfin | Activo |
| photos.home.arpa | CNAME docker-srv2 | 1 | Alias fotos | Activo |
| npm.home.arpa | 10.0.20.10 | 20 | Nginx Proxy Manager | Activo |
| ns1.home.arpa | 10.0.30.10 | 30 | DNS primario | Activo |
| ns2.home.arpa | 10.0.30.11 | 30 | DNS secundario | Activo |
| mqtt.home.arpa | 10.0.30.12 | 30 | Broker MQTT | Activo |
| z2m.home.arpa | CNAME mqtt | 30 | Alias Zigbee2MQTT | Activo |
| hass.home.arpa | 10.0.30.14 | 30 | Home Assistant | Activo |
| ha.home.arpa | CNAME hass | 30 | Alias Home Assistant | Activo |
| pxe.home.arpa | 10.0.30.20 | 30 | Servidor PXE | Activo |
| uptime.home.arpa | 10.0.99.20 | 99 | Uptime Kuma | Activo |
| omada.home.arpa | 10.0.99.10 | 99 | Controlador Omada | Activo |
| unifi.home.arpa | 10.0.99.12 | 99 | Controlador UniFi OS | Activo |
| zeus.home.arpa | 10.0.99.100 | 99 | Nodo Proxmox Zeus | Activo |
| hermes.home.arpa | 10.0.99.102 | 99 | Nodo Proxmox Hermes | Activo |
| pbs.home.arpa | 10.0.99.110 | 99 | Proxmox Backup Server | Activo |
| core-sw01.home.arpa | 10.0.99.200 | 99 | Switch core TL-SG2008 | Activo |
| em-sw01.home.arpa | 10.0.99.202 | 99 | Switch Omada SG205GP #1 | Activo |
| em-sw02.home.arpa | 10.0.99.204 | 99 | Switch Omada SG205GP #2 | Activo |

## Sistema PXE

- `pxe.home.arpa` vive en VLAN 30.
- El servicio está operativo para UEFI.
- BIOS se mantiene fuera de alcance por decisión operativa.

## Inventario Zigbee

| Nombre | IEEE | Modelo | Marca | Ubicación |
|---|---|---|---|---|
| bano_termohigro | 0xa4c1382757848383 | LYWSD03MMC-z | Xiaomi | Baño |
| cocina_termohigro | 0xa4c138fbd78e4d8b | LYWSD03MMC-z | Xiaomi | Cocina |
| comedor_termohigro | 0xa4c13859a3e356ab | LYWSD03MMC-z | Xiaomi | Comedor |
| dormitorio_termohigro | 0xa4c138ae9a024402 | LYWSD03MMC-z | Xiaomi | Dormitorio |
| oficina_alejandro_termohigro | 0xa4c138e913e72473 | LYWSD03MMC-z | Xiaomi | Oficina Alejandro |
| cocina_movimiento | 0x881a14fffee850b5 | E2134 | IKEA | Cocina |
| luz_exterior_rele | 0x70c59cfffe493dce | ZBMINIR2 | Sonoff | Exterior |
| zigbee_router_1 | 0xb43522fffe1e5c62 | DONGLE-E_R | SONOFF | Nodo Hermes |

## Nota de Coherencia

- Existe un conflicto histórico de IP en VLAN 99 que conviene revisar en el inventario de red.
- Si se cambia una IP, este archivo debe actualizarse junto con la entrada DNS asociada.
