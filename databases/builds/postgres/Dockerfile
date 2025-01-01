ARG POSTGRES_VERSION=UNDEFINED

FROM postgres:${POSTGRES_VERSION}

ARG PATRONI_VERSION=UNDEFINED
ARG WALG_VERSION=2.0.0
ARG PGPROFILE_VERSION=4.7

ENV  PATRONI_DIR=/etc/patroni \
 PATRONI_TEMPLATE_DIR=/etc/patroni \
 PATRONI_TEMPLATE_FILE=patroni.yaml \
 PGHOME=/home/postgres \
 PATRONI_CONFIGURATION=/home/postgres/patroni.yaml \
 PATRONICTL_CONFIG_FILE=/home/postgres/patroni.yaml \
 PGDATA=/data

RUN apt-get update \
    && apt-get install -y procps vim curl jq net-tools telnet gettext-base python3-pip python3-psycopg2 \
    && pip3 install patroni[kubernetes]==${PATRONI_VERSION} --break-system-packages \
    && mkdir -p $PATRONI_DIR $PGDATA $PGHOME \
    && chown -R postgres:postgres $PGHOME $PGDATA $PATRONI_DIR \
    && rm -rf /var/lib/apt/lists/* /root/.cache 

COPY *.sh $PGHOME/

# pg_profile
RUN curl -SL https://github.com/zubkov-andrei/pg_profile/releases/download/${PGPROFILE_VERSION}/pg_profile--${PGPROFILE_VERSION}.tar.gz -o /tmp/pg_profile.tar.gz \
    && tar -xzf /tmp/pg_profile.tar.gz -C $(pg_config --sharedir)/extension \
# wal-g
    && curl -SL https://github.com/wal-g/wal-g/releases/download/v${WALG_VERSION}/wal-g-pg-ubuntu-20.04-amd64.tar.gz -o /tmp/wal-g.tar.gz \
    && tar zxf /tmp/wal-g.tar.gz -C /usr/local/bin/ \
    && mv /usr/local/bin/wal-g-pg-ubuntu-20.04-amd64 /usr/local/bin/wal-g \
    && chown -R postgres:postgres /usr/local/bin/wal-g \
#clean up
    && rm -rf /tmp/*

WORKDIR $PGHOME

ENTRYPOINT ["/bin/bash", "/home/postgres/entrypoint.sh"]