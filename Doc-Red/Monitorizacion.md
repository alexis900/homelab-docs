# Monitorización y Alertas

## Herramientas

| Herramienta | Uso |
|---|---|
| Uptime Kuma | Monitorización de HTTP, HTTPS, ping y TCP |
| Logs del sistema | Revisión de errores y eventos |
| Alertas | Correo y Telegram |

## Servicios Críticos

- DNS NS1 y NS2.
- OPNsense.
- Proxmox Zeus y Hermes.
- Home Assistant.
- NPM.
- Conectividad WAN.

## Flujo de Alertas

1. Se detecta la caída o degradación.
2. Se notifica al canal configurado.
3. Se verifica el alcance real.
4. Se aplica mitigación.
5. Se documenta en INC si hay impacto.

## Criterio Práctico

- Un monitor útil debe avisar antes de que el usuario lo note.
- Si un servicio es crítico, debe tener monitorización explícita y no depender solo de revisión manual.
