# Segmentación de VLANs

## Justificación

- Seguridad: aislar IoT, alarmas y gestión.
- Operación: separar tráfico de usuarios, servicios e infraestructura.
- Escalabilidad: añadir segmentos sin romper el plano existente.

## Tabla de VLANs

| VLAN | Nombre | Red | Gateway | Uso principal |
|---|---|---|---|---|
| 1 | LAN | 10.0.1.0/24 | 10.0.1.1 | Dispositivos de usuario general |
| 2 | Alarma | 10.0.2.0/29 | 10.0.2.1 | Sistema de alarma aislado |
| 20 | DMZ | 10.0.20.0/24 | 10.0.20.1 | Servicios expuestos |
| 30 | Servidores | 10.0.30.0/24 | 10.0.30.1 | DNS, MQTT, Home Assistant, PXE |
| 40 | IoT | 10.0.40.0/24 | 10.0.40.1 | Dispositivos IoT restringidos |
| 99 | Management | 10.0.99.0/24 | 10.0.99.1 | Switches, firewall, Proxmox, controladores |
| 100 | VPN | 10.0.100.0/24 | 10.0.100.1 | Clientes remotos |

## Descripción Breve

### VLAN 1

- Red de usuarios.
- Acceso amplio a servicios internos e internet.

### VLAN 2

- Segmento aislado para alarma.
- Solo salida controlada hacia el proveedor.

### VLAN 20

- DMZ para servicios publicados.
- Sin acceso libre al resto de la red.

### VLAN 30

- Servicios internos: DNS, MQTT, Home Assistant, PXE, monitorización auxiliar.
- Red de soporte para infraestructura crítica.

### VLAN 40

- IoT con política de mínimo privilegio.
- Solo puede hablar con DNS, NTP, MQTT y Home Assistant según reglas de firewall.

### VLAN 99

- Plano de control.
- Solo administración y monitorización.
- El acceso a switches y controladores debe residir aquí.

### VLAN 100

- Acceso remoto por VPN.
- Tráfico controlado según políticas.

## Reglas Clave

- VLAN 40 no debe tener salida libre a Internet.
- VLAN 40 no debe acceder a VLAN 1, 20 ni 99 salvo excepción documentada.
- VLAN 99 no debe mezclarse con tráfico de usuario.
- El gateway de cada VLAN es también el punto de control lógico de la segmentación.
