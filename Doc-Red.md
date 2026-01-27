# 

# 

Documentación de Infraestructura de Red

##  

# Tabla de contenido {#tabla-de-contenido .TOC-Heading}

[Introducción [3](#introducción)](#introducción)

[Arquitectura General de la Red
[4](#arquitectura-general-de-la-red)](#arquitectura-general-de-la-red)

[Diagrama de red general
[4](#diagrama-de-red-general)](#diagrama-de-red-general)

[Segmentación de la Red Doméstica
[4](#segmentación-de-la-red-doméstica)](#segmentación-de-la-red-doméstica)

[Equipos principales [6](#_Toc214144449)](#_Toc214144449)

[Dispositivos y Servicios
[7](#dispositivos-y-servicios)](#dispositivos-y-servicios)

[Seguridad y Firewall [8](#seguridad-y-firewall)](#seguridad-y-firewall)

[Monitorización y Alertas
[9](#monitorización-y-alertas)](#monitorización-y-alertas)

[Backup y Recuperación
[10](#backup-y-recuperación)](#backup-y-recuperación)

[Procesos y Procedimientos (SOP)
[11](#procesos-y-procedimientos-sop)](#procesos-y-procedimientos-sop)

[Bitácora de cambios [12](#bitácora-de-cambios)](#bitácora-de-cambios)

[Referencias y Recursos
[13](#referencias-y-recursos)](#referencias-y-recursos)

[**Cómo empezar** [14](#cómo-empezar)](#cómo-empezar)

##  

# Introducción

Este documento reúne toda la información técnica y operacional de la
infraestructura de red para facilitar la gestión, mantenimiento y
evolución. En este cubre toda la infraestructura como pueden ser
switches, routers, VLANs, servidores, servicios, etc.

Este documento va dirigido a tener documentada toda la infraestructura
de red de hogar, donde va dirigida a los administradores y personal de
soporte.

# Arquitectura General de la Red

## Diagrama de red general

## Segmentación de la Red Doméstica

#### Introducción

La segmentación de la red doméstica mediante VLANs es una práctica
esencial para mejorar la seguridad, la eficiencia y la gestión de los
dispositivos conectados. En una red no segmentada, todos los
dispositivos comparten el mismo espacio de comunicación, lo que puede
provocar problemas de congestión, dificultades para administrar los
equipos y aumentar el riesgo de accesos no autorizados.

Mediante la creación de VLANs se logra:

-   **Aislar dispositivos críticos o vulnerables**, como sistemas de
    alarma o dispositivos IoT, reduciendo posibles riesgos de seguridad.

-   **Optimizar el tráfico interno**, evitando interferencias entre
    dispositivos de alto consumo de ancho de banda y servicios
    esenciales.

-   **Facilitar la gestión de la red**, concentrando el acceso a equipos
    de administración en una VLAN específica.

-   **Preparar la red para futuros crecimientos o cambios**, permitiendo
    añadir nuevos servicios o dispositivos sin comprometer la estructura
    existente.

Esta sección detalla las VLANs configuradas en la red, incluyendo sus
rangos de direcciones IP, puertas de enlace y funciones específicas,
proporcionando una visión clara y organizada de la segmentación
implementada.

#### Justificación de la Segmentación

La segmentación de la red mediante VLANs no es solo una cuestión de
organización, sino una estrategia clave para **maximizar la seguridad,
la eficiencia y la gestión del tráfico**. Cada VLAN tiene un propósito
específico que responde a necesidades concretas de la red doméstica:

-   **Seguridad:** Separar dispositivos críticos o potencialmente
    vulnerables, como sistemas de alarma o equipos IoT, limita el
    alcance de posibles intrusiones y protege la información sensible.

-   **Optimización del tráfico:** Al aislar servicios de alto consumo de
    ancho de banda en VLANs específicas, se reduce la congestión en la
    red principal, garantizando un rendimiento estable para dispositivos
    esenciales.

-   **Gestión centralizada:** La VLAN de administración permite
    concentrar el acceso a routers, switches y otros dispositivos de
    red, facilitando la configuración, el monitoreo y la aplicación de
    políticas de seguridad.

-   **Escalabilidad y flexibilidad:** La estructura segmentada permite
    incorporar nuevos dispositivos o servicios sin afectar la
    operatividad de la red existente, ofreciendo un crecimiento
    controlado y seguro.

La combinación de estas medidas asegura que la red doméstica funcione de
manera eficiente, segura y preparada para futuras necesidades,
manteniendo al mismo tiempo un control claro sobre cada segmento de la
red.

#### Descripción de las VLAN

  ------------------------------------------------------------------------
  VLAN    Rango de red     Puerta de enlace     Descripción
  ------- ---------------- -------------------- --------------------------
  1       10.0.1.0/24      10.0.1.1             LAN

  2       10.0.2.0/29      10.0.2.1             Alarma

  20      10.0.20.0/24     10.0.20.1            DMZ

  30      10.0.20.0/24     10.0.30.1            Servidores

  40      10.0.20.0/24     10.0.30.1            IoT

  99      10.0.99.0/24     10.0.99.1            MNGMNT

  100     10.0.100.0/24    10.0.100.1           VPN
  ------------------------------------------------------------------------

##### VLAN 1 --- LAN (10.0.1.0/24, GW 10.0.1.1)

Segmento principal de la red, destinado a los dispositivos de uso
general. Proporciona acceso completo a los servicios internos y a
Internet. Actúa como red base para equipos de usuario y sistemas que
requieren conectividad amplia. El rúter gestiona el enrutamiento hacia
el resto de subredes y aplica las políticas estándar de salida.

##### VLAN 2 --- Alarma (10.0.2.0/29, GW 10.0.2.1)

Segmento aislado diseñado para alojar exclusivamente el dispositivo de
alarma. Utiliza un rango reducido para limitar la superficie de
exposición. Solo se permite el tráfico necesario para su funcionamiento
(principalmente comunicación saliente hacia los servidores del
proveedor). No se autoriza acceso a otros segmentos internos.

##### VLAN 20 --- DMZ (10.0.20.0/24, GW 10.0.20.1)

Subred destinada a servicios accesibles desde Internet. Su función es
aislar máquinas expuestas del resto de la infraestructura. El tráfico
entrante desde WAN termina aquí, aplicando reglas estrictas de control.
Las comunicaciones hacia otras VLAN se limitan a operaciones esenciales
definidas previamente.

##### VLAN 30 --- Servidores (10.0.30.0/24, GW 10.0.30.1)

Segmento destinado a servidores internos: almacenamiento, servicios
auxiliares, automatización y contenedores. La comunicación con esta VLAN
está restringida a redes autorizadas. Solo se permite tráfico
explícitamente definido para garantizar la integridad y estabilidad de
los servicios.

##### VLAN 40 --- IoT (10.0.40.0/24, GW 10.0.40.1)

Subred dedicada a dispositivos IoT. Su objetivo es aislar equipos con
firmware limitado o comportamiento de red impredecible. El acceso a
otras VLAN se restringe de forma estricta, permitiéndose únicamente
excepciones justificadas (por ejemplo, acceso a servicios concretos en
la VLAN de Servidores). El tráfico multicast y broadcast se controla
para evitar propagación innecesaria.

##### VLAN 99 --- Management (10.0.99.0/24, GW 10.0.99.1)

Red reservada para la administración de dispositivos de infraestructura
(switches, puntos de acceso, controlador, firewall, nodos Proxmox). Solo
se permite el acceso desde equipos autorizados. Se usa exclusivamente
para tareas de gestión y no aloja dispositivos de uso cotidiano. Aísla
el plano de control del resto de redes operativas.

##### VLAN 100 --- VPN (10.0.100.0/24, GW 10.0.100.1)

Segmento asignado a clientes conectados por VPN. Permite identificar y
controlar el tráfico procedente del exterior de la red local. Desde esta
VLAN se aplican políticas específicas que determinan qué recursos
internos son accesibles. Facilita el acceso remoto seguro a servicios
internos sin exponer la red completa.

#### Conclusión

La implementación de VLANs en la red doméstica permite mantener un
equilibrio entre seguridad, rendimiento y facilidad de gestión. Cada
segmento cumple una función específica, desde la LAN principal hasta la
VLAN de gestión y la red VPN, asegurando que los dispositivos críticos
estén protegidos y que el tráfico de la red se mantenga optimizado.

Esta estructura segmentada proporciona una **base sólida para la
administración de la red**, facilitando futuras expansiones y
adaptaciones sin comprometer la seguridad ni el rendimiento. La
documentación detallada de las VLANs, sus rangos de IP, puertas de
enlace y funciones asociadas, sirve como referencia clara para la
gestión cotidiana y para cualquier actualización o ampliación de la
infraestructura de red.

## 

## Dispositivos y Servicios

**Fecha de actualización:** 2026-01-03\
**Descripción:** Inventario y documentación de nodos, dispositivos y
servicios, con configuraciones clave, IPs, VLANs y funciones
principales.

### Resumen de Nodos

  ------------------------------------------------------------------------------------
  **Nodo**   **ID**   **Debian**   **Función         **Estado**     **Notas rápidas**
                                   principal**                      
  ---------- -------- ------------ ----------------- -------------- ------------------
  ZEUS       101      13.2         Controlador Omada 🟢 Actualizado Gestión de APs y
                                                                    switches

  ZEUS       102      13.2         Monitorización    🟢 Actualizado Uptime interno /
                                   servicios                        alertas

  ZEUS       103      13.2         Servidor DNS      🟢 Actualizado Zonas internas y
                                   principal                        externas

  ZEUS       202      13.2         Servidor web /    🟢 Actualizado Proxy inverso
                                   proxy inverso                    multi-dominio

  HERMES     104      13.2         Servidor CUPS     🟢 Actualizado Impresión en red

  HERMES     201      13.2         Zigbee2MQTT +     🟢 Actualizado Domótica y MQTT
                                   MQTT                             

  HERMES     203      13.2         Servidor DNS      🟢 Actualizado Redundancia DNS
                                   secundario                       
  ------------------------------------------------------------------------------------

### Detalle de Dispositivos y Servicios

##### Nodo ZEUS

  ---------------------------------------------------------------------------------------------------------------
  **Servicio**   **Modelo /   **Función /      **IP**         **VLAN / **Servicios que   **Estado**   **Notas**
                 Software**   Descripción**                   Red**    provee**                       
  -------------- ------------ ---------------- -------------- -------- ----------------- ------------ -----------
  Omada          Omada        Gestión          192.168.1.10   Admin 10 Gestión de APs,   🟢           
                 Controller   centralizada de                 / WiFi   SSIDs, VLANs                   
                              APs y switches                  20                                      

  Uptime Kuma    Uptime Kuma  Monitorización   192.168.1.20   Admin 10 Uptime y alertas  🟢           
                              de servicios                             (correo /                      
                              internos y                               Telegram)                      
                              externos                                                                

  NS1            BIND9        Servidor DNS     192.168.1.5    Admin 10 DNS interno y     🟢           
                              principal                                externo,                       
                                                                       resolución                     
                                                                       recursiva                      

  NPM            Nginx Proxy  Proxy inverso /  192.168.1.15   Admin 10 Proxy inverso,    🟢           
                 Manager      Servidor web                             HTTPS,                         
                                                                       redirección de                 
                                                                       dominios                       
  ---------------------------------------------------------------------------------------------------------------

##### Nodo HERMES

  -------------------------------------------------------------------------------------------------------------------
  **Dispositivo / **Modelo /    **Función /      **IP**         **VLAN / **Servicios que     **Estado**   **Notas**
  Servicio**      Software**    Descripción**                   Red**    provee**                         
  --------------- ------------- ---------------- -------------- -------- ------------------- ------------ -----------
  CUPS            CUPS 2.x /    Servidor de      192.168.1.30   Admin 10 Impresión en red,   🟢           
                  Debian 13.2   impresión en red                         administración de                
                                                                         trabajos                         

  Z2M             Zigbee2MQTT / Integración de   192.168.1.25   Admin 10 MQTT para domótica, 🟢           
                  Debian 13.2   dispositivos                             comunicación Zigbee              
                                Zigbee a MQTT                                                             

  NS2             Debian 13.2   Servidor DNS     192.168.1.6    Admin 10 DNS secundario,     🟢           
                                secundario                               redundancia y alta               
                                                                         disponibilidad                   
  -------------------------------------------------------------------------------------------------------------------

### Topología de Red

-   Todos los nodos ZEUS y HERMES conectados al switch principal de
    administración (VLAN 10)

-   Comunicación clave:

    -   DNS: ns1 ↔ ns2

    -   MQTT: z2m ↔ otros dispositivos Zigbee

    -   Proxy inverso: npm → acceso web interno/externo

-   **Recomendación en Word:** Insertar un diagrama simple usando
    "Insertar → Formas → Cuadros y flechas" o importar un PNG de
    Draw.io.

### Procedimientos y Notas

-   **Backups:**

    -   Omada → copia de configuración semanal

    -   NS1 / NS2 → backup de zonas DNS 24h

    -   Z2M → backup de topics MQTT y configuración Zigbee

-   **Actualizaciones:**

    -   Todos los nodos corren Debian 13.2 → revisar paquetes críticos
        semanalmente

-   **Resolución de problemas comunes:**

    -   Servicio caído → revisar logs /var/log/\[servicio\].log

    -   Problema de comunicación → revisar VLANs, IPs, firewall interno

-   **Dependencias:**

    -   NPM depende de NS1/NS2 para resolución de nombres

    -   Z2M depende de MQTT y de dispositivos Zigbee conectados

### Historial de Cambios

  ----------------------------------------------------------------------------
  **Fecha**    **Nodo /          **Cambio realizado**        **Responsable**
               Servicio**                                    
  ------------ ----------------- --------------------------- -----------------
  2026-01-03   ZEUS / Omada      Actualización a Debian 13.2 Alejandro

  2026-01-03   HERMES / Z2M      Añadido nuevo topic MQTT    Alejandro
  ----------------------------------------------------------------------------

# Seguridad y Firewall

-   Políticas implementadas.

-   Reglas de firewall principales.

-   Segmentación y control de acceso.

# Monitorización y Alertas

-   Herramientas usadas (Uptime Kuma, Prometheus, etc.).

-   Procedimientos para monitorizar servicios y equipos.

##  

# Backup y Recuperación

-   Estrategias de backup.

-   Procedimientos para recuperación ante fallos.

# Procesos y Procedimientos (SOP)

-   Procedimientos estándar para cambios, actualizaciones, incidencias.

# Bitácora de cambios

-   Listado de RFCs implementados y en curso.

-   Historial de cambios en la infraestructura.

# Referencias y Recursos

-   Documentación oficial de equipos y software.

-   Enlaces a repositorios, scripts, y manuales internos.

### **Cómo empezar**

1.  **Reúne toda la información básica:** inventario de equipos,
    esquemas de red, configuraciones actuales.

2.  **Crea diagramas visuales:** usa herramientas como draw.io,
    diagrams.net o cualquier software de diagramas.

3.  **Escribe resúmenes claros para cada sección.\
    **

4.  **Documenta procedimientos y scripts importantes.\
    **

5.  **Mantén la documentación viva:** revisa y actualiza regularmente.
