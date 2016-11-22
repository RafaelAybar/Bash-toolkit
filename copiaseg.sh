#!/bin/bash
while true
do
  cat <<-EOF
MENÚ DE COPIAS DE SEGURIDAD
1	Copia manual de un directorio
2	Copia manual de un fichero
3	Añadir tareas a CRON
4	Ver lista de tareas automatizadas de CRON
5	Salir
EOF
  read respuesta

  case $respuesta in
    1)	echo "Introduzca el directorio de origen"
		read directorio
	echo "Introduzca la ruta de destino"
		read destino
			if [ -d $directorio ] && [ -d $destino ]
				then
					cp -r $directorio $destino
			else
				echo "Introduzca una ruta válida"
			fi;;
    2) echo "Introduzca el directorio de origen del fichero"
	read fichero
	echo "Introduzca la ruta de destino"
	read destinof
		if [ -f $fichero ] && [ -d $destinof ]
			then
				cp -r $fichero $destinof
		else
			echo "Se ha equivocado"5
		fi;;
    3) echo "Bienvenido a CRON"
	crontab -e;;
    4) echo "Lista de tareas activas:"
	crontab -l;;
    5) echo "Hasta luego"
	exit;;
    *) echo "Debe escoger una opción válida";;
  esac
done
