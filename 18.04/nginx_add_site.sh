#!/bin/bash

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${CURRENT_DIR}/../common/common.sh

[ $(id -u) != "0" ] && { ansi -n --bold --bg-red "Please use root Account executes this script"; exit 1; }

read -r -p "Please enter the project name：" project

[[ $project =~ ^[a-zA-Z\0-9_\-\.]+$ ]] || {
    ansi -n --bold --bg-red "Item name contains illegal characters"
    exit 1
}

read -r -p "Please enter the domain name of the site (multiple domain names are separated by spaces)：" domains

project_dir="/var/www/${project}"

ansi -n --bold --green "Domain list：${domains}"
ansi -n --bold --green "Item name：${project}"
ansi -n --bold --green "Project directory：${project_dir}"

read -r -p "Confirm？ [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        ;;
    *)
        ansi -n --bold --bg-red "User canceled"
        exit 1
        ;;
esac

cat ${CURRENT_DIR}/nginx_site_conf.tpl |
    sed "s|{{domains}}|${domains}|g" |
    sed "s|{{project}}|${project}|g" |
    sed "s|{{project_dir}}|${project_dir}|g" > /etc/nginx/sites-available/${project}.conf

ln -sf /etc/nginx/sites-available/${project}.conf /etc/nginx/sites-enabled/${project}.conf

ansi -n --bold --green "Configuration file created successfully";

mkdir -p ${project_dir} && chown -R ${WWW_USER}.${WWW_USER_GROUP} ${project_dir}

systemctl restart nginx.service

ansi -n --bold --green "Nginx Successful restart";
