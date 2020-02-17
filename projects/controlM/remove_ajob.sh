#!/bin/bash

export PGHOME=/opt/postgres/9.1
export PGDATA=/opt/postgres/9.1/data
export PATH=/opt/postgres/9.1/bin:$PATH
export LD_LIBRARY_PATH=/opt/postgres/9.1/lib:$LD_LIBRARY_PATH
export PGUSER=postgres
export PGDATABASE=postgres
export PGPORT=5432

DATE=$(date +%y%m%d)
DATE_3=$(date -d "-3 days" +%y%m%d)

USUARIO="postgres"
BANCO="posdes01"
SCHEMA="pcpsm001."
HOST="127.0.0.1"
TABLE="pcptb007_consolidacao_ajob"
TABELA01=$SCHEMA"pcptb001_ajob"
TABELA02=$SCHEMA"pcptb002_alnki_p"
TABELA03=$SCHEMA"pcptb003_alnko_p"

STATUS="Ended OK"

psql -h $HOST -U $USUARIO -d $BANCO << EOF
DELETE FROM $SCHEMA$TABLE where $TABLE.odate < '$DATE_3';
DELETE FROM $SCHEMA$TABLE where $TABLE.odate < '$DATE' and status <> '$STATUS';
VACUUM $SCHEMA$TABLE;
VACUUM $TABELA01;
VACUUM $TABELA02;
VACUUM $TABELA03;
\q
EOF
