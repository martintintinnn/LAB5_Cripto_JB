#!/bin/bash

# Crear el usuario "prueba" con contraseña "prueba"
useradd -m prueba
echo "prueba:prueba" | chpasswd

# Configurar el servidor SSH
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Instalar tcpdump para facilitar analisis de C4->S1
apt-get update
apt-get install -y tcpdump

# Iniciar el servicio SSH
service ssh start

# Mensaje de finalización
echo "Configuración completada en C4/S1 (Ubuntu 22.10) con servidor SSH listo"
