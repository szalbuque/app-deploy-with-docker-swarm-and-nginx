# Preparação do container do banco de dados MySQL:

* Acessar a instância 0 por SSH;
* Entrar na pasta da aplicação clonada;
* Criar uma subpasta "db" e mover para ela o arquivo banco.sql;
* Criar o arquivo dockerfile usando o nano (usar este conteúdo: [dockerfile para o banco de dados](db/dockerfile)).
* Usar o comando docker build para gerar a imagem:
> docker build . -t szalbuque/dioapp:1.0

root@ip-10-0-101-148 db # docker image ls
REPOSITORY     |      TAG   |    IMAGE ID   |    CREATED     |     SIZE
---------------|------------|---------------|----------------|----------
szalbuque/dioapp  |   1.0    |   0a8b7889b2da |  19 seconds ago |  496MB
mysql/mysql-server |  latest  |  1d9c2219ff69 |  6 weeks ago   |   496MB

## Enviar a imagem para o Docker Hub:
* Fazer o login no Docker Hub com o comando "docker login";
* Enviar a imagem para o Docker Hub com o comando:
> docker push szalbuque/dioapp:1.0

## Criar um container mysql com base na imagem acima:

* Criar uma pasta na instância 0 para fazer a persistência dos dados:
  * /data/mysqldb
  
* Criar o container
> docker run -dti --name mysqldb -v /data/mysqldb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=12345  szalbuque/dioapp:1.0<br>
> docker ps<br>

CONTAINER ID |  IMAGE   |  COMMAND     |             CREATED   |      STATUS    |     PORTS        |         NAMES
-------------|----------|--------------|-----------------------|----------------|------------------|------------------
ff91469d1447 |  mysql   |  "docker-entrypoint.s…" |  7 seconds ago |  Up 6 seconds |  3306/tcp, 33060/tcp |  mysqldb

* Entrar no container:
> docker exec -it mysqldb /bin/bash

* Entrar no mysql:
> mysql -u root -p

* Acessar o banco de dados:
> use meubanco;

* Listar as tabelas do banco de dados:
> show tabels from meubanco;

* Listar as colunas da tabela:
>  select column_name from information_schema.columns where table_name='dados';

* Inserir um registro na tabela:
>  insert into dados (AlunoID, Nome, Sobrenome, Endereco, Cidade, Host) values (1,"silvia","rocha","rua a","cidade b","host 1");

* Experimentei criar um registro no banco de dados e destruir o container. Depois criei outro container com o mesmo comando:
> docker run -dti --name mysqldb -v /data/mysqldb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=12345  szalbuque/dioapp:1.0
  * Entrei neste novo container e no mysql;
  * Listei os registros com o comando:
  > select * from dados;
  * O registro que eu havia criado antes de destruir o container estava lá. O que significa que a persistência de dados na instância 0 está funcionando.