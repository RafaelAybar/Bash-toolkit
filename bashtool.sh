#!/bin/bash

source funciones.sh

compruebaRoot

OPCIONES=(
    "Gestión de usuarios y grupos."
    "Copias de seguridad y automaticación de tareas."
    "Gestión de discos."
    "Instalación de isos en pendrive."
    "Análisis de bases de datos."
    "Instalación de servicios."
    "Monitorización de procesos."
    "Instalación de Samba."
    "Salir."
)

clear
echo "== BASH TOOLKIT PARA SYSADMIN =="
select OP in "${OPCIONES[@]}"; do
    case "$OP" in
        "${OPCIONES[0]}") sh gestionusuarios.sh ;;
        "${OPCIONES[1]}") sh copiaseg.sh ;;
        "${OPCIONES[2]}") sh gestdisc.sh ;;
        "${OPCIONES[3]}") sh isos.sh ;;
        "${OPCIONES[4]}") python3 infobd.py ;;
        "${OPCIONES[5]}") sh servicios.sh ;;
        "${OPCIONES[6]}") sh gestionprocesos.sh ;;
        "${OPCIONES[7]}") sh installsamba.sh ;;
        "${OPCIONES[8]}") echo "Hasta luego"; exit ;;

        *) echo-r "Seleccione una opción válida"
    esac
done
