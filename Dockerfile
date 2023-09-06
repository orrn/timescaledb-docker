FROM bitnami/postgresql:14.6.0-debian-11-r33
USER root
RUN sed -i "s|deb.debian.org|mirrors.cloud.aliyuncs.com|g" /etc/apt/sources.list && \
    sed -i "s|security.debian.org|mirrors.cloud.aliyuncs.com/debian-security|g" /etc/apt/sources.list && \
    apt update && \
    apt install -y libpq-dev tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/shanghai" > /etc/timezone && \
    rm -rf /var/lib/apt/lists/*
COPY timescaledb-tsl-2.9.2.so timescaledb-2.9.2.so timescaledb.so /opt/bitnami/postgresql/lib/
COPY timescaledb--2.9.2.sql timescaledb.control /opt/bitnami/postgresql/share/extension/
USER postgres
