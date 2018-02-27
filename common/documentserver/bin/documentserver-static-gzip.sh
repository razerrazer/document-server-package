#!/bin/bash

DIR="/var/www/onlyoffice/documentserver"
NGINX_ONLYOFFICE_PATH="/etc/onlyoffice/documentserver/nginx"

cd ${DIR}
# Make gziped scripts
find ./sdkjs ./web-apps ./sdkjs-plugins -type f \( -name *.js* -o -name *.htm* -o -name *.css \) -exec gzip -kf9 {} \;

# Make gziped fonts
find ./fonts -type f ! -name "*.*" -exec gzip -kf9 {} \;

# Turn on static gzip for nginx
sed 's/#*\s*\(gzip_static\).*/\1 on;/g' \
  -i ${NGINX_ONLYOFFICE_PATH}/includes/onlyoffice-documentserver-docservice.conf

# Reload nginx config
sudo service nginx reload
