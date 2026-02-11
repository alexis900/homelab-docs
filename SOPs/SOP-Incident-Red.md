# SOP — Respuesta rápida a incidentes de red

**Ámbito:** Caídas parciales/totales de red, pérdida de servicios críticos (DNS, DHCP, WAN).
**Objetivo:** Restaurar servicio rápido con pasos mínimos y documentar incidente.

## 1) Detección y triage

- Confirmar alcance: qué VLAN/es o servicios están caídos (WAN, DNS, DHCP, WiFi, IoT).
- Consultar alertas (Uptime Kuma) y logs recientes (OPNsense, Proxmox).
- Registrar hora de inicio percibida.

## 2) Checks rápidos

- WAN: ping gateway ISP y 8.8.8.8 desde OPNsense.
- DHCP: `dhclient -v` en cliente de prueba o revisar leases en OPNsense/Kea.
- DNS: `dig @10.0.30.10 example.com` y `dig @10.0.30.11`.
- Switching/APs: comprobar estado en Omada/UniFi (uplinks, PoE, adopción).

## 3) Aislar causa

- Cambios recientes: revisar últimos RFC/MNT ejecutados.
- Separar capa: físico (cables/poe), capa2 (VLAN/tagging), capa3 (rutas/firewall), servicios (DNS/DHCP).
- Revisar reglas recientes que puedan bloquear.

## 4) Mitigación rápida

- DNS caído: forzar uso de NS secundario o DNS público temporal en VLAN afectada.
- DHCP caído: asignar IP estática temporal para administración.
- VLAN caída: mover cliente de prueba a otra VLAN para validar conectividad core.
- WAN caída: reiniciar módem/ONT y renovar IP WAN en OPNsense.

## 5) Restauración

- Revertir cambio reciente (rollback del RFC/MNT o snapshot si aplica).
- Reiniciar servicio puntual (kea-dhcp, unbound/named, interfaces OPNsense) si no hay riesgo.

## 6) Verificación

- Pruebas desde dos VLAN: ping GW, DNS, acceso a servicio crítico (HA/NPM/Proxmox).
- Confirmar monitores Uptime Kuma verdes.

## 7) Documentación

- Abrir incidente en `inc/` con: descripción, timeline, acciones, causa raíz, resolución, lecciones.
- Si hubo rollback, anotar en RFC/MNT afectado.
