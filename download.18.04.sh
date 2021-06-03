#!/bin/bash

{ # this ensures the entire script is downloaded #

lsb_release -d | grep 'Ubuntu' >& /dev/null
[[ $? -ne 0 ]] && { echo "Only supports Ubuntu 18.04 system"; exit 1; }

DISTRO=$(lsb_release -c -s)
[[ ${DISTRO} -ne "bionic" ]] && { echo "Only supports Ubuntu 18.04 system"; exit 1; }

green="\e[1;32m"
nc="\e[0m"

echo -e "${green}===> Downloading...${nc}"
cd $HOME
wget -q https://github.com/diyarit/laravel-stack-deployer-ubuntu/archive/refs/tags/1.0.tar.gz -O laravel-stack-deployer-ubuntu.tar.gz
rm -rf laravel-stack-deployer-ubuntu
tar zxf laravel-stack-deployer-ubuntu.tar.gz
mv laravel-stack-deployer-ubuntu-1.0 laravel-stack-deployer-ubuntu
rm -f laravel-stack-deployer-ubuntu.tar.gz
echo -e "${green}===> Download complete${nc}"
echo ""
echo -e "${green}The installation script is located at： ${HOME}/laravel-stack-deployer-ubuntu${nc}"

[ $(id -u) != "0" ] && {
    source ${HOME}/laravel-stack-deployer-ubuntu/common/ansi.sh
    ansi -n --bold --bg-yellow --black "The current account is not root，Please use root Account to execute the installation script (using the command：sudo -H -s Switch to root）"
} || {
    bash ./laravel-stack-deployer-ubuntu/18.04/install.sh
}

cd - > /dev/null
} # this ensures the entire script is downloaded #
