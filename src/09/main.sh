#!/bin/bash

# Настройка nginx
function settingNginx {
    cp nginx.conf /etc/nginx/nginx.conf             # Перемещение nginx
    nginx -s reload                                 # Обновили конфигурацию nginx
    cp index.html /usr/share/nginx/html/index.html  # Перемещение index.html
}

# Основные функции
./get_metrics.sh
settingNginx

# Основный цикл
while sleep 3
do
    ./get_metrics.sh
    cp index.html /usr/share/nginx/html/index.html
done
