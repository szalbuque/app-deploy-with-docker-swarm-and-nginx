# Prática de uso do docker swarm com microsserviços

## Docker: Utilização prática no cenário de Microsserviços
## Denilson Bonatti, Instrutor - Digital Innovation One

Conteúdo do curso "Linux do Zero", da Dio.me<br>

### <b>Contexto:</b> <br>
Um supermercado decide migrar seus sistemas de gestão para a nuvem e transformar sua aplicação monolítica em microsserviços.
<br>

### <b>Problema:</b> 
Um hipermercado tem sua aplicação gerencial rodando num datacenter local. O custo para escalar a infraestrutura é alto. Se der um problema no hardware do datacenter, o impacto negativo nas vendas é imediato e a solução é demorada.
A empresa deseja construir mais 5 unidades. Isso implica a ampliação da infraestrutura e a criação de VPNs.
A analista de TI contratada levantou as seguintes questões:
* Dificuldades com a segurança da TI (lógica e física);
* Custo com mão de obra especializada;
* Custo de hardware;
* Custo de energia elétrica;
* Risco de falta de energia (uso de geradores);
* Despesas inesperadas.

### <b>Solução:</b> Migrar para nuvem pública e transformar a aplicação monolítica em microsserviços.
Vantagens de migrar para a nuvem pública:
* Preço (pague somente o que usar);
* Facilidade de contratação, configuração e infraestrutura;
* Escalabilidade;
* Performance.<br>

Para aproveitar melhor as vantagens da computação em nuvem, a aplicação monolítica será transformada em microsserviços.
Desta forma, será possível escalar os serviços de maneira independente, de acordo com a demanda de cada um.

<h3> A figura abaixo ilustra a diferença entre aplicações monolíticas e microsserviços:</h3><br>

![](images/monolithic%20vs%20microservice.png)
<br><i>Fonte: https://medium.com/tecnologia-e-afins/que-raios-s%C3%A3o-microsservi%C3%A7os-e4aa96599284</i>

## CLUSTER:
Vamos usar um cluster, ou seja, um conjunto de máquinas que trabalham em conjunto, funcionando como um único sistema. Essas máquinas executam a mesma tarefa e cada uma delas é chamada de NÓ (node). Faremos isso para potencializar o desempenho e aumentar a disponibilidade da aplicação.
Neste exercício, será utilizado o Docker Swarm, que faz a orquestração e o agendamento de cargas de trabalho de containers Docker. A aplicação vai rodar em um cluster "Swarm".
Se um dos nós tiver um problema de hardware e parar de funcionar, o Docker Swarm automaticamente realoca o containers nos outros nós do cluster.

## AWS:
* VPC e instâncias EC2 criadas com o Terraform.
* Veja os passos em: [Passos para criação do ambiente com Terraform](./terraform/tfREADME.md)
  
## Conectar na instância via SSH:

> ssh -i "dio-app-key" ec2-user@IP.EXTERNO.DA.INSTANCIA   

## Instalar o docker nos nós do cluster:
* Atualizar o linux: sudo yum update
* Instalar o docker: sudo yum install docker
* Iniciar o docker deamon: sudo systemctl start docker

## Clonar o repositório da aplicação para a instância 0:
* instalar o git:
> yum install git 
* fazer o clone (na pasta /home/ec2-user):
> git clone https://github.com/denilsonbonatti/toshiro-shibakita.git


## Criar o container do banco de dados na instância 0:
* Baixar a imagem do mysql
> sudo docker pull mysql
* Criar um volume para armazenar os dados (O docker aloca o volume na pasta /var/lib/docker/volumes):
> docker volume create volumedb
> [root@ip-10-0-101-148 toshiro-shibakita]# docker volume ls

DRIVER  |  VOLUME NAME
--------|-------------
local   |  5ce55ecfd682eb854717d7425c133b6a26c9e5e23c4de69c42e956f3cba306e1
local   |  volumedb

  
* Criar o container
> docker container run --name mysqldb -v volumedb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=12345 -d mysql<br>
> docker ps<br>

CONTAINER ID |  IMAGE   |  COMMAND     |             CREATED   |      STATUS    |     PORTS        |         NAMES
-------------|----------|--------------|-----------------------|----------------|------------------|------------------
ff91469d1447 |  mysql   |  "docker-entrypoint.s…" |  7 seconds ago |  Up 6 seconds |  3306/tcp, 33060/tcp |  mysqldb

* Entrar no container:
> docker exec -it mysqldb /bin/bash

* Entrar no mysql:
> mysql -u root -p



## Criação do container da aplicação em PHP:
> /var/lib/docker/volumes