# SOP — Alta / Cambio de VLAN en OPNsense + Switching

**Ámbito:** VLANs en OPNsense y switches (TL-SG2008, SG205GP).  
**Objetivo:** Crear o modificar VLANs con reglas mínimas, evitando cortes.

## 1) Preparación

- Definir: ID, nombre, gateway, rango DHCP, propósito y VLAN tagging en troncales.
- Backup: export OPNsense + config del controlador Omada.
- Verificar trunks actuales (puertos a OPNsense/Proxmox/APs).

## 2) OPNsense

- Crear interfaz VLAN (padre: LAN/trunk, VID=<ID>, descripción).
- Asignar interfaz + habilitar, IP/gateway; DHCP/estático según plan.
- Reglas iniciales (mínimas):
  - DNS (53/853) hacia DNS internos.
  - NTP (123) hacia tiempo autorizado.
  - Bloqueo default a otras VLANs salvo excepciones.
- Aplicar y guardar.

## 3) Switches (Omada)

- Añadir VLAN en perfil de puerto troncal (uplink a OPNsense/Proxmox/APs).
- Asignar puertos access a la nueva VLAN según topología.
- Confirmar que la VLAN de gestión (99) no se altera en puertos de control.

## 4) DHCP/Reserva

- Si usa DHCP: configurar rango, gateway, DNS y reservas clave.
- Si está deshabilitado: documentar IPs estáticas requeridas.

## 5) Validación

- Cliente de prueba en puerto access: obtiene IP correcta, ping a gateway y DNS.
- Prueba de reglas: acceso solo a lo permitido; bloqueo al resto.
- Monitor en Uptime Kuma (si aplica) para gateway o servicio de la VLAN.

## 6) Documentación

- Actualizar tabla de VLANs y resumen de reglas en Doc-Red.md.
- Registrar cambio en RFC correspondiente (o cerrar MNT si es mantenimiento menor).

## 7) Rollback

- Revertir perfil de puerto y quitar VLAN de OPNsense (deshabilitar interfaz) si falla.
- Restaurar backup de OPNsense y Omada si hay pérdida de conectividad.
