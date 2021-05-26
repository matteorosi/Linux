#!/bin/bash

OLDCONFIG=$(dpkg -l|grep "^rc"|awk '{print $2}')
OLDKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
sudo dpkg --configure -a

# Pulizia cache

sudo apt-get clean && sudo apt-get autoclean

# Rigenera cache

sudo apt-get update --fix-missing

# Rimuove Vecchi Kernel
sudo aptitude purge $OLDKERNEL

#Rimuove Vecchie Configurazioni
sudo aptitude purge $OLDCONFIG

#Rimuove tutti i .gz logs file
find /var/log -type f -regex ".*\.gz$" | xargs rm -Rf

# Installa dipendenze Mancanti

sudo apt-get install -f
sudo apt-get update -y
sudo apt-get autoremove --purge -y

# Cancella tutti i cestini
sudo rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
sudo rm -rf /root/.local/share/Trash/*/** &> /dev/null

# Pulizia Finale 

sudo rm -rf /var/lib/apt/lists/lock/* 
sudo rm -rf /var/cache/apt/archives/lock/* 
sudo rm -rf /var/lib/dpkg/lock/*
sudo rm -rf /lib/live/mount/rootfs/*
sudo rm -rf /lib/live/mount/*
sudo rm -rf /var/cache/apt/archives/*.deb
sudo rm -rf /var/cache/apt/archives/partial/*.deb
sudo rm -rf /var/cache/apt/partial/*.deb
sudo rm -rf /opt/tmp/*
sudo rm -rf /.git

