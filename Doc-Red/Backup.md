# Backup y Recuperación

## Estrategia de Backups

| Componente | Frecuencia | Método | Ubicación | RPO |
|-----------|-----------|--------|-----------|------|
| Proxmox CTs | Semanal | Snapshot | Storage local | 7 días |
| Configuración Firewall | Mensual | Exportación | Repositorio git | 30 días |
| Zonas DNS | Diaria | Backup de ficheros | Proxmox storage | 1 día |
| UniFi OS | Semanal | Exportación config | Storage local | 7 días |

## Procedimiento de Recuperación

1. **Identificar componente afectado**
2. **Localizar último backup válido**
3. **Restaurar según procedimiento** (CT snapshot, exportación, etc.)
4. **Validar funcionamiento** (ping, SSH, servicios)
5. **Documentar en RFC si es cambio** o en INC si es incidente
