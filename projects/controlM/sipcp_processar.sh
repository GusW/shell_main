#!/bin/bash

### Forcar export do profile do PSQL no caso de reinicializacao do servidor
#export PGHOME=/opt/postgres/9.1
#export PGDATA=/opt/postgres/9.1/data
#export PATH=/opt/postgres/9.1/bin:$PATH
#export LD_LIBRARY_PATH=/opt/postgres/9.1/lib:$LD_LIBRARY_PATH
#export PGUSER=postgres
#export PGDATABASE=postgres
#export PGPORT=5432

### Das 14:59:59 às 16:01:00 todos os arquivos na ENTRADA serao processados

DAT1="150959"
DAT3="154100"
DAT2=$(date +%H%M%S)

### Arquivos e caminhos para processamento

INC=$(cat "/tmp/INC") #MECANISMO DE TROCA ENTRE AS TABELAS
INCREMENTO=$(echo $INC+"1" | bc) #nu_replicacao DA ULTIMA LINHA DA TABELA PCPTB011_CONTROLE_REPLICACAO
ENTRADA="/tmp/sipcp/ENTRADA/" #ARQUIVO DE DUMP GERADO PELO BANCO ORACLE CEPTI
PROCESSADO="/tmp/sipcp/PROCESSADO/"

### ARQUIVOS ESPECIFICOS PARA OS JOBS (TEMPORARIOS)

AJOB="/tmp/AJOB.txt"
ALNKI="/tmp/ALNKI_P.txt"
ALNKO="/tmp/ALNKO_P.txt"
ASHOUT="/tmp/ASHOUT.txt"
ATEMP="/tmp/ATEMP.txt" #arquivo deverá ser utilizado como remoção temporária de Carrige Return no AJOB

### BANCO POSTGRESQL

USUARIO="postgres"
BANCO="posdes01"
SCHEMA="pcpsm001."
HOST="127.0.0.1"
TABELA01=$SCHEMA"pcptb001_ajob"
TABELA02=$SCHEMA"pcptb002_alnki_p"
TABELA03=$SCHEMA"pcptb003_alnko_p"
TABELA04=$SCHEMA"pcptb022_ashout"
TABELA_CONTROLE=$SCHEMA"pcptb011_controle_replicacao"

### Funcao para remover arquivos que não sejam os últimos processados
### _manter_ultimos CAMINHO TIPO_ARQUIVO QUANTIDADE

_manter_ultimos(){
CAMINHO="$1"
TIPO_ARQUIVO="$2"
QUANTIDADE="$3"
cd $CAMINHO
ULTIMOS=($(ls *.$TIPO_ARQUIVO -t | head -$QUANTIDADE))
for f in *
do
  if [[ ! ${ULTIMOS[*]} =~ $f ]]; then
    rm -f $f 2> /dev/null
  fi
done

}

### Codigo para efetivo processamento dos arquivos

_processar(){

cd $ENTRADA
chmod 777 $ZIP_ARQUIVO
unzip $ZIP_ARQUIVO
if [ $? -ne 0 ]; then
exit
# else
# rm $ZIP_ARQUIVO
# sleep 5
fi
SQL_ARQUIVO=$(ls -1 *.sql)
chmod 777 $SQL_ARQUIVO
[ -z "$SQL_ARQUIVO" ] && exit
CONTROL=$ENTRADA$SQL_ARQUIVO

echo "fazendo AJOB"
cat $CONTROL | egrep _ajob | egrep Insert | iconv -f iso-8859-1 -t utf-8 | sed "s/.*values (//g" | sed "s/','/'ほ/g;s/,null/ほnull/g;s/null,/nullほ/g" | sed 's/null,/\\Nほ/g;s/null/\\N/g;s/ほ/\t/g'| sed "s/'\t/\t/g;s/\t'/\t/g"| sed s/\'//1 | sed "s/);"//g | sed "s/'\r/\r/g" | sed s/\'$// | sed '/CTG8P/d' | sed '/CV6Z3/d' > $AJOB

echo "Carriage Return"
tr '\r\n' '\r' < $AJOB > $ATEMP

echo "fazendo ALNKI"
cat $CONTROL | egrep _alnki_p | egrep Insert | sed 's/^.*values (//g;s/null/\\N/g;s/);//g' | sed s/"'"//g | iconv -f iso-8859-1 -t utf-8 > $ALNKI

echo "fazendo ALNKO"
cat $CONTROL | egrep _alnko_p | egrep Insert | sed 's/^.*values (//g;s/null/\\N/g;s/);//g' | sed s/"'"//g | iconv -f iso-8859-1 -t utf-8 > $ALNKO

echo "fazendo ASHOUT"
cat $CONTROL | egrep _ashout | egrep Insert | sed "s/','/;/g" | sed 's/^.*values (//g;s/null/\\N/g;s/);//g' | sed s/"'"//g | iconv -f iso-8859-1 -t utf-8 > $ASHOUT

echo "psql copia"
psql -h $HOST -U $USUARIO -d $BANCO << EOF
	truncate $TABELA01,$TABELA02,$TABELA03,$TABELA04;
	ALTER TABLE $TABELA01 DROP COLUMN instream_jcl RESTRICT;
	COPY $TABELA01 from '$ATEMP' DELIMITER '	';
	COPY $TABELA02 from '$ALNKI' DELIMITER ',';
	COPY $TABELA03 from '$ALNKO' DELIMITER ',';
	COPY $TABELA04 from '$ASHOUT' DELIMITER ';';
	ALTER TABLE $TABELA01 ADD COLUMN instream_jcl character varying(1);
	\q
EOF

DTIMESTAMP="$(date "+%Y%m%d") $(date +%T)"

echo "psql replicacao controle"
psql -h $HOST -U $USUARIO -d $BANCO << EOF
	INSERT INTO $TABELA_CONTROLE (nu_replicacao,dt_insercao) VALUES ($INCREMENTO,TIMESTAMP '$DTIMESTAMP');
	\q
EOF
echo $INCREMENTO > /tmp/INC
echo $SQL_ARQUIVO  >> ../ARQ.TXT

ARQUIVO=$PROCESSADO$SQL_ARQUIVO"_"$(date "+%d%m%y_%H%M%S")".ok.txt"

psql -h $HOST -U $USUARIO -d $BANCO << EOF > /tmp/PROC
  SELECT dt_insercao FROM $TABELA_CONTROLE ORDER BY dt_insercao DESC limit 1;
	\q
EOF
PROC=$(cat "/tmp/PROC")
PROC=$(echo ${PROC:56:8})
HORAMOD=$(echo $ARQUIVO | cut -d"_" -f3)
HORAMOD=$(echo ${HORAMOD:0:2}:${HORAMOD:2:2}:${HORAMOD:4:2})
if [ "$PROC" = "$HORAMOD" ]; then
  rm $ZIP_ARQUIVO
  sleep 5

  echo "mover processado"
  mv $CONTROL $ARQUIVO

  echo "zipar processado"
  bzip2 $PROCESSADO*.txt
  sleep 60
  _manter_ultimos $PROCESSADO bz2 10
else
  if [ "$DAT2" -lt "$DAT1"  -a  "$DAT2" -gt "$DAT3" ]; then
    rm $ZIP_ARQUIVO
    sleep 5
  fi
  echo $ZIP_ARQUIVO >> /tmp/sipcp/FALHA.TXT
  rm $CONTROL
fi
exit

}

###############################################################################################################
#                                                                                                             #
#                                             ALTERAR SE NECESSÁRIO                                           #
#                                                                                                             #
###############################################################################################################

ZIP_ARQUIVO=$(ls -1 $ENTRADA*.zip | tac | tail -n 1)
ZIP_QUANTIDADE=$(ls $ENTRADA*.zip | wc -l )
[ $ZIP_QUANTIDADE -ne 0 ] ||  exit

# if [ "$DAT2" -ge "$DAT1"  -a  "$DAT2" -le "$DAT3" ]; then
_processar
# else
# _manter_ultimos $ENTRADA zip 1
# sleep 10
# _processar
# fi
