# Historial de Cambios

## RFCs Completadas

| RFC | Título | Fecha | Criticidad |
|---|---|---:|---|
| RFC-2026-0017-NET | Creacion de SSID IoT HOME_IoT en VLAN 40 | 2026-03-13 | Media |
| RFC-2026-0007-NET | Migración de gestión de APs UniFi U7 Lite a VLAN 99 | 2026-03-13 | Media |
| RFC-2026-0013-APP | Migración de UniFi Network Server a UniFi OS Server | 2026-02-17 | Media |
| RFC-2026-0015-IOT | Instalacion de rele Sonoff ZBMINIR2 con neutro para bombilla exterior | 2026-02-16 | Media |
| RFC-2026-0014-IOT | Instalacion de lampara IKEA NYMÅNE + 3 bombillas Zigbee en Oficina Alejandro | 2026-02-15 | Baja |
| RFC-2026-0012-NET | Recuperación de PXE tras desactivar ISC DHCP en OPNsense | 2026-02-14 | Alta |
| RFC-2026-0011-DOC | Documentación del servidor PXE | 2026-02-12 | Baja |
| RFC-2026-0010-HW | Instalación física final de APs UniFi U7 Lite | 2026-02-11 | Media |
| RFC-2026-0005-HW | Despliegue y adopción de dos switches Omada SG205GP en VLAN de gestión | 2026-02-11 | Media |
| RFC-2026-0004-APP | Migración de Uptime Kuma a contenedor Docker | 2026-02-11 | Media |

## Mantenimientos Completados

| MTN | Título | Fecha | Criticidad |
|---|---|---:|---|
| MTN-2026-0007-HW | Actualización de firmware del relé Zigbee luz_exterior_rele | 2026-02-15 | Baja |
| MTN-2026-0001-NET | Actualización Omada Controller 6.0.0.25 a 6.1.0.19 | 2026-01-29 | Media |
| MTN-2026-0002-NET | Actualización de OPNsense a 26.1 | 2026-01-30 | Media |
| MTN-2026-0004-NET | Actualización del firewall OPNsense de la versión 26.1 a 26.1.1 | 2026-02-14 | Baja |
| MTN-2026-0009-NET | Actualización del firewall OPNsense de la versión 26.1 a 26.1.8 | 2026-05-14 | Baja |
| MTN-2026-0005-SYS | Actualización del nodo Zeus de la versión 9.1.4 a 9.1.5 | 2026-02-14 | Baja |
| MTN-2026-0006-SYS | Actualización del nodo Hermes de la versión 9.1.4 a 9.1.5 | 2026-02-14 | Baja |
| MTN-2026-0010-SYS | Actualización del nodo Hermes a la versión 9.1.11 | 2026-05-14 | Media |
| MTN-2026-0011-SYS | Actualización del nodo Zeus a la versión 9.1.11 | 2026-05-14 | Media |
| MTN-2026-0003-NET | Actualización UniFi Network Application 10.0.162 → 10.1.85 | 2026-02-14 | Media |

## Cambios Recientes

- 2026-05-14: Actualización de OPNsense a 26.1.8.
- 2026-05-14: Actualización del nodo Hermes y Zeus a 9.1.11.
- 2026-03-13: SSID HOME_IoT en VLAN 40 creado y validado.
- 2026-03-13: Migración de gestión de APs UniFi U7 Lite a VLAN 99 completada.
- 2026-03-13: Incidencia en nodo Hermes al iniciar CT en VLAN 99 resuelta.
- 2026-02-17: Migración UniFi Network Server → UniFi OS Server completada.
- 2026-02-16: Finalizada instalación relé Sonoff ZBMINIR2 para luz exterior.
- 2026-02-15: Actualización firmware relé Zigbee `luz_exterior_rele`.
- 2026-02-14: Actualización de OPNsense a 26.1.1.
- 2026-02-14: Servicio PXE recuperado y validado en UEFI.

## Pendientes

- RFC-2025-0020-APP: servidor CUPS e impresora Epson M100.
- RFC-2026-0016-SEC: segmentación de red IoT con reglas restrictivas.
- RFC-2026-0018-SEC: NTP interno unificado.
- RFC-2026-0008-SEC: endurecimiento de accesos admin.
- RFC-2026-0009-SEC: Caddy en CT por nodo Proxmox.
