#!/bin/bash

HOSTPSQL="localhost"
USERPSQL="postgres"
BANCOPSQL="sutdb001"
TABELAPSQL="tb_sut_snep"
SCHEMAPSQL="public"

SNEPDIR=/tmp/snep_sisut
TEMPFILE=$SNEPDIR/snep.txt

psql -h $HOSTPSQL -U $USERPSQL -d $BANCOPSQL << EOF
    TRUNCATE $SCHEMAPSQL.$TABELAPSQL;
    COPY $SCHEMAPSQL.$TABELAPSQL FROM '$TEMPFILE' DELIMITER ',';
    \q
EOF
