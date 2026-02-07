# Documentación de Infraestructura de Red

**Última actualización:** 7 de febrero de 2026  
**Responsable:** Alejandro Martín Pérez

---

## Introducción

Este documento reúne toda la información técnica y operacional de la infraestructura de red para facilitar la gestión, mantenimiento y evolución. Cubre toda la infraestructura incluyendo switches, routers, VLANs, servidores, servicios, procedimientos y políticas de seguridad.

**Audiencia:** Administradores de red y personal de soporte técnico.

---

## Tabla de Contenidos

- [Introducción](#introducción)
- [Arquitectura General](#arquitectura-general)
- [Segmentación de VLANs](#segmentación-de-vlans)
- [Dispositivos de Infraestructura](#dispositivos-de-infraestructura)
- [Servicios y Contenedores](#servicios-y-contenedores)
- [Seguridad y Firewall](#seguridad-y-firewall)
- [Monitorización y Alertas](#monitorización-y-alertas)
- [Backup y Recuperación](#backup-y-recuperación)
- [Procedimientos (SOP)](#procedimientos-sop)
- [Historial de Cambios](#historial-de-cambios)

---

## Arquitectura General

### Descripción General

La red doméstica utiliza una arquitectura de **segmentación por VLANs** con un firewall central (OPNsense) que gestiona el tráfico entre segmentos. La infraestructura de virtualización (Proxmox) aloja contenedores para servicios críticos, y dispositivos especializados (switches, APs, controladores) proporcionan conectividad y gestión centralizada.

### Componentes Principales

| Componente | Dispositivo | Función | VLAN |
|-----------|-----------|---------|------|
| Firewall | OPNsense | Enrutamiento, firewall, políticas de red | 99 |
| Switch Core | TP-Link TL-SG2008 | Conmutación entre VLANs y dispositivos | 99 |
| Virtualización | Proxmox | Host para contenedores (CT) | 99 |
| Gestión Omada | Omada (CT) | Gestión centralizada de switches Omada | 99 |
| Gestión UniFi | UniFi OS (CT) | Gestión centralizada de APs UniFi | 99 |
| Monitorización | Uptime Kuma (CT) | Monitorización de servicios y alertas | 30 |

---

## Segmentación de VLANs

### Justificación

La segmentación mediante VLANs es esencial para:

- **Seguridad:** Aislar dispositivos críticos y potencialmente vulnerables (IoT, alarmas)
- **Optimización:** Reducir congestión separando servicios de alto ancho de banda
- **Gestión:** Concentrar acceso administrativo en VLAN segregada
- **Escalabilidad:** Facilitar crecimiento futuro sin afectar operativa actual

### Tabla de VLANs

| VLAN | Nombre | Red | Gateway | Propósito |
|------|--------|-----|---------|----------|
| 1 | LAN | 10.0.1.0/24 | 10.0.1.1 | Dispositivos de usuario general |
| 2 | Alarma | 10.0.2.0/29 | 10.0.2.1 | Sistema de alarma (aislado) |
| 20 | DMZ | 10.0.20.0/24 | 10.0.20.1 | Servicios expuestos a internet |
| 30 | Servidores | 10.0.30.0/24 | 10.0.30.1 | Contenedores, almacenamiento, servicios internos |
| 40 | IoT | 10.0.40.0/24 | 10.0.40.1 | Dispositivos IoT (firmware limitado) |
| 99 | Management | 10.0.99.0/24 | 10.0.99.1 | Infraestructura: switches, firewall, virtualizadores |
| 100 | VPN | 10.0.100.0/24 | 10.0.100.1 | Clientes remotos (acceso VPN) |

### Descripción Detallada de VLANs

#### VLAN 1 — LAN (10.0.1.0/24)

- **Propósito:** Segmento principal para dispositivos de usuario (PCs, laptops, teléfonos)
- **Acceso:** Acceso completo a servicios internos e internet
- **Características:** Red base, sin restricciones especiales
- **Gateway:** 10.0.1.1

#### VLAN 2 — Alarma (10.0.2.0/29)

- **Propósito:** Aislamiento exclusivo del sistema de alarma
- **Acceso:** Solo tráfico saliente hacia servidores del proveedor
- **Características:** Rango pequeño (/29) para limitar exposición
- **Gateway:** 10.0.2.1
- **Restricciones:** No puede acceder a otros segmentos internos

#### VLAN 20 — DMZ (10.0.20.0/24)

- **Propósito:** Servicios expuestos a internet (Nginx Proxy Manager)
- **Acceso:** Tráfico entrante desde WAN con control estricto
- **Características:** Aislada del resto de infraestructura
- **Gateway:** 10.0.20.1
- **Reglas Firewall:**
  - DMZ → WAN: Solo puerto 443 (HTTPS)
  - DMZ → LAN: Bloqueado por defecto
  - LAN → DMZ: Solo administración específica

#### VLAN 30 — Servidores (10.0.30.0/24)

- **Propósito:** Contenedores internos (DNS, monitorización, servicios auxiliares)
- **Acceso:** Restringido a redes autorizadas
- **Características:** Hospeda infraestructura crítica
- **Gateway:** 10.0.30.1
- **Servicios:** BIND9 (DNS), Uptime Kuma, contenedores CT

#### VLAN 40 — IoT (10.0.40.0/24)

- **Propósito:** Aislamiento de dispositivos IoT con firmware limitado
- **Acceso:** Acceso restrictivo a otras VLANs
- **Características:** Control de broadcast/multicast
- **Gateway:** 10.0.40.1
- **Restricciones:** Excepciones justificadas solo para servicios específicos

#### VLAN 99 — Management (10.0.99.0/24)

- **Propósito:** Administración exclusiva de infraestructura
- **Acceso:** Solo desde equipos autorizados
- **Características:** Aísla plano de control del resto de redes
- **Gateway:** 10.0.99.1
- **Dispositivos:** Switch, firewall, Proxmox, UniFi OS, controladores
- **Nota crítica:** El acceso a switch se restringe únicamente a VLAN 99

#### VLAN 100 — VPN (10.0.100.0/24)

- **Propósito:** Acceso remoto de clientes VPN
- **Acceso:** Control granular según políticas específicas
- **Características:** Identifica y segmenta tráfico externo
- **Gateway:** 10.0.100.1

---

## Dispositivos de Infraestructura

### Switch Principal: TP-Link TL-SG2008

| Atributo | Valor |
|----------|-------|
| Modelo | TP-Link TL-SG2008 |
| Puertos | 8 puertos Gigabit |
| VLAN Nativas | 1, 20, 30, 40, 99, 100 |
| Gestión | VLAN 99 (10.0.99.X) |
| Puertos Trunk | Hacia OPNsense, Proxmox |
| Estado | Activo |

**Nota:** La interfaz de gestión del switch debe estar en VLAN 99, nunca en VLAN 1.

### Firewall/Router: OPNsense

| Atributo | Valor |
|----------|-------|
| Software | OPNsense |
| Función | Enrutamiento, firewall, DHCP |
| VLANs Gestionadas | Todas (1-100) |
| Gestión | VLAN 99 (10.0.99.X) |
| Acceso WAN | A través de gateway ISP |
| Estado | Activo |

**Nota reciente:** tras la actualización a OPNsense 26.1 (MNT-2026-0002-NET) el servicio DHCP normal corre sobre **Kea DHCP** en todas las VLANs excepto la VLAN PXE. ISC DHCP legacy permanece únicamente en ese segmento para evitar interrupciones en clientes PXE mientras Kea gestiona los rangos LAN, alarma, DMZ, servidores, IoT, management y VPN.

### Virtualización: Proxmox

| Atributo | Valor |
|----------|-------|
| Nodo | Apollo |
| Función | Host para contenedores (CT) |
| Sistema | Debian |
| VLAN Gestión | VLAN 99 |
| IP Gestión | 10.0.99.101/24 |
| Capacidad | CPU, RAM, almacenamiento (ver planificación) |
| Estado | Activo |

---

## Servicios y Contenedores

### Resumen de Servicios

| CT/Servicio | Nodo | VLAN | IP | Función | Estado |
|-------------|------|------|-----|---------|--------|
| Omada | Proxmox | 99 | 10.0.99.10 | Gestión centralizada de switches Omada | 🟢 |
| UniFi OS | Proxmox | 99 | 10.0.99.12 | Gestión centralizada de APs UniFi | 🟢 |
| DNS (NS1) | Proxmox | 30 | 10.0.30.10 | Servidor DNS primario | 🟢 |
| DNS (NS2) | Proxmox | 30 | 10.0.30.11 | Servidor DNS secundario | 🟢 |
| Uptime Kuma | Proxmox | 30 | 10.0.30.X | Monitorización de servicios | 🟢 |
| NPM | Proxmox | 20 | 10.0.20.10 | Nginx Proxy Manager (DMZ) | 🟢 |
| Zigbee2MQTT | Proxmox | 30 | 10.0.30.13 | Puente Zigbee → MQTT | 🟢 |

### Servicios DNS

**NS1 (Primario)**

- **VLAN:** 30
- **Software:** BIND9
- **Función:** Resolución interna y externa
- **Zonas:** Internas (lab.local, etc.) + delegadas
- **Backup:** Semanal

**NS2 (Secundario)**

- **VLAN:** 30
- **Software:** BIND9
- **Función:** Redundancia DNS
- **Sincronización:** Transferencias de zona desde NS1

### Gestión Omada

- **VLAN:** 99
- **Software:** Omada Controller
- **Función:** Gestión centralizada de switches Omada (TP-Link TL-SG2008)
- **Acceso:** Web UI y API
- **Integración:** Control de VLANs, puertos, trunk y políticas de red en switches

### Gestión UniFi OS

- **VLAN:** 99
- **Software:** UniFi OS
- **Función:** Gestión centralizada de APs UniFi
- **Acceso:** Web UI, SSH y API
- **Integración:** Control de SSIDs, banda ancha, roaming y políticas de WiFi

### Monitorización: Uptime Kuma

- **VLAN:** 30
- **Función:** Monitoreo de servicios internos y externos
- **Alertas:** Correo, Telegram
- **Frecuencia:** Chequeos cada 1-5 minutos según servicio

### Proxy Inverso: Nginx Proxy Manager (NPM)

- **VLAN:** 20 (DMZ)
- **Función:** Exposición segura de servicios a internet
- **Certificados:** Let's Encrypt (HTTPS automático)
- **Redireccionamiento:** Multi-dominio
- **Dependencia:** NS1/NS2 para resolución de nombres

### Domótica: Zigbee2MQTT

- **VLAN:** 30
- **Función:** Integración de dispositivos Zigbee vía MQTT
- **Broker:** MQTT interno
- **Dispositivos:** Sensores, controles Zigbee

---

## Seguridad y Firewall

### Políticas Generales

1. **Principio de mínimo privilegio:** Solo tráfico explícitamente permitido
2. **Segregación por VLAN:** Cada segmento aislado por defecto
3. **Inspección de tráfico:** OPNsense inspecciona tráfico inter-VLAN
4. **Logs:** Todos los cambios de política se registran

### Reglas de Firewall Principales

#### Entrada (Inbound)

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|--------|---------|--------|-----------|--------|------|
| WAN | DMZ | 443 | TCP | Permitir | HTTPS externo |
| WAN | DMZ | 80 | TCP | Permitir | HTTP redirección |
| VLAN 1 | VLAN 99 | 22,443 | TCP | Permitir | Admin SSH/Web |
| VLAN 1 | VLAN 30 | 53 | UDP,TCP | Permitir | DNS |

#### Salida (Outbound)

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|--------|---------|--------|-----------|--------|------|
| VLAN 2 | WAN | 443,80 | TCP | Permitir | Alarma a servidor |
| VLAN 40 | VLAN 30 | 1883 | TCP | Permitir | IoT → MQTT |
| VLAN 40 | VLAN 1 | Todos | Todos | Bloquear | IoT aislado |
| VLAN 100 | VLAN 30,1 | Selectivo | TCP | Permitir | VPN acceso controlado |

### Acceso Administrativo

- **VLAN 99:** Única red para administración
- **Dispositivos críticos:** Acceso SSH key-based + 2FA (cuando aplique)
- **Switch management:** Solo desde VLAN 99
- **Firewall:** Acceso solo desde VLAN 99/LAN

---

## Monitorización y Alertas

### Herramientas

- **Uptime Kuma:** Monitorización de servicios (HTTP/HTTPS, ping, TCP)
- **Logs:** Centralizados en dispositivos (revisar `/var/log`)
- **Alertas:** Correo, Telegram para incidentes críticos

### Servicios Monitoreados

- DNS (NS1, NS2)
- NPM (disponibilidad web)
- Proxmox (estado de host)
- OPNsense (estado del firewall)
- Conectividad WAN

### Procedimiento de Alertas

1. Detección de caída de servicio
2. Notificación inmediata (correo, Telegram)
3. Verificación manual de causa
4. Documentación en incidente (INC-YYYY-NNNN.md)
5. Resolución y validación post-cambio

---

## Backup y Recuperación

### Estrategia de Backups

| Componente | Frecuencia | Método | Ubicación | RPO |
|-----------|-----------|--------|-----------|------|
| Proxmox CTs | Semanal | Snapshot | Storage local | 7 días |
| Configuración Firewall | Mensual | Exportación | Repositorio git | 30 días |
| Zonas DNS | Diaria | Backup de ficheros | Proxmox storage | 1 día |
| UniFi OS | Semanal | Exportación config | Storage local | 7 días |

### Procedimiento de Recuperación

1. **Identificar componente afectado**
2. **Localizar último backup válido**
3. **Restaurar según procedimiento** (CT snapshot, exportación, etc.)
4. **Validar funcionamiento** (ping, SSH, servicios)
5. **Documentar en RFC si es cambio** o en INC si es incidente

---

## Procedimientos (SOP)

### Cambios en la Infraestructura

Toda modificación debe documentarse en [RFC](rfc/):

1. Crear RFC en `rfc/propuestas/` usando [template](templates/RFC.md)
2. Detallar: cambios, riesgos, rollback, validaciones
3. Ejecutar cambio siguiendo plan de acción
4. Mover RFC a `rfc/completadas/` con resultado actual
5. Actualizar `Doc-Red.md` si aplica

### Mantenimiento Rutinario

Registrar en [MNT](mnt/) usando [template](templates/MNT.md):

- Actualizaciones de paquetes
- Limpiezas de almacenamiento
- Rotación de logs
- Tests de backup

### Incidentes y Problemas

Registrar en [INC](inc/) usando [template](templates/INC.md):

- Descripción del problema
- Timeline de detección y acciones
- Causa raíz identificada
- Resolución aplicada
- Lecciones aprendidas

---

## Historial de Cambios

### RFCs Completadas (Muestra)

| RFC | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| RFC-2025-0001-NET | Migración de Apollo a VLAN 99 | 2025-07-16 | Alta | ✓ |
| RFC-2025-0006-NET | Creación DMZ (VLAN 20) | 2025-07-30 | Media | ✓ |
| RFC-2025-0012-NET | Gestión switch a VLAN 99 | 2025-08-08 | Media | ✓ |
| RFC-2026-0002-NET | Instalación CT UniFi OS | 2026-01-28 | Media | ✓ |
| RFC-2026-0003-NET | Migración de DHCP normal a Kea en OPNsense 25.7.11_9 | 2026-02-06 | Media | ✓ |

Consulta [rfc/completadas](rfc/completadas/) para lista completa y detalles.

### Mantenimientos Completados (MNT)

| MNT | Título | Fecha | Criticidad | Estado |
|-----|--------|-------|-----------|--------|
| MNT-2026-0001-NET | Actualización Omada Controller 6.0.0.25 a 6.1.0.19 | 2026-01-29 | Media | ✓ |
| MNT-2026-0002-NET | Actualización de OPNsense a 26.1 | 2026-01-30 | Media | ✓ |

Consulta [mnt/completadas](mnt/completadas/) para lista completa y detalles.

### Cambios Recientes (Últimos 30 días)

- **2026-01-28:** Instalación de UniFi OS (RFC-2026-0002-NET)
- **2026-01-29:** Actualización Omada Controller (MNT-2026-0001-NET)
- **2026-02-06:** Migración de DHCP a Kea en OPNsense (RFC-2026-0003-NET)
- **2026-02-07:** Actualización de OPNsense a 26.1 (MNT-2026-0002-NET)

---

## Contacto y Referencias

- **Administrador:** Alejandro Martín Pérez
- **Repositorio:** GitHub homelab-docs
- **Documentación Oficial:**
  - [OPNsense](https://docs.opnsense.org/)
  - [Proxmox](https://pve.proxmox.com/wiki/Main_Page)
  - [UniFi](https://help.ui.com/)
  - [TP-Link TL-SG2008](https://www.tp-link.com/es/business/managed-switch/tl-sg2008/)

---

**Próxima revisión programada:** 28 de febrero de 2026
