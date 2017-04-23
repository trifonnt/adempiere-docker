# adempiere-docker

Collection of Docker files for running ADempiere ERP-CRM on Docker

## Steps

### Clone this repository
```shell
$ git clone https://github.com/trifonnt/adempiere-docker.git
$ cd adempiere-docker
```

### Start PostregSQL DB server
```shell
$ docker run -d --name my-postgres \
 -v /etc/localtime:/etc/localtime \
 -v "$(pwd)/pgdata:/var/lib/postgresql/data" \
 -e POSTGRES_PASSWORD=adempiere \
 -p 5432:5432 \
 postgres-adempiere:9.6-alpine
```

### Import ADempiere DB dump into Postgres server
```shell
$ wget https://raw.githubusercontent.com/adempiere/adempiere/develop/data/seed/Adempiere_pg.jar
$ unzip Adempiere_pg.jar

$ docker run -it --rm \
 --link my-postgres:postgres \
 -e PGPASSWORD=adempiere \
 -v "$(pwd)/Adempiere_pg.dmp:/ExpDat.dmp" \
 postgres:9.6-alpine psql -h postgres -d adempiere -U adempiere -f /ExpDat.dmp
```

### Start phpPgAdmin (OPTIONAL)
```shell
$ docker run -d --name=my-phpPgAdmin \
 -v /etc/localtime:/etc/localtime \
 -e "DB_HOST=postgres" -e "DB_PORT=5432" \
 -p 88:80 \
 --link my-postgres:postgres \
 zhajor/docker-phppgadmin:latest
```
phpPgAdmin can be access at [http://localhost:88/](http://localhost:88/)
