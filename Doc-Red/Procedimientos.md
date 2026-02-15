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
- [SOP-Zigbee-Devices](../SOPs/SOP-Zigbee-Devices.md): Alta/baja de dispositivos Zigbee (pairing, naming, IEEE, validación y rollback).
- [SOP-HA-Automations](../SOPs/SOP-HA-Automations.md): Creación y mantenimiento de automatizaciones en Home Assistant con pruebas y rollback.
- [SOP-DNS-Changes](../SOPs/SOP-DNS-Changes.md): Cambios de DNS interno en BIND9 con validación y rollback.
- [SOP-Monitoring-Alerts](../SOPs/SOP-Monitoring-Alerts.md): Alta de monitores y alertas en Uptime Kuma con pruebas de notificación.

## Incidentes y Problemas

Registrar en [INC](../inc/) usando [template](../templates/INC.md):

- Descripción del problema
- Timeline de detección y acciones
- Causa raíz identificada
- Resolución aplicada
- Lecciones aprendidas
