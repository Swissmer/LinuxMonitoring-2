#!/bin/bash

# main lists
response_codes=(
    # Success (успешно)
    "200" # 200 OK («успешный ответ»)
    "201" # 201 Created («успешно создан новый ресурс»)
    # Client Error (ошибка клиента)
    "400" # 400 Bad Request («некорректный запрос»)
    "401" # 401 Unauthorized («требуется авторизация»)
    "403" # 403 Forbidden («доступ запрещен»)
    "404" # 404 Not Found («страница не найдена»)
    # Server Error (ошибка сервера)
    "500" # 500 Internal Server Error («внутренняя ошибка сервера»)
    "501" # 501 Not Implemented («сервер не поддерживает функционал, необходимый для обработки запроса»)
    "502" # 502 Bad Gateway («некорректный ответ от сервера»)
    "503" # 503 Service Unavailable («сервис недоступен»)
)

methods=(
    "GET" "POST" "PUT" "PATCH" "DELETE"
)

agents=(
    "Mozilla" "Google" "Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot""Library and net tool"
)

platforms=(
    "Mac" "Windows" "Linux" "IOS" "Android"
)

# generation ip
function getIp {
    local num_1=$((RANDOM % 255))
    local num_2=$((RANDOM % 255))
    local num_3=$((RANDOM % 255))
    local num_4=$((RANDOM % 255))
    echo "${num_1}.${num_2}.${num_3}.${num_4}"
}

# generation status
function getStatus {
    local RANGE=${#response_codes[@]}
    local INDEX=$((RANDOM % RANGE))
    echo ${response_codes[INDEX]}
}

# generation method
function getMethod {
    local RANGE=${#methods[@]}
    local INDEX=$((RANDOM % RANGE))
    echo ${methods[INDEX]}
}

# generation time
function getTime {
    HOUR=$((RANDOM % 24))
    MINUTE=$((RANDOM % 60))
    SECOND=$((RANDOM % 60))

    # if value < 10
    if [[ $HOUR -lt 10 ]]; then
        HOUR="0$HOUR"
    fi
    if [[ $MINUTE -lt 10 ]]; then
        MINUTE="0$MINUTE"
    fi
    if [[ $SECOND -lt 10 ]]; then
        SECOND="0$SECOND"
    fi

    echo "$HOUR:$MINUTE:$SECOND"
}

# generation date
function getDate {
    echo "$(date +"%d/%b/%Y" -d "$1 day ago")"
}

# generation URL
function getURL {
    local RANGE=${#platforms[@]}
    local INDEX=$((RANDOM % RANGE))
    local VERSION=$((RANDOM % 6 + 1))
    local USER_AGENT=$(getAgents)
    local PLATFORM=${platforms[INDEX]}
    # User-Agent: Platform: 
    echo "Mozila/${VERSION}.0 Platform: ${PLATFORM}"
}

# generation agents
function getAgents {
    local RANGE=${#agents[@]}
    local INDEX=$((RANDOM % RANGE))
    echo ${agents[INDEX]}
}

# created logs
function getLogs {
    local valueTime=$(getTime)
    local valueDate=$(getDate $1)
    local valueMethod=$(getMethod)
    local valueStatus=$(getStatus)
    local valueUrlAgent=$(getURL)
    local valueIp=$(getIp)
    local valueAgent=$(getAgents)
    echo "$valueIp - - [${valueDate}:${valueTime} +0700] \"${valueMethod} ${valueUrlAgent}\" ${valueStatus} - \"-\" \"${valueAgent}\""
}

for i in {1..5}
do
    valueCount=$(($RANDOM % 901 + 100))
    for (( j = 1; j <= valueCount; j++))
    do
        echo "$(getLogs $i)" >> ../logs/04_log_$i.log
        sort -k 4 -o ../logs/04_log_$i.log ../logs/04_log_$i.log
    done
done

