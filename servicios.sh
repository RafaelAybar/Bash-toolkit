#!/bin/bash
while true
do
   cat <<- EOF
   Instalación de servicios
1   Instalación LAMPP.
2   Instalación de servidor DNS (bind9)
3   Instalación de servidor DHCP
4   Generar certificados SSL/TSL
6   Salir
EOF
    read respuesta
    
    case $respuesta in
        1) echo "Instalaremos Apache2, MySQL y PHP"
            #https://www.digitalocean.com/community/tutorials/como-instalar-linux-apache-mysql-php-lamp-en-ubuntu-16-04-es
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
        2) sudo apt install bind9 bind9utils bind9-doc;
            echo "Creamos una copia del archivo named.conf.local llamado named.conf.local.bak"
            sudo cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
            echo "Introduce el nombre del dominio"
            read nombredom
            if [ -z "$nombredom" ]
                then
                    echo "Debes introducir algún nombre"
                    exit
            else
                echo "Se va a crear el archivo de zona directa vacío"
                sudo cp /etc/bind/db.local /etc/bind/db.$nombredom
                echo "Se va a crear el archivo de zona inversa"
                echo "zone \"$nombredom\" {" >> /etc/bind/named.conf.local
                echo "Seleccione el tipo  de zona (master ó slave)"
                read tipozona
                if [ "$tipozona" = "master" ] || [ "$tipozona" = "slave" ] 
                then
                        echo "  type $tipozona;" >> /etc/bind/named.conf.local
                        echo "  file \"/etc/bind/db.$nombredom\";" >> /etc/bind/named.conf.local
                        echo "};" >> /etc/bind/named.conf.local
                        cat /etc/bind/named.conf.local
                        echo "Se va a proceder a configurar la zona inversa"
                        echo "Introduzca la ip de esta forma: 1.168.192"
                        read ipinversa
                        if [ -z ipinversa ]
                        then
                                echo "Debes introducir una zona inversa"
                                exit
                            else
                            cp /etc/bind/db.127 /etc/db.$ipinversa.rev
                            echo "zone \"$ipinversa.in-addr.arpa\" {"
                            echo "Introduce el tipo de zona inversa (master ó slave)"
                            read tipozonainv
                            if [ "$tipozonainv" = "master" ] || [ "$tipozonainv" = "slave" ]
                            then
                                    echo "  type $tipozonainv;" >> /etc/bind/named.conf.local
                                    echo "  file \"/etc/bind/db.$ipinversa.rev\";" >> /etc/bind/named.conf.local
                                    echo "};" >> /etc/bind/named.conf.local
                                    cat /etc/bind/named.conf.local
                                else
                                    echo "Introduce un tipo de zona válido"
                                    exit
                            fi
                        fi
                else
                    echo "Introduce una respuesta válida"
                    exit
                fi
            fi
        ;;
        3) echo "En progreso" ;;
        4) echo "En progreso" ;;
        5) echo "Adios";;
        *) echo "Escoge un parámetro válido" ;;
    esac
    done
