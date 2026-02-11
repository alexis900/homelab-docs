# Documentación de Infraestructura de Red

**Última actualización:** 11 de febrero de 2026  
**Responsable:** Alejandro Martín Pérez

---

## Introducción

Este índice reúne y enlaza toda la documentación técnica y operacional de la infraestructura de red. Usa los enlaces siguientes para editar o consultar cada ámbito sin manejar un único fichero gigante.

---

## Estructura de Documentos

- [Arquitectura General](Doc-Red/Arquitectura.md)
- [Segmentación de VLANs](Doc-Red/VLANs.md)
- [Dispositivos de Infraestructura](Doc-Red/Dispositivos.md)
- [Servicios y Contenedores](Doc-Red/Servicios.md)
- [Seguridad y Firewall](Doc-Red/Seguridad.md)
- [Monitorización y Alertas](Doc-Red/Monitorizacion.md)
- [Backup y Recuperación](Doc-Red/Backup.md)
- [Procedimientos (SOP) e Incidentes](Doc-Red/Procedimientos.md)
- [Historial de Cambios](Doc-Red/Cambios.md)
- [Contacto y Referencias](Doc-Red/Contacto.md)

---

## Notas de Uso

- Mantén este índice sincronizado si se añaden nuevas secciones o ficheros.
- Las tablas de VLANs, inventario de servicios y reglas de firewall ahora viven en sus archivos dedicados (enlaces arriba).
- Los SOP siguen en `SOPs/` y se referencian desde la sección de Procedimientos.
- El workflow CI `doc-red-consistency` verifica que `Doc-Red-full.md` esté regenerado en cada push/PR.

---

**Próxima revisión programada:** 28 de febrero de 2026


---

# Arquitectura General

La red doméstica utiliza una arquitectura de **segmentación por VLANs** con un firewall central (OPNsense) que gestiona el tráfico entre segmentos. La infraestructura de virtualización (Proxmox) aloja contenedores para servicios críticos, y dispositivos especializados (switches, APs, controladores) proporcionan conectividad y gestión centralizada.

## Componentes Principales

| Componente | Dispositivo | Función | VLAN |
|-----------|-----------|---------|------|
| Firewall | OPNsense | Enrutamiento, firewall, políticas de red | 99 |
| Switch Core | TP-Link TL-SG2008 | Conmutación entre VLANs y dispositivos | 99 |
| Virtualización | Proxmox | Host para contenedores (CT) | 99 |
| Gestión Omada | Omada (CT) | Gestión centralizada de switches Omada | 99 |
| Gestión UniFi | UniFi OS (CT) | Gestión centralizada de APs UniFi | 99 |
| Monitorización | Uptime Kuma (Docker en CT Proxmox) | Monitorización de servicios y alertas | 99 |

**Nota:** El plano de control reside en VLAN 99; mantener accesos de gestión dentro de ese segmento.


---

# Segmentación de VLANs

## Justificación

- **Seguridad:** Aislar dispositivos críticos y potencialmente vulnerables (IoT, alarmas)
- **Optimización:** Reducir congestión separando servicios de alto ancho de banda
- **Gestión:** Concentrar acceso administrativo en VLAN segregada
- **Escalabilidad:** Facilitar crecimiento futuro sin afectar operativa actual

## Tabla de VLANs

| VLAN | Nombre | Red | Gateway | Propósito |
|------|--------|-----|---------|----------|
| 1 | LAN | 10.0.1.0/24 | 10.0.1.1 | Dispositivos de usuario general |
| 2 | Alarma | 10.0.2.0/29 | 10.0.2.1 | Sistema de alarma (aislado) |
| 20 | DMZ | 10.0.20.0/24 | 10.0.20.1 | Servicios expuestos a internet |
| 30 | Servidores | 10.0.30.0/24 | 10.0.30.1 | Contenedores, almacenamiento, servicios internos |
| 40 | IoT | 10.0.40.0/24 | 10.0.40.1 | Dispositivos IoT (firmware limitado) |
| 99 | Management | 10.0.99.0/24 | 10.0.99.1 | Infraestructura: switches, firewall, virtualizadores, monitorización |
| 100 | VPN | 10.0.100.0/24 | 10.0.100.1 | Clientes remotos (acceso VPN) |

## Descripción Detallada de VLANs

### VLAN 1 — LAN (10.0.1.0/24)

- **Propósito:** Segmento principal para dispositivos de usuario (PCs, laptops, teléfonos)
- **Acceso:** Acceso completo a servicios internos e internet
- **Características:** Red base, sin restricciones especiales
- **Gateway:** 10.0.1.1

### VLAN 2 — Alarma (10.0.2.0/29)

- **Propósito:** Aislamiento exclusivo del sistema de alarma
- **Acceso:** Solo tráfico saliente hacia servidores del proveedor
- **Características:** Rango pequeño (/29) para limitar exposición
- **Gateway:** 10.0.2.1
- **Restricciones:** No puede acceder a otros segmentos internos

### VLAN 20 — DMZ (10.0.20.0/24)

- **Propósito:** Servicios expuestos a internet (Nginx Proxy Manager)
- **Acceso:** Tráfico entrante desde WAN con control estricto
- **Características:** Aislada del resto de infraestructura
- **Gateway:** 10.0.20.1
- **Reglas Firewall:**
  - DMZ → WAN: Solo puerto 443 (HTTPS)
  - DMZ → LAN: Bloqueado por defecto
  - LAN → DMZ: Solo administración específica

### VLAN 30 — Servidores (10.0.30.0/24)

- **Propósito:** Contenedores internos (DNS, monitorización, servicios auxiliares)
- **Acceso:** Restringido a redes autorizadas
- **Características:** Hospeda infraestructura crítica
- **Gateway:** 10.0.30.1
- **Servicios:** BIND9 (DNS), contenedores CT

### VLAN 40 — IoT (10.0.40.0/24)

- **Propósito:** Aislamiento de dispositivos IoT con firmware limitado
- **Acceso:** Acceso restrictivo a otras VLANs
- **Características:** Control de broadcast/multicast
- **Gateway:** 10.0.40.1
- **Restricciones:** Excepciones justificadas solo para servicios específicos

### VLAN 99 — Management (10.0.99.0/24)

- **Propósito:** Administración exclusiva de infraestructura
- **Acceso:** Solo desde equipos autorizados
- **Características:** Aísla plano de control del resto de redes
- **Gateway:** 10.0.99.1
- **Dispositivos:** Switch, firewall, Proxmox, UniFi OS, controladores, Uptime Kuma
- **Nota crítica:** El acceso a switch se restringe únicamente a VLAN 99

### VLAN 100 — VPN (10.0.100.0/24)

- **Propósito:** Acceso remoto de clientes VPN
- **Acceso:** Control granular según políticas específicas
- **Características:** Identifica y segmenta tráfico externo
- **Gateway:** 10.0.100.1


---

# Dispositivos de Infraestructura

## Switch Principal: TP-Link TL-SG2008

| Atributo | Valor |
|----------|-------|
| Modelo | TP-Link TL-SG2008 |
| Puertos | 8 puertos Gigabit |
| VLAN Nativas | 1, 20, 30, 40, 99, 100 |
| Gestión | VLAN 99 (10.0.99.X) |
| Puertos Trunk | Hacia OPNsense, Proxmox |
| Estado | Activo |

**Nota:** La interfaz de gestión del switch debe estar en VLAN 99, nunca en VLAN 1.

## Firewall/Router: OPNsense

| Atributo | Valor |
|----------|-------|
| Software | OPNsense |
| Función | Enrutamiento, firewall, DHCP |
| VLANs Gestionadas | Todas (1-100) |
| Gestión | VLAN 99 (10.0.99.X) |
| Acceso WAN | A través de gateway ISP |
| Estado | Activo |

**Nota reciente:** tras la actualización a OPNsense 26.1 (MTN-2026-0002-NET) el servicio DHCP normal corre sobre **Kea DHCP** en todas las VLANs. ISC DHCP legacy está desactivado y PXE aún no se ha configurado (pendiente de RFC específico).

## Virtualización: Proxmox

| Atributo | Valor |
|----------|-------|
| Nodo | Hermes |
| Función | Host para contenedores (CT) |
| Sistema | Debian |
| VLAN Gestión | VLAN 99 |
| IP Gestión | 10.0.99.101/24 |
| Capacidad | CPU, RAM, almacenamiento (ver planificación) |
| Estado | Activo |


---

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

| Hostname | IP / CNAME | VLAN | Descripción | Estado |
|----------|------------|------|-------------|--------|
| docker-srv2.home.arpa | 10.0.1.10 | 1 | Host docker servicios LAN | Activo |
| sonarr.home.arpa | CNAME docker-srv2 | 1 | Alias Sonarr en docker-srv2 | Activo |
| radarr.home.arpa | CNAME docker-srv2 | 1 | Alias Radarr en docker-srv2 | Activo |
| jelly.home.arpa | CNAME docker-srv2 | 1 | Alias Jellyfin en docker-srv2 | Activo |
| photos.home.arpa | CNAME docker-srv2 | 1 | Alias fotos en docker-srv2 | Activo |
| u7-salon.home.arpa | 10.0.1.250 | 1 | AP UniFi U7 Lite salón | Activo |
| u7-ruter.home.arpa | 10.0.1.252 | 1 | AP UniFi U7 Lite router | Activo |
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


---

# Seguridad y Firewall

## Políticas Generales

1. **Principio de mínimo privilegio:** Solo tráfico explícitamente permitido
2. **Segregación por VLAN:** Cada segmento aislado por defecto
3. **Inspección de tráfico:** OPNsense inspecciona tráfico inter-VLAN
4. **Logs:** Todos los cambios de política se registran

## Reglas de Firewall Principales

### Entrada (Inbound)

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|--------|---------|--------|-----------|--------|------|
| WAN | DMZ | 443 | TCP | Permitir | HTTPS externo |
| WAN | DMZ | 80 | TCP | Permitir | HTTP redirección |
| VLAN 1 | VLAN 99 | 22,443 | TCP | Permitir | Admin SSH/Web |
| VLAN 1 | VLAN 30 | 53 | UDP,TCP | Permitir | DNS |
| WAN | Firewall (self) | 51820 | UDP | Permitir | VPN WireGuard |

### Salida (Outbound)

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|--------|---------|--------|-----------|--------|------|
| VLAN 2 | WAN | 443,80 | TCP | Permitir | Alarma a servidor |
| VLAN 40 | VLAN 30 | 1883 | TCP | Permitir | IoT → MQTT |
| VLAN 40 | VLAN 1 | Todos | Todos | Bloquear | IoT aislado |
| VLAN 100 | VLAN 30,1 | Selectivo | TCP | Permitir | VPN acceso controlado |

### Resumen de reglas activas (export OPNsense 11/02/2026)

- **WAN → DMZ (NPM_DMZ):** TCP 80, 443 permitidos.
- **WAN → Firewall (self):** UDP 51820 permitida (WireGuard).
- **LAN → DNS_SERVERS:** UDP/TCP 53 y UDP 853 permitidos.
- **LAN → salidas web básicas:** TCP 80, 443 permitidos; UDP 123 (NTP) permitido.
- **LAN (ADMIN_PC) → servicios internos:** NPM_DMZ:81, Z2MQTT:8080, Home Assistant:8123, Proxmox:8006-8007, DNS/Z2MQTT SSH:22, Uptime Kuma:3001, Omada:8443, Zigbee Coordinator:80.
- **LAN regla amplia:** allow any/any (entrada) presente al final de la cadena.
- **OPT1 (VLAN secundaria):** DNS 53/853, NTP 123, HTTP/HTTPS permitidos; ICMP permitido; bloqueo catch-all TCP/UDP en 261.
- **OPT2 (otra VLAN):** DNS 53 (TCP/UDP) hacia DNS_SERVERS, HTTP/HTTPS permitidos; flujos Z2MQTT↔ZBCOORD puerto 6638; ICMP permitido; allow any/any (351).
- **OPT3 (otra VLAN):** DNS 53, NTP 123 permitidos; tráfico Zigbee coordinator ↔ Z2MQTT puerto 6638 permitido.

## Acceso Administrativo

- **Estado actual:** Acceso de administración permitido desde VLAN 1 y VLAN 99 (sin 2FA aplicado aún).
- **SSH:** Claves recomendadas; verificar y aplicar en dispositivos pendientes.
- **Switch management:** Acceso desde VLAN 99 previsto; consolidar y bloquear desde otras VLANs.
- **Firewall:** Revisar y limitar a VLAN 99/LAN según plan de hardening.


---

# Monitorización y Alertas

## Herramientas

- **Uptime Kuma:** Monitorización de servicios (HTTP/HTTPS, ping, TCP)
- **Logs:** Centralizados en dispositivos (revisar `/var/log`)
- **Alertas:** Correo, Telegram para incidentes críticos

## Servicios Monitoreados

- DNS (NS1, NS2)
- NPM (disponibilidad web)
- Proxmox (estado de host)
- OPNsense (estado del firewall)
- Conectividad WAN

## Procedimiento de Alertas

1. Detección de caída de servicio
2. Notificación inmediata (correo, Telegram)
3. Verificación manual de causa
4. Documentación en incidente (INC-YYYY-NNNN.md)
5. Resolución y validación post-cambio


---

# Backup y Recuperación

## Estrategia de Backups

| Componente | Frecuencia | Método | Ubicación | RPO |
|-----------|-----------|--------|-----------|------|
| Proxmox CTs | Semanal | Snapshot | Storage local | 7 días |
| Configuración Firewall | Mensual | Exportación | Repositorio git | 30 días |
| Zonas DNS | Diaria | Backup de ficheros | Proxmox storage | 1 día |
| UniFi OS | Semanal | Exportación config | Storage local | 7 días |

## Procedimiento de Recuperación

1. **Identificar componente afectado**
2. **Localizar último backup válido**
3. **Restaurar según procedimiento** (CT snapshot, exportación, etc.)
4. **Validar funcionamiento** (ping, SSH, servicios)
5. **Documentar en RFC si es cambio** o en INC si es incidente


---

# Procedimientos (SOP) e Incidentes

## Cambios en la Infraestructura

Toda modificación debe documentarse en [RFC](../rfc/):

1. Crear RFC en `rfc/propuestas/` usando [template](../templates/RFC.md)
2. Detallar: cambios, riesgos, rollback, validaciones
3. Ejecutar cambio siguiendo plan de acción
4. Mover RFC a `rfc/completadas/` con resultado actual
5. Actualizar `Doc-Red` si aplica

## Mantenimiento Rutinario

Registrar en [MTN](../mtn/) usando [template](../templates/MTN.md):

- Actualizaciones de paquetes
- Limpiezas de almacenamiento
- Rotación de logs
- Tests de backup

## SOP disponibles

- [SOP-CT-Proxmox](../SOPs/SOP-CT-Proxmox.md): Despliegue/actualización de contenedores (LXC o Docker en CT) en Proxmox Hermes: backups, despliegue, validaciones, rollback y limpieza.
- [SOP-VLAN](../SOPs/SOP-VLAN.md): Alta/cambio de VLAN en OPNsense + switches (creación, reglas mínimas, validación y rollback).
- [SOP-TLS-Certs](../SOPs/SOP-TLS-Certs.md): Gestión de certificados TLS en NPM y distribución a servicios internos.
- [SOP-Incident-Red](../SOPs/SOP-Incident-Red.md): Respuesta rápida a incidentes de red (triage, mitigación, restauración, documentación).

## Incidentes y Problemas

Registrar en [INC](../inc/) usando [template](../templates/INC.md):

- Descripción del problema
- Timeline de detección y acciones
- Causa raíz identificada
- Resolución aplicada
- Lecciones aprendidas


---

# Historial de Cambios

## RFCs Completadas (últimos 30 días)

| RFC | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
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

Consulta `mtn/completadas/` para lista completa y detalles.

## Cambios Recientes (Últimos 30 días)

- **2026-02-11:** Migración de Uptime Kuma a contenedor Docker (RFC-2026-0004-APP)
- **2026-02-11:** Despliegue de dos switches Omada SG205GP (RFC-2026-0005-HW)
- **2026-02-07:** Actualización de OPNsense a 26.1 (MTN-2026-0002-NET)
- **2026-02-06:** Migración de DHCP a Kea en OPNsense (RFC-2026-0003-NET)
- **2026-01-31:** Instalación y adopción de APs UniFi U7 Lite (RFC-2026-0006-NET)
- **2026-01-29:** Actualización Omada Controller (MTN-2026-0001-NET)
- **2026-01-28:** Instalación de UniFi OS (RFC-2026-0002-NET)

## Cambios Planificados / Pendientes

- **(Prioridad media)** RFC-2025-0020-APP (Propuesta, 2025-11-16): Instalación de servidor CUPS en VLAN de servidores y migración de impresora Epson M100 Ecotank.
- **(Prioridad media)** MTN-2026-0003-NET (Planificado, 2026-02-07): Actualización de UniFi Network Application 10.0.162 → 10.1.83 en el controlador UniFi OS; incluye backup previo, actualización y validaciones de servicio.
- **(Prioridad media)** RFC-2026-0007-NET (Propuesta, 2026-02-11): Migrar gestión de APs UniFi U7 Lite a VLAN 99. Gestión actual en VLAN 1 (10.0.1.250 / 10.0.1.252); pendiente reservar IPs en 10.0.99.x y ejecutar plan.
- **(Prioridad alta)** RFC-2026-0008-SEC (Propuesta, 2026-02-11): Endurecimiento de accesos admin (SSH clave + 2FA) y limitar gestión a VLAN 99; incluye ajustes de firewall y switches.
- **(Prioridad media)** RFC-2026-0009-SEC (Propuesta, 2026-02-11): Caddy en CT por nodo Proxmox para front TLS de servicios internos en VLAN 99 (Zeus y Hermes), con CA interna/DNS-01 y sync opcional.
- **(Prioridad baja)** RFC-2025-0015-HW (Propuesta, 2025-09-27): Instalación de dos enchufes Schuko y una toma RJ45 Cat6a en canaleta empotrada.


---

# Contacto y Referencias

- **Administrador:** Alejandro Martín Pérez
- **Repositorio:** GitHub homelab-docs
- **Documentación Oficial:**
  - [OPNsense](https://docs.opnsense.org/)
  - [Proxmox](https://pve.proxmox.com/wiki/Main_Page)
  - [UniFi](https://help.ui.com/)
  - [TP-Link TL-SG2008](https://www.tp-link.com/es/business/managed-switch/tl-sg2008/)
