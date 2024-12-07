FROM ubuntu:22.10

# Cambiar repositorio y actualizar
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list && \
    sed -i '/security.ubuntu.com/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y openssh-client openssh-server && \
    apt-get clean

# Copiar y ejecutar el script de configuración
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh
RUN /setup.sh

# Comando para mantener el contenedor activo y el servicio SSH corriendo
CMD ["/usr/sbin/sshd", "-D"]
