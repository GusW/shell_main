#!/bin/bash

##########################################################
#                     INICIALIZACOES                     #
##########################################################

### Diretorio dos logs
directory="/usr/local/EAP-6.0.1/jboss-eap-6.0/standalone/log"
### Data limite - 3 dias atra
limit=$(date --date="3 day ago" +%Y%m%d)
### Ano da data limite
limitYear=$(echo $limit | cut -c1-4)
### Mes da data limite
limitMonth=$(echo $limit | cut -c5-6)
### Dia da data limite
limitDay=$(echo $limit | cut -c7-8)
### Prefixo (string) do arquivo de log alvo
serverLogPrefix="server.log."
### Tamanho do prefixo
lenPrefix=${#serverLogPrefix}
### Delimitador entre datas
delimiter="-"
### Funcao para forcar a remocao de arquivos
_remove(){
    chmod 777 $1
    rm -f $1
}

##########################################################
#    REGRA DE REMOCAO DE ARQUIVOS, CUIDADO AO EDITAR     #
##########################################################

cd $directory
### Iteração dentro dos arquivos no Diretorio
for f in *
do
  ### Ano presente no nome do arquivo
  fileYear=${f:lenPrefix:4}
  ### Tamanho do ano no nome do arquivo
  lenYear=${#fileYear}+${#delimiter}
  ### Mes presente no nome do arquivo
  fileMonth=${f:lenPrefix+lenYear:2}
  ### Tamanho do mes no nome do arquivo
  lenMonth=${#fileMonth}+${#delimiter}
  ### Dia presente no nome do arquivo
  fileDay=${f:lenPrefix+lenYear+lenMonth:2}
  ### Se o arquivo comeca com o prefixo do serverLogPrefix
  if [[ $f == $serverLogPrefix* ]]; then
    ### Se o ano do arquivo eh menor ao ano limite
    if [[ $fileYear -lt $limitYear ]]; then
      echo "Removendo arquivo $f..."
      _remove $f
    ### Se o mes do arquivo eh menor ao mes limite
    elif [[ $fileMonth -lt $limitMonth ]]; then
      echo "Removendo arquivo $f..."
      _remove $f
    ### Se o dia do arquivo eh menor que o dia limite
    elif [[ $fileDay -lt $limitDay ]]; then
      echo "Removendo arquivo $f..."
      _remove $f
    fi
  fi
done

##########################################################
#           GITEC/BH - TTS - GUSTAVO WATANABE            #
##########################################################
