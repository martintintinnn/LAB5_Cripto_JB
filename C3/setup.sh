#!/bin/bash
set -e

# Eliminar openssh-client instalado por defecto si lo hubiera
apt-get remove -y openssh-client || true

# Instalar dependencias de compilación
apt-get update
apt-get install -y wget build-essential zlib1g-dev libssl-dev libpam0g-dev libselinux1-dev libwrap0-dev ca-certificates

# Descargar el código fuente de OpenSSH 8.3p1 desde un mirror confiable
# URL alternativa: https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.3p1.tar.gz
wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.3p1.tar.gz
tar xvfz openssh-8.3p1.tar.gz
cd openssh-8.3p1

# Modificar la cadena de versión en el código fuente
sed -i 's/^#define SSH_VERSION.*/#define SSH_VERSION "OpenSSH_?"/' version.h

# Configurar, compilar e instalar
./configure --prefix=/usr --sysconfdir=/etc/ssh
make
make install

# Limpieza
cd ..
rm -rf openssh-8.3p1*
apt-get remove -y build-essential zlib1g-dev libssl-dev libpam0g-dev libselinux1-dev libwrap0-dev
apt-get autoremove -y
apt-get clean

echo "Configuración completada en C3 (Ubuntu 20.10) con OpenSSH_? personalizado"
