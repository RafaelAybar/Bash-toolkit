#!/bin/bash
while true
do
  cat <<-EOF
cat <<-EOF
1	Comprobar procesos y rendimiento del sistema
2	Monitorizar un proceso específico
3	Eliminar un proceso específico
4	Salir
EOF
  read respuesta
  case $respuesta in
    1) 
        top;;

    2)
    echo "Introduce nombre o el pid del proceso a controlar"
    read idproceso
        if [ -z "$idproceso" ]
            then
                echo "debes introducir el nombre o pid del proceso"
        fi
        top | grep $idproceso
        ;;

    3)
    echo "Introduce el nombre del proceso a eliminar"
    read idproces
        if [ -z "$idproces" ]
            then
                echo "debes introducir el nombre o pid del proceso"
        fi
        id=$(pgrep $idproces)
        sudo kill $id
        ;;

    4)
    echo "Adiós"
        exit
        ;;
    *) echo "Introduce una opción correcta"
        exit
        ;;
    esac
done