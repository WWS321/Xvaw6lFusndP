FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl && \
    wget -O temp.zip FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl && \
    wget -O temp.zip https://github.com/XTLS/Xray-core/releases/download/v1.8.0/Xray-linux-64.zip && \
    unzip temp.zip xray && \
    rm -f temp.zip && \
    chmod -v 755 xray entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]