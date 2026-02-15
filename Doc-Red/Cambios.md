# Historial de Cambios

## RFCs Completadas (últimos 30 días)

| RFC | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| RFC-2026-0014-IOT | Instalacion de lampara IKEA NYMÅNE + 3 bombillas Zigbee en Oficina Alejandro | 2026-02-15 | Baja | ✓ |
| RFC-2026-0012-NET | Recuperación de PXE tras desactivar ISC DHCP en OPNsense | 2026-02-14 | Alta | ✓ |
| RFC-2026-0011-DOC | Documentación del servidor PXE | 2026-02-12 | Baja | ✓ |
| RFC-2026-0010-HW | Instalación física final de APs UniFi U7 Lite | 2026-02-11 | Media | ✓ |
| RFC-2026-0005-HW | Despliegue y adopción de dos switches Omada SG205GP en VLAN de gestión | 2026-02-11 | Media | ✓ |
| RFC-2026-0004-APP | Migración de Uptime Kuma a contenedor Docker | 2026-02-11 | Media | ✓ |
| RFC-2026-0003-NET | Migración de DHCP normal a Kea en OPNsense 25.7.11_9 | 2026-02-06 | Media | ✓ |
| RFC-2026-0006-NET | Instalación y adopción de puntos de acceso UniFi U7 Lite | 2026-01-31 | Media | ✓ |
| RFC-2026-0002-NET | Instalación de CT UniFi OS | 2026-01-28 | Media | ✓ |

Consulta el histórico completo en `rfc/completadas/` para el resto de RFCs.

## Mantenimientos Completados (MTN)

| MTN | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| MTN-2026-0001-NET | Actualización Omada Controller 6.0.0.25 a 6.1.0.19 | 2026-01-29 | Media | ✓ |
| MTN-2026-0002-NET | Actualización de OPNsense a 26.1 | 2026-01-30 | Media | ✓ |
| MTN-2026-0004-NET | Actualización del firewall OPNsense de la versión 26.1 a 26.1.1 | 2026-02-14 | Baja | ✓ |
| MTN-2026-0005-SYS | Actualización del nodo Zeus de la versión 9.1.4 a 9.1.5 | 2026-02-14 | Baja | ✓ |
| MTN-2026-0006-SYS | Actualización del nodo Hermes de la versión 9.1.4 a 9.1.5 | 2026-02-14 | Baja | ✓ |
| MTN-2026-0003-NET | Actualización UniFi Network Application 10.0.162 → 10.1.85 | 2026-02-14 | Media | ✓ |

Consulta `mtn/completadas/` para lista completa y detalles.

## Cambios Recientes (Últimos 30 días)

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
- **2026-02-07:** Actualización de OPNsense a 26.1 (MTN-2026-0002-NET)
- **2026-02-06:** Migración de DHCP a Kea en OPNsense (RFC-2026-0003-NET)
- **2026-01-31:** Instalación y adopción de APs UniFi U7 Lite (RFC-2026-0006-NET)
- **2026-01-29:** Actualización Omada Controller (MTN-2026-0001-NET)
- **2026-01-28:** Instalación de UniFi OS (RFC-2026-0002-NET)

## Cambios Planificados / Pendientes

- **(Prioridad media)** RFC-2025-0020-APP (Propuesta, 2025-11-16): Instalación de servidor CUPS en VLAN de servidores y migración de impresora Epson M100 Ecotank.
- **(Prioridad media)** RFC-2026-0013-APP (Propuesta, 2026-02-14): Migración de UniFi Network Server a UniFi OS Server (autoalojado).
- **(Prioridad media)** RFC-2026-0007-NET (Propuesta, 2026-02-11): Migrar gestión de APs UniFi U7 Lite a VLAN 99. Gestión actual en VLAN 1 (10.0.1.250 / 10.0.1.252); pendiente reservar IPs en 10.0.99.x y ejecutar plan.
- **(Prioridad alta)** RFC-2026-0008-SEC (Propuesta, 2026-02-11): Endurecimiento de accesos admin (SSH clave + 2FA) y limitar gestión a VLAN 99; incluye ajustes de firewall y switches.
- **(Prioridad media)** RFC-2026-0009-SEC (Propuesta, 2026-02-11): Caddy en CT por nodo Proxmox para front TLS de servicios internos en VLAN 99 (Zeus y Hermes), con CA interna/DNS-01 y sync opcional.
- **(Prioridad baja)** RFC-2025-0015-HW (Propuesta, 2025-09-27): Instalación de dos enchufes Schuko y una toma RJ45 Cat6a en canaleta empotrada.
