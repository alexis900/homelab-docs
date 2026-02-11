---
rfc: RFC-YYYY-NNNN-TIPO
titulo: {{ titulo breve y claro }}
tipo: NET | SYS | APP | SEC | HW | IOT | DOC | OTHER
estado: Propuesta | En curso | Completada | Cancelada
criticidad: Baja | Media | Alta
fecha: YYYY-MM-DD
autor: {{ nombre }}
---

# RFC — {{ titulo }}

## Resumen

Breve descripción del cambio y objetivo principal.

## Motivación

- Razón/es del cambio (seguridad, disponibilidad, funcionalidad, coste, etc.).
- Impacto esperado si NO se realiza.

## Alcance / Sistemas afectados

- Servicios / hosts / VLANs / usuarios involucrados.
- Dependencias y áreas excluidas.

## Plan de acción

1. Paso 1
2. Paso 2
3. Paso 3

> Ajusta la granularidad según la complejidad; incluye backups y checkpoints si aplican.

## Riesgos

- Riesgo 1 (probabilidad/impacto)
- Riesgo 2

## Mitigación

- Medida 1 (qué reduce y cómo)
- Medida 2

## Plan de rollback

1. Acción de reversión 1
2. Acción de reversión 2

## Validaciones post-cambio

- [ ] Servicio/s responden según esperado
- [ ] Logs sin errores relevantes
- [ ] Monitorización sin alertas
- [ ] Pruebas específicas (ej. API, UI, rendimiento)

## Cambios DNS (si aplica)

- Entrada: `<host>` `<tipo>` `<destino>` (motivo: <razón>)
- Validación: `dig <host> @ns1` / servicio accesible
- Inventario actualizado en `Doc-Red/Servicios.md`

## Resultado (completar al cerrar)

- Estado final, fechas, duración, incidencias.

## Observaciones

Notas adicionales, pendientes, deudas técnicas.

## Firma

**{{ autor }}** — {{ fecha }}
