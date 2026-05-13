#!/usr/bin/env bash
# Concatenate Doc-Red files into a single Markdown file.
# Usage: scripts/build-doc-red.sh [output-file]

set -euo pipefail

out_file="${1:-Doc-Red/Doc-Red-full.md}"

parts=(
  "Doc-Red/00_INDICE.md"
  "Doc-Red/Arquitectura.md"
  "Doc-Red/VLANs.md"
  "Doc-Red/Servicios.md"
  "Doc-Red/Seguridad.md"
  "Doc-Red/Procedimientos.md"
  "Doc-Red/Backup.md"
  "Doc-Red/Monitorizacion.md"
  "Doc-Red/Contacto.md"
  "Doc-Red/Cambios.md"
  "Doc-Red/Dispositivos.md"
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
