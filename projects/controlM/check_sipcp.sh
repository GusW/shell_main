#!/bin/bash

AJOB=$(cat /tmp/AJOB.txt| wc -l)
HOST="127.0.0.1"
USUARIO="postgres"
BANCO="posdes01"
SCHEMA="pcpsm001."
TABELA01=$SCHEMA"pcptb001_ajob"

cat << EOF | psql -h $HOST -U $USUARIO -d $BANCO
BEGIN;
\o /tmp/CHECK.txt
SELECT COUNT(*) FROM $TABELA01;
\o
END;
EOF

PSQL=$(cat /tmp/CHECK.txt | sed -n '3p' | xargs)
if [ $AJOB -ne $PSQL ]; then
  echo "ERRO"
  echo "ERRO"
  echo "ERRO"
  echo "ERRO"
  echo "ERRO"
  echo "ERRO"
else
  echo $AJOB
fi
