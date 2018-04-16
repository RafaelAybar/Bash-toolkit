#!/bin/bash
while true
do
   cat <<- EOF
   Instalación de servicios
1   Instalación LAMPP.
2   Instalación de servidor DNS (bind9)
3   Instalación de servidor DHCP
4   Instalación de servidor ftp (ProFTPD)
5   Instalación completa
6   Salir
EOF
    read respuesta
    
    case $respuesta in
        1) echo "Instalaremos Apache2, MySQL y PHP"
            echo  "La ruta por defecto donde se alojan las páginas web es /var/www/html"
            sudo apt install php libapache2-mod-php php-mcrypt php-mysqg php-gettext mysql-server mysql-client libmysqlclient-dev;
            echo "Comprobamos que los paquetes se han instsalado correctamente"
            sudo apache2ctl configtest
            sleep 4
            sudo service apache2 status
            sleep 4
            sudo service mysql
            sleep 4
            echo "¿Desea iniciar el asistente para la instalación segura de mysql? Pulsa s para confirmar"
            read instalsec
            if [ "$instalsec" == "s" ]
                then
                    mysql_secure_installation
                else
                    echo "No se iniciará el asistente"
            fi
            echo "¿Quiere ajustar el firewal para permitir tráfico web? Pulsa s para confirmar "
            read permitirweb
            if [ "$permitirweb" == "s" ]
                then
            #Comprobamos la lista de servicios que podemos filtrar
                    sudo ufw app list
                    echo "Añadimos la regla sobre Apache Full"
                    sudo ufw allow in "Apache Full"
            else
                echo "No se ha modificado el firewall"

            fi
            echo "Configuración finalizada"
            ;;
        2) sudo apt install bind9;
        ;;
        3) echo "En progreso" ;;
        4) echo "En progreso" ;;
        5) echo "En progreso" ;;
        6) echo "Adios";;
        *) echo "Escoge un parámetro válido" ;;
    esac
    done
