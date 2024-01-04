FROM postgres:14


ENV PGDATA=/var/lib/postgresql/volume/data \
 PATRONI_DIR=/patroni \
 LANG=en_US.utf8 \
 PGHOME=/home/postgres \
 HOME=/home/postgres \
 PATRONI_DIR=/patroni \
 PGUSER=postgres \
 PATRONICTL_CONFIG_FILE=/patroni/patroni.yaml \
 PATRONI_POSTGRESQL_DATA_DIR=/var/lib/postgresql/volume/data

COPY *.sh $PGHOME/
RUN apt-get update \
    && apt-get install -y python3-psycopg2 python3-pip curl jq vim procps gettext-base \
    && pip3 install patroni[kubernetes]==2.1.1 --break-system-packages \
    && mkdir -p $PATRONI_DIR \
    && chown -R postgres:postgres $PGHOME  \
    && rm -rf /var/lib/apt/lists/* /root/.cache \
    && chown -R postgres:postgres $PATRONI_DIR
RUN cd $HOME && curl -SL https://github.com/wal-g/wal-g/releases/download/v2.0.0/wal-g-pg-ubuntu-20.04-amd64.tar.gz --output wal-g.tar.gz \
    && tar zxvf wal-g.tar.gz \
    && mv wal-g-pg-ubuntu-20.04-amd64 /usr/local/bin/walg \
    && rm wal-g.tar.gz \
    && chown -R postgres:postgres /usr/local/bin/walg

WORKDIR $PGHOME

ENTRYPOINT ["/bin/bash", "/home/postgres/entrypoint.sh"]


