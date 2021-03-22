#!/bin/bash
echo -e "\n*******************************Nginx Website Manager*******************************\n*                                                                                 *\n*                              Crée par  Jean Staffe                              *\n*                                Licence GNU GPLv3                                *\n*                  https://github.com/IceroDev/nginx-website-manager              *\n*                                                                                 *\n***********************************************************************************\n\n"

if [[ $EUID -ne 0 ]]; then
    echo "* Ce programme doit être executé en tant qu'utilisateur sudo" 1>&2
    exit 1
fi
if ! [ -x "$(command -v apt)" ]; then
echo "* Votre système d'exploitation n'est malheureusement pas compatible avec l'installateur."
    exit 1
fi
echo -e "\nQue voulez vous faire ?\n\n1) Installer un hébergement web\n2) Installer/Gérer un certificat SSL Let's Encrypt\n3) Supprimer un hébergement web\n"
read -rp "(1/3) ~" -e qvvf

if [ $qvvf == "1" ]; then
    apt install sudo
    echo -e "Vérification de l'installation de NGINX..."
    sleep 3
    if ! [ -x "$(command -v nginx)" ]; then
        echo -e "Nginx n'est pas installé. Installation de Nginx et mise à jour du serveur ..."
        sleep 3
        sudo apt update && apt upgrade -y && apt install nginx -y
        systemctl enable nginx
        systemctl start nginx
    fi
    echo "Nginx est installé."
    
    echo -e "Vérification de l'installation de php 7.4..."
    sleep 3
    if ! [ -x "$(command -v php)" ]; then
        echo -e "Php n'est pas installé. Installation de php et mise à jour du serveur ..."
        sleep 3
        sudo apt update && apt upgrade -y
        sudo apt -y install lsb-release apt-transport-https ca-certificates 
        sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
        echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
        sudo apt update
        sudo apt -y install php7.4
        sudo apt -y install php7.4-fpm
    fi
    echo "Php est installé."
    read -rp "Quel domaine/sous-domaine souhaitez vous héberger ? " -e domain

    mkdir /var/www/html/$domain
    echo -e "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n\n<style type=\"text/css\">\n      body { text-align: center; padding: 150px; }\n      h1 { font-size: 40px; }\n      body { font: 20px Helvetica, sans-serif; color: rgb(0, 0, 0); }\n      #article { display: block; text-align: left; width: 650px; margin: 0 auto; }\n      a { color: #542d9c; text-decoration: none; }\n      a:hover { color: #6f42c1; text-decoration: none; }\n    </style>\n</head>\n\n<body>\n	<img src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Octicons-mark-github.svg/1200px-Octicons-mark-github.svg.png\" alt=\"logo\" style=\"width:15%\">\n<div id=\"article\">\n<h1>Hébergement en ligne !</h1>\n<div>\n<p style=\"height:50%\">Merci d'avour utilisé mon outil d'installation !<br>\nLes fichiers de votre hébergement web se situent dans le dossier /var/www/html/$domain de votre serveur\n</p>\n<p>Bon Coding !</p>\n  <p>&mdash; <strong>Jean Staffe</strong></p>\n</div>\n</div>\n</body>\n</html>" >/var/www/html/$domain/index.html
    chown -R www-data:www-data /var/www/html/$domain
    echo -e "server {\n        listen 80;\n        listen [::]:80;\n        root /var/www/html/$domain;\n        index index.html index.htm;\n        server_name $domain;\n\n   location / {\n       try_files \$uri \$uri/ =404;\n   }\n\n}" >/etc/nginx/sites-available/$domain
    rm /etc/nginx/sites-enabled/$domain
    ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
    systemctl restart nginx
    echo "Votre hébergement web pour $domain est désormais disponible !"
    read -rp "Voulez vous sécuriser votre domaine par un certificat SSL Let's Encrypt ? (oui/non)" -e ssl

    if [ $ssl == "oui" ]; then

        if ! [ -x "$(command -v certbot)" ]; then
            echo -e "Certbot n'est pas installé. Installation de Certbot et mise à jour du serveur ..."
            sleep 3
            sudo apt update && apt upgrade -y && apt install certbot -y
            apt-get install python3-certbot-nginx -y
        fi
        certbot --nginx -d $domain
        echo "Installation du certificat SSL terminée"
        echo -e "\n******************************Installation terminée !******************************\n*                                                                                 *\n*                            Ce programme vous à plu ?                            *\n*                  N'hésitez pas à laisser une étoile sur le github               *\n*                  https://github.com/IceroDev/nginx-website-manager              *\n*                                                                                 *\n***********************************************************************************\n"
    else
        echo -e "\n******************************Installation terminée !******************************\n*                                                                                 *\n*                            Ce programme vous à plu ?                            *\n*                  N'hésitez pas à laisser une étoile sur le github               *\n*                  https://github.com/IceroDev/nginx-website-manager              *\n*                                                                                 *\n***********************************************************************************\n"
    fi

elif [ $qvvf == "2" ]; then
    echo -e "\nQue voulez vous faire ?\n\n1) Gérer/Créer un certificat SSL\n2) Retirer un certificat SSL\n"
    read -rp "(1/2) ~" -e qf
    if [ $qf == "1" ]; then
        read -rp "Quel domaine/sous-domaine souhaitez vous sécuriser ? " -e domain
        if ! [ -x "$(command -v certbot)" ]; then
            echo -e "Certbot n'est pas installé. Installation de Certbot et mise à jour du serveur ..."
            sleep 3
            sudo apt update && apt upgrade -y && apt install certbot -y
            apt-get install python3-certbot-nginx -y
        fi
        certbot --nginx -d $domain
        echo -e "\n****************************Installation SSL terminée !****************************\n*                                                                                 *\n*                            Ce programme vous à plu ?                            *\n*                  N'hésitez pas à laisser une étoile sur le github               *\n*                  https://github.com/IceroDev/nginx-website-manager              *\n*                                                                                 *\n***********************************************************************************\n"
    elif [ $qf == "2" ]; then
        read -rp "Quel domaine/sous-domaine souhaitez vous ne plus sécuriser ? " -e domain
        sudo certbot delete --cert-name $domain
        rm /etc/nginx/sites-available/$domain
        rm /etc/nginx/sites-enabled/$domain
        echo -e "server {\n        listen 80;\n        listen [::]:80;\n        root /var/www/html/$domain;\n        index index.html index.htm index.php;\n        server_name $domain;\n\n   location / {\n       try_files \$uri \$uri/ =404;\n   }\n   location ~ \.php$ {\n               include snippets/fastcgi-php.conf;\n               fastcgi_pass unix:/run/php/php7.4-fpm.sock;\n        }\n}" >/etc/nginx/sites-available/$domain
        ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
        systemctl restart nginx
    else
        echo "Ceci n'est pas une option. Fin du programme."
    fi
elif [ $qvvf == "3" ]; then
    read -rp "Quel domaine/sous-domaine souhaitez vous supprimer ? " -e domain
    certbot delete --cert-name $domain
    rm /etc/nginx/sites-available/$domain
    rm /etc/nginx/sites-enabled/$domain
    rm -r /var/www/html/$domain
    systemctl restart nginx
    echo -e "\n****************************Désinstallation terminée !*****************************\n*                                                                                 *\n*                            Ce programme vous à plu ?                            *\n*                  N'hésitez pas à laisser une étoile sur le github               *\n*                  https://github.com/IceroDev/nginx-website-manager              *\n*                                                                                 *\n***********************************************************************************\n"
else
    echo "Ceci n'est pas une option. Fin du programme."
fi
