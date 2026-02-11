# Homelab Docs

Documentación versionada del homelab: cambios (RFC), mantenimientos (MTN), incidentes (INC) y estado de la red (Doc-Red).

---

## Estructura

```text
homelab-docs/
├── Doc-Red.md             # Índice de la documentación de red (enlaza a secciones)
├── Doc-Red/               # Secciones individuales (Arquitectura, VLANs, Seguridad, etc.)
├── scripts/               # Utilidades locales (ej. build-doc-red.sh)
├── templates/             # Plantillas RFC, MTN, INC
├── rfc/                   # Requests for Change (propuestas/completadas)
├── mtn/                   # Mantenimientos (planificados/completados)
└── inc/                   # Incidentes
```

---

## Flujos principales

- **RFC** (`rfc/`): Proponer y ejecutar cambios mayores. Usar `templates/RFC.md`.
- **MTN** (`mtn/`): Mantenimientos rutinarios. Usar `templates/MTN.md`.
- **INC** (`inc/`): Incidentes y post-mortems. Usar `templates/INC.md`.
- **Doc-Red** (`Doc-Red/`): Estado vivo de la red (VLANs, dispositivos, servicios, reglas). Editar secciones específicas para evitar un único fichero grande.

### SOPs rápidos
- [SOP-CT-Proxmox](SOPs/SOP-CT-Proxmox.md) — despliegue/actualización de contenedores en Hermes.
- [SOP-VLAN](SOPs/SOP-VLAN.md) — alta/cambio de VLAN en OPNsense + switches.
- [SOP-TLS-Certs](SOPs/SOP-TLS-Certs.md) — gestión de certificados TLS en NPM y servicios internos.
- [SOP-Incident-Red](SOPs/SOP-Incident-Red.md) — respuesta rápida a incidentes de red.

---

## Generar documento completo de red

Para obtener un único markdown combinado desde las secciones:

```bash
./scripts/build-doc-red.sh            # genera Doc-Red-full.md
./scripts/build-doc-red.sh salida.md  # opcional, nombre personalizado
```

El script valida que existan todas las secciones y coloca separadores `---` entre ellas.

---

## Hook opcional (pre-commit)

Para regenerar automáticamente `Doc-Red-full.md` cuando cambies cualquier archivo de `Doc-Red/` o `Doc-Red.md`:

```bash
ln -s ../../scripts/hooks/pre-commit-doc-red.sh .git/hooks/pre-commit
```

El hook reconstruye `Doc-Red-full.md` y lo vuelve a añadir al índice si cambió.

---

## Notas

- Mantén sincronizado `Doc-Red.md` si se añaden nuevas secciones o SOPs.
- Los SOP siguen viviendo en `SOPs/` y se referencian desde `Doc-Red/Procedimientos.md`.
- Commits: agrupa cambios por tema (ej. “docs: actualizar VLANs y reglas”).
