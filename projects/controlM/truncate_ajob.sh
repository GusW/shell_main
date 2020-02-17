#!/bin/bash

export PGHOME=/opt/postgres/9.1
export PGDATA=/opt/postgres/9.1/data
export PATH=/opt/postgres/9.1/bin:$PATH
export LD_LIBRARY_PATH=/opt/postgres/9.1/lib:$LD_LIBRARY_PATH
export PGUSER=postgres
export PGDATABASE=postgres
export PGPORT=5432

DATE=$(date +%y%m%d)

USUARIO="postgres"
BANCO="posdes01"
SCHEMA="pcpsm001."
HOST="127.0.0.1"
TABLE="pcptb007_consolidacao_ajob"
STATUS="Ended OK"

psql -h $HOST -U $USUARIO -d $BANCO << EOF
TRUNCATE TABLE $SCHEMA$TABLE;
\q
EOF
