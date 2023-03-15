ARG BASE_IMAGE=debian:11.4-slim@sha256:68c1f6bae105595d2ebec1589d9d476ba2939fdb11eaba1daec4ea826635ce75
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-09-08

LABEL Name="senzing/wrap-with-mysql" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

USER root

# Install packages via apt-get.

RUN apt-get update \
 && apt-get -y install \
      wget

# MySQL support

RUN wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc_8.0.20-1debian10_amd64.deb \
 && wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-common_8.0.20-1debian10_amd64.deb \
 && wget http://repo.mysql.com/apt/debian/pool/mysql-8.0/m/mysql-community/libmysqlclient21_8.0.20-1debian10_amd64.deb \
 && apt-get update \
 && apt-get -y install \
      ./mysql-connector-odbc_8.0.20-1debian10_amd64.deb \
      ./mysql-common_8.0.20-1debian10_amd64.deb \
      ./libmysqlclient21_8.0.20-1debian10_amd64.deb \
 && rm \
      ./mysql-connector-odbc_8.0.20-1debian10_amd64.deb \
      ./mysql-common_8.0.20-1debian10_amd64.deb \
      ./libmysqlclient21_8.0.20-1debian10_amd64.deb \
 && rm -rf /var/lib/apt/lists/*

 RUN rm /opt/senzing/g2/sdk/python/senzing_governor.py || true

# Set/Reset the USER.

ARG USER=1005
USER ${USER}
