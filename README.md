# adempiere-docker

Collection of Docker files for running ADempiere ERP-CRM on Docker

## Steps

### Start PostregSQL DB server
```shell
$ docker run -d --name my-postgres \
 -v /etc/localtime:/etc/localtime \
 -v "$(pwd)/pgdata:/var/lib/postgresql/data" \
 -e POSTGRES_PASSWORD=adempiere \
 -p 5432:5432 \
 postgres-adempiere:9.6-alpine
```

### Start PHP PG admin (OPTIONAL)
```shell
$ docker run -d --name=my-phpGgAdmin \
 -v /etc/localtime:/etc/localtime \
 -e "DB_HOST=postgres" -e "DB_PORT=5432" \
 -p 88:80 \
 --link my-postgres:postgres \
 zhajor/docker-phppgadmin:latest
```
