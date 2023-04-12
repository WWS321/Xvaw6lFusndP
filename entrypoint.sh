#!/usr/bin/env bash

UUID=${UUID:-'de04add9-5c68-8bab-950c-08cd5320df18'}
VLESS_WSPATH=${VLESS_WSPATH:-'/vless'}

sed -i "s#UUID#$UUID#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" config.json
sed -i "s#VLESS_WSPATH#${VLESS_WSPATH}#g" /etc/nginx/nginx.conf

RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv xray ${RELEASE_RANDOMNESS}
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
cat config.json | base64 > config
rm -f config.json

nginx
base64 -d config > config.json
./${RELEASE_RANDOMNESS} -config=config.json
