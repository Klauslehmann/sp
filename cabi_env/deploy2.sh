#! /bin/sh

echo -e "R_CONFIG_ACTIVE=$1" > .Renviron

# Ir a la carpeta que tiene la aplicacion
cd /home/klaus/cabify
pwd

# Construir la imagen de la aplicación
docker build -t cabify_app .

# Borrar el contenedor de shinyproxy y  echarlo a andar 
docker rm -f shinyproxy
docker run -v /var/run/docker.sock:/var/run/docker.sock:ro --group-add $(getent group docker | cut -d: -f3) --net sp-example-net --env-file /home/klaus/sp/cabi_env/.Renviron  --name shinyproxy \
 -p 8080:8080 shinyproxy


