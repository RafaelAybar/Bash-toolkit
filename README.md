# Bash-toolkit
## Proyecto realizado por Rafael Aybar Segura, curso 2017-2018, IES AL-ANDALUS
Este proyecto es un conjunto de herramientas para sysadmin para servidores con sistema opertativo Ubuntu server 16.04 o superior con las siguientes funcionalidades

-    Copias de seguridad y automatización de tareas.
-    Obtención de información de base de datos MySQL.
-    Gestión de usuarios y permisos.
-    Conexiones remotas.
-    Gestión de discos.
    ADVERTENCIA: No me hago responsable de la pérdida de datos ni de las consecuencias que pueda acarrear el mal uso de estos scripts.
    - Incluye:
        - Obtención de información de los discos del sistema.
        - Cifrado de particiones/discos.
        - Borrado seguro de archivos (Esta opción puede degradar bastante su disco SSD debido a los procesos de sobreescritura).
        - Creación y eliminación de particiones.

-    Instalación de sistemas operativos en pendrive.
-    Monitorización de procesos.
-    Configuración de tarjetas de red:
 
        NOTA: El script configurará la tarjeta de red principal y deberá ejecutarse de la siguiente manera, siguiendo el orden de los parámetros de forma rigurosa:
        ./configred.sh nombre-de-la-tarjeta-de-red red ip-de-la-máquina puerta-de-enlace máscara servidores-dns dominio
        Ejemplo:
        ./configred.sh enp0s3 192.168.209.0 192.168.209.45 192.168.209.1 255.255.255.0

-    Servicios DNS, DHCP, emisión de certificados, y combrobación del estado de los mismos

### Requerimientos:
* Bash
* Python 3.5 o superior
