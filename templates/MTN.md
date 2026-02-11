---
mnt: MTN-YYYY-NNNN-TIPO
titulo: Tarea de mantenimiento
tipo: NET | SYS | APP | SEC | HW
estado: Planificado | Ejecutado | Fallido
criticidad: Baja | Media
fecha: YYYY-MM-DD
autor: Alejandro Martín Pérez
---

# MTN — {{ titulo }}

## Descripción

Descripción breve de la tarea de mantenimiento.

---

## Sistemas afectados

- Servicio / Host / Contenedor

---

## Acciones realizadas

- Actualización de paquetes
- Reinicio de servicios
- Limpieza / ajustes menores
- Cambios DNS: `<host>` `<tipo>` `<destino>` (motivo) — Inventario sync en `Doc-Red/Servicios.md`

---

## Validaciones

- [ ] Servicio operativo
- [ ] Logs sin errores
- [ ] Conectividad correcta
- [ ] DNS resuelve (`dig <host> @ns1/ns2`) y servicio ok

---

## Resultado

Resultado final del mantenimiento.

---

## Observaciones

Notas breves si aplica.

---

## Firma

**{{ autor }}** — {{ fecha }}
