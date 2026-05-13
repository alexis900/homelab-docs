#!/usr/bin/env bash
# Concatenate Doc-Red legacy files into a single Markdown file.
# Usage: scripts/build-doc-red.sh [output-file]

set -euo pipefail

out_file="${1:-Doc-Red/legacy/Doc-Red-full.md}"

parts=(
  "Doc-Red/legacy/00_INDICE.md"
  "Doc-Red/legacy/Arquitectura.md"
  "Doc-Red/legacy/VLANs.md"
  "Doc-Red/legacy/Servicios.md"
  "Doc-Red/legacy/Seguridad.md"
  "Doc-Red/legacy/Procedimientos.md"
  "Doc-Red/legacy/Backup.md"
  "Doc-Red/legacy/Monitorizacion.md"
  "Doc-Red/legacy/Contacto.md"
  "Doc-Red/legacy/Cambios.md"
  "Doc-Red/legacy/Dispositivos.md"
)

out_dir="$(dirname "$out_file")"
if [[ "$out_dir" != "." ]]; then
  mkdir -p "$out_dir"
fi

> "$out_file"

for file in "${parts[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Falta el fichero: $file" >&2
    exit 1
  fi

  # Separador legible entre secciones (excepto antes de la primera)
  if [[ "$file" != "${parts[0]}" ]]; then
    printf "\n\n---\n\n" >> "$out_file"
  fi

  cat "$file" >> "$out_file"
done

echo "Generado $out_file"
