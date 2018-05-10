#!/bin/bash
#La documentación usada se encuentra disponible en https://femarper.wordpress.com/2017/05/02/a-vueltas-con-los-dominios-samba-clientes-linux/
#Importante leer también https://blogdeanillas.wordpress.com/2011/10/24/montar-unidades-con-fstab-en-un-active-directory/


echo "Introduce el dominio"
    read dnssearch
if [ -z "$dnssearch" ]
    then
        echo "Debes introducir todos los parámetros"
        exit
else
            echo "Modificamos /etc/pam.d/common-session"
            sed -i.back "30s/^/session [success=ok default=ignore] pam_lsass.so \n/" /etc/pam.d/common-session
            echo "Se ha generado un fichero commonsession.conf.bak de copia de seguridad"
            sudo /opt/pbis/bin/config UserDomainPrefix $dnssearch
            sudo /opt/pbis/bin/config AssumeDefaultDomain true
            sudo /opt/pbis/bin/config LoginShellTemplate /bin/bash
            sudo /opt/pbis/bin/config HomeDirTemplate %H/%U
            echo "Añada %domain^admins ALL=(ALL:ALL) ALL a /etc/sudoers"
fi