# Historial de Cambios

## RFCs Completadas (últimos 30 días)

| RFC | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| RFC-2026-0017-NET | Creacion de SSID IoT HOME_IoT en VLAN 40 | 2026-03-13 | Media | ✓ |
| RFC-2026-0007-NET | Migración de gestión de APs UniFi U7 Lite a VLAN 99 | 2026-03-13 | Media | ✓ |
| RFC-2026-0013-APP | Migración de UniFi Network Server a UniFi OS Server | 2026-02-17 | Media | ✓ |
| RFC-2026-0015-IOT | Instalacion de rele Sonoff ZBMINIR2 con neutro para bombilla exterior | 2026-02-16 | Media | ✓ |
| RFC-2026-0014-IOT | Instalacion de lampara IKEA NYMÅNE + 3 bombillas Zigbee en Oficina Alejandro | 2026-02-15 | Baja | ✓ |
| RFC-2026-0012-NET | Recuperación de PXE tras desactivar ISC DHCP en OPNsense | 2026-02-14 | Alta | ✓ |
| RFC-2026-0011-DOC | Documentación del servidor PXE | 2026-02-12 | Baja | ✓ |
| RFC-2026-0010-HW | Instalación física final de APs UniFi U7 Lite | 2026-02-11 | Media | ✓ |
| RFC-2026-0005-HW | Despliegue y adopción de dos switches Omada SG205GP en VLAN de gestión | 2026-02-11 | Media | ✓ |
| RFC-2026-0004-APP | Migración de Uptime Kuma a contenedor Docker | 2026-02-11 | Media | ✓ |

Consulta el histórico completo en `rfc/completadas/` para el resto de RFCs.

## Mantenimientos Completados (MTN)

| MTN | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| MTN-2026-0007-HW | Actualización de firmware del relé Zigbee luz_exterior_rele | 2026-02-15 | Baja | ✓ |
| MTN-2026-0001-NET | Actualización Omada Controller 6.0.0.25 a 6.1.0.19 | 2026-01-29 | Media | ✓ |
| MTN-2026-0002-NET | Actualización de OPNsense a 26.1 | 2026-01-30 | Media | ✓ |
| MTN-2026-0004-NET | Actualización del firewall OPNsense de la versión 26.1 a 26.1.1 | 2026-02-14 | Baja | ✓ |
| MTN-2026-0005-SYS | Actualización del nodo Zeus de la versión 9.1.4 a 9.1.5 | 2026-02-14 | Baja | ✓ |
| MTN-2026-0006-SYS | Actualización del nodo Hermes de la versión 9.1.4 a 9.1.5 | 2026-02-14 | Baja | ✓ |
| MTN-2026-0003-NET | Actualización UniFi Network Application 10.0.162 → 10.1.85 | 2026-02-14 | Media | ✓ |

Consulta `mtn/completadas/` para lista completa y detalles.

## Cambios Recientes (Últimos 30 días)

- **2026-03-13:** Incidencia en nodo Hermes al iniciar CT en VLAN 99; pérdida de red y `/etc/pve` en read-only, resuelta (INC-2026-0001-SYS).
- **2026-03-13:** SSID HOME_IoT en VLAN 40 creado y validado (RFC-2026-0017-NET); aislamiento cliente‑cliente desactivado.
- **2026-03-13:** Migración de gestión de APs UniFi U7 Lite a VLAN 99 completada (RFC-2026-0007-NET).
- **2026-02-17:** Migración UniFi Network Server → UniFi OS Server completada (RFC-2026-0013-APP).
- **2026-02-16:** Finalizada instalación relé Sonoff ZBMINIR2 para luz exterior (RFC-2026-0015-IOT).
- **2026-02-15:** Actualización firmware relé Zigbee `luz_exterior_rele` (MTN-2026-0007-HW).
- **2026-02-15:** Instalacion de lampara IKEA NYMÅNE + 3 bombillas Zigbee en Oficina Alejandro (RFC-2026-0014-IOT).
- **2026-02-14:** Actualización del nodo Zeus a 9.1.5 (MTN-2026-0005-SYS).
- **2026-02-14:** Actualización del nodo Hermes a 9.1.5 (MTN-2026-0006-SYS).
- **2026-02-14:** Actualización de OPNsense a 26.1.1 (MTN-2026-0004-NET).
- **2026-02-14:** Actualización UniFi Network Application a 10.1.85 (MTN-2026-0003-NET).
- **2026-02-14:** Servicio PXE recuperado y validado en UEFI; BIOS fuera de alcance por decision operativa (cierre de RFC-2026-0012-NET).
- **2026-02-12:** Servicio PXE en estado degradado tras desactivar ISC DHCP; abierta RFC-2026-0012-NET para migracion a Kea/ProxyDHCP.
- **2026-02-12:** Documentación del servidor PXE (RFC-2026-0011-DOC)
- **2026-02-11:** Migración de Uptime Kuma a contenedor Docker (RFC-2026-0004-APP)
- **2026-02-11:** Despliegue de dos switches Omada SG205GP (RFC-2026-0005-HW)
- **2026-02-11:** Instalación física final de APs UniFi U7 Lite (RFC-2026-0010-HW)

## Cambios Planificados / Pendientes

- **(Prioridad media)** RFC-2025-0020-APP (Propuesta, 2025-11-16): Instalación de servidor CUPS en VLAN de servidores y migración de impresora Epson M100 Ecotank.
- **(Prioridad media)** RFC-2026-0016-SEC (Propuesta, 2026-02-17): Segmentación de red IoT (VLAN 40) con reglas restrictivas en OPNsense.
- **(Prioridad media)** RFC-2026-0018-SEC (Propuesta, 2026-02-17): NTP interno unificado y bloqueo de NTP externo.
- **(Prioridad alta)** RFC-2026-0008-SEC (Propuesta, 2026-02-11): Endurecimiento de accesos admin (SSH clave + 2FA) y limitar gestión a VLAN 99; incluye ajustes de firewall y switches.
- **(Prioridad media)** RFC-2026-0009-SEC (Propuesta, 2026-02-11): Caddy en CT por nodo Proxmox para front TLS de servicios internos en VLAN 99 (Zeus y Hermes), con CA interna/DNS-01 y sync opcional.
- **(Prioridad baja)** RFC-2025-0015-HW (Propuesta, 2025-09-27): Instalación de dos enchufes Schuko y una toma RJ45 Cat6a en canaleta empotrada.
