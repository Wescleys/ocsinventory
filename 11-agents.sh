#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 04/02/2018
# Data de atualização: 04/02/2018
# Versão: 0.1
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Download dos Agents Microsoft e MacOS
#
# Utilizar o comando: sudo -i para executar o script
#

# Arquivo de configuração de parâmetros
source 00-parametros.sh
#

# Caminho para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 
					 echo -e "Usuário é `whoami`, continuando a executar o $LOGSCRIPT"
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 echo
					 echo  ============================================================ &>> $LOG
					 
					 echo -e "Download dos Agentes do OCS Inventory"
					 echo -e "Pressione <Enter> para começar o Download"
					 read
					 sleep 2
					 echo
					 
					 #Verificando se existe arquivos no diretório /var/lib/ocsinventory-reports/download/
					 if [ -f /var/lib/ocsinventory-reports/download/*.zip ]; then
					 	echo -e "Arquivos zipados existentes, fazendo a limpeza do diretório"
						cd /var/lib/ocsinventory-reports/download/
						rm -Rf * &>> $LOG
						cd -
						echo -e "Diretório limpo com sucesso!!!, continuando o script"
						sleep 2
					 else
					 	echo -e "Diretório vazio, continuando com script..."
						sleep 2
					 fi
					 
					 echo -e "Download dos arquivos, aguarde..."
					 wget $OCSAGENTWIN10 -O /var/lib/ocsinventory-reports/download/OCSAgentWin10.zip &>> $LOG
					 wget $OCSAGENTWINXP -O /var/lib/ocsinventory-reports/download/OCSAgentWinXP.zip &>> $LOG
					 wget $OCSAGENTMAC -O /var/lib/ocsinventory-reports/download/OCSAgentMAC.zip &>> $LOG
					 wget $OCSAGENTTOOLS -O /var/lib/ocsinventory-reports/download/OCSAgentTools.zip &>> $LOG
					 wget $OCSAGENTDEPLOY -O /var/lib/ocsinventory-reports/download/OCSAgentDeploy.zip &>> $LOG
					 echo -e "Download dos arquivos concluído com sucesso!!!, continuando o script"
					 echo
					 
					 echo -e "Descompactando todos os arquivos Zipados, aguarde..."
					 for i in $(ls *.zip);do unzip $i; done &>> $LOG
					 echo -e "Arquivos descompactados com sucesso!!!, continuando o script"
					 echo
					 sleep 2
					 
					 echo -e "Listando o contéudo do diretório"
					 echo
					 ls /var/lib/ocsinventory-reports/download/
					 echo
					 echo -e "Arquivos listados com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
				 
           				 echo  ============================================================ >> $LOG
                     
					 echo -e "Fim do $LOGSCRIPT em: `date`" &>> $LOG
					 echo -e "Finalização do Download dos Agentes feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do agents.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do netdata.sh: $TEMPO"
					 echo -e "Pressione <Enter> para reinicializar o servidor: `hostname`"
					 read
					 sleep 2
					 reboot
					 else
						 echo -e "Versão do Kernel: $KERNEL não homologada para esse script, versão: >= 4.4 "
						 echo -e "Pressione <Enter> para finalizar o script"
						 read
			fi
	 	 else
			 echo -e "Distribuição GNU/Linux: `lsb_release -is` não homologada para esse script, versão: $UBUNTU"
			 echo -e "Pressione <Enter> para finalizar o script"
			 read
	fi
else
	 echo -e "Usuário não é ROOT, execute o comando com a opção: sudo -i <Enter> depois digite a senha do usuário `whoami`"
	 echo -e "Pressione <Enter> para finalizar o script"
	read
fi
