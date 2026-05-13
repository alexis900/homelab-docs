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
