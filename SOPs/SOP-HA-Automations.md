# SOP — Gestión de Automatizaciones en Home Assistant

**Ámbito:** Automatizaciones en Home Assistant.  
**Objetivo:** Crear, modificar o retirar automatizaciones con pruebas controladas y rollback sencillo.

## 1) Preparación

- Definir objetivo y comportamiento esperado.
- Identificar entidades implicadas y dependencias.
- Verificar que no hay automatizaciones duplicadas que entren en conflicto.

## 2) Implementación

- Crear o editar la automatización en HA.
- Configurar `trigger`, `condition` y `action` con nombres claros.
- Guardar con estado inicial `disabled` si es un cambio de riesgo.

## 3) Pruebas

- Ejecutar manualmente desde HA para validar acciones.
- Revisar `trace` y `logbook` para confirmar ejecución.
- Ajustar condiciones o acciones si hay comportamientos no deseados.

## 4) Activación y monitorización

- Activar la automatización.
- Supervisar el primer ciclo real (tiempo/condición real).
- Revisar logs tras 24h para confirmar estabilidad.

## 5) Documentación

- Registrar cambios en RFC si afectan a servicios o zonas críticas.
- Actualizar inventario de automatizaciones si existe catálogo.

## 6) Rollback

- Desactivar la automatización.
- Revertir a la versión anterior (si existe backup o YAML previo).
- Validar que el comportamiento vuelve al estado esperado.
