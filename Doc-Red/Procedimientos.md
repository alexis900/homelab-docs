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
