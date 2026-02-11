# Segmentación de VLANs

## Justificación

- **Seguridad:** Aislar dispositivos críticos y potencialmente vulnerables (IoT, alarmas)
- **Optimización:** Reducir congestión separando servicios de alto ancho de banda
- **Gestión:** Concentrar acceso administrativo en VLAN segregada
- **Escalabilidad:** Facilitar crecimiento futuro sin afectar operativa actual

## Tabla de VLANs

| VLAN | Nombre | Red | Gateway | Propósito |
|------|--------|-----|---------|----------|
| 1 | LAN | 10.0.1.0/24 | 10.0.1.1 | Dispositivos de usuario general |
| 2 | Alarma | 10.0.2.0/29 | 10.0.2.1 | Sistema de alarma (aislado) |
| 20 | DMZ | 10.0.20.0/24 | 10.0.20.1 | Servicios expuestos a internet |
| 30 | Servidores | 10.0.30.0/24 | 10.0.30.1 | Contenedores, almacenamiento, servicios internos |
| 40 | IoT | 10.0.40.0/24 | 10.0.40.1 | Dispositivos IoT (firmware limitado) |
| 99 | Management | 10.0.99.0/24 | 10.0.99.1 | Infraestructura: switches, firewall, virtualizadores, monitorización |
| 100 | VPN | 10.0.100.0/24 | 10.0.100.1 | Clientes remotos (acceso VPN) |

## Descripción Detallada de VLANs

### VLAN 1 — LAN (10.0.1.0/24)

- **Propósito:** Segmento principal para dispositivos de usuario (PCs, laptops, teléfonos)
- **Acceso:** Acceso completo a servicios internos e internet
- **Características:** Red base, sin restricciones especiales
- **Gateway:** 10.0.1.1

### VLAN 2 — Alarma (10.0.2.0/29)

- **Propósito:** Aislamiento exclusivo del sistema de alarma
- **Acceso:** Solo tráfico saliente hacia servidores del proveedor
- **Características:** Rango pequeño (/29) para limitar exposición
- **Gateway:** 10.0.2.1
- **Restricciones:** No puede acceder a otros segmentos internos

### VLAN 20 — DMZ (10.0.20.0/24)

- **Propósito:** Servicios expuestos a internet (Nginx Proxy Manager)
- **Acceso:** Tráfico entrante desde WAN con control estricto
- **Características:** Aislada del resto de infraestructura
- **Gateway:** 10.0.20.1
- **Reglas Firewall:**
  - DMZ → WAN: Solo puerto 443 (HTTPS)
  - DMZ → LAN: Bloqueado por defecto
  - LAN → DMZ: Solo administración específica

### VLAN 30 — Servidores (10.0.30.0/24)

- **Propósito:** Contenedores internos (DNS, monitorización, servicios auxiliares)
- **Acceso:** Restringido a redes autorizadas
- **Características:** Hospeda infraestructura crítica
- **Gateway:** 10.0.30.1
- **Servicios:** BIND9 (DNS), contenedores CT

### VLAN 40 — IoT (10.0.40.0/24)

- **Propósito:** Aislamiento de dispositivos IoT con firmware limitado
- **Acceso:** Acceso restrictivo a otras VLANs
- **Características:** Control de broadcast/multicast
- **Gateway:** 10.0.40.1
- **Restricciones:** Excepciones justificadas solo para servicios específicos

### VLAN 99 — Management (10.0.99.0/24)

- **Propósito:** Administración exclusiva de infraestructura
- **Acceso:** Solo desde equipos autorizados
- **Características:** Aísla plano de control del resto de redes
- **Gateway:** 10.0.99.1
- **Dispositivos:** Switch, firewall, Proxmox, UniFi OS, controladores, Uptime Kuma
- **Nota crítica:** El acceso a switch se restringe únicamente a VLAN 99

### VLAN 100 — VPN (10.0.100.0/24)

- **Propósito:** Acceso remoto de clientes VPN
- **Acceso:** Control granular según políticas específicas
- **Características:** Identifica y segmenta tráfico externo
- **Gateway:** 10.0.100.1
