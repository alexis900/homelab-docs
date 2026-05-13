# Homelab Docs

Documentación versionada del homelab: cambios (RFC), mantenimientos (MTN), incidentes (INC) y estado de la red.

---

## Estructura

```text
homelab-docs/
├── Doc-Red/               # Documentación principal y operativa
│   └── legacy/            # Fuente canónica del homelab
├── scripts/               # Utilidades locales (ej. build-doc-red.sh)
├── templates/             # Plantillas RFC, MTN, INC
├── rfc/                   # Requests for Change (propuestas/completadas)
├── mtn/                   # Mantenimientos (propuestas/en-progreso/completadas)
├── inc/                   # Incidentes
└── SOPs/                  # Standard Operating Procedures
```

---

## Acceso Rápido

- [🚀 **ÍNDICE PRINCIPAL**](Doc-Red/legacy/00_INDICE.md)

- **RFC** (`rfc/`): Proponer y ejecutar cambios mayores. Usar `templates/RFC.md`.
- **MTN** (`mtn/`): Mantenimientos rutinarios. Usar `templates/MTN.md`.
- **INC** (`inc/`): Incidentes y post-mortems. Usar `templates/INC.md`.
- **Doc-Red** (`Doc-Red/legacy/`): documentación principal y operativa.

### SOPs rápidos

- [SOP-CT-Proxmox](SOPs/SOP-CT-Proxmox.md) — despliegue/actualización de contenedores en Hermes.
- [SOP-Proxmox-New-Node](SOPs/SOP-Proxmox-New-Node.md) — instalación de un nuevo nodo Proxmox.
- [SOP-VLAN](SOPs/SOP-VLAN.md) — alta/cambio de VLAN en OPNsense + switches.
- [SOP-TLS-Certs](SOPs/SOP-TLS-Certs.md) — gestión de certificados TLS en NPM y servicios internos.
- [SOP-Incident-Red](SOPs/SOP-Incident-Red.md) — respuesta rápida a incidentes de red.

---

## Generar documento completo de red

Para obtener un único markdown combinado desde la documentación legacy:

```bash
./scripts/build-doc-red.sh                               # genera Doc-Red/legacy/Doc-Red-full.md
./scripts/build-doc-red.sh Doc-Red/legacy/Doc-Red-full.md  # opcional, nombre personalizado
```

El script valida que existan todas las secciones legacy y coloca separadores `---` entre ellas.

---

## Hook opcional (pre-commit)

Para regenerar automáticamente `Doc-Red/legacy/Doc-Red-full.md` cuando cambies cualquier archivo de `Doc-Red/legacy/`:

```bash
ln -s ../../scripts/hooks/pre-commit-doc-red.sh .git/hooks/pre-commit
```

El hook reconstruye `Doc-Red/legacy/Doc-Red-full.md` y lo vuelve a añadir al índice si cambió.

---

## Notas

- Mantén sincronizado `Doc-Red/legacy/00_INDICE.md` si cambian secciones, servicios o rutas.
- Los SOP siguen viviendo en `SOPs/` y se referencian desde `Doc-Red/legacy/Procedimientos.md`.
- Commits: agrupa cambios por tema (ej. “docs: actualizar VLANs y reglas”).
