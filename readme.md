## Introduction

Applicable to the LNMP installation script of Ubuntu 16.04 / 18.04 / 20.04, and set the domestic image acceleration.

Please ensure that all commands are executed under the root account. If the login account is not root, you need to execute sudo -H -s to switch to the root account before downloading and installing.  

> NOTE: will be used here in after {version}instead select your system, such as 16.04 / 18.04 / 20.04.

## Software list

* Git
* PHP 7.4
* Nginx
* MySQL
* Sqlite3
* Composer
* Nodejs 10
* Yarn
* Redis
* Beanstalkd
* Memcached

## Optional software list

The following software needs to manually execute the installation script:

* Elasticsearch:, the ./{version}/install_elasticsearch.sh default is 6.x, if you want to install 7.x, execute./{version}/install_elasticsearch.sh 7`

## installation

### Ubuntu 16.04

```
wget -qO- https://raw.githubusercontent.com/diyarit/laravel-stack-deployer-ubuntu/main/download.16.04.sh - | bash
```


### Ubuntu 18.04

```
wget -qO- https://raw.githubusercontent.com/diyarit/laravel-stack-deployer-ubuntu/main/download.18.04.sh - | bash
```


### Ubuntu 20.04

```
wget -qO- https://raw.githubusercontent.com/diyarit/laravel-stack-deployer-ubuntu/main/download.20.04.sh - | bash
```


### Special Note

This script will download the installation script to the `laravel-stack-deployer-ubuntu` directory under the current user's Home directory and automatically execute the installation script.

**After the installation, the password of the Mysql root account will be output on the screen, please keep it properly. **

If it is not currently in the root account, it will not be installed automatically. You need to switch to the root account and execute `./{version}/install.sh`.

## Daily use

### 1. Add Nginx site

```
./{version}/nginx_add_site.sh
```

You will be prompted to enter the site name (only English, numbers, `-` and `_`), domain name (multiple domain names are separated by spaces), after confirmation, the corresponding Nginx configuration will be created and Nginx restarted.

### 2. Add Mysql user and database

```
./{version}/mysql_add_user.sh
```

You will be prompted to enter the root password, if you make a mistake, you will not be able to continue. Enter the Mysql user name to be created, and confirm whether a database corresponding to the user name needs to be created.

After creation, the password of the new user will be output to the screen, please keep it properly.

### 3. Execute commands as www-data

This project provides an `alias` of `sudowww`. When you need to execute commands as the `www-data` user (such as `git clone project`, `php artisan config:cache`, etc.), you can add it directly before the command Add `sudowww` and add single quotes at both ends of the original command, such as:      

```
sudowww 'php artisan config:cache'
```
