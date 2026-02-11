---
rfc: RFC-2025-0012-NET
titulo: Migración de la gestión del switch a VLAN 99 y solución de pérdida de comunicación
tipo: NET
estado: Completada
criticidad: Media
fecha: 2025-08-08
autor: Alejandro Martín Pérez
---

# RFC — Migración de la gestión del switch a VLAN 99 y solución de pérdida de comunicación

## Resumen

Se migró la interfaz de gestión del switch principal (TP-Link TL-SG2008) desde la VLAN 1 a la VLAN 99. Durante el proceso se resolvió una pérdida de comunicación provocada por el no aprendizaje de la MAC de OPNsense en la tabla ARP/MAC del switch. La administración remota funciona correctamente en la nueva VLAN sin incidencias mayores.

---

## Motivación

- Mejorar la seguridad y administración de la red separando la VLAN de gestión del switch del resto del tráfico.  
- Segmentar la infraestructura crítica de administración de la red de la red de usuarios.  
- Reducir riesgo de accesos no autorizados a la gestión del switch.

---

## Justificación de criticidad

El cambio afecta a la administración de la red doméstica. Un fallo podría dejar inaccesible el switch y afectar la gestión de servidores, VLANs y servicios conectados a él.

---

## Sistemas / Dispositivos afectados

- Switch principal: TP-Link TL-SG2008  
- VLAN 1 y VLAN 99  
- Router OPNsense  
- Puertos del switch conectados a servidores y PCs

---

## Plan de acción

1. Crear VLAN 99 en el switch y en OPNsense.  
2. Configurar puerto troncal entre switch y OPNsense para VLANs 1 y 99.  
3. Configurar puertos finales como untagged en su VLAN correspondiente.  
4. Cambiar la interfaz de gestión del switch a la VLAN 99.  
5. Eliminar VLAN 1 de los puertos de gestión.  
6. Detectar la pérdida de comunicación temporal.  
7. Generar tráfico con ping desde un PC hacia OPNsense para actualizar las tablas ARP/MAC.  
8. Confirmar acceso y comunicación estable.  
9. Documentar la configuración final.

---

## Cambios DNS (si aplica)

- Entrada: `<host>` `<tipo>` `<destino>` (motivo: <razón>)
- Validación: `dig <host> @ns1` / servicio accesible
- Inventario actualizado en `Doc-Red/Servicios.md`

---

## Riesgos

- Pérdida temporal de acceso al switch.  
- Conflictos en la configuración de VLANs o etiquetado.  
- Impacto en la administración remota si falla el aprendizaje de MAC.

---

## Mitigación

- Realizar pruebas previas en entorno controlado.  
- Mantener conexión física directa al switch para recuperación manual.  
- Uso de ping para forzar aprendizaje de MAC y evitar entradas ARP estáticas.  
- Documentar cada cambio para rápida reversión si fuera necesario.

---

## Plan de rollback

1. Conexión física directa al switch.  
2. Restaurar configuración previa de VLANs y gestión en VLAN 1.  
3. Verificar acceso al switch desde la red de administración.  
4. Validar conectividad de servidores y clientes conectados al switch.

---

## Validaciones post-cambio

- [x] Servicios accesibles  
- [x] Sistemas en línea  
- [x] Configuraciones aplicadas  
- [x] Logs sin errores críticos  
- [x] Backup realizado

---

## Resultado

La migración de la gestión del switch a VLAN 99 se completó con éxito. Se solucionó la pérdida de comunicación al forzar el aprendizaje de la MAC de OPNsense mediante ping desde un PC hacia el router. La administración del switch funciona correctamente en la nueva VLAN sin interrupciones mayores.

---

## Observaciones

- Mantener monitoreo continuo de la VLAN 99 para asegurar estabilidad.  
- Considerar documentar futuros cambios de VLAN en manual interno para referencia.

---

## Firma

**Alejandro Martín Pérez** — 2025-08-08
