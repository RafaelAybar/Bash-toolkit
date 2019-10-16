#!/bin/bash

source funciones.sh

compruebaRoot

OPCIONES=(
    "Añadir/eliminar usuarios y gestión de contraseñas."
    "Crear/eliminar grupos."
    "Modificar el grupo al que pertenece un usuario."
    "Cambiar el propietario de un archivo/directorio."
    "Comprobar qué usuarios existen y cuáles están conectados."
    "Salir."
)

aniadirUsuario() {
    usuario=$1

    if adduser $usuario; then
        read -p "¿Quieres definir la caducidad de la contraseña? [s/N]" res
        if [[ "$res" =~ ^[Ss]$ ]]; then
            numDias="NOPE"
            until [[ "$numDias" =~ ^[0-9]+$ ]]; do
                read -p "Introduce el numero de días: " numDias
            done
            chage -M $numDias $usuario
        fi
        echo-v "El usuario '$usuario' se ha creado correctemente"
    else
        echo-r "No se ha podido crear el usuario '$usuario'"
    fi
}
borrarUsuario() {
    usuario=$1

    homeDir=`grep $usuario /etc/passwd | cut -d':' -f6`
    if userdel $usuario; then
        mensaje="Se ha eliminado correctamente el usuario '$usuario'";
        read -p "¿Quieres borrar el directorio del usuario? [s/N]" res
        if [[ "$res" =~ ^[Ss]$ ]]; then
            rm -rf $homeDir
            mensaje="$mensaje y su directorio personal"
        fi
        echo-v "$mensaje"
    else
        echo-r "No se ha podido eliminar el usuario '$usuario'"
    fi
}
aniadirGrupo() {
    grupo=$1

    if groupadd $grupo 2> /dev/null; then
        echo-v "El grupo '$grupo' se ha creado correctamente"
    else
        echo-r "No se ha podido crear el grupo '$grupo'"
    fi
}
borrarGrupo() {
    grupo=$1

    if groupdel $grupo 2> /dev/null; then
        echo-v "El grupo '$grupo' se ha eliminado correctamente"
    else
        echo-r "No se ha podido eliminar el grupo '$grupo'"
    fi
}
modificarGrupoDe() {
    pideInformacion "nombre de grupo"
    usuario=$1
    grupo=$INFO_PEDIDA

    if usermod -aG $grupo $usuario 2> /dev/null; then
        echo-v "Se ha agregado correctamente '$usuario' al grupo '$grupo'"
    else
        echo-r "No se ha podido agregar '$usuario' al grupo '$grupo'"
    fi
}
cambiarOwner() {
    pideInformacion "nombre de directorio o fichero"
    nuevoPropietario=$1
    fichero="$INFO_PEDIDA"

    if [ -e "$fichero" ]; then
        chown -R $nuevoPropietario "$fichero"
        echo-v "Se ha asignado correctamente el usuario '$usuario' como"
        echo-v "nuevo propietario de '$fichero'"
    else
        echo-r "El fichero '$fichero' no se encuentra"
        echo-r "Por favor indique una ruta relativa/absotuta hacia el"
    fi
}
listarUsuarios() {
    echo "- Todos los usuarios:"
    imprimeColoreado /etc/passwd ':'
    echo "- Usuarios conectados:"
    echo-v "$(who)"
}

mostrarMenu() {
    echo -e "\n== MENÚ DEL GESTIÓN de usuarios y grupos =="
    select OP in "${OPCIONES[@]}"; do
        case "$OP" in
            "${OPCIONES[0]}")
                echo -e "\nIntroduce A para añadir un usuario, y D para borrarlo"
                read -p "#? " res
                if [[ "$res" =~ ^[Aa]$ ]]; then
                    pideInformacion "nombre de usuario"
                    aniadirUsuario $INFO_PEDIDA
                elif [[ "$res" =~ ^[Dd]$ ]]; then
                    pideInformacion "nombre de usuario"
                    borrarUsuario $INFO_PEDIDA
                else
                    echo-r "'$res' no es una opción válida"
                fi
                mostrarMenu
            ;;
            "${OPCIONES[1]}")
                echo -e  "\nIntroduce A para añadir un grupo, y D para borrarlo"
                read -p "#? " res
                if [[ "$res" =~ ^[Aa]$ ]]; then
                    pideInformacion "nombre de grupo"
                    aniadirGrupo $INFO_PEDIDA
                elif [[ "$res" =~ ^[Dd]$ ]]; then
                    pideInformacion "nombre de grupo"
                    borrarGrupo $INFO_PEDIDA
                else
                    echo-r "'$res' no es una opción válida"
                fi
                mostrarMenu
            ;;
            "${OPCIONES[2]}")
                echo
                pideInformacion "nombre de usuario"
                modificarGrupoDe $INFO_PEDIDA
                mostrarMenu
            ;;
            "${OPCIONES[3]}")
                echo
                pideInformacion "nuevo propietario"
                cambiarOwner $INFO_PEDIDA
                mostrarMenu
            ;;
            "${OPCIONES[4]}")
                echo
                listarUsuarios
                mostrarMenu
            ;;
            "${OPCIONES[5]}") echo -e "\nHasta luego"; exit ;;

            *) echo-r "Seleccione una opción válida"
        esac
    done
}

clear
mostrarMenu
