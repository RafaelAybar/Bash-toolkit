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
6 Conexiones remotas
7 Instalación y comprobación de servicios DNS, DHCP y emisión de certificados
8 Monitorización de procesos.
9 Configurar tarjeta de red primaria
10 Salir
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
	9)echo "Introduce los parámetros para configurar la tarjeta de red primaria en este orden"
		echo "1º tarjeta de red 2º red 3º IP de la máquina 4º puerta de enlace 5º máscara de red 6º servidores DNS 7º dominio"
	read parametros
	if [ -z $parametros ]
		then
			echo "Debes introducir los parámetros que sean necesarios"
			exit
	else
		./configred.sh $parametros
	fi
		;;
	10) echo "Hasta luego"
        exit;;
    *) echo "Introduce una opción válida"
  esac
done
