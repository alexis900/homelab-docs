#!/usr/bin/env bash
# Generate/update an incident MD from Uptime Kuma exec notification.
# Usage (from Kuma Exec):
#   /home/amartinper/homelab-docs/scripts/inc-from-kuma.sh \
#     "{{monitor_name}}" "{{monitor_url}}" "{{monitor_status}}" "{{incident_time}}"
#
# monitor_status: "up" | "down" | "unknown"
# incident_time: ISO string or epoch (Kuma sends ISO). We store only time (HH:MM) for timeline.
#
# Behavior:
# - On "down": create a new INC file (if none open for this monitor) with estado=Abierto.
# - On "up": mark existing open INC for this monitor as Resuelto y set fecha_fin.
# - INC files live in inc/INC-YYYY-NNNN.md using templates/INC.md structure (simplified fill).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INC_DIR="$ROOT/inc"
TEMPLATE="$ROOT/templates/INC.md"

monitor_name="${1:-}"
monitor_url="${2:-}"
monitor_status="${3:-}"
incident_time="${4:-}"

if [[ -z "$monitor_name" || -z "$monitor_status" ]]; then
  echo "Usage: $0 <monitor_name> <monitor_url> <monitor_status> <incident_time>" >&2
  exit 1
fi

now_date="$(date +%F)"
now_time="$(date +%H:%M)"
time_event="${incident_time:-$now_time}"

next_inc_id() {
  local last
  last=$(ls -1 "$INC_DIR"/INC-*.md 2>/dev/null | sed -E 's|.*INC-([0-9]{4})-([0-9]{4}).*|\\1\\2|' | sort | tail -n1 || true)
  if [[ -z "$last" ]]; then
    echo "0001"
  else
    printf "%04d" $((10#$last % 10000 + 1))
  fi
}

find_open_inc() {
  rg --files -g 'INC-*.md' "$INC_DIR" 2>/dev/null | while read -r f; do
    if grep -qi "^estado: Resuelto\\|^estado: Cerrado" "$f"; then
      continue
    fi
    grep -qi "$monitor_name" "$f" && echo "$f" && break
  done
}

ensure_template() {
  [[ -f "$TEMPLATE" ]] || { echo "Template not found: $TEMPLATE" >&2; exit 1; }
}

create_inc() {
  ensure_template
  local seq id file
  seq=$(next_inc_id)
  id="INC-$(date +%Y)-$seq"
  file="$INC_DIR/$id.md"
  cat >"$file" <<EOF
---
inc: $id
titulo: ${monitor_name} caído
tipo: NET
estado: Abierto
criticidad: Alta
fecha_inicio: $now_date $now_time
fecha_fin: 
autor: Alejandro Martín Pérez
---

# INC — ${monitor_name} caído

## Resumen

Alerta automática de Uptime Kuma: el monitor "${monitor_name}" está DOWN.

## Severidad e Impacto

- Severidad: Alta
- Impacto: servicio monitorizado inaccesible. URL: ${monitor_url}

## Línea temporal

- ${time_event} — Detección (Uptime Kuma)

## Causa raíz

Pendiente de análisis.

## Acciones realizadas

1. Pendiente

## Verificación

- [ ] Servicio/endpoint responde
- [ ] Logs sin errores relevantes
- [ ] Métricas/monitores en verde

## Lecciones aprendidas

- Pendiente

## Acciones posteriores

- [ ] Crear RFC/MTN si procede
- [ ] Actualizar documentación
- [ ] Ajustar monitorización/prevenir recurrencia

## Firma

**Alejandro Martín Pérez** — 
EOF
  echo "$file"
}

update_inc_up() {
  local file="$1"
  tmp="$(mktemp)"
  awk -v nowdate="$now_date" -v nowtime="$now_time" -v event="$time_event" '
    BEGIN {done_estado=0; done_fecha=0}
    /^estado:/ && !done_estado {print "estado: Resuelto"; done_estado=1; next}
    /^fecha_fin:/ && !done_fecha {print "fecha_fin: " nowdate " " nowtime; done_fecha=1; next}
    {print}
  ' "$file" >"$tmp"
  mv "$tmp" "$file"
  perl -0777 -i -pe "s|(## Línea temporal\\n\\n)(- .*D.*\\n)?|\\1- ${event} — Servicio restaurado (alerta UP)\\n|m" "$file"
}

main() {
  mkdir -p "$INC_DIR"
  if [[ "$monitor_status" =~ ^down$ ]]; then
    existing=$(find_open_inc || true)
    if [[ -z "$existing" ]]; then
      f=$(create_inc)
      echo "INC creada: $f"
    else
      echo "Ya existe INC abierta para $monitor_name: $existing"
    fi
  elif [[ "$monitor_status" =~ ^up$ ]]; then
    existing=$(find_open_inc || true)
    if [[ -n "$existing" ]]; then
      update_inc_up "$existing"
      echo "INC actualizada como resuelta: $existing"
    else
      echo "No se encontró INC abierta para $monitor_name; no se actualiza."
    fi
  else
    echo "Estado no manejado: $monitor_status" >&2
    exit 1
  fi
}

main "$@"
