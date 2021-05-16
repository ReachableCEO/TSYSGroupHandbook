# TSYS Group - IT Documentation - Applications - Web Server Setup

- [TSYS Group - IT Documentation - Applications - Web Server Setup](#tsys-group-it-documentation-applications-web-server-setup)
  - [packages to install](#packages-to-install)
  - [php modifications](#php-modifications)
    - [memcache](#memcache)
    - [php config changes](#php-config-changes)
  - [apache](#apache)
    - [apache configuration mods needed](#apache-configuration-mods-needed)
    - [apache modules needed](#apache-modules-needed)
    - [apache tweaks performed](#apache-tweaks-performed)
  - [scripts to load](#scripts-to-load)
  - [TSYS root ca and UCS DC root cert](#tsys-root-ca-and-ucs-dc-root-cert)

These notes capture actions taken to build the www vm around 9/15 to 10/1 2020. 

## packages to install 

* php stuff and other packages needed :

```console
sudo apt install memcached php7.4 php7.4-mysqli php7.4-fpm php7.4-mbstring php7.4-xml php7.4-imap php7.4-json php7.4-zip php7.4-gd php7.4-curl php7.4-ldap php7.4-gd php7.4-gmp php-par php-apcu jq unzip python3-pip —no-install-recommends
```

## php modifications

### memcache

root@www:/etc/php/7.4/fpm/conf.d# grep -v ^\;  20-memcache.ini 

extension=memcache.so

[memcache]
memcache.allow_failover="1"
memcache.max_failover_attempts="20"
memcache.default_port="11211"
memcache.hash_strategy="consistent"
session.save_handler="memcache"
session.save_path = 'tcp://10.251.51.1:11211,tcp://10.251.51.2:11211,tcp://10.251.51.3:11211'
memcache.redundancy=1
memcache.session_redundancy=4

### php config changes

Timezone

## apache

### apache configuration mods needed

-- alter site config for fpm socket to php7.4-fpm (from 7.3) (socket path)

### apache modules needed

* headers
* deflate
* rewrite
* proxy
* proxy_http
* proxy_fcgi
* cache_disk

### apache tweaks performed

* 1153  sudo a2dismod mpm_prefork
* 1154  sudo a2enmod mpm_event
* 1155  sudo apt install libapache2-mod-fcgid
* 1156  sudo a2enconf php7.2-fpm
* 1157  sudo a2enconf php7.-fpm
* 1158  sudo a2enconf php7.4-fpm

## scripts to load

```console
sandstorm-cert.sh

certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-public-ip-logging-ok -d '*.sandstorm.turnsys.com' -d sandstorm.turnsys.com 
```

## TSYS root ca and UCS DC root cert

Without having the domain root cert present, none of the apps will be able to validate teh domain controller certificate presented during authentication. 

```console

root@www:/usr/local/share/ca-certificates# ls -l
total 12
drwxr-xr-x 2 root root 4096 Sep 28 20:43 extra
lrwxrwxrwx 1 root root   13 Sep 28 20:44 tsys-root.crt -> tsys-root.pem
-r--r--r-- 1 root root  822 Sep 28 20:43 tsys-root.pem
lrwxrwxrwx 1 root root   12 Sep 28 20:44 ucs-root.crt -> ucs-root.pem
-rw-r--r-- 1 root root 2094 Sep 28 20:43 ucs-root.pem
root@www:/usr/local/share/ca-certificates# 
```