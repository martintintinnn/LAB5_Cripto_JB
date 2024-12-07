# Dockerfile para C3 (Ubuntu 20.10)
FROM ubuntu:20.10

# Cambiar a repositorio antiguo y eliminar referencias a security.ubuntu.com
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list && \
    sed -i '/security.ubuntu.com/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y openssh-client && \
    apt-get clean

# Copiar script de configuración
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh
RUN /setup.sh

# Ejecutar el script durante la construcción
RUN /setup.sh

# En caso de querer que se pare CMD ["/bin/bash"]
CMD ["tail", "-f", "/dev/null"]
