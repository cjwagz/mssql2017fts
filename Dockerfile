FROM ubuntu:16.04
LABEL com.microsoft.product="Microsoft SQL Server"
LABEL com.microsoft.version="14.0.3238.1"

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD='P@ssw0rd1!'
ENV MSSQL_PID=Developer
ENV MSSQL_COLLATION=SQL_Latin1_General_CP1_CS_AS

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates sudo \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server-2017.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends mssql-server mssql-server-fts \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /opt/mssql/bin/mssql-conf -n setup

EXPOSE 1433/tcp
CMD ["/opt/mssql/bin/sqlservr"]