# SOP — Alta/Baja de Dispositivos Zigbee (Zigbee2MQTT + Home Assistant)

**Ámbito:** Dispositivos Zigbee integrados vía Zigbee2MQTT y Home Assistant.  
**Objetivo:** Añadir o retirar dispositivos Zigbee con trazabilidad, naming consistente y validación funcional.

## 1) Preparación

- Verificar cobertura Zigbee y estado del coordinador.
- Confirmar que el dispositivo está soportado por Zigbee2MQTT.
- Definir nombre y área en Home Assistant antes de emparejar.
- Tener el punto de instalación accesible (caja, mecanismo, sensor).

## 2) Emparejamiento en Zigbee2MQTT

- Poner Zigbee2MQTT en modo `permit join`.
- Emparejar el dispositivo siguiendo el método del fabricante.
- Esperar confirmación en Zigbee2MQTT y revisar `friendly_name`.
- Registrar el IEEE y el `network_address`.

## 3) Integración en Home Assistant

- Verificar que la entidad aparece en Home Assistant.
- Asignar área correcta y entidad con nombre claro.
- Configurar atributos relevantes (exposición, íconos, etc.).

## 4) Pruebas funcionales

- Validar control básico (on/off, estado, lectura).
- Verificar latencia y estabilidad de comunicación.
- Confirmar que el dispositivo responde desde la ubicación final.

## 5) Documentación

- Añadir el dispositivo en inventario general (IEEE, nombre, ubicación).
- Si aplica, actualizar `Doc-Red/Servicios.md` (Zigbee2MQTT).
- Referenciar el cambio en RFC o MTN según corresponda.

## 6) Baja / Retirada

- Eliminar el dispositivo desde Zigbee2MQTT y Home Assistant.
- Restablecer el dispositivo a valores de fábrica si se reutiliza.
- Actualizar inventario y documentación.

## 7) Rollback rápido

- Deshabilitar automatizaciones afectadas.
- Volver al dispositivo anterior si existía reemplazo.
- Revertir cambios de naming en HA si se necesita.
