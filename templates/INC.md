---
inc: INC-YYYY-NNNN
titulo: Descripción corta del incidente
tipo: NET | SYS | APP | SEC | HW
estado: Abierto | En investigación | Mitigado | Resuelto | Cerrado
criticidad: Baja | Media | Alta | Crítica
fecha_inicio: YYYY-MM-DD HH:MM
fecha_fin: YYYY-MM-DD HH:MM
autor: Alejandro Martín Pérez
---

# INC — {{ titulo }}

## Resumen

Qué ha ocurrido, estado actual (Resuelto/Mitigado/En curso) y servicios afectados.

## Severidad e Impacto

- Severidad: Alta | Media | Baja | Crítica
- Impacto: servicios/usuarios afectados y duración aproximada.

## Línea temporal

- **HH:MM** — Detección (monitor/usuario)
- **HH:MM** — Acción inicial
- **HH:MM** — Causa identificada (si aplica)
- **HH:MM** — Mitigación
- **HH:MM** — Servicio restaurado

## Causa raíz

Explicación técnica; si pendiente, hipótesis y próximos pasos.

## Acciones realizadas

1. Acción 1
2. Acción 2

## Verificación

- [ ] Servicio/endpoint responde
- [ ] Logs sin errores relevantes
- [ ] Métricas/monitores en verde

## Lecciones aprendidas

- Mejora 1 (p.ej. hardening, capacity, alertas)

## Acciones posteriores

- [ ] Crear RFC/MTN si procede
- [ ] Actualizar documentación
- [ ] Ajustar monitorización/prevenir recurrencia

## Firma

**{{ autor }}** — {{ fecha_fin }}
