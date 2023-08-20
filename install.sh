#!/bin/bash
# Autor: Marcos Mota
# Data de Criação: Agosto de 2023

# Baixando e instalando Zabbix
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb
# Atualizar repositórios
sudo apt update -y
# Intação apache2
sudo apt-get install -y apache2
# Instalar o Zabbix Server e outras dependências
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
 # Configurar o MySQL para o Zabbix 
sudo apt-get install -y mysql-server
sudo mysql -uroot
sudo mysql -uroot -e "create database zabbix character set utf8mb4 collate utf8mb4_bin"
sudo mysql -uroot -e "create user zabbix@localhost identified by 'password'"
sudo mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost"
sudo mysql -uroot -e "set global log_bin_trust_function_creators = 1"
sudo mysql -uroot -e "quit"
 # Configurar o MySQL para o Zabbix 
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -ppassword zabbix
sudo mysql -uroot -e "set global log_bin_trust_function_creators = 0"
echo -e 'DBPassword=password' >> /etc/zabbix/zabbix_server.conf
 # Reiniciar serviços
sudo systemctl restart apache2
sudo systemctl restart zabbix-server zabbix-agent
# Habilitar serviços na inicialização
sudo systemctl enable apache2
sudo systemctl enable zabbix-server zabbix-agent
###FIM###