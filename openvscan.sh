#!/bin/bash

# Definindo variáveis
alvo=$1
usuario_openvas=$2
senha_openvas=$3
arquivo_saida_openvas=$4
nome_modulo_metasploit=$5

# Escaneamento de portas e serviços com o nmap
echo "Realizando escaneamento de portas e serviços com o nmap..."
nmap -sS -sV $alvo > nmap_scan.txt

# Escaneamento de vulnerabilidades com o OpenVAS
echo "Realizando escaneamento de vulnerabilidades com o OpenVAS..."
openvas-cli --target=$alvo --username=$usuario_openvas --password=$senha_openvas --verbose --xml=$arquivo_saida_openvas

# Importação do resultado do OpenVAS no Metasploit
echo "Importando resultados do OpenVAS no Metasploit..."
msfconsole -q -x "db_import $arquivo_saida_openvas; exit"

# Seleção e execução do módulo de exploit no Metasploit
echo "Selecionando e executando módulo de exploit no Metasploit..."
msfconsole -q -x "use $nome_modulo_metasploit; set RHOSTS $alvo; run; exit"
