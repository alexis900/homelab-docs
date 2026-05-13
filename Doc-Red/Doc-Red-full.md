# Homelab Docs Legacy

## Visión General

Esta es la versión principal de la documentación operativa del homelab. Mantiene un estilo compacto, directo y práctico, con el estado actual de red, servicios, seguridad, mantenimiento y cambios.

## Puntos Clave

- Plano de control en VLAN 99.
- Servicios de infraestructura en VLAN 30.
- IoT en VLAN 40 con salida restringida.
- DMZ en VLAN 20.
- OPNsense como firewall y router central.

## Navegación

1. [Arquitectura General](Arquitectura.md)
2. [Segmentación de VLANs](VLANs.md)
3. [Servicios y Contenedores](Servicios.md)
4. [Seguridad y Firewall](Seguridad.md)
5. [Procedimientos e Incidentes](Procedimientos.md)
6. [Backup y Recuperación](Backup.md)
7. [Monitorización y Alertas](Monitorizacion.md)
8. [Contacto y Referencias](Contacto.md)
9. [Historial de Cambios](Cambios.md)
10. [Dispositivos de Infraestructura](Dispositivos.md)

## Estado Actual

- OPNsense: `26.1.8`
- Home Assistant: operativo en VLAN 30
- Zigbee2MQTT: operativo en VLAN 30
- SSID `HOME_IoT`: activo en VLAN 40

## Uso Recomendado

- Consultar `Servicios.md` para inventario y nombres.
- Consultar `Seguridad.md` para reglas y aliases.
- Consultar `Cambios.md` para ver qué se movió y cuándo.
- Consultar `Procedimientos.md` para ejecutar cambios o resolver incidentes.



---

# Arquitectura General

## Resumen Operativo

La red doméstica está organizada por **VLANs** con un plano de control separado en **VLAN 99**. OPNsense actúa como firewall central y router inter-VLAN, mientras que Proxmox aloja los servicios críticos y los controladores de red.

## Plano de Control

- VLAN 99 concentra administración, monitorización y control.
- VLAN 30 concentra servicios internos de infraestructura.
- VLAN 40 concentra dispositivos IoT con acceso muy restringido.
- VLAN 20 se reserva para DMZ y servicios expuestos.

## Componentes Principales

| Componente | Dispositivo | Función | VLAN |
|---|---|---|---|
| Firewall | OPNsense | Enrutamiento, firewall y políticas de red | 99 |
| Switch Core | TP-Link TL-SG2008 | Conmutación entre VLANs y uplinks principales | 99 |
| Virtualización | Proxmox | Host para VMs y CTs | 99 |
| Gestión Omada | Omada (CT) | Control de switches Omada | 99 |
| Gestión UniFi | UniFi OS (CT) | Control de APs UniFi | 99 |
| Monitorización | Uptime Kuma | Monitorización y alertas | 99 |

## Estado Actual

- OPNsense: `26.1.8`
- Proxmox: `9.1.x`
- Home Assistant: en VLAN 30
- Zigbee2MQTT: en VLAN 30
- SSID IoT activo sobre VLAN 40

## Observaciones

- El acceso de gestión debe permanecer restringido a VLAN 99.
- Los servicios críticos de usuario viven fuera de VLAN 99 solo cuando existe una razón clara.
- La arquitectura debe leerse como un mapa vivo, no como un diagrama genérico.


---

# Segmentación de VLANs

## Justificación

- Seguridad: aislar IoT, alarmas y gestión.
- Operación: separar tráfico de usuarios, servicios e infraestructura.
- Escalabilidad: añadir segmentos sin romper el plano existente.

## Tabla de VLANs

| VLAN | Nombre | Red | Gateway | Uso principal |
|---|---|---|---|---|
| 1 | LAN | 10.0.1.0/24 | 10.0.1.1 | Dispositivos de usuario general |
| 2 | Alarma | 10.0.2.0/29 | 10.0.2.1 | Sistema de alarma aislado |
| 20 | DMZ | 10.0.20.0/24 | 10.0.20.1 | Servicios expuestos |
| 30 | Servidores | 10.0.30.0/24 | 10.0.30.1 | DNS, MQTT, Home Assistant, PXE |
| 40 | IoT | 10.0.40.0/24 | 10.0.40.1 | Dispositivos IoT restringidos |
| 99 | Management | 10.0.99.0/24 | 10.0.99.1 | Switches, firewall, Proxmox, controladores |
| 100 | VPN | 10.0.100.0/24 | 10.0.100.1 | Clientes remotos |

## Descripción Breve

### VLAN 1

- Red de usuarios.
- Acceso amplio a servicios internos e internet.

### VLAN 2

- Segmento aislado para alarma.
- Solo salida controlada hacia el proveedor.

### VLAN 20

- DMZ para servicios publicados.
- Sin acceso libre al resto de la red.

### VLAN 30

- Servicios internos: DNS, MQTT, Home Assistant, PXE, monitorización auxiliar.
- Red de soporte para infraestructura crítica.

### VLAN 40

- IoT con política de mínimo privilegio.
- Solo puede hablar con DNS, NTP, MQTT y Home Assistant según reglas de firewall.

### VLAN 99

- Plano de control.
- Solo administración y monitorización.
- El acceso a switches y controladores debe residir aquí.

### VLAN 100

- Acceso remoto por VPN.
- Tráfico controlado según políticas.

## Reglas Clave

- VLAN 40 no debe tener salida libre a Internet.
- VLAN 40 no debe acceder a VLAN 1, 20 ni 99 salvo excepción documentada.
- VLAN 99 no debe mezclarse con tráfico de usuario.
- El gateway de cada VLAN es también el punto de control lógico de la segmentación.


---

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


---

# Seguridad y Firewall

## Principios

1. Mínimo privilegio: permitir solo lo necesario.
2. Segmentación por VLAN: cada red aislada por defecto.
3. Regla explícita antes que excepción: nada sale sin motivo.
4. Registro de cambios: toda modificación relevante debe quedar trazada.

## Políticas Base

| Zona | Política |
|---|---|
| WAN | Solo entradas publicadas y VPN |
| VLAN 1 | Acceso de usuario a servicios internos permitidos |
| VLAN 30 | Servicios internos con permisos controlados |
| VLAN 40 | Solo DNS, NTP, MQTT y Home Assistant |
| VLAN 99 | Solo gestión |

## Reglas de Firewall

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|---|---|---:|---|---|---|
| WAN | DMZ | 80, 443 | TCP | Permitir | NPM |
| WAN | Firewall | 51820 | UDP | Permitir | WireGuard |
| VLAN 1 | VLAN 99 | 22, 443 | TCP | Permitir | Administración |
| VLAN 1 | VLAN 30 | 53 | UDP/TCP | Permitir | DNS |
| VLAN 40 | VLAN 30 | 1883 | TCP | Permitir | IoT a MQTT |
| VLAN 40 | WAN | Todos | Todos | Bloquear | IoT sin salida libre |
| VLAN 40 | VLAN 1/20/99 | Todos | Todos | Bloquear | Aislamiento lateral |

## Resumen de Alias

| Alias | Valor |
|---|---|
| ADMIN_PC | 10.0.1.10, 10.0.1.11, 10.0.1.20 |
| DNS_SERVERS | 10.0.30.10, 10.0.30.11 |
| HOMEASSISTANT | 10.0.30.14 |
| NPM_DMZ | 10.0.20.10 |
| PROXMOX_NODES | 10.0.99.100, 10.0.99.101, 10.0.99.102, 10.0.99.110 |
| PXE_SERVER | 10.0.30.20 |
| SWITCH | 10.0.99.200 |
| UPTAME_KUMA | 10.0.99.20, 10.0.99.15 |
| Z2MQTT | 10.0.30.12 |
| ZBCOORD | 10.0.40.10 |

## Acceso Administrativo

- El acceso de gestión debe concentrarse en VLAN 99.
- SSH debe preferir llaves.
- 2FA sigue pendiente de despliegue total en la capa admin.
- Cualquier regla amplia en LAN o VLAN 1 debe revisarse y justificarse.

## Estado de IoT

- IoT ya tiene su SSID propio.
- IoT debe quedar sin salida directa a WAN salvo excepciones justificadas por RFC.
- DNS y NTP internos son prerequisito para no romper dispositivos.


---

# Procedimientos e Incidentes

## Flujo Normal de Cambio

1. Abrir RFC en `rfc/propuestas/`.
2. Describir objetivo, riesgos, rollback y validación.
3. Ejecutar el cambio.
4. Mover el RFC a `rfc/completadas/`.
5. Reflejar el estado final en `Doc-Red` o en el inventario afectado.

## Mantenimiento Rutinario

Registrar en `mtn/`:

- Actualizaciones de paquetes.
- Limpiezas y rotación de logs.
- Tests de backup y restauración.
- Ajustes menores de servicios.

## SOP Disponibles

| SOP | Uso |
|---|---|
| SOP-CT-Proxmox | Despliegue y actualización de contenedores |
| SOP-VLAN | Alta o cambio de VLAN en OPNsense y switches |
| SOP-TLS-Certs | Gestión de certificados TLS |
| SOP-Incident-Red | Respuesta rápida a incidentes de red |
| SOP-Zigbee-Devices | Alta y baja de dispositivos Zigbee |
| SOP-HA-Automations | Automatizaciones de Home Assistant |
| SOP-DNS-Changes | Cambios de DNS interno |
| SOP-Monitoring-Alerts | Alta de monitores y alertas |

## Incidentes

Cuando algo se rompe:

1. Identificar el alcance.
2. Registrar el síntoma.
3. Mitigar lo urgente.
4. Corregir la causa raíz.
5. Cerrar con lecciones aprendidas.


---

# Backup y Recuperación

## Estrategia

| Componente | Frecuencia | Método | Ubicación | RPO |
|---|---|---|---|---|
| CTs Proxmox | Semanal | Snapshot | Almacenamiento local | 7 días |
| Firewall OPNsense | Post-cambio | Exportación | Git y backup externo | 30 días |
| Zonas DNS | Diaria | Ficheros | Proxmox storage | 1 día |
| UniFi OS | Semanal | Exportación de config | Almacenamiento local | 7 días |

## Recuperación

1. Identificar qué ha fallado.
2. Buscar el último backup válido.
3. Restaurar con el método apropiado.
4. Validar conectividad y servicios.
5. Registrar el resultado en RFC o INC según corresponda.

## Regla Simple

- Si el cambio rompe algo, primero vuelve al último estado bueno.
- Si el backup no se puede restaurar, el problema no está resuelto.


---

# Monitorización y Alertas

## Herramientas

| Herramienta | Uso |
|---|---|
| Uptime Kuma | Monitorización de HTTP, HTTPS, ping y TCP |
| Logs del sistema | Revisión de errores y eventos |
| Alertas | Correo y Telegram |

## Servicios Críticos

- DNS NS1 y NS2.
- OPNsense.
- Proxmox Zeus y Hermes.
- Home Assistant.
- NPM.
- Conectividad WAN.

## Flujo de Alertas

1. Se detecta la caída o degradación.
2. Se notifica al canal configurado.
3. Se verifica el alcance real.
4. Se aplica mitigación.
5. Se documenta en INC si hay impacto.

## Criterio Práctico

- Un monitor útil debe avisar antes de que el usuario lo note.
- Si un servicio es crítico, debe tener monitorización explícita y no depender solo de revisión manual.


---

# Contacto y Referencias

## Responsable

- Alejandro Martín Pérez

## Repositorio

- `homelab-docs`

## Referencias Oficiales

- [OPNsense](https://docs.opnsense.org/)
- [Proxmox](https://pve.proxmox.com/wiki/Main_Page)
- [UniFi](https://help.ui.com/)
- [TP-Link TL-SG2008](https://www.tp-link.com/es/business/managed-switch/tl-sg2008/)

## Nota

- Esta carpeta legacy prioriza contexto operativo y referencia histórica.


---

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

**Nota de ubicación:** la VM de OPNsense está alojada en el nodo Proxmox **Zeus**.  
**Nota reciente (2026-05-14):** tras la actualización a OPNsense 26.1.8 (MTN-2026-0009-NET), el DHCP normal sigue corriendo sobre **Kea DHCP**. El incidente de PXE provocado al desactivar ISC DHCP quedó corregido y documentado en `rfc/completadas/RFC-2026-0012-NET.md`.

## Virtualización: Proxmox

| Atributo | Valor |
|----------|-------|
| Nodo | Zeus |
| Función | Host para contenedores (CT) |
| Sistema | Debian |
| VLAN Gestión | VLAN 99 |
| IP Gestión | 10.0.99.100/24 |
| Capacidad | CPU, RAM, almacenamiento (ver planificación) |
| Estado | Activo |

| Atributo | Valor |
|----------|-------|
| Nodo | Hermes |
| Función | Host para contenedores (CT) |
| Sistema | Debian |
| VLAN Gestión | VLAN 99 |
| IP Gestión | 10.0.99.102/24 |
| Capacidad | CPU, RAM, almacenamiento (ver planificación) |
| Estado | Activo |
