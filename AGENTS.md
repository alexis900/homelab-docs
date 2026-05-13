# AGENTS.md

## General

- Trabaja sobre el estado actual del repositorio y no reviertas cambios existentes salvo que el usuario lo pida.
- Usa `apply_patch` para editar archivos cuando hagas cambios manuales.
- Prefiere comandos no interactivos y evita operaciones destructivas.
- Si hay cambios previos no relacionados, ignóralos salvo que bloqueen la tarea.
- Cuando el usuario pida "subir" o "actualizar" documentación, deja el árbol coherente antes de cerrar la tarea.

## Documentación

- `Doc-Red/` es la documentación principal y operativa.
- `Doc-Red/legacy/` es un archivo histórico o de referencia.
- Si cambias archivos de `Doc-Red/`, ejecuta:

```bash
./scripts/build-doc-red.sh
```

- Si el build falla, corrige la causa antes de terminar.

## RFC / MTN / INC

- Usa las carpetas `rfc/`, `mtn/` e `inc/` para cambios mayores, mantenimientos e incidentes.
- Mantén el historial y la documentación principal alineados cuando un cambio afecte al estado real del entorno.
- Si un mantenimiento o cambio toca servicios de `Doc-Red`, actualiza también el inventario o la sección correspondiente.

## Estilo

- Mantén los cambios ajustados al alcance pedido.
- Prefiere claridad sobre abstracción extra.
- Conserva el tono y la estructura del repositorio cuando edites documentación existente.
