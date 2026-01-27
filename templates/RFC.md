---
rfc: RFC-YYYY-NNNN-TIPO
titulo: Título corto y descriptivo del cambio
tipo: NET | SYS | APP | SEC | HW
estado: Propuesta | En curso | Completada | Cancelada
criticidad: Baja | Media | Alta
fecha: YYYY-MM-DD
autor: Alejandro Martín Pérez
---

# RFC — {{ titulo }}

## Resumen

Descripción breve del cambio que se va a realizar.

---

## Motivación

¿Por qué se realiza este cambio?

- Mejora funcional
- Seguridad
- Mantenimiento mayor
- Cambio arquitectural

---

## Justificación de criticidad

Explicación del impacto potencial en caso de fallo.

---

## Sistemas / Dispositivos afectados

- Servidores / CTs / VMs
- Servicios
- Infraestructura de red

---

## Plan de acción

Pasos detallados para ejecutar el cambio:

1. Backup completo
2. Snapshot previo
3. Detención de servicios
4. Aplicación del cambio
5. Verificaciones
6. Tests funcionales
7. Backup post-cambio

---

## Riesgos

- Riesgo 1
- Riesgo 2

---

## Mitigación

Acciones para reducir o controlar los riesgos.

---

## Plan de rollback

Pasos claros para volver al estado anterior:

1. Detener servicio actualizado
2. Restaurar snapshot / backup
3. Verificar funcionamiento
4. Validar conectividad

---

## Validaciones post-cambio

- [ ] Servicios accesibles
- [ ] Sistemas en línea
- [ ] Configuraciones aplicadas
- [ ] Logs sin errores críticos
- [ ] Backup realizado

---

## Resultado

(Completar tras ejecutar el cambio)

---

## Observaciones

Notas adicionales o lecciones aprendidas.

---

## Firma

**{{ autor }}** — {{ fecha }}
