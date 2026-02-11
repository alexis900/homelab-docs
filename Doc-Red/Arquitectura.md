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
