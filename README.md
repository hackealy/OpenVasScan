Instale o OpenVAS:
sudo apt-get update
sudo apt-get install openvas

Atualize os feeds do OpenVAS:
sudo greenbone-nvt-sync
sudo greenbone-scapdata-sync
sudo greenbone-certdata-sync

Inicie o serviço do OpenVAS:
sudo systemctl start openvas-scanner

Crie um usuário para o OpenVAS:
sudo openvasmd --create-user=seu_usuario

Defina a senha para o usuário criado:
sudo openvasmd --user=seu_usuario --new-password=sua_senha

--------------------------------------------------------------------------------------------------------

Neste exemplo, o script recebe cinco parâmetros: o alvo a ser testado, o usuário e senha para autenticação no OpenVAS, o nome do arquivo de saída do OpenVAS e o nome do módulo de exploit a ser executado no Metasploit.

O script começa realizando um escaneamento de portas e serviços com o nmap, salvando o resultado em um arquivo de texto. Em seguida, é realizado um escaneamento de vulnerabilidades com o OpenVAS, salvando o resultado em um arquivo XML.

O resultado do OpenVAS é importado no Metasploit e, por fim, o módulo de exploit é selecionado e executado no Metasploit, configurado com o alvo identificado pelo nmap e OpenVAS.
