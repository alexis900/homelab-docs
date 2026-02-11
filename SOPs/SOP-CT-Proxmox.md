# SOP — Despliegue / Actualización de Contenedores en Proxmox

**Ámbito:** CTs en nodo Proxmox (Hermes). Aplica a contenedores LXC y CT con Docker dentro.  
**Objetivo:** Desplegar o actualizar contenedores minimizando downtime y riesgo.

## 1)

- Confirmar ventana y notificar si aplica.
- Verificar backups: snapshot CT reciente o backup PBS.
- Anotar versión actual de la imagen/paquete y commit del servicio.
- Comprobar espacio libre en `rootfs` y pool de almacenamiento.
- Verificar salud del nodo (`pveperf`, carga, I/O) y de la red (ping GW, DNS).

## 2) Backup rápido

- CT LXC: `pct snapshot <CTID> pre-update` (o backup PBS si pesa mucho).
- Docker en CT: exportar `docker compose` y `env` actuales; opcional `docker save` de la imagen vigente.

## 3) Actualización / despliegue

- Paquetes base (si aplica): `apt update && apt upgrade` dentro del CT.
- Docker: `docker compose pull` + `docker compose up -d` (o `docker run` con tag nuevo).
- LXC sin Docker: actualizar binarios/servicio según procedimiento del app.
- Aplicar cambios de config (env, volumes, puertos) y validar sintaxis antes de subir.

## 4) Validación funcional

- Comprobar estado del servicio: `docker compose ps`, `systemctl status`, `curl/healthcheck`.
- Checks internos: ping a dependencias (DB, DNS), puertos abiertos (`ss -lnptu`).
- Checks externos: acceso desde VLAN esperada; si aplica, monitor en Uptime Kuma ok.
- Revisar logs iniciales: `docker compose logs --tail 50`, `journalctl -u <svc>`.

## 5) Rollback (si falla)

- Restaurar snapshot: `pct rollback <CTID> pre-update`.
- Docker: bajar stack y volver a tag anterior (`docker compose down && docker compose up -d imagen:tag-previa`).
- Validar servicio tras rollback.

## 6) Documentación

- Registrar versión nueva (imagen/tag, hash) y fecha.
- Actualizar inventario/Doc-Red si cambian IP, puertos, dependencia o monitorización.
- Marcar/crear RFC o MNT según corresponda (cambio vs mantenimiento).

## 7) Limpieza

- Eliminar snapshots/imagenes antiguas tras 24-48h de estabilidad.
- Confirmar alertas sin falsos positivos en Uptime Kuma.
