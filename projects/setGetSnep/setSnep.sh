#!/bin/bash

HOST="10.32.60.8"
TARGET="mg7435sr266"
USER="root"
PASS="sneppass"
DB="snep25"

SNEPDIR=/tmp
TEMPFILE=$SNEPDIR/snep.txt
SNEPSERVER=/tmp/snep_sisut

mysql -h $HOST -u $USER -p$PASS -e "USE $DB; SELECT DATE_FORMAT(cdr.calldate,'%d/%m/%Y  %T') AS data, cdr.clid, cdr.src, cdr.dst, cdr.billsec, cdr.disposition, cdr.accountcode, operadoras.nome as operadoras, operadoras.tbf, operadoras.tbc, ccustos.nome as custos,cdr.duration FROM snep25.cdr, snep25.oper_ccustos, snep25.operadoras, snep25.ccustos WHERE operadoras.codigo = oper_ccustos.operadora AND	cdr.accountcode = oper_ccustos.ccustos AND oper_ccustos.ccustos = ccustos.codigo AND cdr.calldate < current_date();" > $TEMPFILE
sed '1d' $TEMPFILE > tmpfile; mv tmpfile $TEMPFILE
sed 's/\t/,/g' $TEMPFILE > tmpfile; mv tmpfile $TEMPFILE

ssh root@$TARGET bash -c "'
if [[ ! -d $SNEPSERVER ]]; then
   mkdir $SNEPSERVER
fi
'"

scp $TEMPFILE root@$TARGET:$SNEPSERVER
