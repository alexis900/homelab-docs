# Seguridad y Firewall

## Principios

1. Mínimo privilegio: permitir solo lo necesario.
2. Segmentación por VLAN: cada red aislada por defecto.
3. Regla explícita antes que excepción: nada sale sin motivo.
4. Registro de cambios: toda modificación relevante debe quedar trazada.

## Políticas Base

| Zona | Política |
|---|---|
| WAN | Solo entradas publicadas y VPN |
| VLAN 1 | Acceso de usuario a servicios internos permitidos |
| VLAN 30 | Servicios internos con permisos controlados |
| VLAN 40 | Solo DNS, NTP, MQTT y Home Assistant |
| VLAN 99 | Solo gestión |

## Reglas de Firewall

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|---|---|---:|---|---|---|
| WAN | DMZ | 80, 443 | TCP | Permitir | NPM |
| WAN | Firewall | 51820 | UDP | Permitir | WireGuard |
| VLAN 1 | VLAN 99 | 22, 443 | TCP | Permitir | Administración |
| VLAN 1 | VLAN 30 | 53 | UDP/TCP | Permitir | DNS |
| VLAN 40 | VLAN 30 | 1883 | TCP | Permitir | IoT a MQTT |
| VLAN 40 | WAN | Todos | Todos | Bloquear | IoT sin salida libre |
| VLAN 40 | VLAN 1/20/99 | Todos | Todos | Bloquear | Aislamiento lateral |

## Resumen de Alias

| Alias | Valor |
|---|---|
| ADMIN_PC | 10.0.1.10, 10.0.1.11, 10.0.1.20 |
| DNS_SERVERS | 10.0.30.10, 10.0.30.11 |
| HOMEASSISTANT | 10.0.30.14 |
| NPM_DMZ | 10.0.20.10 |
| PROXMOX_NODES | 10.0.99.100, 10.0.99.101, 10.0.99.102, 10.0.99.110 |
| PXE_SERVER | 10.0.30.20 |
| SWITCH | 10.0.99.200 |
| UPTAME_KUMA | 10.0.99.20, 10.0.99.15 |
| Z2MQTT | 10.0.30.12 |
| ZBCOORD | 10.0.40.10 |

## Acceso Administrativo

- El acceso de gestión debe concentrarse en VLAN 99.
- SSH debe preferir llaves.
- 2FA sigue pendiente de despliegue total en la capa admin.
- Cualquier regla amplia en LAN o VLAN 1 debe revisarse y justificarse.

## Estado de IoT

- IoT ya tiene su SSID propio.
- IoT debe quedar sin salida directa a WAN salvo excepciones justificadas por RFC.
- DNS y NTP internos son prerequisito para no romper dispositivos.
