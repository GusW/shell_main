#!/bin/bash
################################################################################
#                                                                              #
#                  PROCESSAMENTO DOS ARQUIVOS DE CALLBACK                      #
#                         P767229 - GUSTAVO WATANABE                           #
################################################################################

################################################################################
#                        INICIALIZAÇÃO DE VARIÁVEIS                            #
################################################################################

ENTRADA=/var/spool/asterisk/callfiles
SAIDA=$ENTRADA/SAIDA
UNIDADES=(CERATBH GERAL GISEGBH GITECBH SR SR2601)
AUX=/var/spool/asterisk/outgoing_done
OUTPUT=$SAIDA/OUTPUT
LOGDIR=$SAIDA/LOG
PROCESSADO=$SAIDA/PROCESSADO
SDIR=$SAIDA/S
TEMPFILE=$OUTPUT/temp.txt
TEMPFILE_S=$OUTPUT/temp_s.txt
OUTPUTFILE=$OUTPUT/output.txt
ERRORFILE=$OUTPUT/erro.txt
DATALIM="2016-01-01"
DIFFLIM=180
USER="root"
PASS="sneppass"
DB="snep25"
TABLE="cdr"
TABLE1="oper_ccustos"
TABLE2="operadoras"
TABLE3="ccustos"
HOSTPSQL="10.123.18.45"
HOSTPSQLPASS="suporte"
USERPSQL="postgres"
PASSPSQL="suporte"
BANCOPSQL="sutdb001"
TABELAPSQL="tb_sut_callback"
SCHEMAPSQL="public"
TEMPPSQL="/var/spool/asterisk/callfiles/OUTPUT/output.txt"

################################################################################
#                      FUNÇÃO PARA ACERTAR NOME DE ARQUIVOS                    #
################################################################################
_acertoNome(){
  FILE="$1"
  STAT=$(stat -c %y $1)
  DATA=$(date -d "$STAT" +%d%m%Y)
  HORA=$(date -d "$STAT" +%H%M%S)
  NOMEFINAL="${1%.*}$DATA"_"$HORA"
  mv $1 $NOMEFINAL.call
}

################################################################################
#                   VERIFICAÇÃO DA EXISTÊNCIA DOS DIRETÓRIOS                   #
################################################################################

cd $ENTRADA
if [ ! -d "$SAIDA" ]; then
  mkdir $SAIDA
fi
if [ ! -d "$OUTPUT" ]; then
  mkdir $OUTPUT
fi
if [ ! -d "$PROCESSADO" ]; then
  mkdir $PROCESSADO
fi
if [ ! -d "$LOGDIR" ]; then
  mkdir $LOGDIR
fi
if [ ! -d "$SDIR" ]; then
  mkdir $SDIR
fi

chmod 777 -R $SAIDA

################################################################################
#                      NÃO MODIFICAR A PARTIR DESTE PONTO                      #
################################################################################

# REMOÇÃO DO ARQUIVO TEMPORÁRIO - SELECT DO MYSQL DATADIVI
rm -f $TEMPFILE
rm -f $TEMPFILE_S
# SELECT DO MYSQL DATADIVI
mysql -u $USER -p$PASS -e "USE $DB; SELECT * FROM $TABLE,$TABLE1,$TABLE2,$TABLE3 WHERE clid LIKE '%CALLBACK%' AND dst <> 's' AND $TABLE2.codigo = $TABLE1.operadora AND $TABLE.accountcode = $TABLE1.ccustos AND $TABLE1.ccustos = $TABLE3.codigo AND $TABLE.disposition = 'ANSWERED' AND $TABLE.calldate > '$DATALIM' ORDER BY calldate DESC;" > $TEMPFILE
sed '1d' $TEMPFILE > tmpfile; mv tmpfile $TEMPFILE

mysql -u $USER -p$PASS -e "USE $DB; SELECT * FROM $TABLE,$TABLE1,$TABLE2,$TABLE3 WHERE clid LIKE '%CALLBACK%' AND dst = 's' AND $TABLE2.codigo = $TABLE1.operadora AND $TABLE.accountcode = $TABLE1.ccustos AND $TABLE1.ccustos = $TABLE3.codigo AND $TABLE.disposition = 'ANSWERED' AND $TABLE.calldate > '$DATALIM' ORDER BY calldate DESC;" > $TEMPFILE_S
sed '1d' $TEMPFILE_S > tmpfile; mv tmpfile $TEMPFILE_S

mysql -u $USER -p$PASS -e "USE $DB; SELECT * FROM $TABLE WHERE clid LIKE '%CALLBACK%' AND accountcode = '' AND dst = 's' AND disposition = 'ANSWERED' AND calldate > '$DATALIM' ORDER BY calldate DESC;" > temp2
sed '1d' temp2 > tmpfile; cat tmpfile >> $TEMPFILE_S

for u in ${UNIDADES[*]}
do
  cd $ENTRADA/$u
  mv *.call $LOGDIR
done

cd $AUX
mv *.call $LOGDIR

cd $LOGDIR
LIST=(*.call)
for f in ${LIST[*]}
do
  L=${f%.*} # NOME DO ARQUIVO SEM TERMINAÇÃO
  L1=$(echo $L | tr _ -) # SUBSTITUI _ POR - NO NOME DO ARQUIVO
  ORIGEM=$(echo $L1 | cut -d"-" -f1) # SPLIT DO NOME - ORIGEM DA LIGAÇÃO
  DATASIMP=$(echo $L1 | cut -d"-" -f2) # SPLIT DO NOME - DATA DA LIGAÇÃO
  HORASIMP=$(echo $L1 | cut -d"-" -f3) # SPLIT DO NOME - HORA DA LIGAÇÃO
  if [[ $DATASIMP = "" && $HORASIMP = "" ]]; then
    _acertoNome $f
  fi
done

LOG=$(ls -t *.call)
while read p # ITERAÇÃO DAS LINHAS DENTRO DO ARQUIVO SQL
do
  DATATEMP=$(echo $p | cut -d" " -f1)
  if [[ $(date -d "$DATATEMP" +%Y%m%d) -ge $(date -d "$DATALIM" +%Y%m%d) ]]; then
    HORATEMP=$(echo $p | cut -d" " -f2)
    DATAHORATEMP=$(date -d "$DATATEMP $HORATEMP" +%Y%m%d%H%M%S)
    RAMALTEMP=$(echo $p | tr '<' - | tr '>' - | cut -d"-" -f4)
    DESTTEMP=$(echo $p | cut -d" " -f6)
    DURACAO=$(echo $p | cut -d" " -f12)
    BILLSEC=$(echo $p | cut -d" " -f13)
    DISPOSITION=$(echo $p | cut -d" " -f14)
    ACCOUNTCODE=$(echo $p | cut -d" " -f16)
    NOME1=$(echo $p | cut -d" " -f22)
    NOME2=$(echo $p | cut -d" " -f23)
    NOME=$(echo $NOME1 $NOME2)
    TBF=$(echo $p | cut -d" " -f26)
    TBC=$(echo $p | cut -d" " -f27)
    CUSTO1=$(echo $p | cut -d" " -f32)
    CUSTO2=$(echo $p | cut -d" " -f33)
    CUSTO=$(echo $CUSTO1 $CUSTO2)

    for f in ${LOG[*]} # PARA CADA ARQUIVO DE LOG
    do
      STATUS=false
      L=${f%.*} # NOME DO ARQUIVO SEM TERMINAÇÃO
      L1=$(echo $L | tr _ -) # SUBSTITUI _ POR - NO NOME DO ARQUIVO
      ORIGEM=$(echo $L1 | cut -d"-" -f1) # SPLIT DO NOME - ORIGEM DA LIGAÇÃO
      DATASIMP=$(echo $L1 | cut -d"-" -f2) # SPLIT DO NOME - DATA DA LIGAÇÃO
      HORASIMP=$(echo $L1 | cut -d"-" -f3) # SPLIT DO NOME - HORA DA LIGAÇÃO
      DATA=$(echo ${DATASIMP:4:4}-${DATASIMP:2:2}-${DATASIMP:0:2}) # FORMATAÇÃO DATA PADRÃO YYYY-MM-DD
      if [[ $(date -d "$DATA" +%Y%m%d) -ge $(date -d "$DATALIM" +%Y%m%d) ]]; then
        L2=$(cat $f | tr '<' ';' | tr '>' ';') # SUBSTITUI < E > POR ";" NO TEXTO DO ARQUIVO E DÁ SPLIT DO RAMAL
	      RAMAL=$(echo $L2 | cut -d";" -f2) # SPLIT DO TEXTO - RAMAL DA LIGAÇÃO
        if [ "$RAMAL" = "$RAMALTEMP" ]; then
          HORA=$(echo ${HORASIMP:0:2}:${HORASIMP:2:2}:${HORASIMP:4:2}) # FORMATAÇÃO HORA PADRÃO HH:MM:SS
          DATAHORA=$(date -d "$DATA $HORA" +%Y%m%d%H%M%S) # TRANSFORMAÇÃO DATA E HORA PADRÃO UNIX YYYY-MM-DD HH:MM:SS
          t1=$(date --date="$DATA $HORA" +%s)
          t2=$(date --date="$DATATEMP $HORATEMP" +%s)
          tDiff=$(( $t2 - $t1 ))
          DIFF=$(( $DATAHORATEMP - $DATAHORA ))
          if [[ $tDiff -gt 0 && $tDiff -le $DIFFLIM ]]; then
		    echo "calldateSQL sendo processado : "$DATAHORATEMP
            echo "............................................................."
            mv $f $PROCESSADO
            if [ "$ACCOUNTCODE" = "2.02" ]; then
              ACCOUNTCODE="2.02"
              NOME="Embratel VC2 VC3"
              TBF="0.06"
              TBC="0.4226"
              CUSTO="Fixo DDD"
            fi
            echo $DATA $HORA';'$DATATEMP $HORATEMP';'$RAMAL';'$ORIGEM';'$DESTTEMP';'$DURACAO';'$BILLSEC';'$DISPOSITION';'$ACCOUNTCODE';'$NOME';'$TBF';'$TBC';'$CUSTO >> $OUTPUTFILE
            if [ "$DESTTEMP" != "s" ]; then
              while read s # ITERAÇÃO DAS LINHAS DENTRO DO ARQUIVO SQL TEMP_S
              do
                DATATEMP_S=$(echo $s | cut -d" " -f1)
                HORATEMP_S=$(echo $s | cut -d" " -f2)
                RAMALTEMP_S=$(echo $s | tr '<' - | tr '>' - | cut -d"-" -f4)
                if [[ $(date -d "$DATA $HORA" +%Y%m%d%H%M%S) -le $(date -d "$DATATEMP_S $HORATEMP_S" +%Y%m%d%H%M%S) && $(date -d "$DATATEMP $HORATEMP" +%Y%m%d%H%M%S) -ge $(date -d "$DATATEMP_S $HORATEMP_S" +%Y%m%d%H%M%S) && "$RAMALTEMP_S" = "$RAMAL" ]]; then
                  DURACAO_S=$(echo $s | cut -d" " -f11)
                  BILLSEC_S=$(echo $s | cut -d" " -f12)
                  DISPOSITION_S=$(echo $s | cut -d" " -f13)
                  ACCOUNTCODE_S=$(echo $s | cut -d" " -f15)
      	          RAM=$(echo ${ORIGEM:2:1})
            		  if [ "$RAM" = "9" ];then
            		     CUSTO_S="Celular local"
            		  else
            		     CUSTO_S="Fixo local"
            		  fi
                  if [ "$ACCOUNTCODE_S" = "2.11" ]; then
              	     ACCOUNT_S=$ACCOUNTCODE_S
              	     NOME1_S=$(echo $s | cut -d" " -f20)
              	     NOME2_S=$(echo $s | cut -d" " -f21)
             		     NOME_S=$(echo $NOME1_S $NOME2_S)
                     TBF_S=$(echo $s | cut -d" " -f24)
                     TBC_S=$(echo $s | cut -d" " -f25)
                  elif [ "$ACCOUNTCODE_S" = "2.12" ]; then
                     ACCOUNT_S="2.12"
                     NOME_S="Embratel VC2 VC3"
                     TBF_S="0.06"
                     TBC_S="0.4226"
                  else
                     ACCOUNT_S="2.11"
                     NOME_S="Embratel Local"
                     TBF_S="0.0326"
                     TBC_S="0.4"
                  fi
                  echo $DATA $HORA';'$DATATEMP_S $HORATEMP_S';'$RAMAL';'$RAMAL';'$ORIGEM';'$DURACAO_S';'$BILLSEC_S';'$DISPOSITION_S';'$ACCOUNT_S';'$NOME_S';'$TBF_S';'$TBC_S';'$CUSTO_S >> $OUTPUTFILE
                fi
              done <$TEMPFILE_S
            fi
            cd $LOGDIR
            LOG=$(ls -t *.call)
            STATUS=true
            break
          elif [[ $tDiff -gt $DIFFLIM ]]; then
            break
          elif [[ $tDiff -lt 0 ]]; then
			      mv $f $SDIR
            cd $LOGDIR
            LOG=$(ls -t *.call)
          fi
        fi
      fi
    done
  fi
  if [ "$STATUS" = false ]; then
    echo $p >> $ERRORFILE
  fi
done <$TEMPFILE

# MOVIMENTAÇÃO LOGS NÃO CONCILIADOS
mv $LOGDIR/*.call $SDIR

if [ "$HOSTPSQL" != "localhost" ]; then
  scp $OUTPUTFILE root@$HOSTPSQL:$OUTPUT
fi

psql -h $HOSTPSQL -U $USERPSQL -d $BANCOPSQL << EOF
    TRUNCATE $SCHEMAPSQL.$TABELAPSQL;
    COPY $SCHEMAPSQL.$TABELAPSQL FROM '$OUTPUTFILE' DELIMITER ';';
    \q
EOF
