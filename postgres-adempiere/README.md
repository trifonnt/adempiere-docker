
# Build postgres-adempiere image
```shell
$ docker build -t postgres-adempiere:9.6-alpine -f ./postgres-adempiere.df .
```

# Run newly built image
```shell
$ docker run -d --name my-postgres \
 -v /etc/localtime:/etc/localtime \
 -v "$(pwd)/pgdata:/var/lib/postgresql/data" \
 -e POSTGRES_PASSWORD=adempiere \
 -p 5432:5432 \
 postgres-adempiere:9.6-alpine
```
