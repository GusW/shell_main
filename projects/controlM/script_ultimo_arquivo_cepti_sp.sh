#! /bin/bash

DAT1="145959"
DAT3="160100"
DAT2=$(date +%H%M%S)
SINAL=$(cat "/tmp/SINAL")

[ $SINAL -eq 1 ] || exit

[ "$DAT2" -ge "$DAT3" ] || [ "$DAT1" -ge "$DAT2" ] || echo 0 > /tmp/SINAL 
CONTROL="/tmp/sipcp/ENTRADA/" #ARQUIVO DE DUMP GERADO PELO BANCO ORACLE CEPTI

QUANTARQUI=$(ls $CONTROL*.zip | wc -l )
[ $QUANTARQUI -ne 0 ] ||  exit

_ultimo_arquivo(){

arq=$(ls -lhrt *.zip 2> /dev/null | tac |  head -n 1 | cut -d " " -f 9)
sleep 10
arq2=$(ls -lhrt *.zip 2> /dev/null | tac |  head -n 1 | cut -d " " -f 9)

if [ $arq != $arq2 ] ;then
        _ultimo_arquivo

else
        mv $arq tem.tmp
        rm *.zip 2> /dev/null
        mv tem.tmp $arq
        echo 0 > /tmp/SINAL 
        sleep 300 
fi
}

cd $CONTROL
_ultimo_arquivo

exit

