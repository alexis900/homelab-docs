# Backup y Recuperación

## Estrategia

| Componente | Frecuencia | Método | Ubicación | RPO |
|---|---|---|---|---|
| CTs Proxmox | Semanal | Snapshot | Almacenamiento local | 7 días |
| Firewall OPNsense | Post-cambio | Exportación | Git y backup externo | 30 días |
| Zonas DNS | Diaria | Ficheros | Proxmox storage | 1 día |
| UniFi OS | Semanal | Exportación de config | Almacenamiento local | 7 días |

## Recuperación

1. Identificar qué ha fallado.
2. Buscar el último backup válido.
3. Restaurar con el método apropiado.
4. Validar conectividad y servicios.
5. Registrar el resultado en RFC o INC según corresponda.

## Regla Simple

- Si el cambio rompe algo, primero vuelve al último estado bueno.
- Si el backup no se puede restaurar, el problema no está resuelto.
