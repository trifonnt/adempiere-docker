# adempiere-docker

Collection of Docker files for running ADempiere ERP-CRM on Docker

## Steps

### Start PostregSQL DB server
Check postrges-adempiere folder

### Start PHP PG admin
```shell
$ docker run -d --name=my-phpGgAdmin -p 88:80 -v /etc/localtime:/etc/localtime --link my-postgres:postgres -e "DB_HOST=postgres" -e "DB_PORT=5432" zhajor/docker-phppgadmin:latest
```
