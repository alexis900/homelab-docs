# RFC-ID:

RFC-2025-0008-SRVNET

# Título:

Instalación del controlador Omada en la VLAN 99 y adopción del switch
core

# Tipo de cambio:

SRV / NET

# Fecha propuesta:

2025-08-01

# Estado:

Propuesta

# Criticidad:

Media

# Justificación de criticidad:

El cambio introduce un nuevo controlador de red y modifica la gestión
del switch principal, lo que puede afectar a la conectividad si no se
realiza correctamente.

# Resumen:

Se desplegará el controlador Omada en un contenedor LXC dentro de la
VLAN 99 y se procederá a adoptar el switch TP-Link TL-SG2008 para una
gestión centralizada.

# Motivación:

Establecer una plataforma de gestión unificada para la red doméstica,
con visibilidad, control y mantenimiento centralizado de switches y
puntos de acceso.

# Dispositivo(s) afectados:

-   Contenedor LXC: omada.home.arpa

-   VLAN 99 (infraestructura)\
    Switch TL-SG2008

-   Red de gestión

-   Servidor DNS interno (Pi-hole)

# Plan de acción:

-   Crear contenedor LXC (omada) en Proxmox con IP fija en la VLAN 99.

-   Instalar Omada Controller en dicho contenedor.\
    Comprobar conectividad desde Omada hacia el switch.\
    Acceder a la interfaz del switch y restaurar configuración de
    fábrica si es necesario.

-   Adoptar el switch desde Omada.

-   Verificar la correcta aparición del dispositivo y su gestión.

-   Realizar copia de seguridad de la configuración del controlador.

-   Registrar nombre DNS omada.home.arpa con IP estática en Pi-hole o
    Bind9

-   Documentar el cambio en el sistema de gestión.

# Riesgos:

-   Fallos de adopción del switch (por configuraciones previas o
    firmware).

-   Pérdida de conectividad si se aplica una configuración errónea.

-   Posibles reinicios del switch durante el proceso.

# Mitigación:

-   Realizar copia de seguridad previa del switch y del contenedor.

-   Ejecutar la adopción fuera de horas críticas.

-   Validar la configuración antes de aplicarla.

-   Documentar fallback manual (IP/usuario temporal) del switch.

# Resultado:

Adopción correctamente realizada.

Se tuvo que adoptar el switch estando en la VLAN1, y, en la propia
interfaz de Omada migrar a la VLAN99 para su correcta gestión.

# Firma:

Alejandro Martín Perez -- 2025-08-01
