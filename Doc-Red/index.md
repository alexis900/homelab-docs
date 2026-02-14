# Documentación de Infraestructura de Red

**Última actualización:** 11 de febrero de 2026  
**Responsable:** Alejandro Martín Pérez

---

## Introducción

Este índice reúne y enlaza toda la documentación técnica y operacional de la infraestructura de red. Usa los enlaces siguientes para editar o consultar cada ámbito sin manejar un único fichero gigante.

---

## Estructura de Documentos

- [Arquitectura General](Arquitectura.md)
- [Segmentación de VLANs](VLANs.md)
- [Dispositivos de Infraestructura](Dispositivos.md)
- [Servicios y Contenedores](Servicios.md)
- [Seguridad y Firewall](Seguridad.md)
- [Monitorización y Alertas](Monitorizacion.md)
- [Backup y Recuperación](Backup.md)
- [Procedimientos (SOP) e Incidentes](Procedimientos.md)
- [Historial de Cambios](Cambios.md)
- [Contacto y Referencias](Contacto.md)

---

## Notas de Uso

- Mantén este índice sincronizado si se añaden nuevas secciones o ficheros.
- Las tablas de VLANs, inventario de servicios y reglas de firewall ahora viven en sus archivos dedicados (enlaces arriba).
- Los SOP siguen en `SOPs/` y se referencian desde la sección de Procedimientos.
- El workflow CI `doc-red-consistency` verifica que `Doc-Red/Doc-Red-full.md` esté regenerado en cada push/PR.

---

**Próxima revisión programada:** 28 de febrero de 2026
