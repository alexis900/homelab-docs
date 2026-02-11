# SOP — Gestión de Certificados TLS (NPM y servicios internos)

**Ámbito:** Certificados Let’s Encrypt en Nginx Proxy Manager (NPM) y distribución a servicios internos.
**Objetivo:** Renovar/emisor certificados sin interrumpir servicios.

## 1) Preparación

- Confirmar dominios/hosts a renovar y accesos DNS/HTTP-01.
- Verificar puertos 80/443 abiertos hacia NPM (DMZ) y DNS resolviendo.
- Backup rápido de NPM (export config) y de servicios que recibirán certificados.

## 2) Renovación en NPM

- En NPM: Certificates → Add/Renew → seleccionar Let’s Encrypt (HTTP-01 o DNS-01 según caso).
- Validar creación: estado “Valid”.
- Descargar/fullchain+key si se necesitan para servicios internos fuera de NPM.

## 3) Distribución a servicios internos (si aplica)

- Copiar cert/key al servicio (ej. HA, Omada, UniFi, Proxmox) usando canal seguro.
- Actualizar rutas en la configuración del servicio y reiniciar/recargar (systemctl reload o comando propio).
- Para Proxmox/OPNsense: seguir guías oficiales para cargar certificados.

## 4) Validación

- Comprobar caducidad: `openssl s_client -connect host:443 -servername host | openssl x509 -noout -enddate`.
- Revisar que el certificado servido es el nuevo (CN/SAN y fecha).
- Uptime Kuma: confirmar monitores HTTPS sin alertas.

## 5) Rollback

- Volver a cert anterior (copia previa) y recargar servicio.
- Si falla HTTP-01, usar DNS-01 temporalmente.

## 6) Documentación

- Registrar fecha de renovación, método (HTTP-01/DNS-01) y expiración nueva.
- Actualizar `Doc-Red/Seguridad.md` si cambia el flujo (p.ej. se añade DNS-01 con API).
