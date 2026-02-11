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
