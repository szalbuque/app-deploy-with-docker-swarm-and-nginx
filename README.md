# Prática de uso do docker swarm com microsserviços

## Docker: Utilização prática no cenário de Microsserviços
## Denilson Bonatti, Instrutor - Digital Innovation One

Conteúdo do curso "Linux do Zero", da Dio.me<br>

Contexto: <br>
Um supermercado decide migrar seus sistemas de gestão para a nuvem e transformar sua aplicação monolítica em microsserviços.
<br>

## AWS:
Três instâncias EC2 (t2.micro) com Ubuntu Server. Todas "free tier eligible".<br>
Criação de um par de chaves (nome: aws-keys) RSA para acessar remotamente as máquinas.<br>
Rede: <br>
* VPC: padrão (10.0.0.0/24) - minha-rede
* Subnet: padrão (10.0.0.0/24) - minha-subrede
* Não atribui automaticamente IP público
* Firewall (security group): launch-wizard-1
  
## Usando Terraform para criar as VMs
1. Baixar o Terraform no site https://developer.hashicorp.com/terraform/downloads ;
2. Extrair o arquivo;
3. Criar uma pasta "C:\Program Files (x86)\Terraform" ;
4. Copiar o arquivo terraform.exe para a pasta criada;
5. Incluir o caminho dessa pasta na variável de ambiente PATH do Windows;
6. Criar usuário no IAM com permissão "Programmatic access";
7. Adicionar políticas de acesso diretamente ao usuário, para este exercício;
8. Selecionar a política "AmazonEC2FullAccess";
9. 




