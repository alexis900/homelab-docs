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

**Nota:** las IPs de gestión permanecen en VLAN 99; las IPs de VLAN 1 se documentan como secundarias o de contingencia.

| Atributo | Valor |
|----------|-------|
| Nodo | Zeus |
| Función | Host para contenedores (CT) |
| Sistema | Debian |
| VLAN Gestión | VLAN 99 |
| IP Gestión | 10.0.99.100/24 |
| VLAN Secundaria | VLAN 1 |
| IP Secundaria | 10.0.1.125/24 |
| Capacidad | CPU, RAM, almacenamiento (ver planificación) |
| Estado | Activo |

| Atributo | Valor |
|----------|-------|
| Nodo | Hermes |
| Función | Host para contenedores (CT) |
| Sistema | Debian |
| VLAN Gestión | VLAN 99 |
| IP Gestión | 10.0.99.102/24 |
| VLAN Secundaria | VLAN 1 |
| IP Secundaria | 10.0.1.230/24 |
| Capacidad | CPU, RAM, almacenamiento (ver planificación) |
| Estado | Activo |
