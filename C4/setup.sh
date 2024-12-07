#!/bin/bash
set -e

# Crear usuario y contraseña
useradd -m prueba
echo "prueba:prueba" | chpasswd

# Instalar SSH server y tcpdump
apt-get update && apt-get install -y openssh-server tcpdump

# Ajustar configuración SSH
mkdir -p /var/run/sshd
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Eliminar GSSAPIAuthentication del ssh_config (cliente) si existe
sed -i '/GSSAPIAuthentication/d' /etc/ssh/ssh_config || true

# Configuración mínima para KEI reducido
# Se elige un solo algoritmo compatible:
# - KEX: ecdh-sha2-nistp256 (el cliente lo soporta)
# - Cipher: aes128-ctr (breve y soportado)
# - MAC: hmac-sha1 (breve)
echo "KexAlgorithms ecdh-sha2-nistp256
Ciphers aes128-ctr
MACs hmac-sha1" >> /etc/ssh/sshd_config

# Reiniciar SSH
service ssh restart

echo "KEI reducido y sin GSSAPIAuthentication"
