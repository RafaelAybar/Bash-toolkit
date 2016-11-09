#!/bin/bash
while true
do
  cat <<-EOF
BASH TOOLKIT PARA SYSADMIN (EJECUTAR COMO ADMINISTRADOR)
1 Gestión de usuarios y grupos.
2 Copias de seguridad y automaticación de tareas.
3 Gestión de discos.
4 Instalación de isos en pendrive.
5 Conexión a bases de datos mysql (python 3.5.2)
6 Conexión remota
7 Instalación y comprobación de servicios DNS, DHCP y emisión de certificados
8 Monitorización de procesos.
9 Salir
EOF
  read respuesta

  case $respuesta in
    1) sh gestionusuarios.sh;;
    2) sh copiaseg.sh;;
    3) sh gestdisc.sh;;
    4) sh isos.sh;;
    5) echo enprogreso;;
    6) sh remoto.sh;;
    7) sh servicios.sh;;
    8) sh monit.sh;;
    9) echo "Hasta luego"
        exit;;
    *) echo "Introduce una opción válida"
  esac
done
