
<h1 align="center">Le module de gestion de sites NGINX facile à utiliser</h1>
<h2 align="center">Un outil pour créer et sécuriser des hébergements web sur un serveur.</h2>
<p align="center">
  
  <img width="250" src="https://share.thehostingbot.xyz/sZka9bw.png">
</p>

* ✔️ Créer des sites web sous nginx
* ✔️ Sécuriser des sites nginx avec un certificat SSL Let's Encrypt
* ✔️ Supprimer des sites sous nginx
* ✔️ Supprimer des certificats SSL
* ✔️ Renouveller des certificats SSL
* ❌ Renouveller automatiquement des certificats SSL
<h1>Compatibilité</h1>

| OS               | Version | Compatible ?       | Testé ?     |
| ---------------- | ------- | ------------------ | ----------- |
| Ubuntu           | 14.04   | :white_check_mark: | Non         |
|                  | 16.04   | :white_check_mark: | Non         |
|                  | 18.04   | :white_check_mark: | Oui         |
|                  | 20.04   | :white_check_mark: | Oui         |
| Debian           | 8       | :white_check_mark: | Non         |
|                  | 9       | :white_check_mark: | Oui         |
|                  | 10      | :white_check_mark: | Oui         |
| CentOS           | All     | :red_circle:       | Non         |
| Windows          | All     | :red_circle:       | Non         |
| MacOS            | All     | :red_circle:       | Non         |

<h1 align="center">1. Utilisation.</h1>
<h2 align="center">1.1. Créez un enregistrement de type A vers votre serveur</h2>

![exemple01](https://share.thehostingbot.xyz/ZSX6lCK.png)
⚠️ Si comme sur cet exemple vous utilisiez une zone DNS de Cloudflare, faites attention à bien mettre le proxy status sur "DNS only"

```
# Télécharger le script et aller dans le dossier du projet
$ git clone https://github.com/IceroDev/nginx-website-manager.git
$ cd nginx-website-manager
#
# Rendre le script exectutable
$ chmod +x nginx-website-manager.sh
#
# Lancer le script
$ ./nginx-website-manager.sh
```

<h1 align="center">2. Contribuer au projet.</h1>
N'hésitez pas à faire des pull request avec vos versions modifiées du programme !

Ce programme vous à aidé ? N'oubliez pas de mettre une ⭐, ça fait toujours plaisir :)

<h1 align="center">Captures d'écran.</h1>

![capture01](https://share.thehostingbot.xyz/F2D9aKT.png)

![capture02](https://share.thehostingbot.xyz/ovGVRcU.png)

