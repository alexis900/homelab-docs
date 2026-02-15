# SOP — Alta de Monitores y Alertas (Uptime Kuma)

**Ámbito:** Monitores de servicios y alertas en Uptime Kuma.  
**Objetivo:** Crear monitores consistentes, con notificaciones fiables y validación posterior.

## 1) Preparación

- Confirmar el endpoint a monitorizar (URL, IP/puerto o ping).
- Definir frecuencia de chequeo y umbrales adecuados.
- Identificar canales de alerta (Telegram, correo, etc.).

## 2) Creación del monitor

- Crear el monitor con nombre claro y etiqueta de servicio.
- Configurar tipo de chequeo (HTTP, TCP, ping, etc.).
- Asignar notificaciones y grupos si aplica.

## 3) Prueba de alertas

- Forzar fallo temporal (si es posible) para validar notificaciones.
- Confirmar recepción y tiempos de aviso.
- Restablecer el servicio y verificar recuperación.

## 4) Documentación

- Actualizar `Doc-Red/Servicios.md` si se añade monitor a un servicio crítico.
- Registrar cambios en MTN si aplica.

## 5) Rollback

- Desactivar o eliminar el monitor.
- Retirar notificaciones asociadas si ya no son necesarias.
