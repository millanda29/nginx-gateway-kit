#!/bin/sh

# ============================================================
# Script de entrada para el contenedor de NGINX
# Genera dinámicamente el archivo de configuración de NGINX 
# usando un template y variables de entorno.
# ============================================================

# Falla al primer error
set -e

# -----------------------------
# Mensaje informativo
# -----------------------------
echo "📦 Generando archivo de configuración NGINX..."

# -----------------------------
# Expande variables de entorno en el template
# - default.template.conf debe tener variables como ${SERVICE1_HOST}
# - Se genera default.conf que es cargado por NGINX
# -----------------------------
envsubst < /etc/nginx/default.template.conf > /etc/nginx/conf.d/default.conf

# -----------------------------
# Mensaje informativo
# -----------------------------
echo "🚀 Iniciando NGINX..."

# -----------------------------
# Inicia NGINX en primer plano (sin daemon)
# -----------------------------
nginx -g 'daemon off;'
