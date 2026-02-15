# SOP — Cambios DNS Internos (BIND9)

**Ámbito:** Registros DNS internos gestionados por BIND9.  
**Objetivo:** Añadir o modificar registros DNS con validación y rollback seguro.

## 1) Preparación

- Identificar la zona a modificar (p.ej., `home.arpa`).
- Definir hostname, tipo de registro y destino.
- Verificar que no hay conflictos de nombres existentes.

## 2) Edición de zona

- Editar el fichero de zona correspondiente.
- Añadir o modificar el registro.
- Incrementar el `serial` de la zona.

## 3) Validación

- Ejecutar `named-checkzone <zona> <archivo>` en el servidor DNS.
- Recargar la zona o reiniciar el servicio BIND9.
- Validar resolución con `dig` desde VLANs relevantes.

## 4) Documentación

- Actualizar `Doc-Red/Servicios.md` en “Entradas DNS internas”.
- Registrar el cambio en RFC/MTN si aplica.

## 5) Rollback

- Revertir el cambio en el fichero de zona.
- Incrementar `serial` nuevamente.
- Recargar y validar que el registro vuelve al estado previo.
