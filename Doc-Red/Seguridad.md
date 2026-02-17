# Seguridad y Firewall

## Políticas Generales

1. **Principio de mínimo privilegio:** Solo tráfico explícitamente permitido
2. **Segregación por VLAN:** Cada segmento aislado por defecto
3. **Inspección de tráfico:** OPNsense inspecciona tráfico inter-VLAN
4. **Logs:** Todos los cambios de política se registran

## Reglas de Firewall Principales

### Entrada (Inbound)

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|--------|---------|--------|-----------|--------|------|
| WAN | DMZ | 443 | TCP | Permitir | HTTPS externo |
| WAN | DMZ | 80 | TCP | Permitir | HTTP redirección |
| VLAN 1 | VLAN 99 | 22,443 | TCP | Permitir | Admin SSH/Web |
| VLAN 1 | VLAN 30 | 53 | UDP,TCP | Permitir | DNS |
| WAN | Firewall (self) | 51820 | UDP | Permitir | VPN WireGuard |

### Salida (Outbound)

| Origen | Destino | Puerto | Protocolo | Acción | Nota |
|--------|---------|--------|-----------|--------|------|
| VLAN 2 | WAN | 443,80 | TCP | Permitir | Alarma a servidor |
| VLAN 40 | VLAN 30 | 1883 | TCP | Permitir | IoT → MQTT |
| VLAN 40 | VLAN 1 | Todos | Todos | Bloquear | IoT aislado |
| VLAN 100 | VLAN 30,1 | Selectivo | TCP | Permitir | VPN acceso controlado |

### Resumen de reglas activas (export OPNsense 11/02/2026)

- **WAN → DMZ (NPM_DMZ):** TCP 80, 443 permitidos.
- **WAN → Firewall (self):** UDP 51820 permitida (WireGuard).
- **LAN → DNS_SERVERS:** UDP/TCP 53 y UDP 853 permitidos.
- **LAN → salidas web básicas:** TCP 80, 443 permitidos; UDP 123 (NTP) permitido.
- **LAN (ADMIN_PC) → servicios internos:** NPM_DMZ:81, Z2MQTT:8080, Home Assistant:8123, Proxmox:8006-8007, DNS/Z2MQTT SSH:22, Uptime Kuma:3001, Omada:8443, Zigbee Coordinator:80.
- **LAN regla amplia:** allow any/any (entrada) presente al final de la cadena.
- **OPT1 (VLAN secundaria):** DNS 53/853, NTP 123, HTTP/HTTPS permitidos; ICMP permitido; bloqueo catch-all TCP/UDP en 261.
- **OPT2 (otra VLAN):** DNS 53 (TCP/UDP) hacia DNS_SERVERS, HTTP/HTTPS permitidos; flujos Z2MQTT↔ZBCOORD puerto 6638; ICMP permitido; allow any/any (351).
- **OPT3 (otra VLAN):** DNS 53, NTP 123 permitidos; tráfico Zigbee coordinator ↔ Z2MQTT puerto 6638 permitido.

## Acceso Administrativo

- **Estado actual:** Acceso de administración permitido desde VLAN 1 y VLAN 99 (sin 2FA aplicado aún).
- **SSH:** Claves recomendadas; verificar y aplicar en dispositivos pendientes.
- **Switch management:** Acceso desde VLAN 99 previsto; consolidar y bloquear desde otras VLANs.
- **Firewall:** Revisar y limitar a VLAN 99/LAN según plan de hardening.

---

## Aliases OPNsense (inventario)

| Alias | Tipo | Valor / Contenido |
|---|---|---|
| ADMIN_PC | Host(s) | 10.0.1.10, 10.0.1.11, 10.0.1.20 |
| DNS_SERVERS | Host(s) | 10.0.30.10, 10.0.30.11 |
| DUCKDNS | Host(s) | api.duckdns.org |
| GMAIL_SMTP | Host(s) | smtp.gmail.com |
| HOMEASSISTANT | Host(s) | 10.0.30.14 |
| NAS | Host(s) | 10.0.1.173 |
| NPM_DMZ | Host(s) | 10.0.20.10 |
| PROXMOX_NODES | Host(s) | 10.0.99.100, 10.0.99.101, 10.0.99.110, 10.0.99.102 |
| PXE_SERVER | Host(s) | 10.0.30.20 |
| SWITCH | Host(s) | 10.0.99.200 |
| UPTAME_KUMA | Host(s) | 10.0.99.20, 10.0.99.15 |
| Z2MQTT | Host(s) | 10.0.30.12 |
| ZBCOORD | Host(s) | 10.0.40.10 |
