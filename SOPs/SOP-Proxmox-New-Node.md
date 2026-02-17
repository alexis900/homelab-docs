# SOP — Instalación de un Nuevo Nodo Proxmox

**Ámbito:** Despliegue de un nodo Proxmox VE nuevo en el clúster existente.  
**Objetivo:** Instalar, configurar e integrar un nuevo nodo minimizando riesgos y con trazabilidad.

## 1) Planificación y prerequisitos

- Confirmar ventana de mantenimiento y comunicar impacto si aplica.
- Definir nombre del nodo (mitología griega), IP, VLAN y rol (p. ej. cómputo, storage, edge).
- Verificar compatibilidad de hardware (CPU con VT-x/AMD-V, RAM, NICs, storage).
- Preparar ISO oficial de Proxmox VE y checksum validado.
- Confirmar acceso físico o remoto (KVM/IPMI) y credenciales.

## 2) Preparación de hardware y BIOS/UEFI

- Actualizar firmware/BIOS a versión estable recomendada.
- Activar virtualización (VT-x/AMD-V) y, si aplica, IOMMU.
- Configurar orden de arranque para ISO.
- Validar configuración RAID/almacenamiento (ZFS, hardware RAID o LVM).

## 3) Instalación de Proxmox VE

- Instalar PVE desde ISO.
- Configurar `hostname` y dominio: `nombre.home.arpa`.
- Asignar IP estática y gateway en la VLAN de gestión (VLAN 99).
- Configurar DNS interno correcto.
- Establecer password seguro de `root`.

## 4) Post-instalación base

- Actualizar sistema: `apt update && apt dist-upgrade`.
- Verificar repositorios **community** (sin licencia).
- Configurar NTP público (no hay NTP interno aún).
- Validar conectividad: gateway, DNS, acceso web UI y SSH.

## 5) Red y bridge

- Configurar `vmbr0` para la VLAN de gestión.
- Crear bridges adicionales según diseño (LAN, IoT, DMZ, etc.).
- Verificar MTU, VLAN tagging y trunking con el switch.

## 6) Almacenamiento

- Crear pools ZFS o storage LVM según estándar.
- Registrar datastores en el nodo (local, NFS, PBS, etc.).
- Validar rendimiento básico con `pveperf`.

## 7) Integración en clúster

- Desde el nodo maestro, ejecutar `pvecm add <IP_nuevo_nodo>`.
- Verificar estado del clúster: `pvecm status`.
- Validar sincronización de configuración y certificados.

## 8) Seguridad y acceso

- Configurar acceso SSH con claves (si aplica).
- Revisar firewall del nodo y reglas del clúster.
- Verificar acceso a la UI solo desde VLAN de gestión.

## 9) Monitorización y backups

- Registrar el nodo en Uptime Kuma o herramienta de monitorización.
- Verificar integración con PBS (`pbs.home.arpa`) si aplica.
- Configurar alertas críticas (CPU, RAM, disco, SMART).

## 10) Validaciones finales

- Nodo visible y saludable en el clúster.
- Red y almacenamiento operativos.
- Acceso web/SSH correcto desde VLAN de gestión.
- Sin errores críticos en logs (`journalctl`, `pve-cluster`, `pvedaemon`).

## 11) Documentación

- Añadir el nodo en `Doc-Red/Servicios.md` y `Doc-Red/Dispositivos.md`.
- Registrar IPs, VLANs, roles y hardware.
- Crear RFC o MTN si corresponde.

## 12) Rollback / contingencia

- Si falla la unión al clúster: eliminar nodo (`pvecm delnode`) y revisar red/DNS.
- Si falla storage: revertir a configuración base y revalidar discos.
- Mantener el nodo aislado hasta resolver incidentes.
