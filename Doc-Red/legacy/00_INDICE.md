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

