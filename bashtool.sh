#!/bin/bash
while true
do
  cat <<-EOF
BASH TOOLKIT PARA SYSADMIN (EJECUTAR COMO ADMINISTRADOR)
1 Gestión de usuarios y grupos.
2 Copias de seguridad y automaticación de tareas.
3 Gestión de discos.
4 Instalación de isos en pendrive.
5 Análisis de bases de datos
6 Instalación de servicios
7 Monitorización de procesos.
8 Instalación de Samba
9 Salir
EOF
echo "La configuración de red no se realiza en este menú"
  read respuesta

  case $respuesta in
	1) sh gestionusuarios.sh;;
	2) sh copiaseg.sh;;
	3) sh gestdisc.sh;;
	4) sh isos.sh;;
	5) python3 infobd.py;;
	6) sh servicios.sh;;
	7) sh gestionprocesos.sh;;
	8) sh installsamba.sh
		;;
	9) echo "Hasta luego"
        exit;;
    *) echo "Introduce una opción válida"
  esac
done
