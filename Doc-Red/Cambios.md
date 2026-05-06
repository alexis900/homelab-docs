# Historial de Cambios

## RFCs Completadas (últimos 30 días)

| RFC | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| RFC-2026-0017-NET | Creacion de SSID IoT HOME_IoT en VLAN 40 | 2026-03-13 | Media | ✓ |
| RFC-2026-0007-NET | Migración de gestión de APs UniFi U7 Lite a VLAN 99 | 2026-03-13 | Media | ✓ |

**Nota:** Estos son los únicos RFCs completados en los últimos 30 días (desde 2026-04-07). Para el histórico completo, consulta `rfc/completadas/`.

## Mantenimientos Completados (MTN) — Últimos 30 días

**No hay mantenimientos registrados en los últimos 30 días (desde 2026-04-07).**

Para el histórico completo de mantenimientos, consulta `mtn/completadas/`.

## Cambios Recientes Registrados (Últimos 60 días)

### Incidencias (INC)

| Fecha | ID | Título | Severidad | Estado |
|-------|----|---------|---------|---------| 
| 2026-04-16 | INC-2026-0003-SYS | Acceso a Home Assistant fallido por certificado inválido | Baja | ✓ Cerrado |
| 2026-03-23 | INC-2026-0002-SYS | Desconexiones SSH ~2 min tras nuevas VLANs y update OPNsense | Media | ✓ Cerrado |
| 2026-03-13 | INC-2026-0001-SYS | Incidencia en nodo Hermes: pérdida de red y `/etc/pve` read-only | Baja | ✓ Cerrado |

### Cambios principales

- **2026-04-16:** Certificado TLS de Home Assistant expirado; regenerado y servicio accesible nuevamente (INC-2026-0003-SYS).

- **2026-03-23:** Desconexiones SSH ~2 minutos tras configuración de nuevas VLANs. Causa: timeout de OPNsense reseteado en update 25.7→26.1. Resuelto (INC-2026-0002-SYS).

- **2026-03-13:** Incidencia crítica en Hermes al iniciar CT de gestión en VLAN 99: pérdida de conectividad de red y filesystem `/etc/pve` en read-only. Resuelta mediante reinicio forzado (INC-2026-0001-SYS).

- **2026-03-13:** SSID HOME_IoT en VLAN 40 creado y validado (RFC-2026-0017-NET). Aislamiento cliente-cliente desactivado para permitir automación.

- **2026-03-13:** Migración de gestión de APs UniFi U7 Lite a VLAN 99 completada (RFC-2026-0007-NET).

## Cambios Planificados / Pendientes

- **(Prioridad media)** RFC-2026-0021-NET (Propuesta, 2026-05-07): Etiquetado de cables y documentación de puertos en switches/routers.
- **(Prioridad media)** RFC-2025-0020-APP (Propuesta, 2025-11-16): Instalación de servidor CUPS en VLAN de servidores y migración de impresora Epson M100 Ecotank.
- **(Prioridad media)** RFC-2026-0016-SEC (Propuesta, 2026-02-17): Segmentación de red IoT (VLAN 40) con reglas restrictivas en OPNsense.
- **(Prioridad media)** RFC-2026-0018-SEC (Propuesta, 2026-02-17): NTP interno unificado y bloqueo de NTP externo.
- **(Prioridad alta)** RFC-2026-0008-SEC (Propuesta, 2026-02-11): Endurecimiento de accesos admin (SSH clave + 2FA) y limitar gestión a VLAN 99; incluye ajustes de firewall y switches.
- **(Prioridad media)** RFC-2026-0009-SEC (Propuesta, 2026-02-11): Caddy en CT por nodo Proxmox para front TLS de servicios internos en VLAN 99 (Zeus y Hermes), con CA interna/DNS-01 y sync opcional.
- **(Prioridad baja)** RFC-2025-0015-HW (Propuesta, 2025-09-27): Instalación de dos enchufes Schuko y una toma RJ45 Cat6a en canaleta empotrada.
