# ===============================
# Dockerfile para API Gateway NGINX
# ===============================

# Usamos la última imagen oficial de nginx como base,
# garantizando que tengamos la última versión estable.
FROM nginx:latest

# Instalamos gettext-base para usar 'envsubst',
# que permite reemplazar variables de entorno en templates.
RUN apt-get update && \
    apt-get install -y --no-install-recommends gettext-base && \
    rm -rf /var/lib/apt/lists/*

# Copiamos el archivo template principal al contenedor.
# Este archivo usará variables de entorno para configurar nginx dinámicamente.
COPY default.template.conf /etc/nginx/default.template.conf

# Copiamos el script entrypoint, que será responsable
# de reemplazar variables y arrancar nginx.
COPY entrypoint.sh /entrypoint.sh

# Damos permisos de ejecución al entrypoint.
RUN chmod +x /entrypoint.sh

# Definimos el entrypoint para que se ejecute al iniciar el contenedor.
ENTRYPOINT ["/entrypoint.sh"]

# Comando por defecto para arrancar nginx en primer plano.
CMD ["nginx", "-g", "daemon off;"]
